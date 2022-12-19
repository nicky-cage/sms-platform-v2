package models

import (
	common "common"
	"encoding/json"
	"fmt"
)

// Menu Model说明 //3185 24996 73
type Menu struct {
	ID        int    `json:"id" xorm:"id pk"`            // 编号
	Name      string `json:"name"`                       // 菜单名称
	ParentID  int    `json:"parent_id" xorm:"parent_id"` // 上级菜单编号
	URL       string `json:"url" xorm:"url"`             // URL
	IsBlank   int    `json:"is_blank"`                   // 是否外链 0:否 1:是
	Method    int    `json:"method"`                     // 方法 1:GET 2:POST 3:ALL, 不考虑其他
	IsView    int    `json:"is_view"`                    // 是否可见 0:否 1:是
	State     int    `json:"state"`                      // 状态 1:正常 0:禁用
	EnableLog int    `json:"enable_log"`                 // 开启日志1 禁用日志0
	Level     int    `json:"level"`                      // 菜单级别, 1: 一级菜单, 2: 二级菜单, 3: 三级菜单
	Sort      int    `json:"sort"`                       // 排序
	Icon      string `json:"icon"`                       // 菜单图标
	Remark    string `json:"remark"`                     // 备注
	LogLevel  int    `json:"log_level"`                  // 日志级别 1:低 2:中 3:高
	LogType   int    `json:"log_type"`                   // 日志类型 1:添加 2:修改 3:删除 4:数据列表 5:数据详情 9:其他

	Children      []Menu `json:"children" xorm:"-"`
	*common.Model `xorm:"-"`
}

// LayMenu 用于layui的菜单
type LayMenu struct {
	ID       int       `json:"id" xorm:"id"`
	Title    string    `json:"title"`
	Field    string    `json:"field"`
	Checked  bool      `json:"checked"`
	Spread   bool      `json:"spread"`
	Children []LayMenu `json:"children"`
}

// Menus 数据访问对象
var Menus = &Menu{
	Model: &common.Model{
		TabName: "menus",
	},
}

// MenusHeap 菜单
var MenusHeap = &Menu{
	Model: &common.Model{
		TabName: "menus_in_heap",
	},
}

// LayMenus 菜单
var LayMenus = &LayMenu{}

// IsEnableLog 是否启用写操作日志
func (ths *Menu) IsEnableLog() bool {
	return ths.EnableLog == 1
}

// AccessMe 本身访问
func (ths *Menu) AccessMe() bool {
	return ths.URL == "/access_logs"
}

// TableName 指定数据表名
func (ths *Menu) TableName() string {
	return "menus"
}

// ToListJSON 转换为二级目录json
func (ths *LayMenu) ToListJSON(list []Menu) string {
	arr := []LayMenu{}
	for _, m1 := range list {
		children := []LayMenu{}
		for _, m2 := range m1.Children {
			children = append(children, LayMenu{
				ID:       m2.ID,
				Title:    m2.Name,
				Field:    fmt.Sprintf("m2_%d", m2.ID),
				Spread:   true,
				Children: []LayMenu{},
			})
		}
		arr = append(arr, LayMenu{
			ID:       m1.ID,
			Title:    m1.Name,
			Field:    fmt.Sprintf("m1_%d", m1.ID),
			Spread:   true,
			Children: children,
		})
	}

	bytes, err := json.Marshal(arr)
	if err != nil {
		fmt.Println("序列化出错菜单 :", err)
		return "{}"
	}

	return string(bytes)
}

//
// 得到所有层级的目录
func getDeepChildren(list []Menu, level int) []LayMenu {
	if len(list) == 0 {
		return []LayMenu{}
	}

	arr := []LayMenu{}
	for _, m := range list {
		isSpread := true
		childrenList := getDeepChildren(m.Children, level+1)
		arr = append(arr, LayMenu{
			ID:       m.ID,
			Title:    m.Name,
			Field:    fmt.Sprintf("m%d_%d", level, m.ID),
			Spread:   isSpread,
			Children: childrenList,
		})
	}

	return arr
}

// GetDeepMenus 所有层级全部转换
func (ths *LayMenu) GetDeepMenus(list []Menu) []LayMenu {
	return getDeepChildren(list, 1)
}

// ToDeepJSON 所有层级全部转换
func (ths *LayMenu) ToDeepJSON(list []LayMenu) string {
	bytes, err := json.Marshal(list)
	if err != nil {
		fmt.Println("序列化出错菜单 :", err)
		return "{}"
	}
	return string(bytes)
}
