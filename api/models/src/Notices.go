package models

import (
	common "common"
)

// Notice Model说明
type Notice struct {
	ID           int    `json:"id" xorm:"id pk autoincr"` //编号
	Type         int    `json:"type"`                     //类型 1:普通 2:特殊 3:财务
	UserType     int    `json:"user_type"`                //用户类型　1会员　2代理
	Title        string `json:"title"`                    //标题
	Content      string `json:"content"`                  //内容
	StartAt      int    `json:"start_at"`                 //开始时间
	EndAt        int    `json:"end_at"`                   //结束时间
	State        int    `json:"state"`                    //1 启用 2 停用
	Sort         int    `json:"sort"`                     //排序
	PlatformType string `json:"platform_type"`            //平台类型
	JumpUrl      string `json:"jump_url" xorm:"jump_url"` //跳转链接
	VipIds       string `json:"vip_ids"`                  //复选vip
	ImgURL       string `json:"img_url" xorm:"img_url"`   //图标地址
	Created      int64  `json:"created" xorm:"created"`   //添加时间
	Updated      int64  `json:"updated" xorm:"updated"`   //修改时间

	*common.Model `xorm:"-"`
}

// Notices 数据访问对象
var Notices = Notice{
	Model: &common.Model{
		TabName: "notices",
	},
}

// TableName 指定数据表名
func (ths *Notice) TableName() string {
	return "notices"
}

// select id, username
