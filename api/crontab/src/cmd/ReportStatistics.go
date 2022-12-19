package cmd

import (
	"common/consts"
	"common/log"
	db "common/mysql"
	"common/utils"
	"fmt"
	"models"
	"strings"

	"github.com/go-xorm/xorm"
)

// TotalRecord 总计统计
type TotalRecord struct {
	Type     string `json:"type"`
	Total    int    `json:"total"`
	TotalNew int    `json:"total_new"`
}

// ReportStatistics 运营报表
type ReportStatistics struct {
	CronCommon
}

// GetSpec 覆盖老的定时器频率
func (ths *ReportStatistics) GetSpec() string {
	return "0 */2 * * * *"
}

// SetConfig 配置
func (ths *ReportStatistics) SetConfig() {
	if ths.Config.GroupType == 0 {
		ths.Config = CronConfig{
			GroupType: 6,                   // 报表任务
			CmdName:   "report-statistics", // 运营报表
		}
	}
}

// Run 运行
func (ths *ReportStatistics) Run() {
	for _, platform := range consts.PlatformCodes {
		ths.DoTaskByPlatform(platform)
	}
}

// DoTaskByPlatform 按平台
func (ths *ReportStatistics) DoTaskByPlatform(platform string) {
	myConn := db.Get(platform)
	defer myConn.Close()

	currentTime := utils.Time()
	currentDate := currentTime.Format("2006-01-02")
	todayTime := utils.GetDayBegin(currentDate) // 今天第一秒
	beginTime := todayTime - 86400*10           // 往后回计5天内的数据

	// 统计汇总
	var i int64
	for i = beginTime; i <= todayTime; i += 86400 {
		timeEnd := i + 86400
		ths.CountByTime(i, timeEnd, myConn)
	}
}

// CountByTime 按时间进行统计
func (ths *ReportStatistics) CountByTime(timeStart, timeEnd int64, myConn *xorm.Session) {
	timeBegin := timeStart * 1000 * 1000               // 开始时间
	timeFinish := timeEnd * 1000 * 1000                // 结束时间
	currentDate := utils.GetDateByTimestamp(timeStart) // 当前日期
	sArr := []string{
		fmt.Sprintf("(SELECT 'mer' AS type, COUNT(*) AS total, SUM(IF(created >= %d AND created < %d, 1, 0)) AS total_new FROM merchants)", timeBegin, timeFinish),         // 商户统计
		fmt.Sprintf("(SELECT 'app' AS type, COUNT(*) AS total, SUM(IF(created >= %d AND created < %d, 1, 0)) AS total_new FROM merchant_apps)", timeBegin, timeFinish),     // 商户统计
		fmt.Sprintf("(SELECT 'tem' AS type, COUNT(*) AS total, SUM(IF(created >= %d AND created < %d, 1, 0)) AS total_new FROM message_templates)", timeBegin, timeFinish), // 商户统计
		fmt.Sprintf("(SELECT 'msg' AS type, COUNT(*) AS total, SUM(state) AS total_new FROM messages WHERE created >= %d AND created < %d)", timeBegin, timeFinish),
	}
	totalSQL := strings.Join(sArr, " UNION ALL")
	var rows = []TotalRecord{}

	data := map[string]interface{}{
		"date": currentDate,
	}

	if err := myConn.SQL(totalSQL).Find(&rows); err != nil {
		log.Logger.Error("读取数据发生错误:", err)
		return
	}

	for _, r := range rows {
		if r.Type == "mer" {
			data["merchant_total"] = r.Total
			data["merchant_new"] = r.TotalNew
		} else if r.Type == "app" {
			data["app_total"] = r.Total
			data["app_new"] = r.TotalNew
		} else if r.Type == "tem" {
			data["template_total"] = r.Total
			data["template_new"] = r.TotalNew
		} else if r.Type == "msg" {
			data["total"] = r.Total            // 总计
			data["total_sent"] = r.Total       // 发送
			data["total_success"] = r.TotalNew // 成功
		}
	}

	row := models.IDRow{}
	if exists, err := myConn.SQL("SELECT id FROM report_counts WHERE `date` = ? LIMIT 1", currentDate).Get(&row); err != nil {
		log.Logger.Error("读取日报发生错误:", err)
	} else if !exists { // 如果已经有记录, 则进行修改
		data["created"] = utils.TimeMicro()
		data["updated"] = utils.TimeMicro()
		if _, err := myConn.Table("report_counts").Insert(data); err != nil {
			log.Logger.Error("写入报表日志发生错误:", err)
		}
	} else if exists { // 如果没有记录, 则添加
		delete(data, "date")
		data["updated"] = utils.TimeMicro()
		if _, err := myConn.Table("report_counts").Where("id = ?", row.Id).Update(data); err != nil {
			log.Logger.Error("更新报表日志发生错误:", err)
		}
	}
}

// SubCommands 得到相关的子命令
func (ths *ReportStatistics) SubCommands() []CommandRun {
	return nil
}
