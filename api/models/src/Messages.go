package models

import (
	"common"
	"common/cache"
	"common/consts"
	"common/log"
	db "common/mysql"
	"common/utils"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/go-redis/redis/v7"
	"github.com/go-xorm/xorm"
)

// QueueKey 队列
const QueueKey = "message_list"

// MessageQuery 结果
// {"status": "DELIVRD", "delivery_time": "1807161404", "mccmnc": "250002"}
type MessageQuery struct {
	Status       string `json:"status"`
	DeliveryTime string `json:"delivery_time"`
	Mccmnc       string `json:"mccmnc"`
}

// MessageResult 发送结果
type MessageResult struct {
	MessageID string `json:"message_id"`
}

// Message Model说明
type Message struct {
	ID            int    `json:"id" xorm:"id pk autoincr"`         // 编号
	OrderNumber   string `json:"order_number" xorm:"order_number"` //
	MerchantID    int    `json:"merchant_id" xorm:"merchant_id"`   //
	MerchantName  string `json:"merchant_name"`                    //
	AppID         int    `json:"app_id" xorm:"app_id"`             //
	AppName       string `json:"app_name"`                         //
	ChannelID     int    `json:"channel_id" xorm:"channel_id"`     //
	CountryID     int    `json:"country_id" xorm:"country_id"`     //
	MessageID     string `json:"message_id" xorm:"message_id"`     // 消息编号
	Phone         string `json:"phone"`                            // 电话
	PhonePrefix   string `json:"phone_prefix"`                     // 前缀
	PhoneFull     string `json:"phone_full"`                       // 电话全号
	TemplateID    int    `json:"template_id" xorm:"template_id"`   //
	State         int    `json:"state"`                            //
	Content       string `json:"content"`                          //
	RequestURL    string `json:"request_url" xorm:"request_url"`   //
	RequestResult string `json:"request_result"`                   //
	Created       int64  `json:"created" xorm:"created"`           // 添加时间
	SendTime      int64  `json:"send_time" xorm:"send_time"`       //
	SentTime      int64  `json:"sent_time" xorm:"sent_time"`       //
	Failure       int    `json:"failure"`                          // 失败次数, 最多重试5次

	*common.Model `xorm:"-"`
}

// Messages 数据访问对象
var Messages = Message{
	Model: &common.Model{
		TabName: "messages",
	},
}

// TableName 指定数据表名
func (ths *Message) TableName() string {
	return "messages"
}

// ToJSON 转化为JSOn
func (ths *Message) ToJSON() string {
	if bytes, err := json.Marshal(ths); err != nil {
		log.Logger.Error("转化JSON失败:", err)
	} else if err == nil && len(bytes) > 0 {
		return string(bytes)
	}
	return ""
}

// FromJSON 从JSON转化
func (ths *Message) FromJSON(result string) *Message {
	var msg Message
	err := json.Unmarshal([]byte(result), &msg)
	if err != nil {
		log.Logger.Error("转化JSON失败:", err, ", result = ", result)
		return nil
	}
	return &msg
}

// LoadCacheAll 加载所有平台到缓存
func (ths *Message) LoadCacheAll() {
	for _, platform := range consts.PlatformCodes {
		ths.LoadCache(platform)
	}
}

// LoadCache 加载
func (ths *Message) LoadCache(platform string) {
	rSession := cache.Get(platform)
	defer cache.Restore(platform, rSession)

	myClient := db.Get(platform)
	defer myClient.Close()

	var rows []Message
	if err := myClient.Table("messages").Where("state = 0 AND failure = 0").Find(&rows); err != nil {
		fmt.Println("读取信息记录出错", err)
		log.Logger.Error("读取信息记录出错:", err)
		return
	}

	fmt.Println("待发送短信数量:", len(rows))

	for _, r := range rows {
		r.PushForSend(rSession)
	}
}

// PushForSend 队列推送
func (ths *Message) PushForSend(rConn *redis.Conn) {
	valStr := ths.ToJSON()
	cacheKey := QueueKey + ":sends"
	if _, err := rConn.LPush(cacheKey, valStr).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("写入消息队列发生错误:", err)
	} else if err == redis.Nil {
		log.Logger.Error("写入消息队列发生错误 Nil:", err)
	}
}

// PopForSend 队列获取
func (ths *Message) PopForSend(rConn *redis.Conn) *Message {
	cacheKey := QueueKey + ":sends"
	if result, err := rConn.RPop(cacheKey).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("获取队列信息失败:", err)
	} else if err == redis.Nil {
		log.Logger.Error("获取队列信息无效-Nil:", err)
	} else if result != "" {
		return ths.FromJSON(result)
	}

	return nil
}

// PushForQuery 队列推送
func (ths *Message) PushForQuery(rConn *redis.Conn) {
	valStr := ths.ToJSON()
	cacheKey := QueueKey + ":queries"
	if _, err := rConn.LPush(cacheKey, valStr).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("写入队列信息失败-Query:", err)
	} else if err == redis.Nil {
		log.Logger.Error("写入消息队列发生错误-Query-Nil:", err)
	}
}

