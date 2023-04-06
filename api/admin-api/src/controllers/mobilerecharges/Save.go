package mobilerecharges

import (
	"admin-api/controllers/actions"
	"common/cache"
	"common/request"
	"common/utils"
	"github.com/gin-gonic/gin"
	"models"
)

var Save = actions.Save{
	Model: models.MobileRecharges,
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {
		platform := request.GetPlatform(c)

		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		billNo := utils.GetBillNo("MB")
		(*data)["created"] = utils.TimeMicro()
		(*data)["order_number"] = billNo
		return nil
	},
}
