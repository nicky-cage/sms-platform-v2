package models

import (
	"common"
)

// MobileRecharge Model说明
type MobileRecharge struct {
	ID                  int     `json:"id" xorm:"id pk"`                                    // 编号
	OrderNumber         string  `json:"order_number" xorm:"order_number	"`                  // 订单编号
	MerchantID          string  `json:"merchant_id" xorm:"merchant_id"`                     // 商户编号
	MerchantName        string  `json:"merchant_name" xorm:"merchant_name"`                 // 商户名称
	MobileAgentID       string  `json:"mobile_agent_id" xorm:"mobile_agent_id"`             // 充值代理id
	MobileProductCode   string  `json:"mobile_product_code" xorm:"mobile_product_code"`     // 充值产品代码
	MobilePhone         string  `json:"mobile_phone" xorm:"mobile_phone"`                   // 充值手机号码
	MobileMoney         float64 `json:"mobile_money" xorm:"mobile_money"`                   // 充值金额
	MobileOrder         string  `json:"mobile_order" xorm:"mobile_order"`                   // 充值订单号
	MobileAuth          string  `json:"mobile_auth" xorm:"mobile_auth"`                     // 充值签名
	MobileRequestURL    string  `json:"mobile_request_url" xorm:"mobile_request_url"`       // 充值请求地址
	MobileRequestResult string  `json:"mobile_request_result" xorm:"mobile_request_result"` // 充值请求结果
	Status              int     `json:"status" xorm:"status"`                               // 状态 0:待充; 1:成功; 2:失败; 3:取消;
	Created             int64   `json:"created" xorm:"created"`                             // 创建时间
	Updated             int64   `json:"updated" xorm:"updated"`                             // 最后修改
	Finished            int64   `json:"finished" xorm:"finished"`                           // 完成时间

	*common.Model `xorm:"-"`
}

// MobileRecharges 数据访问对象
var MobileRecharges = MobileRecharge{
	Model: &common.Model{
		TabName: "mobile_recharges",
	},
}

// TableName 指定数据表名
func (ths *MobileRecharge) TableName() string {
	return "mobile_recharges"
}
