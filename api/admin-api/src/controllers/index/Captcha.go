package index

import (
	"common/captchas"
	"common/request"
	"common/response"

	"github.com/gin-gonic/gin"
)

func Captcha(c *gin.Context) {
	platform := request.GetPlatform(c)
	img := captchas.NewCaptchaWith(platform, 28, 127, 5)
	response.Result(c, img.GenerateCaptcha())
}
