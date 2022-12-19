package merchantaccounts

import (
	"common/cache"
	db "common/mysql"
	"common/request"
	"common/response"
	"common/utils"
	"fmt"
	"models"
	"strconv"

	"github.com/gin-gonic/gin"
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
	counter, cErr := strconv.Atoi(counterStr.(string)) // 要添加短信数量
	if cErr != nil {
		response.Err(c, "数据格式不对")
		return
	}
	if counter <= 0 || counter > 999999 {
		response.Err(c, "短信数值不对")
		return
	}

	platform := request.GetPlatform(c)
	lockKey := fmt.Sprintf("add_msg_count:%s", c.ClientIP())
	if _, lockErr := cache.Lock(platform, lockKey); lockErr != nil {
		response.Err(c, lockErr.Error())
		return
	}
	defer cache.Unlock(platform, lockKey)

	rConn := cache.Get(platform)
	defer cache.Restore(platform, rConn)
	myClient := db.Get(platform)
	defer myClient.Close()

	// 当前登录商户
	token := request.GetAuthorization(c)
	merchant := models.Merchants.GetByToken(rConn, token)
	if merchant == nil {
		response.Err(c, "缺少当前登录商户信息")
		return
	}

	var merchantAcc models.MerchantAccount
	hasAcc, errAcc := myClient.Table("merchant_accounts").Where("merchant_id = ?", merchant.ID).Get(&merchantAcc)
	if errAcc != nil || !hasAcc {
		response.Err(c, "获取商户账户信息失败")
		return
	}
	if merchantAcc.CountRemain < counter {
		response.Err(c, fmt.Sprintf("可用数量(%d)不足(%d), 无法添加短信", merchantAcc.CountRemain, counter))
		return
	}

	// 关于商户的判断 - 要添加短信商户
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
	if merchant.ID == merchantID {
		response.Err(c, "不能自己给自己添加短信数量")
		return
	}

	var merchantAccount models.MerchantAccount
	has, err := myClient.Table("merchant_accounts").
		Where("merchant_id = ?", merchantID).Get(&merchantAccount)
	if err != nil || !has {
		response.Err(c, "获取商户账户信息失败")
		return
	}

	_ = myClient.Begin() // 开始事务

	// 给下级商户把短信数量加上
	data := map[string]interface{}{
		"count_remain": merchantAccount.CountRemain + counter,
		"count_total":  merchantAccount.CountTotal + counter,
		"updated":      utils.TimeMicro(),
	}
	_, uErr := myClient.Table("merchant_accounts").Where("merchant_id = ?", merchantID).Update(data)
	if uErr != nil {
		myClient.Rollback()
		response.Err(c, "保存数据发生错误:"+uErr.Error())
		return
	}

	// 在本级商户把数量减掉
	dataAcc := map[string]interface{}{
		"count_remain": merchantAcc.CountRemain - counter,
		"count_total":  merchantAcc.CountTotal - counter,
		"updated":      utils.TimeMicro(),
	}
	_, mErr = myClient.Table("merchant_accounts").Where("merchant_id = ?", merchant.ID).Update(dataAcc)
	if mErr != nil {
		myClient.Rollback()
		response.Err(c, "保存数据发生错误:"+mErr.Error())
		return
	}

	_ = myClient.Commit() // 提交事务

	response.Message(c, "操作成功")
}
