package messages

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"gopkg.in/ffmt.v1"
	"merchant-api/controllers/actions"
	"models"
	"strings"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.Message]{
	Model: models.Messages,
	QueryCond: map[string]interface{}{
		"content":    "%",
		"phone_full": "%",
		"message_id": "%",
	},
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
			log.Logger.Error("获取商户信息失败")
		}

		cond = cond.And(builder.Eq{"merchant_id": merchant.ID})

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
