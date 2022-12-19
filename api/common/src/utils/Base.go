package utils

import (
	"math/rand"
	"time"
)

// McryptLetters 用于生成随机字符串的值
var McryptLetters = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

// McryptLettersLower 小写
var McryptLettersLower = []rune("abcdefghijklmnopqrstuvwxyz0123456789")

// GetRandString 生成随机字符串
func GetRandString(n int) string {
	rand.Seed(time.Now().UnixNano())
	b := make([]rune, n)
	for i := range b {
		b[i] = McryptLetters[rand.Intn(len(McryptLetters))]
	}
	return string(b)
}

// IfString 依据条件返回
func IfString(c bool, s1, s2 string) string {
	if c {
		return s1
	}
	return s2
}
