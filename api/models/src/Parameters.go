package models

import (
	"common"
	"common/cache"
	"common/consts"
	db "common/mysql"
	"encoding/json"
	"errors"
	"fmt"
	"strconv"
)

// Parameter Model说明
type Parameter struct {
	ID           int    `json:"id" xorm:"id pk autoincr"` // 编号
	Name         string `json:"name"`                     // 参数名称
	Value        string `json:"value"`                    // 参数值
	Title        string `json:"title"`                    // 参数说明
	ValueDefault string `json:"value_default"`            // 默认值
	ValueType    string `json:"value_type"`               // 值类型 1string 2int 3 float64
	Remark       string `json:"remark"`                   // 备注
	Sort         int    `json:"sort"`                     // 排序
	GroupID      int    `json:"group_id" xorm:"group_id"` // 参数组id

	*common.Model `xorm:"-"`
}

// Parameters 数据访问对象
var Parameters = Parameter{
	Model: &common.Model{
		TabName: "parameters",
	},
}

// ConfigReadValue 配置
func (ths *Parameter) ConfigReadValue(platform, key string) (interface{}, error) {
	cacheKey := consts.ParamCacheKey + key
	redisClient := cache.Get(platform)
	defer cache.Restore(platform, redisClient)
	intHas, err := redisClient.Exists(cacheKey).Result()
	if err != nil {
		return nil, err
	}

	if intHas > 0 {
		val, err := redisClient.Get(cacheKey).Result()
		if err != nil {
			return nil, err
		}
		obj := struct {
			Type string `json:"type"`
			Val  string `json:"val"`
		}{
			"",
			"",
		}
		err = json.Unmarshal([]byte(val), &obj)
		if err != nil {
			return nil, err
		}
		if obj.Type == "string" {
			return obj.Val, nil
		} else if obj.Type == "int" {
			v, err := strconv.Atoi(obj.Val)
			if err != nil {
				return nil, err
			}
			return v, nil
		} else if obj.Type == "float64" {
			v, err := strconv.ParseFloat(obj.Val, 64)
			if err != nil {
				return nil, err
			}
			return v, nil
		} else {
			return nil, errors.New(key + " 对应的value_type的类型不存在")
		}

	} else {
		obj := Parameter{}
		b, err := ths.GetSession(platform).Table("parameters").Where("name = ?", key).Get(&obj)
		if err != nil {
			return nil, err
		}
		if b {
			if obj.ID > 0 {
				if obj.ValueType == "string" { // 30天
					_ = redisClient.Set(cacheKey, `{"type":"string","val":"`+obj.Value+`"}`, consts.ForeverExpiration)
					return obj.Value, nil
				} else if obj.ValueType == "int" {
					v, err := strconv.Atoi(obj.Value)
					if err != nil {
						return nil, err
					}
					// 30天
					_ = redisClient.Set(cacheKey, `{"type":"int","val":"`+obj.Value+`"}`, consts.ForeverExpiration)
					return v, nil
				} else if obj.ValueType == "float64" {
					v, err := strconv.ParseFloat(obj.Value, 64)
					if err != nil {
						return nil, err
					}
					// 30天
					_ = redisClient.Set(cacheKey, `{"type":"float64","val":"`+obj.Value+`"}`, consts.ForeverExpiration)
					return v, nil
				} else {
					return nil, errors.New(key + " 对应的value_type的类型不存在")
				}
			}
		}
	}

	return nil, errors.New(key + " 配置表不存在该数据")
}

// TableName 指定数据表名
func (ths *Parameter) TableName() string {
	return "parameters"
}

// GetValueByFloat 获取浮点数
// platform: 平台名称
// key: 参数名称
// defaultValue: 默认值
// args: [0: title]
func (ths *Parameter) GetValueByFloat(platform string, key string, defaultValue float64, args ...string) float64 {
	val := ths.GetValue(platform, key, defaultValue, args...)
	origin := fmt.Sprintf("%v", val)
	if fVal, err := strconv.ParseFloat(origin, 64); err == nil {
		return fVal
	}
	return defaultValue
}

// GetValueByInt 同上
func (ths *Parameter) GetValueByInt(platform string, key string, defaultValue int, args ...string) int {
	val := ths.GetValue(platform, key, defaultValue, args...)
	origin := fmt.Sprintf("%v", val)
	if fVal, err := strconv.Atoi(origin); err == nil {
		return fVal
	}
	return defaultValue
}

// GetValue 获取值
func (ths *Parameter) GetValue(platform string, key string, defaultValue interface{}, args ...string) interface{} {
	sql := "SELECT value FROM parameters WHERE name = ? LIMIT 1"
	mySession := db.Get(platform)
	defer mySession.Close()

	rows, err := mySession.QueryString(sql, key)
	if err != nil {
		return defaultValue
	}
	if len(rows) == 0 { // 自动写入
		title := "请添加参数说明"
		if len(args) > 0 {
			title = args[0]
		}
		_ = ths.SetValue(platform, key, defaultValue, 0, title)
		return defaultValue
	}

	return rows[0]["value"]
}

// SetValue 设置值
// args: [0: group_id, 1: title]
func (ths *Parameter) SetValue(platform string, key string, value interface{}, args ...interface{}) error {
	mySession := db.Get(platform)
	defer mySession.Close()

	hasGroupID := false
	groupID := 6 // 默认的 group_id
	if len(args) > 0 {
		gid := args[0].(int)
		if gid > 0 {
			hasGroupID = true
			groupID = gid
		}
	}
	sql := "SELECT id FROM parameters WHERE name = ?"
	if hasGroupID {
		sql += fmt.Sprintf(" AND group_id = %d ", groupID)
	}

	rows, err := mySession.QueryInterface(sql, key)
	if err != nil {
		return err
	}

	title := ""
	if len(args) > 1 {
		title = args[1].(string)
	}
	if len(rows) > 0 { // 修改
		id := rows[0]["id"].(int64)
		sql := "UPDATE parameters SET `value` = ? "
		if title != "" {
			sql += ", title = '" + title + "'"
		}
		sql += " WHERE id = ?"
		fmt.Println("sql = ", sql)
		_, err := mySession.Exec(sql, value, id)
		if err != nil {
			return err
		}
		return nil
	}

	sql = "INSERT INTO parameters (name, `value`, value_type, group_id, title) VALUES (?, ?, 'string', ?, ?)"
	res, err := mySession.Exec(sql, key, value, groupID, title)
	if err != nil {
		return err
	}
	if lastInsertId, err := res.LastInsertId(); err != nil || lastInsertId == 0 {
		return err
	}

	return nil
}
