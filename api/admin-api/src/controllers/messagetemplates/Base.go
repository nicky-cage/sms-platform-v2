package messagetemplates

import (
	"admin-api/controllers/actions"
	"common/cache"
	"common/request"
	"common/utils"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.MessageTemplate]{
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
	Model: models.MessageTemplates,
}

var Save = actions.Save{
	Model: models.MessageTemplates,
	CreateBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	UpdateBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {
		platform := request.GetPlatform(c)

		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
			(*data)["merchant_id"] = merchant.ID
			(*data)["merchant_name"] = merchant.Name
		}

		return nil
	},
}
