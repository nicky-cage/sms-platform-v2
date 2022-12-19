package models

import (
	"common"
)

// ReportCount Model说明
type ReportCount struct {
	ID            int     `json:"id" xorm:"id pk autoincr"` // 编号
	Date          string  `json:"date"`                     //
	Total         int     `json:"total"`                    //
	TotalSent     int     `json:"total_sent"`               //
	TotalSuccess  int     `json:"total_success"`            //
	MerchantTotal int     `json:"merchant_total"`           //
	MerchantNew   int     `json:"merchant_new"`             //
	MerchantLive  int     `json:"merchant_live"`            //
	AppTotal      int     `json:"app_total"`                //
	AppNew        int     `json:"app_new"`                  //
	TemplateTotal int     `json:"template_total"`           //
	TemplateNew   int     `json:"template_new"`             //
	ChannelFee    float64 `json:"channel_fee"`              // 我们向上游交的钱
	MerchantFee   float64 `json:"merchant_fee"`             // 商户向我们交的钱
	Profit        float64 `json:"profit"`                   //
	Created       int64   `json:"created"`                  //
	Updated       int64   `json:"updated"`                  //
	Remark        string  `json:"remark"`                   //

	*common.Model `xorm:"-"`
}

// ReportCounts 数据访问对象
var ReportCounts = ReportCount{
	Model: &common.Model{
		TabName: "report_counts",
	},
}

// TableName 指定数据表名
func (ths *ReportCount) TableName() string {
	return "report_counts"
}
