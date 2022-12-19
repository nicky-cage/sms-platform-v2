package messages

import (
	"common/log"
	db "common/mysql"
	"common/request"
	"common/response"
	"fmt"
	"github.com/gin-gonic/gin"
	"models"
	"strconv"
)

var Check = func(c *gin.Context) {
	idStr := c.DefaultQuery("id", "0")
	realID, rErr := strconv.Atoi(idStr)
	if rErr != nil || realID <= 0 {
		response.Err(c, "记录编号有误")
		return
	}

	platform := request.GetPlatform(c)
	myClient := db.Get(platform)
	defer myClient.Close()

	var message models.Message
	if mExists, mErr := myClient.Table("messages").Where("id = ?", realID).Get(&message); mErr != nil {
		fmt.Println("获取信息有误:", mErr)
		response.Err(c, "获取记录有误:"+mErr.Error())
		return
	} else if !mExists {
		response.Err(c, "相关记录并不存在")
		return
	}

	if err := message.Query(myClient); err != nil {
		log.Logger.Error("查询记录出错:", err)
	}

	var channel models.MessageChannel
	if cExists, cErr := myClient.Table("message_channels").Where("id = ?", message.ChannelID).Get(&channel); cErr != nil {
		fmt.Println("获取渠道信息出错:", cErr)
		response.Err(c, "")
	} else if !cExists {
		fmt.Println("获取渠道信息出错:", cErr)
		response.Err(c, "")
	}

	response.Message(c, "状态刷新成功")
}
