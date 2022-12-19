package reportcounts

import (
	"admin-api/controllers/actions"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.ReportCount]{
	OrderBy: func(c *gin.Context) string {
		return "`date` DESC"
	},
	Model: models.ReportCounts,
}
