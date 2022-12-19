package merchantapplogs

import (
	"admin-api/controllers/actions"
	"models"
)

// Index 列表
var Index = &actions.List[models.MerchantAppLog]{
	Model: models.MerchantAppLogs,
}
