package models

import (
	"common"
)

// MerchantAccount Model说明
type MerchantAccount struct {
	ID            int     `json:"id" xorm:"id pk autoincr"`       // 编号
	MerchantID    int     `json:"merchant_id" xorm:"merchant_id"` //
	MerchantName  string  `json:"merchant_name"`
	AppCount      int     `json:"app_count"`
	Remain        float64 `json:"remain"`
	Frozen        float64 `json:"frozen"`
	Total         float64 `json:"total"`
	TotalIn       float64 `json:"total_in"`
	TotalOut      float64 `json:"total_out"`
	CountRemain   int     `json:"count_remain"`
	CountFrozen   int     `json:"count_frozen"`
	CountTotal    int     `json:"count_total"`
	SentTotal     int     `json:"sent_total"`
	SentSuccess   int     `json:"sent_success"`
	TotalRecharge float64 `json:"total_recharge"`
	TotalWithdraw float64 `json:"total_withdraw"`
	Updated       int64   `json:"updated"`

	*common.Model `xorm:"-"`
}

// MerchantAccounts 数据访问对象
var MerchantAccounts = MerchantAccount{
	Model: &common.Model{
		TabName: "merchant_accounts",
	},
}

// TableName 指定数据表名
func (ths *MerchantAccount) TableName() string {
	return "merchant_accounts"
}
