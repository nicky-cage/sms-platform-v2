package models

import (
	"common"
)

// PermissionIP 后台用户
type PermissionIP struct {
	ID             int    `json:"id" xorm:"id pk autoincr"` // 编号
	PermissionType int    `json:"permission_type"`          // 授权类型 1 = 允许
	Remark         string `json:"remark"`                   // 备注
	State          int    `json:"state"`                    // 状态
	IP             string `json:"ip" xorm:"ip"`             // IP
	AdminID        int    `json:"admin_id" xorm:"admin_id"` //
	AdminName      string `json:"admin_name"`               //
	Created        int64  `json:"created" xorm:"created"`   // 添加时间
	Updated        int64  `json:"updated" xorm:"updated"`   // 修改时间

	*common.Model `xorm:"-"`
}

// PermissionIps 平台标识
var PermissionIps = PermissionIP{
	Model: &common.Model{
		TabName: "permission_ips",
	},
}

// TableName 指定数据表名
func (ths *PermissionIP) TableName() string {
	return "permission_ips"
}
