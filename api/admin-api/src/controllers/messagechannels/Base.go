package messagechannels

import (
	"admin-api/controllers/actions"
	"common/utils"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.MessageChannel]{
	Model: models.MessageChannels,
}

var Save = actions.Save{
	Model: models.MessageChannels,
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {
		(*data)["created"] = utils.TimeMicro()
		(*data)["updated"] = utils.TimeMicro()
		return nil
	},
}
