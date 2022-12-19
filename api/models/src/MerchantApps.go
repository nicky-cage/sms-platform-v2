package models

import (
	"common"
)

// MerchantApp Model说明
type MerchantApp struct {
	ID           int    `json:"id" xorm:"id pk autoincr"` // 编号
	MerchantID   int    `json:"merchant_id" xorm:"merchant_id"`
	MerchantName string `json:"merchant_name" xorm:"merchant_name"`
	Name         string `json:"name"`
	AppKey       string `json:"app_key"`
	State        int    `json:"state"`
	AllowIP      string `json:"allow_ip" xorm:"allow_ip"`
	Remark       string `json:"remark"`
	Created      int64  `json:"created"`
	Updated      int64  `json:"updated"`

	*common.Model `xorm:"-"`
}

// MerchantApps 数据访问对象
var MerchantApps = MerchantApp{
	Model: &common.Model{
		TabName: "merchant_apps",
	},
}

// TableName 指定数据表名
func (ths *MerchantApp) TableName() string {
	return "merchant_apps"
}
