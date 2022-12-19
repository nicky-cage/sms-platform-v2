package recordcompletes

import (
	"admin-api/controllers/actions"
	"github.com/gin-gonic/gin"
	"models"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.Message]{
	Model: models.Messages,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		cond = cond.And(builder.Eq{"state": 1}) // 只取成功的状态
		return cond
	},
}