// PopForQuery 队列获取
func (ths *Message) PopForQuery(rConn *redis.Conn) *Message {
	cacheKey := QueueKey + ":queries"
	if val, err := rConn.RPop(cacheKey).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("获取队列信息失败-Query:", err)
	} else if err == redis.Nil {
		log.Logger.Error("获取队列信息失败-Query-Nil:", err)
	} else {
		return ths.FromJSON(val)
	}

	return nil
}

// Send 发送短信
func (ths *Message) Send(myClient *xorm.Session, rConn *redis.Conn) {
	data := map[string]interface{}{
		"send_time": utils.TimeMicro(),
	}
	saveMessage := func() {
		if _, err := myClient.Table("messages").Where("id = ?", ths.ID).Update(data); err != nil {
			log.Logger.Error("写入发送记录出错:", err)
			return
		}
	}
	var channel MessageChannel
	hasExists, hasErr := myClient.Table("message_channels").Where("id = ?", ths.ChannelID).Get(&channel)
	if !hasExists {
		log.Logger.Error("获取渠道信息错误:", hasErr)
		return
	}

	requestURL := channel.GetRequestURL()
	data["request_url"] = requestURL
	phoneNumber := fmt.Sprintf("+%s%s", strings.TrimSpace(ths.PhonePrefix), strings.TrimSpace(ths.Phone))
	content := strings.TrimSpace(ths.Content)
	ani := func() string { // 依据渠道生成ani代码
		if val, exists := ChannelRouteCodes[ths.PhonePrefix]; exists {
			return val()
		}
		return utils.GetBillNo("AN")
	}()
	result := channel.Send(phoneNumber, content, ani)
	if result == "" {
		log.Logger.Error("发送短信有误:", result)
		saveMessage()
		return
	}

	var messageResult MessageResult
	if err := json.Unmarshal([]byte(result), &messageResult); err != nil {
		log.Logger.Error("获取信息出错:", err, ", 原始数据内容:", result)
		data["request_result"] = result
		data["failure"] = ths.Failure + 1
		saveMessage()
		return
	}

	data["message_id"] = messageResult.MessageID
	data["request_result"] = result
	saveMessage()

	ths.MessageID = messageResult.MessageID
	fmt.Println("写入查询队列:", ths.MessageID)

	go func() {
		time.Sleep(time.Second * 3) // 3秒后再写入
		ths.PushForQuery(rConn)     // 准备查询
	}()
}

// Query 查询短信状态
func (ths *Message) Query(myClient *xorm.Session) error {
	if ths.State == 1 { // 如果状态是成功 ,则不需要
		return nil
	}

	channelID := ths.ChannelID
	var channel MessageChannel
	hasExists, hasErr := myClient.Table("message_channels").Where("id = ?", channelID).Get(&channel)
	if !hasExists {
		log.Logger.Error("获取渠道信息错误:", hasErr)
		return errors.New("获取渠道信息有误")
	}

	if ths.MessageID == "" {
		log.Logger.Error("缺少message-id: 无法查询")
		return errors.New("缺少message-id")
	}

	result := strings.TrimSpace(channel.Query(ths.MessageID))
	if result == "" {
		log.Logger.Error("返回检测短信内容为空")
		return errors.New("结果为空")
	}

	receiptData := map[string]interface{}{
		"order_number":   ths.OrderNumber,
		"merchant_id":    ths.MerchantID,
		"merchant_name":  ths.MerchantName,
		"app_id":         ths.AppID,
		"app_name":       ths.AppName,
		"channel_id":     ths.ChannelID,
		"country_id":     ths.CountryID,
		"template_id":    ths.TemplateID,
		"message_id":     ths.MessageID,
		"request_time":   utils.TimeMicro(),
		"request_url":    ths.RequestURL,
		"request_result": result,
		"phone_full":     ths.PhoneFull,
		"created":        utils.TimeMicro(),
	}
	if _, err := myClient.Table("message_receipts").Insert(receiptData); err != nil {
		log.Logger.Error("保存回执信息出错:", err)
	}

	saveMessageState := func(state int) { // 只有发送成功才保存到数据库当中
		data := map[string]interface{}{
			"state":     state,
			"sent_time": utils.TimeMicro(),
		}
		if state == 0 { // 表示是失败
			data["failure"] = ths.Failure + 1
		}
		if _, err := myClient.Table("messages").Where("id = ?", ths.ID).Update(data); err != nil {
			log.Logger.Error("保存数据状态失败")
		}
	}

	var query MessageQuery
	err := json.Unmarshal([]byte(result), &query)
	if err != nil {
		log.Logger.Error("解析结果发生错误:", err)
		return err
	}

	// ENROUTE:
	// SENT:
	// DELIVRD:
	// EXPIRED:
	// DELETED:
	// UNDELIV:
	// ACCEPTD:
	// UNKNOWN:
	// REJECTD:
	if query.IsSuccess() { // 表示投递成功 - 两者都要计费
		saveMessageState(1)
	} else {
		log.Logger.Error("获取结果发生错误:", result)
		saveMessageState(0)
	}

	return nil
}

// IsSuccess 是否成功
func (ths *MessageQuery) IsSuccess() bool {
	return ths.Status == "ENROUTE" ||
		ths.Status == "SENT" ||
		ths.Status == "DELIVRD" ||
		ths.Status == "EXPIRED" ||
		ths.Status == "UNDELIV" ||
		ths.Status == "ACCEPTD" ||
		ths.Status == "UNKNOWN"
}
