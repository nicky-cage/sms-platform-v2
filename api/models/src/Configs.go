package models

import (
	"common"
)

// Config 站点配置信息
type Config struct {
	ID                 int    `json:"id" xorm:"id pk"`
	Name               string `json:"name"`
	SiteName           string `json:"site_name"`
	SiteTitle          string `json:"site_title"`
	LogoSite           string `json:"logo_site"`
	LogoWeb            string `json:"logo_web"`
	LogoTitle          string `json:"logo_title"`
	LogoApp            string `json:"logo_app"`
	DomainPC           string `json:"domain_pc" xorm:"domain_pc"`
	DomainApp          string `json:"domain_app"`
	DomainAppPhy       string `json:"domain_app_phy"`
	DomainH5           string `json:"domain_h5"`
	DomainAgentPC      string `json:"domain_agent_pc" xorm:"domain_agent_pc"`
	DomainAgentApp     string `json:"domain_agent_app"`
	AgentQQ            string `json:"agent_qq" xorm:"agent_qq"`
	AgentSkype         string `json:"agent_skype"`
	AdminId            int    `json:"admin_id"`
	AdminName          string `json:"admin_name"`
	Created            int64  `json:"created"`
	Updated            int64  `json:"updated"`
	State              int    `json:"state"`
	CustomerService    int    `json:"customer_service"`
	MessageChannel     int    `json:"message_channel"`
	CustomerServiceUrl string `json:"customer_service_url"`
	*common.Model      `xorm:"-"`
}

// Configs 数据访问对象
var Configs = &Config{
	Model: &common.Model{
		TabName: "configs",
	},
}

// TableName 指定数据表名
func (ths *Config) TableName() string {
	return "configs"
}
