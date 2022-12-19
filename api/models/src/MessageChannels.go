package models

import (
	"common"
	"common/request"
	"common/utils"
	"fmt"
	"strings"

	"gopkg.in/ffmt.v1"
)

// ChannelRouteCodes ani代码
var ChannelRouteCodes = map[string]func() string{
	"66": func() string {
		return "CCSUSTL"
	}, // 泰国
	"84": func() string {
		return "CCSUSVN"
	}, // 越南
	"86": func() string {
		randNum := utils.RandInt(1000, 9999)
		return fmt.Sprintf("8526226%d", randNum)
	}, // 中国
}

// MessageChannel Model说明
type MessageChannel struct {
	ID          int     `json:"id" xorm:"id pk autoincr"`   // 编号
	ProductType string  `json:"product_type"`               // 产品类型
	Name        string  `json:"name"`                       // 渠道名称
	Code        string  `json:"code"`                       // 渠道代码
	State       int     `json:"state"`                      // 状态
	Fee         float64 `json:"fee"`                        // 费率 - 分
	Remark      string  `json:"remark"`                     // 备注
	Protocol    string  `json:"protocol"`                   // 协议
	IP          string  `json:"ip" xorm:"ip"`               // ip地址, 多个用,号分开
	Port        int     `json:"port" xorm:"port"`           // 端口
	Path        string  `json:"path" xorm:"path"`           // 路由 - 路径
	Account     string  `json:"account" xorm:"account"`     // 账号
	Password    string  `json:"password" xorm:"password"`   // 密码
	TPS         int     `json:"tps" xorm:"tps"`             // tps - 并发
	Direction   string  `json:"direction" xorm:"direction"` //
	Created     int64   `json:"created" xorm:"created"`     // 添加时间
	Updated     int64   `json:"updated" xorm:"updated"`     // 修改时间

	*common.Model `xorm:"-"`
}

// ChannelCountry Model说明
type ChannelCountry struct {
	Id        int              `json:"id"`   // 编号
	Name      string           `json:"name"` // 渠道名称
	Countries []map[int]string // 国家
}

// MessageChannels 数据访问对象
var MessageChannels = MessageChannel{
	Model: &common.Model{
		TabName: "message_channels",
	},
}

// TableName 指定数据表名
func (ths *MessageChannel) TableName() string {
	return "message_channels"
}

// GetRequestURL 查询URL
func (ths *MessageChannel) GetRequestURL() string {
	iArr := strings.Split(ths.IP, ",")   //
	count := len(iArr)                   // 最大数量
	channelID := utils.RandInt(0, count) // 渠道编号
	currentIP := iArr[channelID]         // 当前IP
	return fmt.Sprintf("%s://%s:%d%s", ths.Protocol, currentIP, ths.Port, ths.Path)
}

// Send 发送消息
func (ths *MessageChannel) Send(phone, content, ani string) string {
	requestURL := ths.GetRequestURL() // fmt.Sprintf("%s://%s:%d%s", ths.Protocol, currentIP, ths.Port, ths.Path)
	params := map[string]string{
		"username": ths.Account,
		"password": ths.Password,
		"ani":      ani,
		"dnis":     phone,
		"message":  content,
		"command":  "submit",
	}

	fmt.Println("---------- 发送短信 -------------")
	ffmt.Puts(params)
	result, err := request.Get(requestURL, params)
	if err != nil {
		fmt.Println("发送短信有误:", err)
		return err.Error()
	}

	return result
}

// Query 查询状态
func (ths *MessageChannel) Query(messageID string) string {
	requestURL := ths.GetRequestURL()
	params := map[string]string{
		"username":  ths.Account,
		"password":  ths.Password,
		"messageId": messageID,
		"command":   "query",
	}
	fmt.Println("---------- 查询短信:", messageID, " -------------")
	ffmt.Puts(params)
	responseText, err := request.Get(requestURL, params)
	if err != nil {
		fmt.Println("查询短信有误 >> error:", err)
	}

	result := strings.TrimSpace(responseText)
	fmt.Println("result = ", result)

	return result
}
