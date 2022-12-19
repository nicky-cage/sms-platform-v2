package merchantaccounts

import (
	db "common/mysql"
	"common/request"
	"common/response"
	"common/utils"
	"fmt"
	"github.com/gin-gonic/gin"
	"models"
	"strconv"
)

// AddCount 保存点数
var AddCount = func(c *gin.Context) {
	postedData := request.GetPostedData(c)

	// 关于数量的判断
	counterStr, exists := postedData["counter"]
	if !exists {
		response.Err(c, "缺少必要参数")
		return
	}
	counter, cErr := strconv.Atoi(counterStr.(string))
	if cErr != nil {
		response.Err(c, "数据格式不对")
		return
	}
	if counter <= 0 || counter > 999999 {
		response.Err(c, "短信数值不对")
		return
	}

	// 关于商户的判断
	merchantIDOri, merExists := postedData["merchant_id"]
	if !merExists {
		response.Err(c, "缺少商户信息")
		return
	}
	merchantID, mErr := strconv.Atoi(fmt.Sprintf("%v", merchantIDOri))
	if mErr != nil {
		response.Err(c, "获取商户信息失败")
		return
	}

	platform := request.GetPlatform(c)
	myClient := db.Get(platform)
	defer myClient.Close()

	var merchantAccount models.MerchantAccount
	has, err := myClient.Table("merchant_accounts").
		Where("merchant_id = ?", merchantID).Get(&merchantAccount)
	if err != nil || !has {
		response.Err(c, "获取商户账户信息失败")
		return
	}

	data := map[string]interface{}{
		"count_remain": merchantAccount.CountRemain + counter,
		"count_total":  merchantAccount.CountTotal + counter,
		"updated":      utils.TimeMicro(),
	}
	_, uErr := myClient.Table("merchant_accounts").
		Where("merchant_id = ?", merchantID).Update(data)
	if uErr != nil {
		response.Err(c, "保存数据发生错误:"+uErr.Error())
		return
	}

	response.Message(c, "操作成功")
}
