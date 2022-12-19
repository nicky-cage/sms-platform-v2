package messagecounts

import (
	"common/response"

	"github.com/gin-gonic/gin"
)

// Index 列表
func Index(c *gin.Context) {
	response.Pager(c, []interface{}{}, 0)
}
