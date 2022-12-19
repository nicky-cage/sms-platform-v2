package models

import (
	"common"
	"common/cache"
	"common/log"
	"common/request"
	"common/utils"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v7"
	"strings"
	"time"
)

// MerchantTokenKey 保存的key
const MerchantTokenKey = "merchant_login"

// MerchantTokenExpire 超时
const MerchantTokenExpire = 86400

// Merchant Model说明
type Merchant struct {
	ID           int    `json:"id" xorm:"id pk autoincr"`           // 编号
	Name         string `json:"name" xorm:"name"`                   //
	Password     string `json:"password" xorm:"password"`           //
	Salt         string `json:"salt" xorm:"salt"`                   //
	MerchantCode string `json:"merchant_code" xorm:"merchant_code"` //
	MerchantName string `json:"merchant_name" xorm:"merchant_name"` //
	Phone        string `json:"phone" xorm:"phone"`                 //
	Mail         string `json:"mail" xorm:"mail"`                   //
	State        int    `json:"state" xorm:"state"`                 //
	LastIP       string `json:"last_ip" xorm:"last_ip"`             //
	LastLogin    int64  `json:"last_login" xorm:"last_login"`       //
	LoginCount   int    `json:"login_count"`                        // 登录次数
	Created      int64  `json:"created" xorm:"created"`             //
	Updated      int64  `json:"updated" xorm:"updated"`             //
	MerchantType int    `json:"merchant_type" xorm:"merchant_type"` //
	Remark       string `json:"remark" xorm:"remark"`               //
	Sort         int    `json:"sort"`                               //
	AllowIP      string `json:"allow_ip" xorm:"allow_ip"`           //
	ParentID     int    `json:"parent_id" xorm:"parent_id"`         //
	ParentName   string `json:"parent_name" xorm:"parent_name"`     //
	GoogleVerify int    `json:"google_verify" xorm:"google_verify"` //
	GoogleSecret string `json:"google_secret" xorm:"google_secret"` //
	ChannelList  string `json:"channel_list" xorm:"channel_list"`   //
	CountryList  string `json:"country_list" xorm:"country_list"`   //

	Apps []MerchantApp `json:"apps" xorm:"-"`

	*common.Model `xorm:"-"`
}

// Merchants 数据访问对象
var Merchants = Merchant{
	Model: &common.Model{
		TabName: "merchants",
	},
}

// TableName 指定数据表名
func (ths *Merchant) TableName() string {
	return "merchants"
}

// CheckPassword 检测密码
func (ths *Merchant) CheckPassword(password string) bool {
	realPassword := utils.GetPassword(password, ths.Salt)
	return ths.Password == realPassword
}

// IsEnabled 是否启用
func (ths *Merchant) IsEnabled() bool {
	return ths.State == 1
}

// ToJSON 转化JSON
func (ths *Merchant) ToJSON() string {
	if bytes, err := json.Marshal(ths); err != nil {
		log.Logger.Error("格式失败:", err)
	} else if len(bytes) > 0 {
		return string(bytes)
	}
	return ""
}

// AllowIPLogin 是否允许ip登录
func (ths *Merchant) AllowIPLogin(ip string) bool {
	rArr := strings.Split(ths.AllowIP, ",")
	for _, r := range rArr {
		realIP := strings.TrimSpace(r)
		if realIP == ip {
			return true
		}
	}
	return false
}

// FromJSON 从json得到对象
func (ths *Merchant) FromJSON(result string) *Merchant {
	var merchant Merchant
	if err := json.Unmarshal([]byte(result), &merchant); err != nil {
		log.Logger.Error("反序列化失败:", err)
		return nil
	}
	return &merchant
}

// TokenStore 保存token
func (ths *Merchant) TokenStore(rConn *redis.Conn, token string) error {
	cacheKey := fmt.Sprintf("%s:%s", MerchantTokenKey, token)
	value := ths.ToJSON()

	expireTime := time.Second * MerchantTokenExpire
	if _, err := rConn.Set(cacheKey, value, expireTime).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("保存用户TOKEN有误:", err)
		return err
	}

	return nil
}

// TokenRefresh 刷新token
func (ths *Merchant) TokenRefresh(rConn *redis.Conn, token string) error {
	cacheKey := fmt.Sprintf("%s:%s", MerchantTokenKey, token)
	expireTime := time.Second * MerchantTokenExpire
	if _, err := rConn.Expire(cacheKey, expireTime).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("刷新用户TOKEN有误:", err)
		return err
	}

	return nil
}

// GetByToken 获取
func (ths *Merchant) GetByToken(rConn *redis.Conn, token string) *Merchant {
	cacheKey := fmt.Sprintf("%s:%s", MerchantTokenKey, token)
	if result, err := rConn.Get(cacheKey).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("获取商户信息有误:", err)
	} else if result != "" {
		return ths.FromJSON(result)
	}

	return nil
}

// GetLoginMerchant 得到登录管理员信息
func (ths *Merchant) GetLoginMerchant(c *gin.Context) *Merchant {
	platform := request.GetPlatform(c)
	token := request.GetAuthorization(c)
	if token == "" {
		return nil
	}

	rConn := cache.Get(platform)
	defer cache.Restore(platform, rConn)
	return ths.GetByToken(rConn, token)
}
