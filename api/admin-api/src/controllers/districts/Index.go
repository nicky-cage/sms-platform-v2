package districts

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.District]{
	Model: models.Districts,
	QueryCond: map[string]interface{}{
		"card_number": "%",
		"user_names":  "%",
	},
}

var Save = actions.Save{
	Model: models.Districts,
}
