package models

import (
	"common"
)

// ReportMerchant Model说明
type ReportMerchant struct {
	ID               int     `json:"id" xorm:"id pk autoincr"`           // 编号
	MerchantID       int     `json:"merchant_id" xorm:"merchant_id"`     //
	MerchantName     string  `json:"merchant_name" xorm:"merchant_name"` //
	Date             string  `json:"date"`                               //
	Total            int     `json:"total"`                              //
	TotalSent        int     `json:"total_sent"`                         //
	TotalSuccess     int     `json:"total_success"`                      //
	MerchantChildren int     `json:"merchant_children"`                  //
	MerchantNew      int     `json:"merchant_new"`                       //
	MerchantLive     int     `json:"merchant_live"`                      //
	AppTotal         int     `json:"app_total"`                          //
	AppNew           int     `json:"app_new"`                            //
	TemplateTotal    int     `json:"template_total"`                     //
	TemplateNew      int     `json:"template_new"`                       //
	MerchantFee      float64 `json:"merchant_fee"`                       //
	DownstreamFee    float64 `json:"downstream_fee"`                     //
	Profit           float64 `json:"profit"`                             //
	Created          int64   `json:"created"`                            //
	Updated          int64   `json:"updated"`                            //
	Remark           string  `json:"remark"`                             //

	*common.Model `xorm:"-"`
}

// ReportMerchants 数据访问对象
var ReportMerchants = ReportMerchant{
	Model: &common.Model{
		TabName: "report_merchants",
	},
}

// TableName 指定数据表名
func (ths *ReportMerchant) TableName() string {
	return "report_merchants"
}
