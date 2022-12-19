package reportmerchants

import (
	"admin-api/controllers/actions"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.ReportMerchant]{
	OrderBy: func(c *gin.Context) string {
		return "`date` DESC"
	},
	Model: models.ReportMerchants,
}
