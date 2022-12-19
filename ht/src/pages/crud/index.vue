<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="姓名" prop="name">
                    <a-input v-model="search.name" placeholder="请输入姓名"/>
                </a-form-model-item>
                <a-form-model-item label="性别" prop="sex">
                    <a-select v-model="search.sex" placeholder="请选择">
                        <a-select-option value="1"> 男</a-select-option>
                        <a-select-option value="2"> 女</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="addData"> 新增</a-button>
            </div>
        </div>
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination" @change="change">
                <span slot="sex" slot-scope="text">{{ text === 0 ? '男' : '女' }}</span>
                <span slot="action" slot-scope="text, record">
          <a @click="editData(record)">编辑</a>
          <a-divider type="vertical"/>
          <a @click="deleteF(record)">删除</a>
          <a-divider type="vertical"/>
          <a @click="detailsData(record)">查看</a>
        </span>
            </a-table>
        </div>
        <!-- 新增或修改对话框 -->
        <a-modal :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="handleCancel" @ok="handleOk">
            <div>
                <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form" :rules="rules" :wrapper-col="{ span: 20 }">
                    <a-form-model-item label="姓名" prop="name">
                        <a-input v-model="form.name" placeholder="请输入姓名"/>
                    </a-form-model-item>
                    <a-form-model-item label="性别" prop="sex">
                        <a-select v-model="form.sex" placeholder="请选择">
                            <a-select-option value="1"> 男</a-select-option>
                            <a-select-option value="2"> 女</a-select-option>
                        </a-select>
                    </a-form-model-item>
                </a-form-model>
            </div>
        </a-modal>
    </div>
</template>

<script>
import {templateService} from '@/services/index.js'

export default {
    name: "Demo",
    data() {
        return {
            visible: false,
            title: '新增',
            confirmLoading: false,
            type: 'add',
            search: {current: 1, pageSize: 10, name: "", sex: "",},
            form: {name: "", sex: "",},
            rules: {
                name: [{required: true, message: "请输入姓名", trigger: "blur"}],
                sex: [{required: true, message: "请选择性别", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', key: "id",},
                {title: "姓名", dataIndex: 'name', key: "name",},
                {title: "性别", dataIndex: 'sex', scopedSlots: {customRender: 'sex'}, key: "sex",},
                {title: "操作", key: "action", dataIndex: 'action', scopedSlots: {customRender: 'action'}},
            ],
            tableList: [],
            pagination: {
                current: 1,
                pageSize: 10,
                total: 0,
            }
        };
    },
    created() {
        this.getTableData()
    },
    methods: {
        getTableData() {
            templateService.getTableList(this.search).then(res => {
                if (res.code === 0) {
                    this.tableList = res.data.list
                    this.pagination.total = res.data.total
                }
            })
            //上面接口，暂时没有接口，在下面模拟数据
            this.tableList = []
            for (var i = 1; i <= 10; i++) {
                this.tableList.push(
                    {
                        id: i * this.pagination.current,
                        name: '姓名' + i * this.pagination.current,
                        sex: i % 2
                    })
            }
            this.pagination.total = 50
        },
        change(val) {
            this.pagination.current = val.current
            this.getTableData()
        },
        addData() {
            this.type = 'add'
            this.title = '新增'
            this.visible = true
        },
        editData(row) {
            this.type = 'edit'
            this.title = '修改'
            this.form.id = row.id
            this.form.name = row.name
            this.form.sex = row.sex
            this.visible = true
        },
        searchSubmit() {
            this.pagination.current = 1
            this.getTableData()
        },
        handleCancel() {
            this.visible = false
        },
        handleOk() {
            this.$refs.ruleForm.validate((valid) => {
                if (valid) {
                    if (this.type === 'add') {
                        // 新增
                        templateService.addData(this.form).then(res => {
                            if (res.code === 0) {
                                this.$message.success(res.msg)
                                this.pagination.current = 1
                                this.getTableData()
                            }
                        })
                    } else {
                        // 修改
                        templateService.editData(this.form).then(res => {
                            if (res.code === 0) {
                                this.$message.success(res.msg)
                                this.pagination.current = 1
                                this.getTableData()
                            }
                        })
                    }
                } else {
                    console.log("error submit!!");
                    return false;
                }
            });
            
        },
        detailsData(row) {
            this.$router.push({
                path: '/template/details',
                query: {id: row.id}
            })
        },
        deleteF(row) {
            this.$confirm({
                title: '删除',
                content: '确定删除该数据？',
                okText: '确认',
                cancelText: '取消',
                onOk() {
                    templateService.deleteData(row.id).then(res => {
                        if (res.code === 0) {
                            this, $message.success(res.msg)
                            this.pagination.current = 1
                            this.getTableData()
                        }
                    })
                }
            });
        },
    },
};
</script>

<style lang="less" scoped> @import "index.less"; </style>