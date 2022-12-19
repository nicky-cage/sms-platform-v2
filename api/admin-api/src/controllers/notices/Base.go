package notices

import (
	"admin-api/controllers/actions"
	"models"
)

// Index 列表
var Index = &actions.List[models.Notice]{
	QueryCond: map[string]interface{}{
		"title": "%",
		"state": "=",
	},
	Model: models.Notices,
}

// Save 保存
var Save = actions.Save{
	Model: models.Notices,
}
