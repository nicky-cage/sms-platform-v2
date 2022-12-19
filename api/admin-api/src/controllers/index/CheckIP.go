package index

import (
	"common/log"
	db "common/mysql"
	"common/request"
	"common/response"
	"github.com/gin-gonic/gin"
	"models"
)

// CheckIP 检测IP
func CheckIP(c *gin.Context) {

	platform := request.GetPlatform(c)
	clientIP := c.ClientIP()

	mConn := db.Get(platform)
	defer mConn.Close()

	var permissionIP models.PermissionIP
	if exists, err := mConn.Table("permission_ips").
		Where("ip = ? AND permission_type = 1", clientIP).Get(&permissionIP); err != nil {
		log.Logger.Error("获取授权IP出错:", err)
		response.Err(c, "获取授权IP出错")
		return
	} else if !exists {
		response.Err(c, "未授权IP无法登录")
		return
	}

	response.Ok(c)
}
