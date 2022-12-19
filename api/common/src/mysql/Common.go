package mysql

import (
	"common/consts"
	"github.com/go-xorm/xorm"
)

// Get 获得mysql
func Get(platform string, masterOnly ...bool) *xorm.Session {
	isMasterOnly := false
	if len(masterOnly) >= 1 {
		isMasterOnly = masterOnly[0]
	}
	return GetDbByPlatform(platform, isMasterOnly)
}

// AllMysql 所有平台数据库
func AllMysql() map[string]*xorm.Session {
	arr := map[string]*xorm.Session{}
	for _, platform := range consts.PlatformCodes {
		arr[platform] = Get(platform)
	}
	return arr
}

// AllMysqlRestore 关闭所有session
func AllMysqlRestore(allDbSessions map[string]*xorm.Session) {
	for _, dbSession := range allDbSessions {
		dbSession.Close()
	}
}

// Use 使用mysql
func Use(platform string, callback func(*xorm.Session) error) error {
	mConn := Get(platform)
	defer mConn.Close()
	return callback(mConn)
}
