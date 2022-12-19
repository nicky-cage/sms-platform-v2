package merchantloginlogs

import (
	"admin-api/controllers/actions"
	"models"

	"github.com/gin-gonic/gin"
)

// Index 列表
var Index = &actions.List[models.MerchantLoginLog]{
	Model: models.MerchantLoginLogs,
	QueryCond: map[string]interface{}{
		"merchant_name": "%",
	},
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
}
