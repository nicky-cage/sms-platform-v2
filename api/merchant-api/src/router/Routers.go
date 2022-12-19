package router

import (
	"common/utils"
	"merchant-api/controllers/index"
	"merchant-api/controllers/merchantaccounts"
	"merchant-api/controllers/merchantapplogs"
	"merchant-api/controllers/merchantapps"
	"merchant-api/controllers/merchantloginlogs"
	"merchant-api/controllers/merchantlogs"
	"merchant-api/controllers/merchants"
	"merchant-api/controllers/messagebatches"
	"merchant-api/controllers/messagechannels"
	"merchant-api/controllers/messages"
	"merchant-api/controllers/messagetemplates"
	"merchant-api/controllers/recordcompletes"
	"merchant-api/controllers/recordfailures"
	"merchant-api/controllers/recordreceipts"
	"merchant-api/controllers/reportmerchants"
	"merchant-api/middlewares"

	"github.com/gin-gonic/gin"
)

// Init 路由初始化
func Init(router *gin.Engine) {
	router.Use(middlewares.DomainCheck()) // 检测非法域名访问
	// router.Use(middlewares.CheckPermissionIp()) // 检测ip是否有使用权限
	router.Use(middlewares.Cors()) // 跨域

	noAuth := router.Group("/v1")
	{
		noAuth.GET("index/check_ip", index.CheckIP) // 检测IP - 授权
		noAuth.POST("/index/login", index.Login)    // 登录 - Post
		noAuth.GET("/index/login", index.Login)     // 登录 - Get
	}

	auth := router.Group("/v1/auth")
	{
		// auth.Use(middlewares.CheckLoginRole()) // 检测用户是否登录
		auth.Use(middlewares.CheckLogin())                                   // 检测用户是否登录
		auth.POST("/index/upload", utils.UploadFile)                         // 上传文件-通用
		auth.GET("/merchants", merchants.Index.List)                         //
		auth.POST("/merchants/save", merchants.Save.Save)                    //
		auth.POST("/merchants/save_rate", merchants.SaveRate)                //
		auth.GET("/merchant_accounts", merchantaccounts.Index.List)          //
		auth.POST("/merchant_accounts/add_count", merchantaccounts.AddCount) //
		auth.GET("/merchant_logs", merchantlogs.Index.List)                  //
		auth.GET("/merchant_login_logs", merchantloginlogs.Index.List)       //
		auth.GET("/merchant_apps", merchantapps.Index.List)                  //
		auth.POST("/merchant_apps/save", merchantapps.Save.Save)             //
		auth.GET("/merchant_app_logs", merchantapplogs.Index.List)           //
		auth.GET("/messages", messages.Index.List)                           //
		auth.POST("/messages/save", messages.Save.Save)                      //
		auth.GET("/messages/check", messages.Check)                          //
		auth.GET("/message_templates", messagetemplates.Index.List)          //
		auth.POST("/message_templates/save", messagetemplates.Save.Save)     //
		auth.GET("/message_channels", messagechannels.Index.List)            //
		auth.POST("/message_channels/save", messagechannels.Save.Save)       //
		auth.GET("/message_batches", messagebatches.Index.List)              //
		auth.POST("/message_batches/save", messagebatches.Save.Save)         //
		auth.GET("/record_completes", recordcompletes.Index.List)            //
		auth.GET("/record_failures", recordfailures.Index.List)              //
		auth.GET("/record_receipts", recordreceipts.Index.List)              //
		auth.GET("/report_merchants", reportmerchants.Index.List)            //
	}
}
