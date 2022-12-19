package utils

import (
	"fmt"
	"strconv"
	"strings"
	"time"
)

// TimeDebugEnable 是否启用时间调式
var TimeDebugEnable = false

// Time 标准获取当前时间 - 考虑时区因素
func Time() time.Time {
	_, _ = time.LoadLocation("Asia/Shanghai")
	return time.Now()
}

// CurrentTime 标准获取当前时间 - 考虑时区因素
func CurrentTime() time.Time {
	return Time()
}

// TimeMicro 当前微秒数
func TimeMicro() int64 {
	return Time().UnixMicro()
}

// Unix 标准获取当前时间
func Unix() int64 {
	return Time().Unix()
}

// Timestamp 标准获取当前时间
func Timestamp() int64 {
	return Time().Unix()
}

// GetDateTimeByTimestamp 依据时间戳获取日期时间
func GetDateTimeByTimestamp(ts int64) string {
	_, _ = time.LoadLocation("Asia/Shanghai")
	return time.Unix(ts, 0).Format("2006-01-02 15:04:05")
}

// GetTimestampByDate 依据时间得到时间
func GetTimestampByDate(dateStr string, args ...string) int64 {
	if len(args) >= 1 {
		return GetTimestampByString(dateStr + " " + args[0])
	}
	return GetTimestampByString(dateStr + " 00:00:00")
}

// GetTimestampByString 通过字符串转化为时间戳: YYYY-mm-dd HH:MM::SS
func GetTimestampByString(dateStr string) int64 {
	loc, _ := time.LoadLocation("Asia/Shanghai")
	theTime, err := time.ParseInLocation("2006-01-02 15:04:05", dateStr, loc)
	if err != nil {
		return 0
	}
	return theTime.Unix()
}

// // GetTimeStampByString4 通过字符串转化为时间戳: mm-dd-YYYY HH:MM:SS(小数)
// func GetTimeStampByString4(dateStr string) int64 {
// 	loc, _ := time.LoadLocation("Asia/Shanghai")
// 	theTime, err := time.ParseInLocation("01-02-2006 15:04:05.000000", dateStr, loc)
// 	if err != nil {
// 		return 0
// 	}
// 	return theTime.Unix()
// }

// GetDateByTimestamp 通过时间戳，获取日期
func GetDateByTimestamp(timeUnix int64, args ...string) string {
	need := "-"
	if len(args) > 0 {
		need = args[0]
	}
	_, _ = time.LoadLocation("Asia/Shanghai")
	return time.Unix(timeUnix, 0).Format("2006" + need + "01" + need + "02")
}

// GetDateTimeByTimeStamp 通过时间戳，获取日期时分秒
func GetDateTimeByTimeStamp(timeUnix int64, args ...string) string {
	need := "-"
	if len(args) > 0 {
		need = args[0]
	}
	_, _ = time.LoadLocation("Asia/Shanghai")
	return time.Unix(timeUnix, 0).Format("2006" + need + "01" + need + "02 15:04:05")
}

// GetDateTimeByTimestampT 获取日期
func GetDateTimeByTimestampT(timeUnix int64, args ...string) string {
	need := "-"
	if len(args) > 0 {
		need = args[0]
	}
	_, _ = time.LoadLocation("Asia/Shanghai")
	return time.Unix(timeUnix, 0).Format("2006" + need + "01" + need + "02T15:04:05")
}

// GetDateTimeByTimestampTZ 以时区获取
func GetDateTimeByTimestampTZ(timeUnix int64, args ...string) string {
	need := "-"
	if len(args) > 0 {
		need = args[0]
	}
	return time.Unix(timeUnix, 0).Format("2006" + need + "01" + need + "02T15:04:05Z")
}

// Date 得到当前的年/月/日
func Date() (int, int, int) {
	_, _ = time.LoadLocation("Asia/Shanghai")
	now := Time()
	return DateOf(now)
}

