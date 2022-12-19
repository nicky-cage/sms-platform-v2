package models

import (
	"common"
)

// MerchantLog 后台用户日志
type MerchantLog struct {
	ID           int    `json:"id" xorm:"id pk autoincr"`           // 编号
	MerchantID   int    `json:"merchant_id" xorm:"merchant_id"`     // 后台用户编号
	MerchantName string `json:"merchant_name" xorm:"merchant_name"` //
	ObjectID     int    `json:"object_id" xorm:"object_id"`         //
	ObjectName   string `json:"object_name" xorm:"object_name"`     //
	Module       string `json:"module" xorm:"module"`               //
	Level        int    `json:"level"`                              // 日志级别
	Type         int    `json:"type"`                               // 日志类型
	Created      int64  `json:"created" xorm:"created"`             // 添加时间
	URL          string `json:"url" xorm:"url"`                     // 操作url
	Remark       string `json:"remark"`                             // 操作备注

	*common.Model `xorm:"-"`
}

// MerchantLogs 管理员日志
var MerchantLogs = MerchantLog{
	Model: &common.Model{
		TabName: "merchant_logs",
	},
}

// TableName 指定数据表名
func (ths *MerchantLog) TableName() string {
	return "merchant_logs"
}
