<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="参数分组" prop="status">
                    <a-select v-model="search.group_id" placeholder="请选择分组">
                        <a-select-option v-for="item in parameter_groups" :key="item.id" :value="item.id">{{item.title}}</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="参数名称" prop="title">
                    <a-input v-model="search.title" placeholder="请输入参数名称"/>
                </a-form-model-item>
                <a-form-model-item label="参数代码" prop="name">
                    <a-input v-model="search.name" placeholder="请输入参数代码"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="recordCreate">添加参数</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small"
                     @change="pageChange">
                <span slot="status" slot-scope="text">{{ text === 1 ? '正常' : '禁用' }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="recordUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
                <a-form-model-item label="参数分组" prop="group_id">
                    <a-select v-model="form.group_id" placeholder="请选择分组">
                        <a-select-option v-for="item in parameter_groups" :key="item.id" :value="item.id">{{item.title}}</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="参数名称" prop="title">
                    <a-input v-model="form.title" placeholder="请输入参数名称"/>
                </a-form-model-item>
                <a-form-model-item label="参数代码" prop="name">
                    <a-input v-model="form.name" placeholder="请输入参数代码"/>
                </a-form-model-item>
                <a-form-model-item label="参数内容" prop="value">
                    <a-input v-model="form.value" placeholder="请输入参数内容"/>
                </a-form-model-item>
                <a-form-model-item label="默认内容" prop="value_default">
                    <a-input v-model="form.value_defalt" placeholder="请输入默认参数内容"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注"/>
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import { crudService, PAGE_SIZE, BASE_URL } from '@/services/index.js';

export default {
    name: "Parameters",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, group_id: "", title: "", name: "" },
            form: { group_id: "", name: "", title: "", value: "", value_default: "", remark: ""},
            rules: {
                group_id: [{required: true, message: "必须选择参数分组", trigger: "blur"}],
                title: [{required: true, message: "必须输入参数名称", trigger: "blur"}],
                name: [{required: true, message: "必须输入参数代码", trigger: "blur"}],
                value: [{required: true, message: "必须输入参数内容", trigger: "blur"}],
                value_default: [{required: true, message: "必须输入默认参数内容", trigger: "blur"}],
                remark: [{required: true, message: "必须输入备注", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "参数分组", dataIndex: 'group_id', width: 80},
                {title: "参数名称", dataIndex: 'title', width: 150},
                {title: "参数代码", dataIndex: 'name', width: 150},
                {title: "参数内容", dataIndex: 'value', width: 200},
                {title: "默认内容", dataIndex: 'value_default', width: 200},
                {title: "备注", dataIndex: 'remark' },
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
            ],
            tableList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            parameter_groups: [],
        };
    },
    created() {
        this.getTableData()
    },
    methods: {
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/parameters`, this.search).then(res => {
                let result = res.data;
                if (result.code === 0) {
                    this.tableList = result.data.records;
                    this.pagination.current = result.data.page;
                    this.pagination.total = result.data.total;

                    if (result.data.parameter_groups) { 
                        this.parameter_groups = result.data.parameter_groups;
                    }
                    return;
                }
                this.$message.error({ content: result.message });
                if (result.code == 405) {
                    this.$router.push("/");
                }
            });
        },
        pageChange(val) {
            this.pagination.current = val.current;
            this.getTableData();
        },
        searchSubmit() {
            this.pagination.current = 1;
            this.getTableData();
        },
        recordCreate() {
            this.is_creating = true;
            this.title = '新增记录';
            this.visible = true;
        },
        recordUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id
            this.form.title = r.title
            this.form.group_id = r.group_id
            this.form.name = r.name
            this.form.value = r.value;
            this.form.value_default = r.value_default;
            this.form.remark = r.remark;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                let url = this.is_creating ? `${BASE_URL}/parameters/create`: `${BASE_URL}/parameters/update`;
                crudService.editRecord(url, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        if (result.code == 405) {
                            this.$router.push("/");
                        }
                        return;
                    }
                    this.$refs.ruleForm.resetFields();
                    this.$message.success(result.message);
                    this.pagination.current = 1;
                    this.visible = false;
                    this.getTableData();
                });
            });
        },
        formCancel() {
            this.visible = false;
        },
        recordDelete(r) {
            this.$confirm({
                title: '删除', content: '确定删除该数据？', okText: '确认', cancelText: '取消',
                onOk() {
                    crudService.deleteRecord(URL_DELETE, {id: r.id}).then(res => {
                        let result = res.data;
                        if (result.code > 0) {
                            this.$message.success(result.message);
                            return;
                        }
                        this.pagination.current = 1;
                        this.getTableData();
                    })
                }
            });
        },
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>