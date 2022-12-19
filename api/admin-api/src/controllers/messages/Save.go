package messages

import (
	"admin-api/controllers/actions"
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/utils"
	"errors"
	"fmt"
	"models"
	"strconv"

	"github.com/gin-gonic/gin"
)

var Save = actions.Save{
	Model: models.Messages,
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {

		platform := request.GetPlatform(c)

		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		if idStr, _ := (*data)["template_id"]; idStr == "" {
			return errors.New("必须先择短信模板")
		}
		if id, _ := strconv.Atoi(fmt.Sprintf("%v", (*data)["template_id"])); id > 0 {
			row := models.MessageTemplate{}
			if exists, err := models.MessageTemplates.FindByID(platform, id, &row); err != nil || !exists {
				return errors.New("缺少必要的模板名称")
			}
			(*data)["merchant_id"] = row.MerchantID
			(*data)["merchant_name"] = row.MerchantName
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

		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)
		if hasExists {
			message.PushForSend(rConn)
		}
	},
}
