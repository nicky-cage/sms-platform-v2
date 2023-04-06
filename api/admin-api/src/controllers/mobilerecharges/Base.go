package mobilerecharges

import (
	"admin-api/controllers/actions"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.MobileRecharge]{
	Model: models.MobileRecharges,
	QueryCond: map[string]interface{}{
		"mobile_phone": "%",
	},
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
}
