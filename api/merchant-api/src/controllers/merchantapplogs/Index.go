package merchantapplogs

import (
	"github.com/gin-gonic/gin"
	"merchant-api/controllers/actions"
	"models"
)

// Index 列表
var Index = &actions.List[models.MerchantAppLog]{
	Model: models.MerchantAppLogs,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
}
