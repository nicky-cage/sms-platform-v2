package models

import (
	"common"
)

// FinanceLog 财务日志
type FinanceLog struct {
	ID        int    `json:"id" xorm:"id pk autoincr"` //编号
	Type      int    `json:"type"`                     //日志类型 0 存款 1 提款 2 代理提款
	BillNo    string `json:"bill_no"`                  //订单号
	Result    string `json:"result"`                   //结果
	Operating string `json:"operating"`                //操作
	Operator  string `json:"operator"`                 //操作人
	Consuming string `json:"consuming"`                //耗时,单位秒
	Remark    string `json:"remark"`                   //操作备注
	Created   int64  `json:"created" xorm:"created"`   //添加时间

	*common.Model `xorm:"-"`
}

// FinanceLogs 财务日志
var FinanceLogs = &FinanceLog{
	Model: &common.Model{
		TabName: "finance_logs",
	},
}

// TableName 指定数据表名
func (ths *FinanceLog) TableName() string {
	return "finance_logs"
}
