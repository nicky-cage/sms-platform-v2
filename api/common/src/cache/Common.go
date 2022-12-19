package cache

import (
	"errors"
	"fmt"
	"math/rand"

	"github.com/go-redis/redis/v7"
)

// RandString 获取随机的字符串
func RandString(n int) string {
	Letters := []rune("abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_")
	b := make([]rune, n)
	total := len(Letters)
	for i := range b {
		b[i] = Letters[rand.Intn(total)]
	}
	return string(b)
}

// Lock 分布式锁
func Lock(platform string, idStr string) (string, error) {
	conn := GetConn(platform)
	defer ReturnConn(platform, conn)

	// currentTime := time.Now()
	// randStr := RandString(16)
	// key := fmt.Sprintf("LOCK:%d:%s:%s", currentTime.UnixNano(), randStr, idStr)
	key := fmt.Sprintf("LOCK:%s", idStr)
	val, err := conn.Incr(key).Result()
	if err != nil && err != redis.Nil { // 操作出现问题
		return "", err
	}

	if val > 1 { // 表示已经被锁定
		return "", errors.New("locked data")
	}
	return key, nil
}

// Unlock 解锁
func Unlock(platform, key string) {
	redis := GetConn(platform)
	defer ReturnConn(platform, redis)
	_, _ = redis.Del("LOCK:" + key).Result()
}
