package models

import (
	"common"
)

// CountryFee 国家费率 - 由商户绑定
type CountryFee struct {
	CountryID string  `json:"country_id"`
	Fee       float64 `json:"fee"`
}

// CountryRate Model说明
type CountryRate struct {
	ID        int     `json:"id" xorm:"id pk"`              // 编号
	CountryID int     `json:"name" xorm:"country_id"`       // 国家名称
	ChannelID int     `json:"channel_id" xorm:"channel_id"` // 渠道编码
	Rate      float64 `json:"rate"`                         // 费率
	Created   int64   `json:"created"`                      // 添加
	Updated   int64   `json:"updated"`                      // 修改

	*common.Model `xorm:"-"`
}

// CountryRates 数据访问对象
var CountryRates = Country{
	Model: &common.Model{
		TabName: "country_rates",
	},
}

// TableName 指定数据表名
func (ths *CountryRate) TableName() string {
	return "country_rates"
}
