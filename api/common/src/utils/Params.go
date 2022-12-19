package utils

import (
	"common/consts"
	"regexp"
	"strconv"
	"strings"
	"time"
)

// IsDateFormat 校验日期格式
func IsDateFormat(date string) bool {
	_, err := time.Parse("2006-01-02", date)
	return err == nil
}

// IsRealName 校验真实姓名
func IsRealName(realName string) bool {
	ok, _ := regexp.MatchString("^[\u4E00-\u9FA5]{2,10}$", realName)
	return ok
}

// IsBankBranch 校验银行支行
func IsBankBranch(branch string) bool {
	ok, _ := regexp.MatchString("^[\u4E00-\u9FA5]{4,20}$", branch)
	return ok
}

// IsBankAddress 校验银行支行
func IsBankAddress(address string) bool {
	ok, _ := regexp.MatchString("^[\u4e00-\u9fa5_a-zA-Z0-9]{4,20}$", address)
	return ok
}

// IsUserName 校验用户名  4-11位字母或数字
func IsUserName(userName string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9]{4,12}$", userName)
	return ok
}

// IsPassword 校验密码 6-12位字母或数字
func IsPassword(password string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9]{32}$", password)
	return ok
}

// IsVerifyCode 校验手机邮箱验证码 只允许输入4-6位字母或数字
func IsVerifyCode(code string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9]{4,6}$", code)
	return ok
}

// IsImageCode 图形验证码
func IsImageCode(code string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9]{4,6}$", code)
	return ok
}

// IsImageCodeID 图形验证码ID
func IsImageCodeID(id string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9]{1,100}$", id)
	return ok
}

// FormatPhoneNumber 格式化电话号码
func FormatPhoneNumber(number string) string {
	runeNumber := []rune(number)
	if len(runeNumber) != 11 {
		return ""
	}
	front := string(runeNumber[:3])
	tail := string(runeNumber[7:])
	return front + "****" + tail
}

// FormatEmail 格式化邮件
func FormatEmail(email string) string {
	ss := strings.Split(email, "@")
	if len(ss) != 2 {
		return ""
	}

	var front string
	if len(ss[0]) < 2 {
		front = ss[0]
	} else {
		front = string([]rune(ss[0])[:2])
	}

	return front + "****@" + ss[1]
}

// IsPhoneNumber 校验手机号
func IsPhoneNumber(phone string) bool {
	pattern := "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0-8])|(18[0-9])|166|198|(19[1-9])|(147))\\d{8}$"
	ok, _ := regexp.MatchString(pattern, phone)
	return ok
}

// IsEmail 校验邮箱
func IsEmail(email string) bool {
	pattern := `\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*`
	ok, _ := regexp.MatchString(pattern, email)
	return ok
}

// IsBankCard 校验卡号
func IsBankCard(bankCard string) bool {
	pattern := `^[0-9]{16,20}$`
	ok, _ := regexp.MatchString(pattern, bankCard)
	return ok
}

// IsBankCode 检查银行编码
func IsBankCode(bankCode string) bool {
	for _, v := range consts.BankList {
		if v.BankCode == bankCode {
			return true
		}
	}
	return false
}

// IsDeviceID 设备ID
func IsDeviceID(deviceID string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9:\\-]{1,100}$", deviceID)
	return ok
}

// IsHttpUrl 检查url
func IsHttpUrl(url string) bool {
	ok, _ := regexp.MatchString(`(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]`, url)
	return ok
}

// IsIP 检查ip
func IsIP(ip string) bool {
	reg := `^(([1-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.)(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){2}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$`
	ok, _ := regexp.MatchString(reg, ip)
	return ok
}

// IsVType 检查vtype
func IsVType(vType string) bool {
	vt, _ := strconv.Atoi(vType)
	if vt < 1 || vt > 20 {
		return false
	}
	return true
}

// IsDirFormat 检查dir格式
func IsDirFormat(dir string) bool {
	ok, _ := regexp.MatchString("^[a-zA-Z0-9/.]{1,100}$", dir)
	return ok
}
