package merchantaccounts

import (
	"admin-api/controllers/actions"
	"common/cache"
	"common/request"
	"models"

	"github.com/gin-gonic/gin"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.MerchantAccount]{
	Model: models.MerchantAccounts,
	QueryCond: map[string]interface{}{
		"merchant_name": "%",
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
			cond = cond.And(builder.Eq{"parent_id": merchant.ID})
		}

		return cond
	},
}
