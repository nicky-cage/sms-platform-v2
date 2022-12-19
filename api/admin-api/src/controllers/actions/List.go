package actions

import (
	"common"
	"common/log"
	"common/request"
	"common/response"
	"fmt"

	"github.com/flosch/pongo2"
	"github.com/gin-gonic/gin"
	"github.com/go-xorm/xorm"
	"xorm.io/builder"
)

// ActionResult 处理结果
type ActionResult = map[string]interface{}

// List 数据列表
type List[M common.IModel] struct {
	Model             M                                 // 必须 - 实例
	QueryCond         map[string]interface{}            // 查询条件
	GetQueryCond      func(*gin.Context) builder.Cond   // 获得查询条件, 此条件会与 QueryCond条件进行累加
	ProcessRow        func(*gin.Context, interface{})   // 默认处理函数
	Rows              func() interface{}                // 多条记录
	ExtendData        func(*gin.Context) pongo2.Context // 扩展数据
	OrderBy           func(*gin.Context) string         // 获取排序
	GetQuerySession   func(*gin.Context) *xorm.Session  // 得到自定义的查询session
	RequireParameters bool                              // 必须带参数访问 - 如果此值为true, 则访问必须带参数否则将返回空白
	AfterAction       func(*gin.Context, *ActionResult) // 处理之后
}

// List 记录列表 - get
func (ths *List[M]) List(c *gin.Context) {
	// 必须多余的参数
	if ths.RequireParameters {
		requestData := c.Request.URL.Query()
		if len(requestData) == 0 {
			response.Err(c, "缺少必要参数")
			return
		}
		if _, exists := requestData["page"]; exists {
			delete(requestData, "page")
			if len(requestData) == 0 {
				response.Pager(c, []interface{}{})
				return
			}
		}
	}

	// 如果没有提供rows参数, 则生成默认的rows参数
	rows := func() interface{} {
		if ths.Rows != nil {
			return ths.Rows()
		}
		return &[]M{}
	}()

	page := request.GetPage(c)
	limit, offset := request.GetOffsets(c)
	platform := request.GetPlatform(c)
	cond := request.GetQueryCond(c, ths.QueryCond)

	if ths.GetQueryCond != nil { // 将条件进行合并
		condTemp := ths.GetQueryCond(c)
		if condTemp != nil { // 确保附加条件不为空
			if cond != nil { // 如果有条件, 则合并条件
				cond = cond.And(condTemp)
			} else { // 如果没有条件, 则生成条件
				cond = condTemp
			}
		}
	}

	// 如果是导出
	if exportExcel := c.DefaultQuery("export_excel", ""); exportExcel != "" {
		if err := func() error {
			if ths.OrderBy != nil {
				return ths.Model.FindAllNoCount(platform, rows, cond, ths.OrderBy(c))
			}
			return ths.Model.FindAllNoCount(platform, rows, cond)
		}(); err != nil {
			log.Logger.Error("执行导出数据时出错: ", err)
			response.Err(c, "导出数据时出错")
			return
		}
		response.Result(c, rows)
		return
	}

	var total uint64
	var err error
	// 关于 order by 的判断
	if ths.OrderBy != nil {
		total, err = ths.Model.FindAll(platform, rows, cond, limit, offset, ths.OrderBy(c))
	} else {
		total, err = ths.Model.FindAll(platform, rows, cond, limit, offset)
	}
	if err != nil {
		log.Logger.Error("获取列表信息出错: %v\n", err)
		fmt.Println("获取列表信息出错: ", err)
		response.Err(c, "获取列表错误:"+err.Error())
		return
	}

	if ths.ProcessRow != nil {
		ths.ProcessRow(c, rows)
	}

	viewData := ActionResult{
		"records": rows,  // 数据列表
		"total":   total, // 总计
		"page":    page,  // 分页
	}

	if ths.ExtendData != nil { // 如果有附加数据, 则进行追加
		data := ths.ExtendData(c)
		for k, v := range data {
			viewData[k] = v
		}
	}

	if ths.AfterAction != nil {
		ths.AfterAction(c, &viewData)
	}

	response.Result(c, viewData)
}
