package parametergroups

import (
	"admin-api/controllers/actions"
	"models"
)

// Index 列表
var Index = &actions.List[models.ParameterGroup]{
	QueryCond: map[string]interface{}{
		"name":   "%",
		"title":  "%",
		"remark": "%",
	},
	Model: models.ParameterGroups,
}

// Save 保存
var Save = actions.Save{
	Model: models.ParameterGroups,
}
