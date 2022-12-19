package common

import (
	"errors"
	"fmt"
	"gopkg.in/ffmt.v1"
	"strconv"
	"strings"

	"common/log"
	db "common/mysql"

	"github.com/go-xorm/xorm"
	"xorm.io/builder"
)

// GetTableName 获取表名称
func (p *Model) GetTableName() string {
	return p.TabName
}

// GetFindParameters 获取分页等相关信息
func (p *Model) GetFindParameters(params ...interface{}) (builder.Cond, int, int, string) {
	var args []interface{}
	if realArgs, ok := params[0].([]interface{}); ok { // 兼容多种格式
		args = realArgs
	} else {
		args = params
	}
	argLength := len(args)

	limit := 15
	offset := 0
	cond := builder.NewCond().And(builder.Eq{"1": 1})
	orderBy := ""

	if argLength >= 1 { // 条件
		if args[0] != nil {
			cond = args[0].(builder.Cond)
		}
		if argLength >= 2 {
			limit = args[1].(int)
			if argLength >= 3 {
				offset = args[2].(int)
				if argLength >= 4 {
					orderBy = args[3].(string)
				}
			}
		}
	}
	return cond, limit, offset, orderBy
}

// FindAllNoCount 获取所有记录
// 参数
//
//	rows 对象数组
//	args: [查询条件, orderBy]
//
// 结果: 记录条数, 错误
// FindAllNoCount 依据平台识别号获取所有记录
func (p *Model) FindAllNoCount(platform string, rows interface{}, args ...interface{}) error {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	mySession := p.GetSession(platform).Table(p.TabName)
	defer mySession.Close()
	if len(p.Joins) >= 1 {
		for _, j := range p.Joins {
			mySession.Join(j[0], j[1], j[2])
		}
	}
	argLength := len(args)
	if argLength >= 1 { // 条件 - where
		if args[0] != nil {
			mySession = mySession.Where(args[0].(builder.Cond))
		}
	}
	if argLength >= 2 { // 排序 - order - by
		mySession = mySession.OrderBy(args[1].(string))
	}

	return mySession.Find(rows)
}

// FindAll 获取所有记录
// 参数
//
//	rows 对象数组
//	args: [查询条件, limit, offset, orderBy]
//
// 结果: 记录条数, 错误
// FindAll 依据平台识别号获取所有记录
func (p *Model) FindAll(platform string, rows interface{}, args ...interface{}) (uint64, error) {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	mySession := p.GetSession(platform).Table(p.TabName)
	defer mySession.Close()
	if len(p.Joins) >= 1 {
		for _, j := range p.Joins {
			mySession.Join(j[0], j[1], j[2])
		}
	}
	orderBy := "id DESC"
	offset := 0
	cond := builder.NewCond()
	limit := 15
	if len(args) > 0 {
		cond, limit, offset, orderBy = p.GetFindParameters(args...)
	}
	if cond != nil && cond.IsValid() {
		mySession = mySession.Where(cond)
	}
	if orderBy != "" {
		mySession = mySession.OrderBy(orderBy)
	}
	total, err := mySession.Limit(limit, offset).FindAndCount(rows)
	sql, _ := mySession.LastSQL()
	ffmt.Puts(sql)
	fmt.Println("total = ", total, "error = ", err)
	return uint64(total), err
}

// Find 参数:
//
//	row: 对象
//	args: [查询条件]
//
// 返回: 是否存在记录, 错误
// Find 获取单条记录
func (p *Model) Find(platform string, row interface{}, args ...interface{}) (bool, error) {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	mySession := p.GetSession(platform).Table(p.TabName)
	defer mySession.Close()
	argLength := len(args)
	if argLength >= 1 { // 如果有第一个参数, 则是 WHERE => Cond.NewCond()
		if args[0] != nil {
			mySession = mySession.Where(args[0].(builder.Cond))
		}
	}
	if argLength >= 2 { // 如果有第二个参数, 则是 ORDER_BY
		if args[1] != nil { // order-by
			mySession = mySession.OrderBy(args[1].(string))
		}
	}
	ok, err := mySession.Get(row)
	return ok, err
}

// FindByID 获取编号、平台获取记录
func (p *Model) FindByID(platform string, id int, row interface{}) (bool, error) {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	mySession := p.GetSession(platform).Table(p.TabName)
	defer mySession.Close()
	cond := builder.And(builder.Eq{"id": id})
	mySession.Where(cond)
	return mySession.Get(row)
}

// CreateOne 添加一条
func (p *Model) CreateOne(platform string, m interface{}) error {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	_, err := p.GetSession(platform).InsertOne(m)
	return err
}

