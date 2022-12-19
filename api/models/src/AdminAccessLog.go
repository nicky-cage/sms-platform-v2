package models

import (
	"common"
)

// AdminAccessLog Model说明
type AdminAccessLog struct {
	ID           int    `json:"id" xorm:"id"`
	MenuID       int    `json:"menu_id" xorm:"menu_id"`   // 菜单编号
	MenuName     string `json:"menu_name"`                // 菜单名称
	AdminID      int    `json:"admin_id" xorm:"admin_id"` // 用户id
	AdminName    string `json:"admin_name"`               // 用户名称
	Created      int64  `json:"created"`                  // 添加时间
	Path         string `json:"path"`                     // 路径
	IP           string `json:"ip" xorm:"ip"`             // 操作IP
	Method       string `json:"method"`                   // 方法
	Data         string `json:"data"`                     // 数据
	LogLevel     int    `json:"log_level"`                // 日志级别
	LogType      int    `json:"log_type"`                 // 日志类型
	OperationKey string `json:"operation_key"`            // 操作KEY
	ObjectID     int    `json:"user_id" xorm:"-"`
	ObjectName   string `json:"user_name" xorm:"-"`

	*common.Model `xorm:"-"`
}

// AdminAccessLogs 数据访问对象
var AdminAccessLogs = &AdminAccessLog{
	Model: &common.Model{
		TabName: "admin_access_logs",
	},
}

// TableName 指定数据表名
func (ths *AdminAccessLog) TableName() string {
	return "admin_access_logs"
}
