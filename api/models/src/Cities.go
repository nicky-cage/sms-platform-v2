package models

import (
	"common"
)

// City Model说明
type City struct {
	ID           int        `json:"id" xorm:"id pk"`    // 编号
	Name         string     `json:"name"`               // 第三方支付名称
	Code         string     `json:"code"`               // 第三方支付编码
	ProvinceCode string     `json:"province_code"`      // 省份编码
	Districts    []District `json:"districts" xorm:"-"` // 城市列表

	*common.Model `xorm:"-"`
}

// Cities 数据访问对象
var Cities = City{
	Model: &common.Model{
		TabName: "cities",
	},
}

// TableName 指定数据表名
func (ths *City) TableName() string {
	return "cities"
}
