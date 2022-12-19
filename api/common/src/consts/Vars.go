package consts

// 系统代理
const (
	SysTestAgent     = "sys_agent_test"
	SysOfficialAgent = "sys_agent_official"
	SysAgentAgent    = "sys_agent_agent"
)

// AppName 应用程序名称
var AppName = ""

// RunMode 运行模式
// develop: 开发模式
// release: 生产环境
var RunMode = "develop"

// PlatformDefault 默认平台识别号
var PlatformDefault = ""

// PlatformIntegrated 综合平台(总台)
var PlatformIntegrated = ""

// PlatformUserNamePrefix 平台用户名称前缀
var PlatformUserNamePrefix = "tj"

// UploadPath 上传路径
var UploadPath = "./uploads"

// UploadURLPath 上传之后前缀
var UploadURLPath = "/uploads"

// LogPath  默认当前目录
var LogPath = "./"

// DbHasRwSplit 是否开启读写分离,最终会通过配置来断定是否开启了读写分离
var DbHasRwSplit = true

// DbServerUrls mysql数据库配置
var DbServerUrls map[string][]string

// RedisServerUrls redis -> 平台识别号: redis连接信息
var RedisServerUrls map[string]string

// InternalIpList 内部IP
var InternalIpList []string

// CustomDebug 自定义debug开关
var CustomDebug = true

// FrontPageSize 每页分页的数量
var FrontPageSize = 20

// DisableSysMaintain 默认不禁用系统维护的标记
var DisableSysMaintain = false

// InternalMemberServUrl 内部调用member 服务
var InternalMemberServUrl = ""

// InternalOssServUrl 内部调用oss 文件上传 服务
var InternalOssServUrl = ""

// InternalAdminServUrl 内部调用后台地址
var InternalAdminServUrl = ""

// IpDbPath ip数据库文件地址
var IpDbPath = ""

// AdminLogTypes 管理员日志类型
var AdminLogTypes = struct {
	Normal     int
	InOut      int
	Permission int
	Finance    int
	Content    int
	Other      int
}{
	Normal:     0,
	InOut:      1,
	Permission: 2,
	Finance:    3,
	Content:    4,
	Other:      9,
}

// AdminLogLevels 管理员日志级别
var AdminLogLevels = struct {
	Normal    int
	Important int
	Warn      int
	Fatal     int
	Error     int
	Special   int
	Other     int
}{
	Normal:    0,
	Important: 1,
	Warn:      2,
	Fatal:     3,
	Error:     4,
	Special:   5,
	Other:     9,
}
