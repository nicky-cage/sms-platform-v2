package models

import (
	common "common"
	"common/consts"
	"common/log"
	"fmt"
	"strconv"
)

// Site 盘口
type Site struct {
	Id         int    `json:"id" xorm:"pk autoincr"`  // 8/编号
	PlatformId int    `json:"platform_id"`            // 8/平台编号
	Name       string `json:"name"`                   // 名称
	Code       string `json:"code"`                   // 名称
	Status     int    `json:"status"`                 // 4/状态
	Sort       int    `json:"sort"`                   // 8/排序
	Created    int    `json:"created" xorm:"created"` // 4/添加时间
	Updated    int    `json:"updated" xorm:"updated"` // 4/修改时间
	Remark     string `json:"remark"`                 // 备注
	Urls       string `json:"urls"`                   // 域名
	Api        string `json:"api"`                    // 前台api
	AdminUrl   string `json:"admin_url"`              // 后台地址
	AdminApi   string `json:"admin_api"`              // 后台api

	*common.Model `xorm:"-"`
}

// PlatformSiteRelated 平台站点/盘口
type PlatformSiteRelated struct {
	Id         int    `json:"id" xorm:"pk autoincr"` //8/编号
	PlatformId int    `json:"platform_id"`           //8/平台编号
	Name       string `json:"name"`                  //名称
}

// PlatformSiteConf 平台配置
type PlatformSiteConf struct {
	PlatformID     int    `json:"platform_id"`
	SiteName       string `json:"site_name"`       // 站点名称
	Platform       string `json:"platform"`        // 平台标识
	ConnStrings    string `json:"conn_strings"`    // 数据库连接
	KafkaStrings   string `json:"kafka_strings"`   // kafka 连接
	RedisStrings   string `json:"redis_strings"`   // redis 连接
	ElasticStrings string `json:"elastic_strings"` // es 连接
	PayStrings     string `json:"pay_strings"`     // 支付配置
	StaticURL      string `json:"static_url"`      // 静态文件路径
	UploadURL      string `json:"upload_url"`      // 上传文件路径
}

// 字段关系映射
var siteConfigFieldMaps = map[string]string{
	"site_name":       "站点/盘口名称",
	"platform":        "平台识别号",
	"conn_strings":    "默认数据连接配置",
	"kafka_strings":   "消息队列 - KAFKA",
	"elastic_strings": "分布数据存储 - Elasticsearch",
	"redis_strings":   "缓存数据服务 - Redis",
	"pay_strings":     "支付信息 - 应用编号:密钥",
	"static_url":      "静态文件地址",
	"upload_url":      "上传文件地址",
}

// getSiteConfgiFieldMap 得到字段相关配置
var getSiteConfigFieldMap = func(field string) string {
	if v, exists := siteConfigFieldMaps[field]; exists {
		return v
	}
	return ""
}

// Sites 网站站点
var Sites = &Site{
	Model: &common.Model{
		TabName: "sites",
		GetPlatform: func() string {
			return consts.PlatformIntegrated
		},
	},
}

// GetConfigsBySiteID
func (p *Site) GetConfigsBySiteID(platform string, siteID int) *PlatformSiteConf {
	sql := fmt.Sprintf("SELECT * FROM site_configs WHERE site_id = %d", siteID)
	dbSession := p.GetSession(platform)
	defer dbSession.Close()
	rows, err := dbSession.QueryString(sql)
	if err != nil { // 如果发生错误
		return nil
	}

	conf := &PlatformSiteConf{}
	for _, r := range rows {
		if conf.PlatformID == 0 {
			platformID, _ := strconv.Atoi(r["platform_id"])
			conf.PlatformID = platformID
		}

		if r["name"] == "platform" {
			conf.Platform = r["value"]
		} else if r["name"] == "site_name" {
			conf.SiteName = r["value"]
		} else if r["name"] == "conn_strings" {
			conf.ConnStrings = r["value"]
		} else if r["name"] == "kafka_strings" {
			conf.KafkaStrings = r["value"]
		} else if r["name"] == "elastic_strings" {
			conf.ElasticStrings = r["value"]
		} else if r["name"] == "redis_strings" {
			conf.RedisStrings = r["value"]
		} else if r["name"] == "pay_strings" {
			conf.PayStrings = r["value"]
		} else if r["name"] == "static_url" { // 静态文件路径
			conf.StaticURL = r["value"]
		} else if r["name"] == "upload_url" { // 上传文件路径
			conf.UploadURL = r["value"]
		}
	}

	return conf
}

// SetConfigsBySiteID 设置平台配置
func (p *Site) SetConfigsBySiteID(platform string, siteID int, conf *PlatformSiteConf) error {
	data := []map[string]string{
		{"name": "site_name", "value": conf.SiteName},
		{"name": "platform", "value": conf.Platform},
		{"name": "conn_strings", "value": conf.ConnStrings},
		{"name": "kafka_strings", "value": conf.KafkaStrings},
		{"name": "elastic_strings", "value": conf.ElasticStrings},
		{"name": "redis_strings", "value": conf.RedisStrings},
		{"name": "pay_strings", "value": conf.PayStrings},
		{"name": "static_url", "value": conf.StaticURL},
		{"name": "upload_url", "value": conf.UploadURL},
	}

	dbSession := p.GetSession(platform)
	defer dbSession.Close()
	for _, r := range data {
		sql := fmt.Sprintf("SELECT 1 FROM site_configs WHERE site_id = %d AND name = '%s'", siteID, r["name"])
		rows, err := dbSession.QueryString(sql)
		if err != nil {
			log.Logger.Error("检测错误: ", err)
			continue
		}
		if len(rows) >= 1 {
			sql = fmt.Sprintf("UPDATE site_configs SET `value` = '%s', remark = '%s' WHERE site_id = %d AND name = '%s' LIMIT 1", r["value"], getSiteConfigFieldMap(r["name"]), siteID, r["name"])
			_, _ = dbSession.Exec(sql)
			continue
		}
		sql = "INSERT INTO site_configs " +
			"(platform_id, site_id, name, `value`, created, updated, remark) VALUES " +
			"(?, ?, ?, ?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), ?)"
		_, err = dbSession.Exec(sql, conf.PlatformID, siteID, r["name"], r["value"], getSiteConfigFieldMap(r["name"]))
		if err != nil {
			fmt.Println("写配置文件时发生错误: ", err)
		}
	}

	return nil
}

// TableName 指定数据表名
func (ths *Site) TableName() string {
	return "sites"
}
