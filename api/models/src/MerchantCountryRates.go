package models

import (
	"common"
)

// MerchantCountryRate Model说明
type MerchantCountryRate struct {
	ID         int     `json:"id" xorm:"id pk"`                // 编号
	MerchantID int     `json:"merchant_id" xorm:"merchant_id"` //
	CountryID  int     `json:"name" xorm:"country_id"`         // 国家名称
	ChannelID  int     `json:"channel_id" xorm:"channel_id"`   // 渠道编码
	Rate       float64 `json:"rate"`                           // 费率
	Created    int64   `json:"created"`                        // 添加
	Updated    int64   `json:"updated"`                        // 修改

	*common.Model `xorm:"-"`
}

// MerchantCountryRates 数据访问对象
var MerchantCountryRates = MerchantCountryRate{
	Model: &common.Model{
		TabName: "merchant_country_rates",
	},
}

// TableName 指定数据表名
func (ths *MerchantCountryRate) TableName() string {
	return "merchant_country_rates"
}
