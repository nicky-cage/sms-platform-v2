package main

import (
	"common/flags"
	"common/log"
	"crontab/cmd"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/robfig/cron/v3"
	"models"
)

// / main
func main() {

	flags.InitConfigs()
	log.Start() //启动日志程序

	// 定时任务
	// 也可以秒级任务
	// c := cron.New(cron.WithSeconds()) // 创建定时任务 秒
	// spec := "0 */1 * * * *" // 每一分钟 如果用到分钟, 秒要设置为0
	// spec := "* */1 * * * *"
	// 六个作用域的意义
	// 秒钟域（1） 分钟域（2） 小时域（3） 日期域（4） 月份域（5） 星期域（6）
	//特定字符星号（ *）
	//特定字符斜划线 （/）
	//spec = "*/5 * 1 * * * *" // 每5秒，
	//spec = " * 1 * * * *" // 每1分钟，
	c := cron.New(cron.WithSeconds()) // 定时任务开启

	// 加载所有未发送的消息到缓存当中
	models.Messages.LoadCacheAll()

	addJobToCrontab := func(job cmd.CommandRun) {
		// job.SetConfig()
		cfg := job.GetConfig() // 定时任务遇到panic,自动恢复
		executeTime := job.GetSpec()
		wrapper := cron.NewChain(cron.Recover(cron.DefaultLogger), cron.SkipIfStillRunning(cron.DefaultLogger))
		entryId, err := c.AddJob(executeTime, wrapper.Then(job))
		if err != nil {
			fmt.Println("加入计划任务有误:", err)
			log.Logger.Errorf("定时任务配置: %#v 启动失败!", cfg)
			return
		}
		log.Logger.Infof("定时任务: %#v 成功运行, 编号: %d", cfg, entryId)
	}

	for _, job := range cmd.CommandList {
		addJobToCrontab(job)
		subCommands := job.SubCommands() // 如果有子命令, 则也要将子命令加入到队列当中
		if len(subCommands) > 0 {
			for _, sub := range subCommands {
				addJobToCrontab(sub)
			}
		}
	}

	c.Start()
	fmt.Printf("定时任务启动成功 ...\n")
	defer c.Stop() // 关闭着计划任务, 但是不能关闭已经在执行中的任务.
	select {}
}
