package admins

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.Admin]{
	Model: models.Admins,
	QueryCond: map[string]interface{}{
		"card_number": "%",
		"user_names":  "%",
	},
}
