package provinces

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.Province]{
	Model: models.Provinces,
	QueryCond: map[string]interface{}{
		"name": "%",
		"code": "%",
	},
}

var Save = actions.Save{
	Model: models.Provinces,
}
