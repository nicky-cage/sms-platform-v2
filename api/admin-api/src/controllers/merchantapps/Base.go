package merchantapps

import (
	"admin-api/controllers/actions"
	"common/request"
	"common/utils"
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	"models"
	"strconv"
)

// Index 列表
var Index = &actions.List[models.MerchantApp]{
	Model: models.MerchantApps,
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)
		var rows []models.Merchant
		_ = models.Merchants.FindAllNoCount(platform, &rows)
		(*data)["merchants"] = rows
	},
}

var Save = actions.Save{
	Model: models.MerchantApps,
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {
		if idStr, _ := (*data)["merchant_id"]; idStr == "" {
			return errors.New("必须先择商户")
		} else {
			row := models.Merchant{}
			platform := request.GetPlatform(c)
			id, _ := strconv.Atoi(fmt.Sprintf("%v", (*data)["merchant_id"]))
			if exists, err := models.Merchants.FindByID(platform, id, &row); err != nil || !exists {
				return errors.New("缺少必要的商户名称")
			}
			(*data)["merchant_name"] = row.Name
		}

		(*data)["created"] = utils.TimeMicro()
		(*data)["updated"] = utils.TimeMicro()
		return nil
	},
}
