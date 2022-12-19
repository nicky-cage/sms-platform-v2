package cmd

// CommandList 执行的列表命令
var CommandList = []CommandRun{
	&SendMessages{},
	&QueryMessages{},
	&ReportMerchants{},
	&ReportStatistics{},
}
