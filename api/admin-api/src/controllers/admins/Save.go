package admins

import (
	"admin-api/controllers/actions"
	"common/utils"
	"errors"
	"github.com/gin-gonic/gin"
	"models"
	"strings"
)

var Save = actions.Save{
	Model: models.Admins,
	CreateBefore: func(c *gin.Context, m *map[string]interface{}) error {
		passVal := strings.TrimSpace((*m)["password"].(string))
		if passVal == "" {
			return errors.New("必须输入密码")
		}
		if len(passVal) > 20 || len(passVal) < 6 {
			errors.New("密码格式不对")
		}
		salt := utils.Secret()
		realPass := utils.GetPassword(passVal, salt)
		(*m)["salt"] = salt
		(*m)["password"] = realPass

		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	UpdateBefore: func(c *gin.Context, m *map[string]interface{}) error {
		(*m)["updated"] = utils.TimeMicro()

		passVal := strings.TrimSpace((*m)["password"].(string))
		if passVal == "" {
			delete(*m, "password")
			return nil
		}

		if len(passVal) > 20 || len(passVal) < 6 {
			return errors.New("密码格式不对")
		}

		salt := utils.Secret()
		realPass := utils.GetPassword(passVal, salt)
		(*m)["salt"] = salt
		(*m)["password"] = realPass
		return nil
	},
}
