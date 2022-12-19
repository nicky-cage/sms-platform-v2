package recordreceipts

import (
	"admin-api/controllers/actions"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.MessageReceipt]{
	Model: models.MessageReceipts,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
}
