package messagebatches

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/utils"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	"gopkg.in/ffmt.v1"
	"merchant-api/controllers/actions"
	"models"
	"strconv"
	"strings"
	"xorm.io/builder"
)

func getRealPhones(phoneList string) []string {
	// 过滤掉空白的部分
	rArr := []string{}
	pArr := strings.Split(strings.TrimSpace(phoneList), ",")
	for _, p := range pArr {
		r := strings.TrimSpace(p)
		if r != "" {
			rArr = append(rArr, r)
		}
	}
	return rArr
}

// Index 列表
var Index = &actions.List[models.MessageBatch]{
	Model: models.MessageBatches,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			return cond
		}
		cond = cond.Or(builder.Eq{"merchant_id": merchant.ID})

		rows := []models.IDRow{}
		myClient := db.Get(platform)
		defer myClient.Close()

		if err := myClient.SQL("SELECT id FROM merchants WHERE parent_id = ?", merchant.ID).Find(&rows); err != nil {
			log.Logger.Error("获取下级商户发生错误")
		} else if len(rows) > 0 {
			rArr := []int{}
			for _, r := range rows {
				rArr = append(rArr, r.Id)
			}

			cond = cond.Or(builder.In("merchant_id", rArr))
		}

		return cond
	},
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)
		mConn := db.Get(platform)
		defer mConn.Close()
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			log.Logger.Error("获取商户信息失败")
		}

		var templates []models.MessageTemplate
		if err := mConn.Table("message_templates").Where("merchant_id = ?", merchant.ID).Find(&templates); err != nil {
			log.Logger.Error("读取模板信息出错:", err)
			(*data)["templates"] = []interface{}{}
		} else {
			(*data)["templates"] = templates
		}

		countryFees := []models.CountryFee{}
		cArr := []string{"0"}
		cSQL := fmt.Sprintf("SELECT country_list FROM merchants WHERE id = %d", merchant.ID)
		if cRows, err := mConn.SQL(cSQL).QueryString(); err != nil {
			log.Logger.Error("获取商户渠道信息有误:", err)
		} else if len(cRows) > 0 {
			countryList := strings.TrimSpace(cRows[0]["country_list"])
			fmt.Println("list: ", countryList)
			if countryList != "" {
				if err := json.Unmarshal([]byte(countryList), &countryFees); err != nil {
					log.Logger.Error("获取国家渠道信息失败:", err, ", content = ", countryList)
				} else {
					ffmt.Puts(countryFees)
					for _, r := range countryFees {
						cArr = append(cArr, r.CountryID)
					}
				}
			}
		}

		countries := []models.Country{}
		wSQL := fmt.Sprintf("is_support = 1 AND id IN (%s)", strings.Join(cArr, ","))
		fmt.Println("sql: ", wSQL)
		if err := mConn.Table("countries").Where(wSQL).Find(&countries); err != nil {
			fmt.Println("获取国家信息有误:", err)
		}
		(*data)["countries"] = countries

		channels := []models.MessageChannel{}
		wSQL = fmt.Sprintf("id IN (%s)", merchant.ChannelList)
		if err := mConn.Table("message_channels").Where(wSQL).Find(&channels); err != nil {
			log.Logger.Error("获取短信渠道有误:", err)
		}
		(*data)["channels"] = channels
	},
}

