package messagebatches

import (
	"admin-api/controllers/actions"
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/utils"
	"fmt"
	"github.com/gin-gonic/gin"
	"models"
	"strconv"
	"strings"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.MessageBatch]{
	Model: models.MessageBatches,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)
		var templates []models.MessageTemplate
		_ = models.MessageTemplates.FindAllNoCount(platform, &templates)
		(*data)["templates"] = templates

		var countries []models.Country
		cond := builder.NewCond()
		cond = cond.And(builder.Eq{"is_support": 1})
		_ = models.Countries.FindAllNoCount(platform, &countries, cond)
		(*data)["countries"] = countries

		var channels []models.MessageChannel
		cond = builder.NewCond()
		cond = cond.And(builder.Eq{"state": 1})
		_ = models.MessageChannels.FindAllNoCount(platform, &channels, cond)
		(*data)["channels"] = channels
	},
}

// Save 保存
var Save = actions.Save{
	Model: models.MessageBatches,
	SaveBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	SaveAfter: func(c *gin.Context, m *map[string]interface{}) {
		if listVal, exists := (*m)["phone_list"]; exists {
			phoneList := strings.TrimSpace(listVal.(string))
			if phoneList == "" {
				return
			}

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
					"order_number": billNo,
					"country_id":   countryID,
					"channel_id":   (*m)["channel_id"],
					"template_id":  (*m)["template_id"],
					"phone_prefix": phonePrefix,
					"phone":        p,
					"phone_full":   phoneFull,
					"content":      (*m)["content"],
					"created":      utils.TimeMicro(),
				}

				if _, err := myClient.Table("messages").Insert(data); err != nil {
					log.Logger.Error("写入短信记录发生错误:", err)
				}
			}

			if len(kArr) == 0 {
				return
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
		}
	},
}
