package common

// IdName 通用IDName
type IdName struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

// AdminToken 后台登录用户信息数据
type AdminToken struct {
	Id   int    `json:"id"`   //用户编号
	Name string `json:"name"` //用户名称
}

// IdNames 转换为序列
func IdNames(data map[int]string) []IdName {
	var rows []IdName
	for k, v := range data {
		rows = append(rows, IdName{
			Id:   k,
			Name: v,
		})
	}
	return rows
}
