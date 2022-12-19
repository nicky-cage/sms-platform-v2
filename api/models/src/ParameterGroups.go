package models

import (
	"common"
)

// ParameterGroup Model说明
type ParameterGroup struct {
	ID     int    `json:"id" xorm:"id pk autoincr"` //编号
	Title  string `json:"title"`                    //参数组名称
	Name   string `json:"name"`                     //KEY
	Remark string `json:"remark"`                   //备注

	*common.Model `xorm:"-"`
}

// ParameterGroups 数据访问对象
var ParameterGroups = ParameterGroup{
	Model: &common.Model{
		TabName: "parameter_groups",
	},
}

// TableName 指定数据表名
func (ths *ParameterGroup) TableName() string {
	return "parameter_groups"
}
