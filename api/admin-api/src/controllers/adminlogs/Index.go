package adminlogs

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.AdminLog]{
	Model: models.AdminLogs,
	QueryCond: map[string]interface{}{
		"card_number": "%",
		"user_names":  "%",
	},
}
