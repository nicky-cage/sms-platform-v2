package messagechannels

import (
	"common/utils"
	"github.com/gin-gonic/gin"
	"merchant-api/controllers/actions"
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
