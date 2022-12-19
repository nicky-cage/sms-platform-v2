package cmd

// CronConfig 有什么其他的配置，往这里添加
type CronConfig struct {
	GroupType int    // 定时任务分组标记
	CmdName   string // 任务名称
}

// CronCommon 基类
type CronCommon struct {
	Config CronConfig
}

// GetSpec 得到定义时间频率
func (ths *CronCommon) GetSpec() string {
	return "0 */15 * * * *" //3分钟频率
}

// SetConfig 设置配置信息
func (ths *CronCommon) SetConfig() {}

// GetConfig 得到配置信息
func (ths *CronCommon) GetConfig() CronConfig {
	return ths.Config
}

// Run 运行程序
func (ths *CronCommon) Run() {}
