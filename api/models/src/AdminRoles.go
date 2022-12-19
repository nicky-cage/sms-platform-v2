package models

import (
	"common"
)

// AdminRole Model说明
type AdminRole struct {
	ID             int    `json:"id" xorm:"id pk"`          // 用户编号
	Name           string `json:"name"`                     // 角色名 称
	Remark         string `json:"remark"`                   // 备注
	PermissionList string `json:"permission_list"`          // 权限描述JSON
	MenuIds        string `json:"menu_ids" xorm:"menu_ids"` // 菜单编号
	Created        int64  `json:"created" xorm:"created"`   // 添加时间
	Updated        int64  `json:"updated" xorm:"updated"`   // 修改时间
	Menus          []Menu `json:"menus" xorm:"-"`           // 权限菜单

	*common.Model `xorm:"-"`
}

// AdminRoles 数据访问对象
var AdminRoles = AdminRole{
	Model: &common.Model{
		TabName: "admin_roles",
	},
}

// TableName 指定数据表名
func (ths *AdminRole) TableName() string {
	return "admin_roles"
}
