package models

import (
	"common"
)

// MerchantLoginLog Model说明
type MerchantLoginLog struct {
	ID            int    `json:"id" xorm:"id"`
	MerchantID    int    `json:"merchant_id" xorm:"merchant_id"` // 用户id
	MerchantName  string `json:"merchant_name"`                  // 用户名称
	Domain        string `json:"domain"`
	LoginIP       string `json:"login_ip" xorm:"login_ip"`
	LoginArea     string `json:"login_aree"`
	UserAgent     string `json:"user_agent"` // 数据
	Created       int64  `json:"created"`    // 添加时间
	Remark        string
	*common.Model `xorm:"-"`
}

// MerchantLoginLogs 数据访问对象
var MerchantLoginLogs = MerchantLoginLog{
	Model: &common.Model{
		TabName: "merchant_login_logs",
	},
}

// TableName 指定数据表名
func (ths *MerchantLoginLog) TableName() string {
	return "merchant_login_logs"
}
