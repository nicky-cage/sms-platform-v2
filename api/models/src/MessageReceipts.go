package models

import (
	"common"
)

// MessageReceipt Model说明
type MessageReceipt struct {
	ID            int    `json:"id" xorm:"id pk autoincr"`         // 编号
	OrderNumber   string `json:"order_number" xorm:"order_number"` //
	MerchantID    int    `json:"merchant_id" xorm:"merchant_id"`   //
	MerchantName  string `json:"merchant_name"`                    //
	AppID         int    `json:"app_id" xorm:"app_id"`             //
	AppName       string `json:"app_name"`                         //
	ChannelID     int    `json:"channel_id" xorm:"channel_id"`     //
	CountryID     int    `json:"country_id" xorm:"country_id"`     //
	MessageID     string `json:"message_id" xorm:"message_id"`     // 消息编号
	PhoneFull     string `json:"phone_full"`                       // 电话全号
	TemplateID    int    `json:"template_id" xorm:"template_id"`   //
	RequestURL    string `json:"request_url" xorm:"request_url"`   //
	RequestTime   int64  `json:"request_time" xorm:"request_time"` //
	RequestResult string `json:"request_result"`                   //
	Created       int64  `json:"created" xorm:"created"`           // 添加时间
	Remark        string `json:"remark"`

	*common.Model `xorm:"-"`
}

// MessageReceipts 数据访问对象
var MessageReceipts = MessageReceipt{
	Model: &common.Model{
		TabName: "message_receipts",
	},
}

// TableName 指定数据表名
func (ths *MessageReceipt) TableName() string {
	return "message_receipts"
}
