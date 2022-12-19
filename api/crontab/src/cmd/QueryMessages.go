package cmd

import (
	"common/cache"
	"common/consts"
	"common/log"
	db "common/mysql"
	"fmt"
	"models"
)

// QueryMessages 运营报表
type QueryMessages struct {
	CronCommon
}

// GetSpec 覆盖老的定时器频率
func (ths *QueryMessages) GetSpec() string {
	return fmt.Sprintf("*/30 * * * * *")
}

// SetConfig 配置
func (ths *QueryMessages) SetConfig() {
	if ths.Config.GroupType == 0 {
		ths.Config = CronConfig{
			GroupType: 6,               // 报表任务
			CmdName:   "pull-messages", // 运营报表
		}
	}
}

// Run 运行
func (ths *QueryMessages) Run() {
	for _, platform := range consts.PlatformCodes {
		ths.DoTaskByPlatform(platform)
	}
}

// DoTaskByPlatform 按平台
func (ths *QueryMessages) DoTaskByPlatform(platform string) {
	myClient := db.Get(platform)
	defer myClient.Close()

	rConn := cache.Get(platform)
	defer cache.Restore(platform, rConn)

	for {
		message := models.Messages.PopForQuery(rConn)
		if message == nil {
			log.Logger.Error("获取要检测的信息失败: Nil - 没有要查询的短信")
			break // 表示没有可以取得的数据了, 暂停本次执行
		}
		if message.MessageID == "" {
			var row models.Message
			if exists, err := myClient.Table("messages").Where("id = ?", message.ID).Get(&row); err != nil {
				log.Logger.Error("获取消息失败:", err)
			} else if exists {
				message.MessageID = row.MessageID
			} else if !exists {
				log.Logger.Error("缺少MessageID无法查询:", message.Phone, " - ", message.Content)
			}
			continue
		}
		// 只查询发送时间超过30s的, 如果小于30秒, 则等会再查
		// if utils.TimeMicro()-message.Created < CheckSecond*1000*1000 {
		// 	fmt.Println("刚才发送的短信,一定时间之后再检测其状态")
		// 	message.PushForQuery(rConn)
		// 	continue
		// }
		if err := message.Query(myClient); err != nil {
			log.Logger.Error("查询信息状态发生错误:", err)
		}
	}
}

// SubCommands 得到相关的子命令
func (ths *QueryMessages) SubCommands() []CommandRun {
	return nil
}