// DateOf 得到当前的年/月/日
func DateOf(now time.Time) (int, int, int) {
	ymd := now.Format("2006-01-02")
	ymdArr := strings.Split(ymd, "-")
	year, _ := strconv.Atoi(ymdArr[0])
	month, _ := strconv.Atoi(ymdArr[1])
	day, _ := strconv.Atoi(ymdArr[2])
	return year, month, day
}

// GetWeekStart 本周第一天
func GetWeekStart() time.Time {
	now := Time()
	offset := int(time.Monday - now.Weekday())
	if offset > 0 {
		offset = -6
	}
	weekStart := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, time.Local).AddDate(0, 0, offset)
	return weekStart
}

// GetMonthStart 得到本月第一天
func GetMonthStart() time.Time {
	now := Time()
	currentYear, currentMonth, _ := now.Date()
	currentLocation := now.Location()
	return time.Date(currentYear, currentMonth, 1, 0, 0, 0, 0, currentLocation)
}

// FirstDayOfMonth 当月第一天
func FirstDayOfMonth(t time.Time) string {
	currentYear, currentMonth, _ := t.Date()
	currentLocation := t.Location()
	firstOfMonth := time.Date(currentYear, currentMonth, 1, 0, 0, 0, 0, currentLocation)
	return firstOfMonth.Format("2006-01-02")
}

// LastDayOfMonth 当月最后一天
func LastDayOfMonth(t time.Time) string {
	currentYear, currentMonth, _ := t.Date()
	currentLocation := t.Location()
	firstOfMonth := time.Date(currentYear, currentMonth, 1, 0, 0, 0, 0, currentLocation)
	lastOfMonth := firstOfMonth.AddDate(0, 1, -1)
	return lastOfMonth.Format("2006-01-02")
}

// FirstDayOfLastMonth 上月第一天
func FirstDayOfLastMonth(t time.Time) string {
	year, month, _ := t.Date()
	thisMonth := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)
	firstDay := thisMonth.AddDate(0, -1, 0).Format("2006-01-02")
	return firstDay
}

// LastDayOfLastMonth 上月最后一天
func LastDayOfLastMonth(t time.Time) string {
	year, month, _ := t.Date()
	thisMonth := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)
	endDay := thisMonth.AddDate(0, 0, -1).Format("2006-01-02")
	return endDay
}

// GetTodayBegin 获取今天的零点时间
func GetTodayBegin() int64 {
	timeStr := Time().Format("2006-01-02")
	t, _ := time.ParseInLocation("2006-01-02 15:04:05", timeStr+" 00:00:00", time.Local)
	return t.Unix()
}

// GetTodayEnd 获取今天的最后结束时间
func GetTodayEnd() int64 {
	timeStr := Time().Format("2006-01-02")
	t, _ := time.ParseInLocation("2006-01-02 15:04:05", timeStr+" 23:59:59", time.Local)
	return t.Unix()
}

// GetDayBegin 某天开始时间
func GetDayBegin(dateStr string) int64 {
	return GetTimestampByString(dateStr + " 00:00:00")
}

// GetDayEnd 某天最后时间
func GetDayEnd(dateStr string) int64 {
	return GetTimestampByString(dateStr + " 23:59:59")
}

// TimeDebugBegin 在开始打印信息
func TimeDebugBegin(args ...interface{}) *time.Time {
	if !TimeDebugEnable {
		return nil
	}
	currentTime := Time()
	debugInfo := append([]interface{}{"[Debug][", currentTime.Format("2006-01-02 15:04:05"), "]"}, args...)
	fmt.Println(debugInfo...)
	return &currentTime
}

// TimeDebugAt 在某个时间点打印信息
func TimeDebugAt(lastTime *time.Time, args ...interface{}) *time.Time {
	if !TimeDebugEnable {
		return nil
	}

	currentTime := Time()
	past := currentTime.Sub(*lastTime)
	us := past.Microseconds()
	message := fmt.Sprintf("%.6f ms", float64(us)/1000.0)

	debugInfo := append([]interface{}{"[Debug][", currentTime.Format("2006-01-02 15:04:05"), fmt.Sprintf("][PAST:%s]", message)}, args...)
	fmt.Println(debugInfo...)
	return &currentTime
}
