package adminloginlogs

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.AdminLoginLog]{
	Model: models.AdminLoginLogs,
	QueryCond: map[string]interface{}{
		"card_number": "%",
		"user_names":  "%",
	},
}
