package cmd

// CommandRun 通用接口
type CommandRun interface {
	GetSpec() string           // 定义执行间隔
	SetConfig()                // 设置配置
	GetConfig() CronConfig     // 获取配置
	Run()                      // 运行
	SubCommands() []CommandRun // 子命令 - 子定时任务
}
