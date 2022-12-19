package models

import (
	"common"
)

// Bank 银行
type Bank struct {
	ID     int    `json:"id" xorm:"id pk"` // 编号
	Name   string `json:"name"`            // 名称
	Code   string `json:"code"`            // 编码
	Remark string `json:"remark"`          // 备注
	State  int    `json:"state"`           // 状态
	Sort   int    `json:"sort"`            // 排序
	Icon   string `json:"icon"`            // 图标
	Image  string `json:"image"`           // 图片

	*common.Model `xorm:"-"`
}

// Banks 数据访问对象
var Banks = Bank{
	Model: &common.Model{
		TabName: "banks",
	},
}

// TableName 指定数据表名
func (ths *Bank) TableName() string {
	return "banks"
}
