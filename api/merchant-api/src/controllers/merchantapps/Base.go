package merchantapps

import (
	"common/cache"
	"common/request"
	"common/utils"
	"errors"
	"github.com/gin-gonic/gin"
	"merchant-api/controllers/actions"
	"models"
	"strings"
)

// Index 列表
var Index = &actions.List[models.MerchantApp]{
	Model: models.MerchantApps,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
}

var Save = actions.Save{
	Model: models.MerchantApps,
	CreateBefore: func(context *gin.Context, data *map[string]interface{}) error {
		(*data)["app_key"] = strings.ToUpper(utils.GetRandString(32)) // 生成 app key
		return nil
	},
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			return errors.New("查找商户信息失败")
		}

		(*data)["merchant_id"] = merchant.ID
		(*data)["merchant_name"] = merchant.Name
		(*data)["created"] = utils.TimeMicro()
		(*data)["updated"] = utils.TimeMicro()
		return nil
	},
}
