package recordreceipts

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"github.com/gin-gonic/gin"
	"merchant-api/controllers/actions"
	"models"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.MessageReceipt]{
	Model: models.MessageReceipts,
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
			return cond
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
}
