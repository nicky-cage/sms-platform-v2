package index

import (
	"common/response"
	"net/url"

	"github.com/gin-gonic/gin"
	"github.com/skip2/go-qrcode"
)

func QRCode(c *gin.Context) { // https://xxx/index/qr?code=xxx
	code := c.DefaultQuery("code", "https://google.com") // 需要从外部传过来
	var png []byte
	png, err := qrcode.Encode(url.QueryEscape(code), qrcode.Medium, 256)
	if err != nil {
		response.RenderString(c, "")
		return
	}
	response.RenderString(c, string(png))
}
