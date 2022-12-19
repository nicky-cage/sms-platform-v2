package models

import (
	"common"
)

// AdminLoginLog Model说明
type AdminLoginLog struct {
	ID            int    `json:"id" xorm:"id"`
	AdminID       int    `json:"admin_id" xorm:"admin_id"` // 用户id
	AdminName     string `json:"admin_name"`               // 用户名称
	IP            string `json:"ip" xorm:"ip"`             // 操作IP
	UserAgent     string `json:"user_agent"`               // 数据
	Created       int64  `json:"created"`                  // 添加时间
	*common.Model `xorm:"-"`
}

// AdminLoginLogs 数据访问对象
var AdminLoginLogs = AdminLoginLog{
	Model: &common.Model{
		TabName: "admin_login_logs",
	},
}

// TableName 指定数据表名
func (ths *AdminLoginLog) TableName() string {
	return "admin_login_logs"
}
