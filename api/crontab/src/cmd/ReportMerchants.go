package cmd

import (
	"common/consts"
	"common/log"
	db "common/mysql"
	"common/utils"
	"fmt"
	"models"

	"github.com/go-xorm/xorm"
)

// MerchantRecord 商户统计
type MerchantRecord struct {
	MerchantID int `json:"merchant_id" xorm:"merchant_id"`
	Total      int `json:"total"`
	TotalNew   int `json:"total_new"`
}

// ReportMerchants 运营报表
type ReportMerchants struct {
	CronCommon
}

// GetSpec 覆盖老的定时器频率
func (ths *ReportMerchants) GetSpec() string {
	return "0 */2 * * * *"
}

// SetConfig 配置
func (ths *ReportMerchants) SetConfig() {
	if ths.Config.GroupType == 0 {
		ths.Config = CronConfig{
			GroupType: 6,                  // 报表任务
			CmdName:   "report-merchants", // 运营报表
		}
	}
}

// Run 运行
func (ths *ReportMerchants) Run() {
	for _, platform := range consts.PlatformCodes {
		ths.DoTaskByPlatform(platform)
	}
}

// DoTaskByPlatform 按平台
func (ths *ReportMerchants) DoTaskByPlatform(platform string) {
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
func (ths *ReportMerchants) CountByTime(timeStart, timeEnd int64, myConn *xorm.Session) {
	timeBegin := timeStart * 1000 * 1000               // 开始时间
	timeFinish := timeEnd * 1000 * 1000                // 结束时间
	currentDate := utils.GetDateByTimestamp(timeStart) // 当前日期

	// 先获取所有商户信息
	var merchants []models.Merchant
	if err := myConn.Table("merchants").Find(&merchants); err != nil {
		log.Logger.Error("获取商户信息列表错误:", err)
		return
	}

	// 得到所有商户信息
	var parents []MerchantRecord
	merSQL := fmt.Sprintf("(SELECT parent_id AS merchant_id, COUNT(*) AS total, SUM(IF(created >= %d AND created < %d, 1, 0)) AS total_new FROM merchants GROUP BY parent_id)", timeBegin, timeFinish)
	if err := myConn.SQL(merSQL).Find(&parents); err != nil {
		log.Logger.Error("查询商户信息失败:", err)
		return
	}

	var apps []MerchantRecord
	aSQL := fmt.Sprintf("(SELECT merchant_id, COUNT(*) AS total, SUM(IF(created >= %d AND created < %d, 1, 0)) AS total_new FROM merchant_apps GROUP BY merchant_id)", timeBegin, timeFinish)
	if err := myConn.SQL(aSQL).Find(&apps); err != nil {
		log.Logger.Error("查询应用信息失败:", err)
		return
	}

	var mtRows []MerchantRecord
	mtSQL := fmt.Sprintf("(SELECT merchant_id, COUNT(*) AS total, SUM(IF(created >= %d AND created < %d, 1, 0)) AS total_new FROM message_templates GROUP BY merchant_id)", timeBegin, timeFinish)
	if err := myConn.SQL(mtSQL).Find(&mtRows); err != nil {
		log.Logger.Error("获取商户模板信息失败:", err)
		return
	}

	var mRows []MerchantRecord
	mSQL := fmt.Sprintf("(SELECT merchant_id, COUNT(*) AS total, SUM(state) AS total_new FROM messages WHERE created >= %d AND created < %d GROUP BY merchant_id)", timeBegin, timeFinish)
	if err := myConn.SQL(mSQL).Find(&mRows); err != nil {
		log.Logger.Error("读取信息记录出鐕:", err)
		return
	}

	for _, mr := range merchants {
		var tRow models.TotalInt
		if exists, err := myConn.SQL("SELECT id FROM report_merchants WHERE `date` = ? AND merchant_id = ?", currentDate, mr.ID).Get(&tRow); err != nil {
			log.Logger.Error("获取商户信息出错:", err)
			return
		} else if !exists { // 先创建记录
			if _, err := myConn.Table("report_merchants").Insert(map[string]interface{}{
				"date":          currentDate,
				"merchant_id":   mr.ID,
				"merchant_name": mr.Name,
				"created":       utils.TimeMicro(),
			}); err != nil {
				log.Logger.Error("写入基本信息出错")
			}
		}

		data := map[string]interface{}{
			"updated": utils.TimeMicro(),
		}
		// 计算下级商户数量
		for _, r := range parents {
			if r.MerchantID == mr.ID {
				data["merchant_children"] = r.Total
				data["merchant_new"] = r.TotalNew
				break
			}
		}
		// 计算ap数量
		for _, r := range parents {
			if r.MerchantID == mr.ID {
				data["app_total"] = r.Total
				data["app_new"] = r.TotalNew
				break
			}
		}
		// 计算模板数量
		for _, r := range mtRows {
			if r.MerchantID == mr.ID {
				data["template_total"] = r.Total
				data["template_new"] = r.TotalNew
			}
		}
		// 计算信息数量
		for _, r := range mRows {
			if r.MerchantID == mr.ID {
				data["total"] = r.Total
				data["total_sent"] = r.Total
				data["total_success"] = r.TotalNew
			}
		}

		if len(data) > 0 {
			data["updated"] = utils.TimeMicro()
			if _, err := myConn.Table("report_merchants").Where("`date` = ? AND merchant_id = ?", currentDate, mr.ID).Update(data); err != nil {
				log.Logger.Error("更新商户统计信息失败:", err)
				return
			}
		}
	}
}

// SubCommands 得到相关的子命令
func (ths *ReportMerchants) SubCommands() []CommandRun {
	return nil
}
