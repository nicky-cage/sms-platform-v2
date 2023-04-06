package router

import (
	"admin-api/controllers/adminloginlogs"
	"admin-api/controllers/adminlogs"
	"admin-api/controllers/adminroles"
	"admin-api/controllers/admins"
	"admin-api/controllers/banks"
	"admin-api/controllers/cities"
	"admin-api/controllers/countries"
	"admin-api/controllers/districts"
	"admin-api/controllers/index"
	"admin-api/controllers/merchantaccounts"
	"admin-api/controllers/merchantapplogs"
	"admin-api/controllers/merchantapps"
	"admin-api/controllers/merchantloginlogs"
	"admin-api/controllers/merchantlogs"
	"admin-api/controllers/merchants"
	"admin-api/controllers/messagebatches"
	"admin-api/controllers/messagechannels"
	"admin-api/controllers/messages"
	"admin-api/controllers/messagetemplates"
	"admin-api/controllers/mobilerecharges"
	"admin-api/controllers/notices"
	"admin-api/controllers/parametergroups"
	"admin-api/controllers/parameters"
	"admin-api/controllers/permissionips"
	"admin-api/controllers/provinces"
	"admin-api/controllers/recordcompletes"
	"admin-api/controllers/recordfailures"
	"admin-api/controllers/recordreceipts"
	"admin-api/controllers/reportcounts"
	"admin-api/controllers/reportmerchants"
	"admin-api/middlewares"
	"common/utils"

	"github.com/gin-gonic/gin"
)

// Init 路由初始化
func Init(router *gin.Engine) {
	router.Use(middlewares.DomainCheck()) // 检测非法域名访问
	// router.Use(middlewares.CheckPermissionIp()) // 检测ip是否有使用权限
	router.Use(middlewares.Cors()) // 跨域

	noAuth := router.Group("/v1")
	{
		noAuth.GET("/index/check_ip", index.CheckIP) // 检测IP - 授权
		noAuth.POST("/index/login", index.Login)     // 登录 - Post
		noAuth.GET("/index/login", index.Login)      // 登录 - Get
	}

	auth := router.Group("/v1/auth")
	{
		auth.Use(middlewares.CheckLogin()) // 检测用户是否登录
		// auth.Use(middlewares.CheckLoginRole()) // 检测用户是否登录
		auth.POST("/index/upload", utils.UploadFile)                         // 上传文件-通用
		auth.GET("/parameter_groups", parametergroups.Index.List)            // 参数分组
		auth.POST("/parameter_groups/save", parametergroups.Save.Save)       // 参数分组
		auth.GET("/parameters", parameters.Index.List)                       // 参数
		auth.POST("/parameters/save", parameters.Save.Save)                  // 参数
		auth.GET("/notices", notices.Index.List)                             //
		auth.POST("/notices/save", notices.Save.Save)                        //
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
		auth.GET("/admins", admins.Index.List)                               //
		auth.POST("/admins/save", admins.Save.Save)                          //
		auth.GET("/admin_roles", adminroles.Index.List)                      //
		auth.GET("/admin_logs", adminlogs.Index.List)                        //
		auth.GET("/admin_login_logs", adminloginlogs.Index.List)             //

		auth.GET("/banks", banks.List.List)       // 银行列表
		auth.POST("/banks/save", banks.Save.Save) // 银行 - 保存

		auth.GET("/countries", countries.Index.List)               //
		auth.POST("/countries/save", countries.Save.Save)          //
		auth.POST("/countries/save_rate", countries.SaveRate)      //
		auth.GET("/provinces", provinces.Index.List)               //
		auth.POST("/provinces/save", provinces.Save.Save)          //
		auth.GET("/cities", cities.Index.List)                     //
		auth.POST("/cities/save", cities.Save.Save)                //
		auth.GET("/districts", districts.Index.List)               //
		auth.POST("/districts/save", districts.Save.Save)          //
		auth.GET("/permission_ips", permissionips.Index.List)      //
		auth.POST("/permission_ips/save", permissionips.Save.Save) //
		auth.GET("/report_merchants", reportmerchants.Index.List)  //
		auth.GET("/report_counts", reportcounts.Index.List)        //

		auth.GET("/mobile_recharges", mobilerecharges.Index.List)      // 充值话费 - 列表
		auth.POST("/mobile_recharges/save", mobilerecharges.Save.Save) // 充值话费 - 保存
	}
}
