package messagetemplates

import (
	"common/cache"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/utils"
	"errors"
	"github.com/gin-gonic/gin"
	"merchant-api/controllers/actions"
	"models"
	"xorm.io/builder"
)

// Index 列表
var Index = &actions.List[models.MessageTemplate]{
	Model: models.MessageTemplates,
	OrderBy: func(c *gin.Context) string {
		return "created DESC"
	},
	GetQueryCond: func(c *gin.Context) builder.Cond {
		cond := builder.NewCond()
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)

		token := request.GetAuthorization(c)
		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			log.Logger.Error("获取商户登录信息失败:")
			return cond
		}

		cond = cond.And(builder.Eq{"merchant_id": merchant.ID})

		var subs []models.Merchant
		mConn := db.Get(platform)
		defer mConn.Close()

		iArr := []int{}
		if err := mConn.Table("merchants").Where("parent_id = ?", merchant.ID).Find(&subs); err != nil {
			log.Logger.Error("读取二级商户信息有误:", err)
			return cond
		}

		if len(iArr) > 0 {
			for _, r := range subs {
				iArr = append(iArr, r.ID)
			}
			cond = cond.Or(builder.In("merchant_id", iArr))
		}

		return cond
	},
}

var Save = actions.Save{
	Model: models.MessageTemplates,
	CreateBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["created"] = utils.TimeMicro()
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	UpdateBefore: func(context *gin.Context, m *map[string]interface{}) error {
		(*m)["updated"] = utils.TimeMicro()
		return nil
	},
	SaveBefore: func(c *gin.Context, data *map[string]interface{}) error {
		platform := request.GetPlatform(c)
		rConn := cache.Get(platform)
		defer cache.Restore(platform, rConn)
		token := request.GetAuthorization(c)

		merchant := models.Merchants.GetByToken(rConn, token)
		if merchant == nil {
			return errors.New("缺少商户信息")
		}

		(*data)["merchant_id"] = merchant.ID
		(*data)["merchant_name"] = merchant.Name

		return nil
	},
}
