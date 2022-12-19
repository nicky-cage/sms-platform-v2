package permissionips

import (
	"admin-api/controllers/actions"
	"common/log"
	"common/utils"
	"github.com/gin-gonic/gin"
	"models"
)

// Index 列表
var Index = &actions.List[models.PermissionIP]{
	Model: models.PermissionIps,
}

var Save = actions.Save{
	Model: models.PermissionIps,
	CreateBefore: func(c *gin.Context, m *map[string]interface{}) error {
		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	SaveBefore: func(c *gin.Context, m *map[string]interface{}) error {
		admin := models.Admins.GetLoginAdmin(c)
		if admin == nil {
			log.Logger.Error("获取后台用户信息有误")
			return nil
		}

		(*m)["admin_id"] = admin.ID
		(*m)["admin_name"] = admin.Name
		return nil
	},
	UpdateBefore: func(c *gin.Context, m *map[string]interface{}) error {
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
}
