package models

import (
	common "common"
)

// Province Model说明
type Province struct {
	ID     int    `json:"id" xorm:"id pk autoincr"` // 编号
	Name   string `json:"name"`                     // 第三方支付名称
	Code   string `json:"code"`                     // 第三方支付编码
	Cities []City `json:"cities" xorm:"-"`          // 城市列表

	*common.Model `xorm:"-"`
}

// Provinces 数据访问对象
var Provinces = Province{
	Model: &common.Model{
		TabName: "provinces",
	},
}

// TableName 指定数据表名
func (ths *Province) TableName() string {
	return "provinces"
}
