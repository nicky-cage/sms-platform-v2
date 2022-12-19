package merchants

import (
	"common/log"
	db "common/mysql"
	"common/request"
	"common/response"
	"common/utils"
	"fmt"
	"github.com/gin-gonic/gin"
	"models"
	"strconv"
	"strings"
)

// SaveRate 保存点数
var SaveRate = func(c *gin.Context) {
	postedData := request.GetPostedData(c)

	platform := request.GetPlatform(c)
	myClient := db.Get(platform)
	defer myClient.Close()

	for k, v := range postedData {
		if strings.Index(k, "_") <= 0 {
			fmt.Println("缺少Error:")
			continue
		}
		sArr := strings.Split(k, "_")
		if len(sArr) != 4 { //
			fmt.Println("提交数据格式不对:")
		}

		merchantStr := sArr[1] // 商户
		channelStr := sArr[2]  // 渠道
		countryStr := sArr[3]  // 国家

		if merchantID, mErr := strconv.Atoi(merchantStr); mErr != nil {
			fmt.Println("获取商户编号有误:", mErr)
			response.Err(c, "获取国家编号有误:"+mErr.Error())
			return
		} else if countryID, yErr := strconv.Atoi(countryStr); yErr != nil {
			fmt.Println("获取国家编号有误:", yErr)
			response.Err(c, "获取国家编号有误:"+yErr.Error())
			return
		} else if channelID, cErr := strconv.Atoi(channelStr); cErr != nil {
			fmt.Println("获取渠道编号有误:", cErr)
			response.Err(c, "渠道编号有误:"+cErr.Error())
			return
		} else if rate, rErr := strconv.ParseFloat(fmt.Sprintf("%v", v), 64); rErr != nil {
			fmt.Println("获取汇率信息有误:", rErr)
			response.Err(c, "获取汇率信息有误:"+rErr.Error())
			return
		} else if countryID > 0 && channelID > 0 && rate > 0.0 && merchantID > 0 {
			data := map[string]interface{}{
				"merchant_id": merchantID,
				"channel_id":  channelID,
				"country_id":  countryID,
				"rate":        rate,
				"updated":     utils.TimeMicro(),
			}
			row := models.MerchantCountryRate{}
			if exists, err := myClient.Table("merchant_country_rates").
				Where("country_id = ? AND channel_id = ? AND merchant_id = ?", countryID, channelID, merchantID).
				Get(&row); err != nil {
				fmt.Println("错误:", err)
				log.Logger.Error(err)
			} else if exists { // 如果存在
				delete(data, "country_id")
				delete(data, "channel_id")
				delete(data, "merchant_id")
				if _, err := myClient.Table("merchant_country_rates").
					Where("country_id = ? AND channel_id = ?", countryID, channelID).Update(data); err != nil {
					log.Logger.Error("更新失败", err)
				}
			} else {
				data["created"] = utils.TimeMicro()
				if _, err := myClient.Table("merchant_country_rates").Insert(data); err != nil {
					fmt.Println("写入记录失败:", err)
					log.Logger.Error("写入记录失败:", err)
				}
			}
		} else {
			response.Err(c, "设置参数异常")
			return
		}
	}

	response.Message(c, "设置保存成功")
}
