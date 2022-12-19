package parameters

import (
	"admin-api/controllers/actions"
	"common/request"
	"models"

	"github.com/gin-gonic/gin"
)

// Index 列表
var Index = &actions.List[models.Parameter]{
	Model: models.Parameters,
	QueryCond: map[string]interface{}{
		"group_id": "=",
		"name":     "%",
		"title":    "%",
		"remark":   "%",
	},
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)
		var rows []models.ParameterGroup
		_ = models.ParameterGroups.FindAllNoCount(platform, &rows)
		(*data)["parameter_groups"] = rows
	},
}

// Save 保存
var Save = actions.Save{
	Model: models.Parameters,
}