// CreateAll 依据平台识别号，一次性创建多条记录
func (p *Model) CreateAll(platform string, postedData []map[string]interface{}) error {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	var vals []string
	flds := ""
	inserts := []interface{}{""}
	// 先检测所有字段是否合法
	for _, v := range postedData {
		_, fields, values := getPostedFieldValues(platform, p.TabName, true, v)
		if fields == nil {
			return errors.New("批量添加失败: 无法依据平台获取字段信息")
		}
		if flds == "" {
			flds = fmt.Sprintf("(%s)", strings.Join(fields, ","))
		}
		vals = append(vals, fmt.Sprintf("(?%s)", strings.Repeat(",?", len(fields)-1)))
		inserts = append(inserts, values...)
	}
	inserts[0] = "INSERT INTO " + p.TabName + " " + flds + " VALUES " + strings.Join(vals, ",")
	mySession := p.GetSession(platform)
	defer mySession.Close()
	_, err := mySession.Exec(inserts...)
	return err
}

// Create 依据平台识别号添加记录
func (p *Model) Create(platform string, postedData map[string]interface{}) (uint64, error) {
	_, fields, values := getPostedFieldValues(platform, p.TabName, true, postedData)
	if fields == nil || values == nil {
		return 0, errors.New("添加数据失败: 无法依据平台获取字段信息")
	}
	// inserts := []interface{}{""}
	// inserts = append(inserts, values...)
	// inserts[0] = fmt.Sprintf("INSERT INTO %s (%s) VALUES (?%s)", p.TabName, strings.Join(fields, ","), strings.Repeat(",?", len(fields)-1))
	mySession := p.GetSession(platform)
	defer mySession.Close()

	if lastInsertID, err := mySession.Table(p.GetTableName()).InsertOne(postedData); err != nil {
		sql, _ := mySession.LastSQL()
		log.Logger.Error("执行Model-Create时失败: ", err, "\nSQL: ", sql, "\n")
		return 0, errors.New("添加失败: " + err.Error())
	} else {
		return uint64(lastInsertID), nil
	}
	// lastInsertID, err := result.LastInsertId()
	// if err != nil {
	// 	log.Err("获取添加记录时失败: %v\n", err)
	// 	return 0, errors.New("添加失败: " + err.Error())
	// }
}

// Update 修改记录
func (p *Model) Update(platform string, postedData map[string]interface{}) error {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	data, fields, values := getPostedFieldValues(platform, p.TabName, false, postedData)
	if fields == nil {
		return errors.New("修改失败: 无法获取字段信息")
	}
	idUn, exists := data["id"]
	if !exists {
		log.Err("修改记录时找不到ID\n")
		return errors.New("修改失败: 无法获取记录编号")
	}
	updates := []interface{}{""}
	updateFields := ""
	for k, v := range fields {
		updates = append(updates, values[k])
		updateFields += fmt.Sprintf("`%s` = ? ", v) + ","
	}
	id, _ := strconv.Atoi(fmt.Sprintf("%v", idUn))
	updates[0] = fmt.Sprintf("UPDATE %s SET %s WHERE id = %v", p.TabName, strings.Trim(updateFields, ","), strconv.Itoa(id))
	mySession := p.GetSession(platform)
	defer mySession.Close()
	if _, err := mySession.Exec(updates...); err != nil {
		log.Err("执行Model-Update时失败: %v\nSQL: %s\n", err, updates)
		return errors.New("修改失败: " + err.Error())
	}
	return nil
}

// Delete 删除记录
func (p *Model) Delete(platform string, idStr string) error {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	var ids []string
	idStrArr := strings.Split(idStr, ",")
	for _, v := range idStrArr {
		_, err := strconv.Atoi(v)
		if err != nil {
			log.Err("错误编号: %s/%v\n", idStr, err)
			return errors.New("删除失败: " + err.Error())
		}
		ids = append(ids, v)
	}
	if len(ids) == 0 {
		log.Err("无效的ID: %s\n", idStr)
		return errors.New("删除失败: 记录编号无效")
	}
	sql := "DELETE FROM " + p.TabName + " WHERE id IN (" + strings.Join(ids, ",") + ")"
	mySession := p.GetSession(platform)
	defer mySession.Close()
	_, err := mySession.Exec(sql)
	if err != nil {
		log.Err("删除失败: %v\n", err)
		return errors.New("删除失败: " + err.Error())
	}
	return nil
}

// GetSession 得到session - 每次拿的都是一个新的session
func (p *Model) GetSession(platform string) *xorm.Session {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	myClient := p.GetEngine(platform)
	if myClient == nil {
		panic("无法依据平台识别号获得 db-session")
	}
	return myClient.NewSession()
}

// GetEngine 得到数据库对象
func (p *Model) GetEngine(platform string) *xorm.EngineGroup {
	if p.GetPlatform != nil {
		platform = p.GetPlatform()
	}
	if d, exists := db.Servers[platform]; exists {
		return d
	}
	return nil
}
