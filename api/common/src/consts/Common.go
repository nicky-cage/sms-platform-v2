package consts

import (
	"time"
)

// TimeLayoutYmdHis 时间格式
const TimeLayoutYmdHis = "2006-01-02 15:04:05"

// TimeLayoutYmd 年月日格式
const TimeLayoutYmd = "2006-01-02"

// TimeLayoutYmdNoLine 不带横线
const TimeLayoutYmdNoLine = "20060102"

// TimeBillLayoutYmd 账户取数
const TimeBillLayoutYmd = "060102150405"

// DATETIME 时间+时区 格式
const DATETIME = "2006-01-02T15:04:05+08:00"

// HeaderKeyToken 常量定义
const HeaderKeyToken = "Authorization"

// RedisUserPrefix 缓存前缀
const RedisUserPrefix = "USER:"

// TokenKeyDuration token-Key持续时间
const TokenKeyDuration time.Duration = 3600 // 1.5个小时

// AccessToken 访问Token
const AccessToken = "Authorization"

// CurUserInfo 当前用户信息
const CurUserInfo = "user_info"

// TokenExpireTime token过期时间
const TokenExpireTime = 60 * 60 * 3

// AdminLoginErrMax 后台登录最多错误次数
const AdminLoginErrMax = 5

// AdminLoginLockSeconds 后台登录错误锁定时间(秒)
const AdminLoginLockSeconds = 3600

// DefaultExpiration 默认缓存时间
const DefaultExpiration = time.Duration(0)

// ForeverExpiration 永久缓存时间
const ForeverExpiration = time.Duration(-1)

// Limit 限制
const Limit = 50

// UploadFile 上传位置
const UploadFile = "upload:file:"

// IncrUserID 编号
const IncrUserID = 9999999
