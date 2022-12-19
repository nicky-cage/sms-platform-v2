package models

import (
	"common"
)

// Country Model说明
type Country struct {
	ID             int     `json:"id" xorm:"id pk"` // 编号
	Name           string  `json:"name"`            // 国家名称
	NameEnglish    string  `json:"name_english"`    // 英文名称
	Code           string  `json:"code"`            // 代码 - 域名简写
	PhonePrefix    string  `json:"phone_prefix"`    // 电话前缀
	TimezoneOffset float64 `json:"timezone_offset"` // 基于中国时区楄移
	IsSupport      int     `json:"is_support"`      // 是否支持
	Remark         string  `json:"remark"`          //

	*common.Model `xorm:"-"`
}

// Countries 数据访问对象
var Countries = Country{
	Model: &common.Model{
		TabName: "countries",
	},
}

// TableName 指定数据表名
func (ths *Country) TableName() string {
	return "countries"
}
