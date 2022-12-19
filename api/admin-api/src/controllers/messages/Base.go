package messages

import (
	"admin-api/controllers/actions"
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"github.com/gin-gonic/gin"
	"models"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.Message]{
	Model: models.Messages,
	QueryCond: map[string]interface{}{
		"message_id": "%",
		"content":    "%",
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
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
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
		}

		return cond
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
