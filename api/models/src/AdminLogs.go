package models

import (
	"common"
)

// AdminLog 后台用户日志
type AdminLog struct {
	ID         int    `json:"id" xorm:"id pk autoincr"`       // 编号
	AdminID    int    `json:"admin_id" xorm:"admin_id"`       // 后台用户编号
	AdminName  string `json:"admin_name" xorm:"admin_name"`   //
	ObjectID   int    `json:"object_id" xorm:"object_id"`     //
	ObjectName string `json:"object_name" xorm:"object_name"` //
	Module     string `json:"module" xorm:"module"`           //
	Level      int    `json:"level"`                          // 日志级别
	Type       int    `json:"type"`                           // 日志类型
	Created    int64  `json:"created" xorm:"created"`         // 添加时间
	URL        string `json:"url" xorm:"url"`                 // 操作url
	Remark     string `json:"remark"`                         // 操作备注

	*common.Model `xorm:"-"`
}

// AdminLogs 管理员日志
var AdminLogs = AdminLog{
	Model: &common.Model{
		TabName: "admin_logs",
	},
}

// TableName 指定数据表名
func (ths *AdminLog) TableName() string {
	return "admin_logs"
}
