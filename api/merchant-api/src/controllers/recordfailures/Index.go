package recordfailures

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"merchant-api/controllers/actions"
	"models"
	"xorm.io/builder"

	"github.com/gin-gonic/gin"
)

// Index 列表
var Index = &actions.List[models.Message]{
	Model: models.Messages,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		cond = cond.And(builder.Eq{"state": 0}) // 只取失败的

		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			log.Logger.Error("缺少商户登录信息")
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
