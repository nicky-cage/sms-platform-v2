package cmd

import (
	"common/cache"
	"common/consts"
	db "common/mysql"
	"fmt"
	"models"
)

// var LastScanning int64 = 0

// SendMessages 运营报表
type SendMessages struct {
	CronCommon
}

// GetSpec 覆盖老的定时器频率
func (ths *SendMessages) GetSpec() string {
	return "*/3 * * * * *"
}

// SetConfig 配置
func (ths *SendMessages) SetConfig() {
	if ths.Config.GroupType == 0 {
		ths.Config = CronConfig{
			GroupType: 6,               // 报表任务
			CmdName:   "send-messages", // 运营报表
		}
	}
}

// Run 运行
func (ths *SendMessages) Run() {
	for _, platform := range consts.PlatformCodes {
		ths.DoTaskByPlatform(platform)
	}
}

// DoTaskByPlatform 按平台
func (ths *SendMessages) DoTaskByPlatform(platform string) {
	myClient := db.Get(platform)
	defer myClient.Close()

	rConn := cache.Get(platform)
	defer cache.Restore(platform, rConn)

	// 一直取数据到没有数据为止
	for {
		message := models.Messages.PopForSend(rConn)
		if message == nil {
			break
		}
		if message.Failure >= 1 {
			fmt.Println("失败次数过多, 将不再重试")
		}
		if message.MessageID != "" { // 表示已经发送过了
			fmt.Println("此条信息已经发送, 请待回执查询")
			message.PushForQuery(rConn) // 准备查询
			return
		}

		message.Send(myClient, rConn)
		//message.PushForQuery(rConn) // 准备查询
	}
}

// SubCommands 得到相关的子命令
func (ths *SendMessages) SubCommands() []CommandRun {
	return nil
}
