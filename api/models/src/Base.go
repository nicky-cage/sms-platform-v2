package models

// IDName 通用id-name
type IDName struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// IDRow 仅ID列
type IDRow struct {
	Id int `json:"id" xorm:"id"`
}

// TotalInt 统计
type TotalInt struct {
	Total int `json:"total"`
}

// TotalFloat  统计
type TotalFloat struct {
	Total float64 `json:"total"`
}
