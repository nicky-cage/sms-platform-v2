package messages

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/utils"
	"errors"
	"fmt"
	"merchant-api/controllers/actions"
	"models"
	"strconv"

	"github.com/gin-gonic/gin"
	"gopkg.in/ffmt.v1"
)

// Save 保存
var Save = actions.Save{
	Model: models.Messages,
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {

		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)
		// clientIP := c.ClientIP()
		// if _, err := cache.Lock(platform, clientIP); err != nil {
		// 	return err
		// }
		// defer cache.Unlock(platform, clientIP)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			return errors.New("缺少商户信息")
		}

		(*data)["merchant_id"] = merchant.ID
		(*data)["merchant_name"] = merchant.Name

		mConn := db.Get(platform)
		defer mConn.Close()

		// 检查可用短信条数
		var merchantAccount models.MerchantAccount
		if exists, err := mConn.Table("merchant_accounts").Where("merchant_id = ?", merchant.ID).Get(&merchantAccount); err != nil || !exists {
			log.Logger.Error("无法获取账户信息:", err)
			return errors.New("无法获取账户信息")
		} else if merchantAccount.CountRemain <= 0 {
			ffmt.Puts(merchantAccount)
			errMsg := fmt.Sprintf("可用短信数量(%d)不足, 无法发放短信", merchantAccount.CountRemain)
			return errors.New(errMsg)
		}

		if idStr, _ := (*data)["template_id"]; idStr == "" {
			return errors.New("必须先择短信模板")
		}
		if id, _ := strconv.Atoi(fmt.Sprintf("%v", (*data)["template_id"])); id > 0 {
			row := models.MessageTemplate{}
			if exists, err := models.MessageTemplates.FindByID(platform, id, &row); err != nil || !exists {
				return errors.New("缺少必要的模板名称")
			}
			(*data)["app_id"] = row.AppID
			(*data)["app_name"] = row.AppName
		}

		if countryIDStr, _ := (*data)["country_id"]; countryIDStr == "" {
			return errors.New("必须选择国家区号")
		}
		if id, _ := strconv.Atoi(fmt.Sprintf("%v", (*data)["country_id"])); id > 0 {
			row := models.Country{}
			if exists, err := models.Countries.FindByID(platform, id, &row); err != nil || !exists {
				return errors.New("缺少必要的国家")
			}
			(*data)["phone_prefix"] = row.PhonePrefix
			(*data)["phone_full"] = fmt.Sprintf("+%s%v", row.PhonePrefix, (*data)["phone"])
		}

		billNo := utils.GetBillNo("MB")
		(*data)["created"] = utils.TimeMicro()
		(*data)["order_number"] = billNo
		return nil
	},
	SaveAfter: func(c *gin.Context, m *map[string]interface{}) {
		platform := request.GetPlatform(c)

		myClient := db.Get(platform)
		defer myClient.Close()

		idVal, idExists := (*m)["id"]
		if !idExists {
			fmt.Println("缺少ID信息, 无法回写记录")
			return
		}
		realID, rErr := strconv.Atoi(fmt.Sprintf("%v", idVal))
		if rErr != nil {
			fmt.Println("缺少ID信息, 无法回写记录:", rErr)
			return
		}

		var message models.Message
		hasExists, hasErr := myClient.Table("messages").Where("id = ?", realID).Get(&message)
		if hasErr != nil {
			log.Logger.Error("读取读录发生错误:", hasErr)
			return
		}

		// 冻结可用短信数量
		var merchantAccount models.MerchantAccount
		if exists, err := myClient.SQL("SELECT * FROM merchant_accounts WHERE merchant_id = ? FOR UPDATE", message.MerchantID).Get(&merchantAccount); err == nil && exists {
			data := map[string]interface{}{
				"count_remain": merchantAccount.CountRemain - 1,
				"count_frozen": merchantAccount.CountFrozen + 1,
			}
			if _, err := myClient.Table("merchant_accounts").Where("merchant_id = ?", merchantAccount.MerchantID).Update(data); err != nil {
				log.Logger.Error("扣除短信数量有误:", err)
			}
		}

		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)
		if hasExists {
			message.PushForSend(rConn)
		}
	},
}
