package consts

// ErrCode 错误代码
type ErrCode int

// 全局错误码
const (
	Success ErrCode = 0 //成功

	ErrorRecoveryNoBalance ErrCode = 1015 //游戏回收余额的时候，如果钱是0.00，直接返回特殊的错误，让回收过滤掉前台游戏的余额刷新
	ErrorIpBan             ErrCode = 1021 //ip禁止登录（nginx做的）统一ip禁止页面
	ErrorLoginExpire       ErrCode = 1022 //token(过期，单点登录的原因) 重定向到登录页面
	ErrorMaintain          ErrCode = 1103 //系统维护 前台统一使用 统一系统维护页面
	ErrorWagers            ErrCode = 1150 //采集数据出错
	ErrorIOSApp            ErrCode = 1180 //IOS特殊错误.
	ErrorInvalidParam      ErrCode = 1100 //参数错误
	ErrorCommon            ErrCode = 1101 //一般错误
	ErrorInternal          ErrCode = 1102 //内部错误
	ErrorPermissionDenied  ErrCode = 1200 //验证失败
	ErrorIPDenied          ErrCode = 1201 //ip禁止
	ErrorNoLogin           ErrCode = 1301 //没有登录
	AgentBanCode           ErrCode = 1302 //代理账号禁用
)

//
var errMap = map[ErrCode]string{
	Success:               "成功",
	ErrorInvalidParam:     "参数错误",
	ErrorCommon:           "一般错误",
	ErrorInternal:         "内部错误",
	ErrorPermissionDenied: "验证失败",
	ErrorIOSApp:           "IOS错误",
	ErrorWagers:           "游戏场馆采集数据出错",
	ErrorIpBan:            "ip被禁止",
	ErrorLoginExpire:      "您尚未登录，请登录后再试",
	ErrorMaintain:         "系统维护",
}

// Error 错误信息
func Error(code ErrCode) string {
	return errMap[code]
}
