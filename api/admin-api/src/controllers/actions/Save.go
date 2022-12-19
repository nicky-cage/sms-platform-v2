package actions

import (
	"common"
	"common/log"
	db "common/mysql"
	"common/request"
	"common/response"
	"fmt"
	"github.com/gin-gonic/gin"
	"gopkg.in/ffmt.v1"
	"models"
)

// Save 保存数据
type Save struct {
	Model           common.IModel                                     // model - 必须
	Validator       func(string, map[string]interface{}) error        //校验器
	CreateValidator func(string, map[string]interface{}) error        //校验器
	CreateBefore    func(*gin.Context, *map[string]interface{}) error //添加数据之前处理, 可以中断
	CreateAfter     func(*gin.Context, *map[string]interface{})       //添加数据之后处理, 不可中断
	UpdateValidator func(string, map[string]interface{}) error        //校验器
	UpdateBefore    func(*gin.Context, *map[string]interface{}) error //修改数据之前处理, 可以中断
	UpdateAfter     func(*gin.Context, *map[string]interface{})       //修改数据之后处理, 不可中断
	SaveBefore      func(*gin.Context, *map[string]interface{}) error //保存数据之前处理, 可以中断
	SaveAfter       func(*gin.Context, *map[string]interface{})       //保存数据之后处理, 不可中断
}

// Save 保存数据 - ajax
func (ths *Save) Save(c *gin.Context) {
	postedData := request.GetPostedData(c)
	ffmt.Puts(postedData)
	isCreate := false
	validator := ths.Validator                                                //优化选择before/after验证器
	if idStr, exists := postedData["id"]; !exists || exists && idStr == "0" { //id不能为0
		isCreate = true
		if ths.CreateAfter != nil {
			validator = ths.CreateValidator
		}
	} else {
		if ths.UpdateAfter != nil {
			validator = ths.UpdateValidator
		}
	}
	platform := request.GetPlatform(c)
	if validator != nil {
		if err := ths.Validator(platform, postedData); err != nil {
			response.Err(c, err.Error())
			return
		}
	}
	if isCreate && ths.CreateBefore != nil { //创建前验证
		if err := ths.CreateBefore(c, &postedData); err != nil { //可以取消
			response.Err(c, err.Error())
			return
		}
	} else if !isCreate && ths.UpdateBefore != nil { //修改前验证
		if err := ths.UpdateBefore(c, &postedData); err != nil { //可以取消
			response.Err(c, err.Error())
			return
		}
	}
	if ths.SaveBefore != nil { //保存前验证
		if err := ths.SaveBefore(c, &postedData); err != nil {
			response.Err(c, err.Error())
			return
		}
	}

	mySession := db.Get(platform)
	defer mySession.Close()

	tableName := ths.Model.GetTableName()
	if isCreate {
		if effectRows, err := mySession.Table(tableName).Insert(postedData); err != nil || effectRows == 0 {
			sql, _ := mySession.LastSQL()
			log.Logger.Error("执行Model-Create时失败: %v\nSQL: %s\n", err, sql)
			response.Err(c, "添加记录失败:"+err.Error())
			return
		}
		if ths.CreateAfter != nil {
			ths.CreateAfter(c, &postedData) //不可取消
		}

		idRow := models.IDRow{}
		if exists, err := mySession.SQL("SELECT last_insert_id() AS id").Get(&idRow); err == nil && exists {
			postedData["id"] = idRow.Id
		} else if err != nil {
			fmt.Println("获取最后一次记录出现错误:", err)
		}
	} else {
		recordID := postedData["id"]
		delete(postedData, "id")
		mySession.Table(tableName).Where("id = ?", recordID).Update(postedData)
		if ths.UpdateAfter != nil {
			ths.UpdateAfter(c, &postedData)
		}

		postedData["id"] = recordID
	}

	if ths.SaveAfter != nil {
		ths.SaveAfter(c, &postedData)
	}

	response.Ok(c)
}
