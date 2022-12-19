package models

import (
	"common"
)

// District Model说明
type District struct {
	ID       int    `json:"id" xorm:"id pk autoincr"` // 编号
	Name     string `json:"name"`                     // 第三方支付名称
	Code     string `json:"code"`                     // 第三方支付编码
	CityCode string `json:"city_code"`                // 省份编码

	*common.Model `xorm:"-"`
}

// Districts 数据访问对象
var Districts = District{
	Model: &common.Model{
		TabName: "districts",
	},
}

// TableName 指定数据表名
func (ths *District) TableName() string {
	return "districts"
}
