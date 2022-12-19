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
	"strconv"
	"strings"
	"time"
)

// AdminTokenKey 保存的key
const AdminTokenKey = "admin_login"

// AdminTokenExpire 超时
const AdminTokenExpire = 86400

// Admin Model说明
type Admin struct {
	ID           int    `json:"id" xorm:"id pk"`          // 编号
	Name         string `json:"name"`                     // 管理员用户名称
	Mail         string `json:"mail"`                     // 电子邮箱
	Password     string `json:"password"`                 // 管理员密码
	Salt         string `json:"salt"`                     // 删除时间
	RoleID       int    `json:"role_id" xorm:"role_id"`   // 管理员所属角色ID
	RoleName     string `json:"role_name"`                // 管理员所属角色名称
	Nickname     string `json:"nickname"`                 // 昵称
	State        int    `json:"state"`                    // 管理员状态 1:禁用; 2:正常;
	Created      int64  `json:"created" xorm:"created"`   // 添加时间
	Updated      int64  `json:"updated" xorm:"updated"`   // 修改时间
	Deleted      int64  `json:"deleted"`                  // 删除时间
	Remark       string `json:"remark"`                   // 备注
	LastLogin    int64  `json:"last_login"`               // 删除时间
	LoginCount   int    `json:"login_count"`              // 删除时间
	LastIP       string `json:"last_ip" xorm:"last_ip"`   // 删除时间
	AllowIP      string `json:"allow_ip" xorm:"allow_ip"` // 允许登录ip
	GoogleCode   int    `json:"google_code"`              // 是否启用谷歌验证
	GoogleSecret string `json:"google_secret"`            // 谷歌密钥
	IsOnline     bool   `json:"is_online" xorm:"-"`       // 是否在线

	*common.Model `xorm:"-"`
}

// LoginAdmin 管理员登录信息
type LoginAdmin struct {
	Id      int    `json:"id"`       // 后台用户编号
	Name    string `json:"name"`     // 后台用户名称
	RoleId  int    `json:"role_id"`  // 角色编号
	Secret  string `json:"secret"`   // 密钥凭证
	LoginIP string `json:"login_ip"` // 来源ip
}

// Admins 数据访问对象
var Admins = Admin{
	Model: &common.Model{
		TabName: "admins",
	},
}

// 用于保存用户登录信息 admin:logined:编号
var loginAdminCacheKey = "sports:admin:"

// // LoginAdmins 用于后台相关用户管理
// var LoginAdmins = struct {
// 	*LoginAdmin
// 	Kick     func(string, int) // 将某个用户t下线
// 	IsOnline func(string, int) bool
// }{
// 	LoginAdmin: &LoginAdmin{},
// 	Kick: func(platform string, id int) {
// 		cache := common.Redis(platform)
// 		defer common.RedisRestore(platform, cache)
// 		cacheKey := loginAdminCacheKey + strconv.Itoa(id)
// 		_ = cache.Del(cacheKey)
// 	},
// 	IsOnline: func(platform string, id int) bool {
// 		cache := common.Redis(platform)
// 		defer common.RedisRestore(platform, cache)
// 		cacheKey := loginAdminCacheKey + strconv.Itoa(id)
// 		if val, err := cache.Get(cacheKey).Result(); err == nil && val != "" {
// 			return true
// 		}
// 		return false
// 	},
// }

// IsDisabled 此账号是否已经被禁用
func (ths *Admin) IsDisabled() bool {
	return ths.State == 1
}

// GoogleEnable 是否启用google验证
func (ths *Admin) GoogleEnable() bool {
	return ths.GoogleCode == 2
}

// ToJSON 将对象转换为json
func (ths *LoginAdmin) ToJSON() string {
	bytes, err := json.Marshal(ths)
	if err != nil {
		return ""
	}
	return string(bytes)
}

// AllowIPLogin 是否允许ip登录
func (ths *Admin) AllowIPLogin(ip string) bool {
	rArr := strings.Split(ths.AllowIP, ",")
	for _, r := range rArr {
		realIP := strings.TrimSpace(r)
		if realIP == ip {
			return true
		}
	}
	return false
}

// FromJSON 从json转换为对象
func (ths *LoginAdmin) FromJSON(data string) *LoginAdmin {
	s := &LoginAdmin{}
	err := json.Unmarshal([]byte(data), s)
	if err != nil {
		return nil
	}

	return s
}

// GetCacheKey 得到保存到缓存的key
func (ths *LoginAdmin) GetCacheKey() string {
	return loginAdminCacheKey + strconv.Itoa(int(ths.Id))
}

// TableName 指定数据表名
func (ths *Admin) TableName() string {
	return "admins"
}

// CheckPassword 检测密码
func (ths *Admin) CheckPassword(password string) bool {
	realPassword := utils.GetPassword(password, ths.Salt)
	return ths.Password == realPassword
}

// IsEnabled 是否启用
func (ths *Admin) IsEnabled() bool {
	return ths.State == 1
}

// ToJSON 转化JSON
func (ths *Admin) ToJSON() string {
	if bytes, err := json.Marshal(ths); err != nil {
		log.Logger.Error("格式失败:", err)
	} else if len(bytes) > 0 {
		return string(bytes)
	}
	return ""
}

// FromJSON 从json得到对象
func (ths *Admin) FromJSON(result string) *Admin {
	var admin Admin
	if err := json.Unmarshal([]byte(result), &admin); err != nil {
		log.Logger.Error("反序列化失败:", err)
		return nil
	}
	return &admin
}

// TokenStore 保存token
func (ths *Admin) TokenStore(rConn *redis.Conn, token string) error {
	cacheKey := fmt.Sprintf("%s:%s", AdminTokenKey, token)
	value := ths.ToJSON()

	expireTime := time.Second * AdminTokenExpire
	if _, err := rConn.Set(cacheKey, value, expireTime).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("保存用户TOKEN有误:", err)
		return err
	}

	return nil
}

// TokenRefresh 刷新token
func (ths *Admin) TokenRefresh(rConn *redis.Conn, token string) error {
	cacheKey := fmt.Sprintf("%s:%s", AdminTokenKey, token)
	expireTime := time.Second * AdminTokenExpire
	if _, err := rConn.Expire(cacheKey, expireTime).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("刷新用户TOKEN有误:", err)
		return err
	}

	return nil
}

// GetByToken 获取
func (ths *Admin) GetByToken(rConn *redis.Conn, token string) *Admin {
	cacheKey := fmt.Sprintf("%s:%s", AdminTokenKey, token)
	if result, err := rConn.Get(cacheKey).Result(); err != nil && err != redis.Nil {
		log.Logger.Error("获取商户信息有误:", err)
	} else if result != "" {
		return ths.FromJSON(result)
	}

	return nil
}

// GetLoginAdmin 得到登录管理员信息
func (ths *Admin) GetLoginAdmin(c *gin.Context) *Admin {
	platform := request.GetPlatform(c)
	token := request.GetAuthorization(c)
	if token == "" {
		return nil
	}

	rConn := cache.Get(platform)
	defer cache.Restore(platform, rConn)
	return ths.GetByToken(rConn, token)
}
