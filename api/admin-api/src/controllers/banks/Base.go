package banks

import (
	"admin-api/controllers/actions"
	"models"
)

var List = actions.List[models.Bank]{
	Model: models.Banks,
	QueryCond: map[string]interface{}{
		"name": "%",
		"code": "%",
	},
}

var Save = actions.Save{
	Model: models.Banks,
}
