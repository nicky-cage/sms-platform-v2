package countries

import (
	"common/request"
	"github.com/gin-gonic/gin"
	"models"
	"xorm.io/builder"

	"admin-api/controllers/actions"
)

// Index 列表
var Index = &actions.List[models.Country]{
	Model: models.Countries,
	QueryCond: map[string]interface{}{
		"name":         "%",
		"name_english": "%",
	},
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)
		var channels []models.MessageChannel
		cond := builder.NewCond()
		cond = cond.And(builder.Eq{"state": 1})
		_ = models.MessageChannels.FindAllNoCount(platform, &channels, cond)
		(*data)["channels"] = channels
	},
}

// Save 保存
var Save = actions.Save{
	Model: models.Countries,
}
