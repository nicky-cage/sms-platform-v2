package merchants

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
	"merchant-api/controllers/actions"
	"models"
	"strings"
	"xorm.io/builder"
)

type ChannelCountry struct {
	ID        int             `json:"id"`
	Name      string          `json:"name"`
	Countries []models.IDName `json:"countries"`
}

// Index 列表
var Index = &actions.List[models.Merchant]{
	Model: models.Merchants,
	OrderBy: func(c *gin.Context) string {
		return "updated DESC"
	},
	QueryCond: map[string]interface{}{
		"name":          "%",
		"merchant_name": "%",
		"state":         "=",
		"remark":        "%",
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
			cond = cond.And(builder.Eq{"parent_id": merchant.ID})
			cond = cond.Or(builder.Eq{"id": merchant.ID})
		}

		return cond
	},
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)

		myClient := db.Get(platform)
		defer myClient.Close()

		merchant := models.Merchants.GetLoginMerchant(c) // 当前登录商户
		if merchant == nil {
			log.Logger.Error("获取商户登录信息失败")
			return
		}

		var channels []models.MessageChannel
		wSQL := fmt.Sprintf("SELECT message_channels.* FROM message_channels,merchants "+
			"WHERE merchants.id = %d AND message_channels.id IN (merchants.channel_list) LIMIT 1", merchant.ID)
		if err := myClient.SQL(wSQL).Find(&channels); err != nil {
			fmt.Println("获取渠道信息有误:", err)
		}

		countryFees := []models.CountryFee{}
		cArr := []string{"0"}
		fSQL := fmt.Sprintf("SELECT country_list FROM merchants WHERE id = %d", merchant.ID)
		if cRows, err := myClient.SQL(fSQL).QueryString(); err != nil {
			log.Logger.Error("获取商户渠道信息有误:", err)
		} else if len(cRows) > 0 {
			countryList := strings.TrimSpace(cRows[0]["country_list"])
			if countryList != "" {
				if err := json.Unmarshal([]byte(countryList), &countryFees); err != nil {
					log.Logger.Error("获取国家渠道信息失败:", err, ", content = ", countryList)
				} else {
					for _, r := range countryFees {
						cArr = append(cArr, r.CountryID)
					}
				}
			}
		}

		countries := []models.Country{}
		cSQL := fmt.Sprintf("is_support = 1 AND id IN (%s)", strings.Join(cArr, ","))
		if err := myClient.Table("countries").Where(cSQL).Find(&countries); err != nil {
			fmt.Println("获取国家信息有误:", err)
		}

		(*data)["channels"] = channels
		(*data)["countries"] = countries
		(*data)["country_fees"] = countryFees
		(*data)["merchant_id"] = merchant.ID
	},
}

// Save 保存
var Save = actions.Save{
	Model: models.Merchants,
	CreateBefore: func(c *gin.Context, m *map[string]interface{}) error {

		passVal, exists := (*m)["password"]
		if !exists {
			return errors.New("必须输入登录密码")
		}

		password := strings.TrimSpace(passVal.(string))
		if len(password) < 6 || len(password) > 20 {
			return errors.New("用户密码格式不正确")
		}

		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()

		salt := utils.Secret()
		realPassword := utils.GetPassword(password, salt)
		(*m)["password"] = realPassword
		(*m)["salt"] = salt

		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
			(*m)["parent_id"] = merchant.ID
			(*m)["parent_name"] = merchant.Name
		}

		return nil
	},
	UpdateBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["updated"] = utils.TimeMicro()
		passVal, exists := (*m)["password"]
		if !exists { // 只要输入密码时才进行修改
			return nil
		}

		password := strings.TrimSpace(passVal.(string))
		if password == "" {
			delete(*m, "password") // 删掉关于空的字段
			return nil
		}
		if len(password) < 6 || len(password) > 20 {
			return errors.New("用户密码格式不正确")
		}

		salt := utils.Secret()
		realPassword := utils.GetPassword(password, salt)
		(*m)["password"] = realPassword
		(*m)["salt"] = salt
		return nil
	},
	SaveBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["merchant_code"] = utils.GetRandString(32)
		return nil
	},
	SaveAfter: func(c *gin.Context, m *map[string]interface{}) {
		if merchantNameStr, exists := (*m)["name"]; exists && merchantNameStr != "" {
			platform := request.GetPlatform(c)
			myClient := db.Get(platform)
			defer myClient.Close()
			merchantName := merchantNameStr.(string)

			merchantID := func() int {
				var merchant models.Merchant
				if has, err := myClient.Table("merchants").
					Where("name = ?", merchantName).Get(&merchant); err != nil {
					log.Logger.Error("读取产户信息出错")
					return 0
				} else if err == nil && has {
					return merchant.ID
				}
				return 0
			}()
			if merchantID <= 0 {
				log.Logger.Error("无法获取商户信息")
				return
			}

			var merchantAccount models.MerchantAccount
			if has, err := myClient.Table("merchant_accounts").
				Where("merchant_name = ?", merchantName).Get(&merchantAccount); err != nil {
				fmt.Println("写入错误:", err)
			} else if err == nil && !has {
				merchantName := (*m)["name"].(string)
				data := map[string]interface{}{
					"merchant_id":   merchantID,
					"merchant_name": merchantName,
				}

				rConn := cache.Get(platform)
				defer cache.Restore(platform, rConn)

				token := request.GetAuthorization(c)
				if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
					data["parent_id"] = merchant.ID
					data["parent_name"] = merchant.Name
				}

				if _, err := myClient.Table("merchant_accounts").Insert(data); err != nil {
					log.Logger.Error("写入商户信息失败:", err)
				}
			}
		}
	},
}
