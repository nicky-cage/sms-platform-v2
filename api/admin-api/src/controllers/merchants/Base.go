package merchants

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/utils"
	"errors"
	"fmt"
	"models"
	"strings"

	"admin-api/controllers/actions"

	"github.com/gin-gonic/gin"
	"gopkg.in/ffmt.v1"
	"xorm.io/builder"
)

// ChannelCountry 渠道国家
type ChannelCountry struct {
	ID        int             `json:"id"`
	Name      string          `json:"name"`
	Countries []models.IDName `json:"countries"`
}

// Index 列表
var Index = &actions.List[models.Merchant]{
	QueryCond: map[string]interface{}{
		"name":          "%",
		"merchant_name": "%",
		"state":         "=",
		"remark":        "%",
	},
	Model: models.Merchants,
	OrderBy: func(c *gin.Context) string {
		return "updated DESC"
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
			cond = cond.And(builder.Eq{"parent_id": merchant.ID})
		}

		return cond
	},
	AfterAction: func(c *gin.Context, data *actions.ActionResult) {
		platform := request.GetPlatform(c)

		myClient := db.Get(platform)
		defer myClient.Close()

		var channels []models.MessageChannel
		if err := myClient.Table("message_channels").Where("state = 1").Find(&channels); err != nil {
			fmt.Println("获取渠道信息有误:", err)
		}

		var countries []models.Country
		if err := myClient.Table("countries").Where("is_support = 1").Find(&countries); err != nil {
			fmt.Println("获取国家信息有误:", err)
		}

		rArr := []ChannelCountry{}
		for _, ch := range channels {
			cArr := []models.IDName{}
			for _, cn := range countries {
				cArr = append(cArr, models.IDName{
					ID:   cn.ID,
					Name: cn.Name,
				})
			}
			rArr = append(rArr, ChannelCountry{
				ID:        ch.ID,
				Name:      ch.Name,
				Countries: cArr,
			})
		}

		(*data)["channels"] = rArr
		(*data)["countries"] = countries
	},
}

// Save 保存
var Save = actions.Save{
	Model: models.Merchants,
	CreateBefore: func(c *gin.Context, m *map[string]interface{}) error {
		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()

		passVal, exists := (*m)["password"]
		if !exists {
			return errors.New("必须输入登录密码")
		}

		password := passVal.(string)
		if len(password) < 6 || len(password) > 20 {
			return errors.New("用户密码格式不正确")
		}
		salt := utils.Secret()
		realPassword := utils.GetPassword(password, salt)
		(*m)["password"] = realPassword
		(*m)["salt"] = salt

		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
			(*m)["parent_id"] = merchant.ID
			(*m)["parent_name"] = merchant.Name
		}

		return nil
	},
	UpdateBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["updated"] = utils.TimeMicro()

		passVal, exists := (*m)["password"]
		if !exists { // 只要输入密码时才进行修改
			return nil
		}

		password := strings.TrimSpace(passVal.(string))
		if password == "" {
			delete(*m, "password")
			return nil
		}
		if len(password) < 6 || len(password) > 20 {
			return errors.New("用户密码格式不正确")
		}
		salt := utils.Secret()
		realPassword := utils.GetPassword(password, salt)
		(*m)["salt"] = salt
		(*m)["password"] = realPassword
		return nil
	},
	SaveBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["merchant_code"] = utils.GetRandString(32)
		return nil
	},
	SaveAfter: func(c *gin.Context, m *map[string]interface{}) {
		if merchantNameStr, exists := (*m)["name"]; exists && merchantNameStr != "" {
			platform := request.GetPlatform(c)
			myClient := db.Get(platform)
			defer myClient.Close()
			merchantName := merchantNameStr.(string)

			merchantID := func() int {
				var merchant models.Merchant
				if has, err := myClient.Table("merchants").
					Where("name = ?", merchantName).Get(&merchant); err != nil {
					log.Logger.Error("读取产户信息出错")
					return 0
				} else if err == nil && has {
					return merchant.ID
				}
				return 0
			}()
			if merchantID <= 0 {
				log.Logger.Error("无法获取商户信息")
				return
			}

			var merchantAccount models.MerchantAccount
			if has, err := myClient.Table("merchant_accounts").
				Where("merchant_name = ?", merchantName).Get(&merchantAccount); err != nil {
				fmt.Println("写入错误:", err)
			} else if err == nil && !has {
				merchantName := (*m)["name"].(string)
				data := map[string]interface{}{
					"merchant_id":   merchantID,
					"merchant_name": merchantName,
				}

				rConn := cache.Get(platform)
				defer cache.Restore(platform, rConn)

				token := request.GetAuthorization(c)
				if merchant := models.Merchants.GetByToken(rConn, token); merchant != nil {
					data["parent_id"] = merchant.ID
					data["parent_name"] = merchant.Name
				}

				ffmt.Puts(data)
				if _, err := myClient.Table("merchant_accounts").Insert(data); err != nil {
					log.Logger.Error("写入商户信息失败:", err)
				}
			}
		}
	},
}
