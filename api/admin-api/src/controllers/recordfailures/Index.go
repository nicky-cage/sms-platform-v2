package recordfailures

import (
	"admin-api/controllers/actions"
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

		return cond
	},
}