// Save 保存
var Save = actions.Save{
	Model: models.MessageBatches,
	SaveBefore: func(c *gin.Context, m *map[string]interface{}) error {
		listVal, exists := (*m)["phone_list"]
		if !exists {
			return errors.New("必须提供发送短信的电话号码")
		}

		// 过滤掉空白的部分
		rArr := getRealPhones(listVal.(string))
		sendCount := len(rArr)
		if sendCount == 0 {
			return errors.New("需要发送的短信数量为0")
		}

		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			return errors.New("缺少商户信息")
		}

		(*m)["merchant_id"] = merchant.ID
		(*m)["merchant_name"] = merchant.Name

		mConn := db.Get(platform)
		defer mConn.Close()

		var merchantAccount models.MerchantAccount
		if exists, err := mConn.Table("merchant_accounts").Where("merchant_id = ?", merchant.ID).Get(&merchantAccount); err != nil || !exists {
			log.Logger.Error("获取商户账户信息失败")
			return errors.New("获取商户账户信息失败")
		} else if exists && merchantAccount.CountRemain < sendCount {
			return errors.New(fmt.Sprintf("可用短信数量(%d)不足以发送(%d)条短信", merchantAccount.CountRemain, sendCount))
		}

		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	SaveAfter: func(c *gin.Context, m *map[string]interface{}) {
		listVal, exists := (*m)["phone_list"]
		if !exists {
			return
		}

		// 过滤掉空白的部分
		rArr := getRealPhones(listVal.(string))
		sendCount := len(rArr)
		if sendCount == 0 {
			return
		}
		phoneList := strings.Join(rArr, ",")

		platform := request.GetPlatform(c)
		myClient := db.Get(platform)
		defer myClient.Close()

		var countries []models.Country
		if err := myClient.Table("countries").Where("is_support = 1").Find(&countries); err != nil {
			log.Logger.Error("获取国家列表错误:", err)
			return
		}
		getCountry := func(id int) *models.Country {
			for _, r := range countries {
				if r.ID == id {
					return &r
				}
			}
			return nil
		}

		merchantID, mErr := strconv.Atoi(fmt.Sprintf("%v", (*m)["merchant_id"]))
		if mErr != nil {
			log.Logger.Error("获取商户编号失败:", mErr)
			return
		}

		currentTime := utils.TimeMicro() // 当前时间
		pArr := strings.Split(phoneList, ",")
		kArr := []string{}
		for _, p := range pArr {
			phoneNumber := strings.TrimSpace(p)
			if phoneNumber == "" {
				continue
			}

			countryID := 0
			phonePrefix := ""
			phoneFull := ""
			if countryIDVal, err := strconv.Atoi(fmt.Sprintf("%v", (*m)["country_id"])); err != nil {
				log.Logger.Error("获取国家编号信息出错:", err)
			} else {
				if country := getCountry(countryIDVal); country != nil {
					countryID = country.ID
					phonePrefix = country.PhonePrefix
					phoneFull = fmt.Sprintf("+%s%s", country.PhonePrefix, p)
				}
			}

			billNo := utils.GetBillNo("MB")
			kArr = append(kArr, billNo)
			data := map[string]interface{}{
				"merchant_id":   merchantID,
				"merchant_name": (*m)["merchant_name"].(string),
				"order_number":  billNo,
				"country_id":    countryID,
				"channel_id":    (*m)["channel_id"],
				"template_id":   (*m)["template_id"],
				"phone_prefix":  phonePrefix,
				"phone":         p,
				"phone_full":    phoneFull,
				"content":       (*m)["content"],
				"created":       utils.TimeMicro(),
			}

			if _, err := myClient.Table("messages").Insert(data); err != nil {
				log.Logger.Error("写入短信记录发生错误:", err)
			}
		}

		if len(kArr) == 0 {
			return
		}

		// 冻结可用短信数量
		var merchantAccount models.MerchantAccount
		if exists, err := myClient.SQL("SELECT * FROM merchant_accounts WHERE merchant_id = ? FOR UPDATE", merchantID).Get(&merchantAccount); err == nil && exists {
			data := map[string]interface{}{
				"count_remain": merchantAccount.CountRemain - sendCount,
				"count_frozen": merchantAccount.CountFrozen + sendCount,
			}
			if _, err := myClient.Table("merchant_accounts").Where("merchant_id = ?", merchantAccount.MerchantID).Update(data); err != nil {
				log.Logger.Error("扣除短信数量有误:", err)
			}
		}

		var rows []models.Message
		wSQL := fmt.Sprintf("state = 0 AND order_number IN ('%s') AND created >= %d", strings.Join(kArr, "','"), currentTime)
		if err := myClient.Table("messages").Where(wSQL).Find(&rows); err != nil {
			log.Logger.Error("获取短信记录失败:", err)
		} else {
			rConn := cache.Get(platform)
			defer cache.Restore(platform, rConn)

			for _, r := range rows {
				r.PushForSend(rConn)
			}
		}
	},
}
