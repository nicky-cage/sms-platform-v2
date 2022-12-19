# integrated-models

综合 - 数据模型

## 前言必读(重要)
开始开发工作之前, 请务必保证已经仔细阅读xorm操作手册:

https://www.kancloud.cn/kancloud/xorm-manual-zh-cn/56013

## 一、命名规范
#### 1.1 表名/字段
- 表名必须是英文名词, 不能出现汉语拼音
- 表名必须为复数形式 , 如 users, post_categories
- 外键为表名单数+_id,如 user__id, post_category_id
- 时间字段为 int unsigned 形式, 添加时间: created, 修改时间 : updated, 完成时间: finished, 尽量用完成时态
- 文件字段，尽量以文件格式命名，如 bank_image 表示图片, card_file, 表示上传的是文件
- 字段，都用小写加下载线形式, user_id, real_name, nickname
#### 1.2 模型
- 模型文件以驼峰样式命名,如: Users、PostCategories
- 模型(Model)名称与控制器名等 同, 如: Users, PostCategories
- 每个表名对一个模型文件, 如 users => Users.go
- 一个模型文件, 至少有2个结构体, 如: User(表示单个对象)/Users(表示对象集合)
- 对象集合, 继续模型操作方法, 包括: FindAll、Find、Create、Update、Delete等, 具体参数请见: integrated-common/Model.go 文件
#### 1.3 控制器/校验器
- 控制器名为首字母大写、去掉下载线首字段大写，如: Users, PostCategories
- 控制器名称、校验器名称、模型名称(集合)必须存在对应关系

## 二、对象定义
#### 开发说明
- 简单模式, 一般使用map[string]interface{} 进行操作
- 如果需要定义、修改Model基类, 请修改文件 integrated-models/Model.go

#### 2.1 单个对象
表示数据结构, 对于数据库表的最直接的展现
```go
// IpBan 模型说明
type IpBan struct {
	Id      uint64 `json:"id"`      //编号
	Ip      string `json:"ip"`      //IP地址
	Remark  string `json:"remark"`  //备注
	Created uint32 `json:"created"` //添加时间
	Updated uint32 `json:"updated"` //修改时间
}
```
#### 2.2 对象集合
表示算法，继承父级模型方法, 基类为 integrated-common/Model.go
```go
// IpBans 数据访问对象
var IpBans = struct {
	*common.Model // 模型基类(模仿面向对象), 文件位于 integrated-common/Model.go
}{
	Model: &common.Model{ // 初始化对象基类
		TabName: "ip_bans", // 指定数据表名
	},
}
```


## 三、使用示例 (复杂模式)
获取Xorm对象, 然后依照xorm主式进行操作
```go
// 添加数据
db := models.Engine() // 获取某个模型的操作对象
admin := modelsAdmin{}
admin.Id = 1
db.Insert(&admin)
// 修改数据
user := models.User{Id: 1}
db := models.Engine() //获取数据对象
has, err := db.Get(user)
user.Name = "new_name"
db.Id(2).Update(user)
```
获取engine对象之后的一些相关操作，请参考以下手册:

Xorm使用说明: https://www.kancloud.cn/kancloud/xorm-manual-zh-cn/56013

Xorm中文手册: http://www.admpub.com:8080/xorm-manual-zh-CN/

## 四、使用示例 (简单模式)
主要使用父类方法, 如果有必要, 则可以添加公用方法
```go
// 示例:
package controllers

import (
    models "integrated-models"
    ffmt "..."
)

func Index() {
    // 获取多条记录, 默认取15条
    users := []models.User{}
    rows := models.Users.FindAll(&users)
    ffmt.Print(rows)

    // 获取单条记录
    user := models.User{}
    row := models.Users.Find(&user)
    ffmt.Print(row)

    // 添加记录
    createInfo := map[string]interface{
        "username": "test",
        "password": "123456",
    }
    insertId, err := models.Users.Create(createInfo)
    //...

    // 修改..
    // 删除
}
```

## 五、Redis的缓存key定义
按如下	RedisKeyLoginUser = "ls:login:user:token:" 格式定义，ls:是统一的前缀

#### 待补充 ...
