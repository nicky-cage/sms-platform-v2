package models

import (
	common "common"
	"common/consts"

	"xorm.io/builder"
)

// Platform 后台用户
type Platform struct {
	ID      int    `json:"id" xorm:"id pk autoincr"` // 编号
	Name    string `json:"name"`                     // 名称
	Remark  string `json:"remark"`                   // 备注
	Sort    int    `json:"sort"`                     // 排序
	Status  int    `json:"status"`                   // 状态
	Created int64  `json:"created" xorm:"created"`   // 添加时间
	Updated int64  `json:"updated" xorm:"updated"`   // 修改时间

	*common.Model `xorm:"-" json:"-"`
}

// PlatformRelated 后台用户
type PlatformRelated struct {
	ID    int                   `json:"id" xorm:"id pk autoincr"` // 编号
	Name  string                `json:"name"`                     // 名称
	Sites []PlatformSiteRelated `json:"sites" xorm:"-"`           // 下属盘口/站点

	*common.Model `xorm:"-" json:"-"`
}

// Platforms 平台标识
var Platforms = &Platform{
	Model: &common.Model{
		TabName: "platforms",
		GetPlatform: func() string {
			return consts.PlatformIntegrated
		},
	},
}

// Related 获得关联项
func (p *Platform) Related() []PlatformRelated {
	platform := consts.PlatformIntegrated
	var platforms []PlatformRelated
	err := p.FindAllNoCount(platform, &platforms)
	if err != nil { // 如果没有数据
		return platforms
	}

	for k, v := range platforms {
		var rs []PlatformSiteRelated
		cond := builder.NewCond().And(builder.Eq{"platform_id": v.Id})
		_ = Sites.FindAllNoCount(platform, &rs, cond)
		platforms[k].Sites = rs
	}

	return platforms
}

// TableName 指定数据表名
func (ths *Platform) TableName() string {
	return "platforms"
}
