package cities

import (
	"models"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.City]{
	Model: models.Cities,
	QueryCond: map[string]interface{}{
		"card_number": "%",
		"user_names":  "%",
	},
}

var Save = actions.Save{
	Model: models.Cities,
}
