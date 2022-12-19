package messenger

import (
	"common/request"
	"common/utils"
	"fmt"
	"strings"
)

// GetRequestURL 得到url
func (ths *Server) GetRequestURL(code string) string {
	channel, exists := ths.CodeList[code]
	if !exists {
		return ""
	}

	count := len(channel.IPList)                                                                // 最大数量
	channelID := utils.RandInt(0, count)                                                        // 渠道编号
	return fmt.Sprintf("http://%s:%d%s", channel.IPList[channelID], channel.Port, channel.Path) // ":8001/api"
}

// Send 发送
func (ths *Server) Send(code string, phone string, content string) string {
	channel, exists := ths.CodeList[code]
	if !exists {
		fmt.Println("发送结果失败: 不存在:", code)
		return ""
	}

	if channel.ChannelType == "HTTP" {
		return ths.sendByHTTP(code, phone, content, &channel)
	}

	return ths.sendBySMPP(code, phone, content, &channel)
}

// sendByHTTP 以http发送
func (ths *Server) sendByHTTP(code string, phone string, content string, channel *CUGSender) string {
	randID := strings.ToUpper(utils.GetBillNo("MS"))
	params := map[string]string{
		"username": channel.Account,
		"password": channel.Password,
		"ani":      randID,
		"dnis":     phone,
		"message":  content,
	}

	url := ths.GetRequestURL(code)
	result, err := request.Get(url, params)
	if err != nil {
		fmt.Println("发送短信有误:", err)
		return err.Error()
	}

	return result
}

// sendBySMPP 以smpp发送
func (ths *Server) sendBySMPP(code string, phone string, content string, channel *CUGSender) string {
	return ""
}
