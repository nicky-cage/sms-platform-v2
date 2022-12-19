package models

import (
	"common"
)

// MessageTemplate Model说明
type MessageTemplate struct {
	ID           int    `json:"id" xorm:"id pk autoincr"` // 编号
	MerchantID   int    `json:"merchant_id" xorm:"merchant_id"`
	MerchantName string `json:"merchant_name" xorm:"merchant_name"`
	AppID        int    `json:"app_id" xorm:"app_id"`
	AppName      string `json:"app_name" xorm:"app_name"`
	Name         string `json:"name"`
	Type         int    `json:"type"`
	Content      string `json:"content" xorm:"content"`
	Remark       string `json:"remark"`
	Created      int64  `json:"created"`
	Updated      int64  `json:"updated"`

	*common.Model `xorm:"-"`
}

// MessageTemplates 数据访问对象
var MessageTemplates = MessageTemplate{
	Model: &common.Model{
		TabName: "message_templates",
	},
}

// TableName 指定数据表名
func (ths *MessageTemplate) TableName() string {
	return "message_templates"
}
