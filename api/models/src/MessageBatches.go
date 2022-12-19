package models

import (
	"common"
)

// MessageBatch Model说明
type MessageBatch struct {
	ID           int    `json:"id" xorm:"id pk autoincr"`       // 编号
	MerchantID   int    `json:"merchant_id" xorm:"merchant_id"` //
	MerchantName string `json:"merchant_name"`                  //
	AppID        int    `json:"app_id" xorm:"app_id"`           //
	CountryID    int    `json:"country_id" xorm:"country_id"`   //
	AppName      string `json:"app_name"`                       //
	ChannelID    int    `json:"channel_id" xorm:"channel_id"`   //
	PhoneList    string `json:"phone_list"`                     //
	TemplateID   int    `json:"template_id" xorm:"template_id"` //
	State        int    `json:"state"`                          //
	Content      string `json:"content"`                        //
	PlanTime     int64  `json:"plan_time" xorm:"plan_time"`     // 计划时间
	Created      int64  `json:"created" xorm:"created"`         // 添加时间
	Updated      int64  `json:"updated" xorm:"updated"`         // 修改时间
	Remark       string `json:"remark"`                         //

	*common.Model `xorm:"-"`
}

// MessageBatches 数据访问对象
var MessageBatches = MessageBatch{
	Model: &common.Model{
		TabName: "message_batches",
	},
}

// TableName 指定数据表名
func (ths *MessageBatch) TableName() string {
	return "message_batches"
}
