package index

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/response"
	"common/utils"
	"errors"
	"models"
	"strings"

	"github.com/gin-gonic/gin"
)

// LoginType 登录类型
var LoginType = struct {
	Merchant string
	Admin    string
}{
	"merchant",
	"admin",
}

// Login 登录
func Login(c *gin.Context) {
	postedData := request.GetPostedData(c)

	var username string
	var password string

	usernameVal, exists := postedData["username"]
	if !exists {
		response.Err(c, "必须输入登录用户名称")
		return
	}
	username = strings.TrimSpace(usernameVal.(string))
	if len(username) > 20 || len(username) < 6 {
		response.Err(c, "用户名称格式不对")
		return
	}

	passwordVal, exists := postedData["password"]
	if !exists {
		response.Err(c, "必须输入用户密码")
		return
	}
	password = strings.TrimSpace(passwordVal.(string))
	if len(password) > 20 || len(password) < 6 {
		response.Err(c, "用户密码格式不对")
		return
	}

	platform := request.GetPlatform(c)
	myClient := db.Get(platform)
	defer myClient.Close()

	salt := utils.Secret()
	realPassword := utils.GetPassword(password, salt)
	clientIP := c.ClientIP()

	token := utils.Secret() // token
	getResult := func(id int, name string, allowIP string, lastIP string) map[string]interface{} {
		return map[string]interface{}{
			"id":            id,
			"name":          name,
			"token":         token,
			"status":        1,
			"allow_ip":      allowIP,
			"last_login_at": utils.Time().Unix(),
			"last_login_ip": lastIP,
			"current_ip":    clientIP,
			"role_id":       1000,
			"created":       utils.Time().Unix(),
		}
	}

	// func() {
	// 	salt := utils.Secret()
	// 	realPassword := utils.GetPassword("qwe123QWE", salt)
	// 	sql := fmt.Sprintf("UPDATE admins SET name = 'admin1', salt = '%s', password = '%s' WHERE id = 1001 LIMIT 1", salt, realPassword)
	// 	fmt.Println("sql: ", sql)
	// }()

	// 商户登录
	loginMerchant := func() (map[string]interface{}, error) {
		data := map[string]interface{}{
			"salt":       salt,
			"password":   realPassword,
			"last_login": utils.TimeMicro(),
			"last_ip":    clientIP,
			"updated":    utils.TimeMicro(),
		}
		var merchant models.Merchant
		if exists, err := myClient.Table("merchants").Where("name = ?", username).Get(&merchant); err != nil {
			return nil, errors.New("查询商户信息有误")
		} else if !exists {
			return nil, errors.New("商户信息无效")
		}

		if !merchant.CheckPassword(password) {
			return nil, errors.New("商户名称或者密码错误")
		}

		// if !merchant.AllowIPLogin(clientIP) {
		// 	return nil, errors.New(fmt.Sprintf("商户未授权登录IP(%s)", clientIP))
		// }

		if !merchant.IsEnabled() {
			return nil, errors.New("商户状态异常")
		}

		data["login_count"] = merchant.LoginCount + 1
		if _, err := myClient.Table("merchants").Where("id = ?", merchant.ID).Update(data); err != nil {
			return nil, errors.New("保存商户登录信息失败")
		}

		domain := c.Request.URL.Hostname()
		logData := map[string]interface{}{
			"merchant_id":   merchant.ID,
			"merchant_name": merchant.Name,
			"domain":        domain,
			"login_ip":      clientIP,
			"created":       utils.TimeMicro(),
			"user_agent":    c.Request.UserAgent(),
			"remark":        "用户登录",
		}
		if _, err := myClient.Table("merchant_login_logs").Insert(logData); err != nil {
			return nil, errors.New("保存商户登录日志有误")
		}

		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		if err := merchant.TokenStore(rConn, token); err != nil {
			log.Logger.Error("保存商户token失败:", err)
			return nil, errors.New("保存商户登录信息失败")
		}

		return getResult(merchant.ID, merchant.Name, merchant.AllowIP, merchant.LastIP), nil
	}

	// 检测结果
	var result map[string]interface{}
	var err error
	result, err = loginMerchant()

	if err != nil {
		response.Err(c, err.Error())
		return
	}

	response.Result(c, result)
}
