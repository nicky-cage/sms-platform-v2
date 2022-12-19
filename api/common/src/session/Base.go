package session

import (
	"fmt"
	"strings"

	"common/cache"
	"common/consts"
	"common/utils"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/sessions"
)

const (
	// SessionSecret 密钥
	SessionSecret string = "SHIPU-A!%2B*R(3)" // Secret
)

var (
	store *sessions.CookieStore
	// SessionName 名称
	SessionName = "backend"
)

// Init 初始化session
func Init(key string) { // } gin.HandlerFunc {
	SessionName = key
	store = sessions.NewCookieStore([]byte(utils.Secret()))
}

// Set 设置数据
func Set(c *gin.Context, key string, value interface{}) bool {
	session, _ := store.Get(c.Request, SessionName)
	session.Values[key] = value
	session.Save(c.Request, c.Writer)
	return true
}

// Get 获取项值
func Get(c *gin.Context, key string) interface{} {
	session, _ := store.Get(c.Request, SessionName)
	if val, exists := session.Values[key]; exists {
		return val
	}
	return nil
}

// Clear 清除所有session
func Clear(c *gin.Context) {
	session, _ := store.Get(c.Request, SessionName)
	session.Flashes(SessionName)
}

// GetAllOnlineUser 获取所有用户的token
func GetAllOnlineUser(platform string) []string {
	key := consts.CacheKeyUserNameToken + "*"
	rClient := cache.Get(platform)
	defer cache.Restore(platform, rClient)
	result, err := rClient.Keys(key).Result()
	if err != nil {
		fmt.Println("获取所有在线用户出错: ", err)
		return nil
	}
	userNames := []string{}

	for _, r := range result {
		sArr := strings.Split(r, ":")
		if len(sArr) >= 2 {
			userNames = append(userNames, sArr[2])
		}
	}

	return userNames
}

// GetTokenByUserName 获取用户的koten
func GetTokenByUserName(platform, userName string) string {
	rClient := cache.Get(platform)
	defer cache.Restore(platform, rClient)
	key := consts.CacheKeyUserNameToken + userName
	token, _ := rClient.Get(key).Result()
	return token
}

// GetAllowOnlineUser 在线
func GetAllowOnlineUser(platform string) []string {
	rClient := cache.Get(platform)
	defer cache.Restore(platform, rClient)
	key := consts.CacheKeyUserNameToken + "*"
	result, err := rClient.Keys(key).Result()
	if err != nil {
		fmt.Println("获取所有在线用户出错: ", err)
		return nil
	}
	userNames := []string{}

	userNames = append(userNames, result...)
	return userNames
}
