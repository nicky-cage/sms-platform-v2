package adminroles

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.AdminRole]{
	Model: models.AdminRoles,
	QueryCond: map[string]interface{}{
		"card_number": "%",
		"user_names":  "%",
	},
}
