package models

import (
	"common"
)

// MerchantAppLog 后台用户日志
type MerchantAppLog struct {
	ID           int    `json:"id" xorm:"id pk autoincr"`           // 编号
	MerchantID   int    `json:"merchant_id" xorm:"merchant_id"`     // 后台用户编号
	MerchantName string `json:"merchant_name" xorm:"merchant_name"` //
	AppID        int    `json:"app_id" xorm:"app_id"`               //
	AppName      string `json:"app_name" xorm:"app_name"`           //
	Type         int    `json:"type"`                               // 日志类型
	Created      int64  `json:"created" xorm:"created"`             // 添加时间
	URL          string `json:"url" xorm:"url"`                     // 操作url
	Remark       string `json:"remark"`                             // 操作备注

	*common.Model `xorm:"-"`
}

// MerchantAppLogs 管理员日志
var MerchantAppLogs = MerchantAppLog{
	Model: &common.Model{
		TabName: "merchant_app_logs",
	},
}

// TableName 指定数据表名
func (ths *MerchantAppLog) TableName() string {
	return "merchant_lapp_ogs"
}
