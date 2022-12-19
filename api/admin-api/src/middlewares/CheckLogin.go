package middlewares

import (
	"common/cache"
	"common/request"
	"common/response"
	"models"

	"github.com/gin-gonic/gin"
)

// CheckLogin 检测用户是否已经登录
func CheckLogin() gin.HandlerFunc {
	return func(c *gin.Context) {

		if c.Request.Host == "admin.ip.vhost" {
			c.Next()
			return
		}

		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		admin := models.Admins.GetByToken(rConn, token)
		if admin == nil {
			response.ErrWithCodeMsg(c, 405, "还未登录或者登录已经失效, 请重新登录")
			return
		}

		models.Admins.TokenRefresh(rConn, token) // 刷新缓存

		c.Next()
	}
}
