package utils

import (
	"bytes"
	"crypto/hmac"
	"crypto/sha1"
	"encoding/base32"
	"encoding/binary"
	"fmt"
	"strings"
	"time"
)

// GoogleAuth google 授权
type GoogleAuth struct{}

// NewGoogleAuth 生成默认
func NewGoogleAuth() *GoogleAuth {
	return &GoogleAuth{}
}

// un 生成唯一识别号
func (p *GoogleAuth) un() int64 {
	return time.Now().UnixNano() / 1000 / 30
}

// hmacSha1 加密
func (p *GoogleAuth) hmacSha1(key, data []byte) []byte {
	h := hmac.New(sha1.New, key)
	if total := len(data); total > 0 {
		h.Write(data)
	}
	return h.Sum(nil)
}

// base32encode 加密
func (p *GoogleAuth) base32encode(src []byte) string {
	return base32.StdEncoding.EncodeToString(src)
}

// base32decode 加密
func (p *GoogleAuth) base32decode(s string) ([]byte, error) {
	return base32.StdEncoding.DecodeString(s)
}

// toBytes 转换为字节
func (p *GoogleAuth) toBytes(value int64) []byte {
	var result []byte
	mask := int64(0xFF)
	shifts := [8]uint16{56, 48, 40, 32, 24, 16, 8, 0}
	for _, shift := range shifts {
		result = append(result, byte((value>>shift)&mask))
	}
	return result
}

// toUint32 转换为int32
func (p *GoogleAuth) toUint32(bts []byte) uint32 {
	return (uint32(bts[0]) << 24) + (uint32(bts[1]) << 16) +
		(uint32(bts[2]) << 8) + uint32(bts[3])
}

// oneTimePassword 一次性密码
func (p *GoogleAuth) oneTimePassword(key []byte, data []byte) uint32 {
	hash := p.hmacSha1(key, data)
	offset := hash[len(hash)-1] & 0x0F
	hashParts := hash[offset : offset+4]
	hashParts[0] = hashParts[0] & 0x7F
	number := p.toUint32(hashParts)
	return number % 1000000
}

// GetSecret 获取秘钥
func (p *GoogleAuth) GetSecret() string {
	var buf bytes.Buffer
	binary.Write(&buf, binary.BigEndian, p.un())
	return strings.ToUpper(p.base32encode(p.hmacSha1(buf.Bytes(), nil)))
}

// GetCode 获取动态码
func (p *GoogleAuth) GetCode(secret string) (string, error) {
	secretUpper := strings.ToUpper(secret)
	secretKey, err := p.base32decode(secretUpper)
	if err != nil {
		return "", err
	}
	number := p.oneTimePassword(secretKey, p.toBytes(time.Now().Unix()/30))
	return fmt.Sprintf("%06d", number), nil
}

// 获取动态码二维码内容
// func (this *GoogleAuth) GetQrcode(user, secret string) string {
// 	return fmt.Sprintf("otpauth://totp/%s?secret=%s", user, secret)
// }
//
// // 获取动态码二维码图片地址,这里是第三方二维码api
// func (this *GoogleAuth) GetQrcodeUrl(user, secret string) string {
// 	qrcode := this.GetQrcode(user, secret)
// 	width := "200"
// 	height := "200"
// 	data := url.Values{}
// 	data.Set("data", qrcode)
// 	return "https://api.qrserver.com/v1/create-qr-code/?" + data.Encode() + "&size=" + width + "x" + height + "&ecc=M"
// }

// VerifyCode 验证动态码
func (p *GoogleAuth) VerifyCode(secret, code string) (bool, error) {
	_code, err := p.GetCode(secret)
	if err != nil {
		return false, err
	}
	return _code == code, nil
}
