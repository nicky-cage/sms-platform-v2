<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="银行名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入银行名称"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="search.remark" placeholder="请输入备注"/>
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="search.state" placeholder="请选择状态">
                        <a-select-option :value="1">启用</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="rowCreate">添加银行</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="state" slot-scope="text">{{ text === 1 ? '正常' : '禁用' }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="rowUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form" :rules="rules" :wrapper-col="{ span: 20 }">
                <a-form-model-item label="银行名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入银行名称"/>
                </a-form-model-item>
                <a-form-model-item label="银行代码" prop="code">
                    <a-input v-model="form.code" placeholder="请输入银行代码"/>
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="form.state" placeholder="请选择状态">
                        <a-select-option :value="1">启用</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="排序" prop="sort">
                    <a-input v-model="form.sort" placeholder="请输排序"/>
                </a-form-model-item>
                <a-form-model-item label="图标" prop="icon">
                    <a-input v-model="form.icon" placeholder="请输入图标"/>
                </a-form-model-item>
                <a-form-model-item label="图片" prop="image">
                    <a-input v-model="form.image" placeholder="请输入图片"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注"/>
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import {BASE_URL, crudService, PAGE_SIZE} from '@/services/index.js';

export default {
    name: "Banks",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, name: "", code: "", state: "", remark: "", icon: "", image: "", sort: ""},
            form: { name: "", code: "", state: 0, remark: "", icon: "", image: "", sort: 0 },
            rules: {
                name: [{required: true, message: "请输入银行名称", trigger: "blur"}],
                code: [{required: true, message: "请输入银行代码", trigger: "blur"}],
                state: [{required: true, message: "请选择状态", trigger: "blur"}],
                sort: [{required: true, message: "请输入排序", trigger: "blur"}],
                icon: [{required: true, message: "请输入图标", trigger: "blur"}],
                image: [{required: true, message: "请输入图片地址", trigger: "blur"}],
                remark: [{required: true, message: "请输入备注", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "银行名称", dataIndex: 'name', width: 180},
                {title: "代码", dataIndex: 'code', width: 100},
                {title: "状态", dataIndex: 'state', scopedSlots: {customRender: 'state'}, width: 80},
                {title: "排序", dataIndex: 'sort', width: 80},
                {title: "图标", dataIndex: 'icon', width: 450},
                {title: "备注", dataIndex: 'remark'},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 50},
            ],
            tableList: [],
            pagination: {current: 1, pageSize: PAGE_SIZE, total: 0},
        };
    },
    created() {
        this.getTableData()
    },
    methods: {
        getTableData() {
            crudService.getRecords(`${BASE_URL}/auth/banks`, this.search).then(res => {
                let result = res.data;
                if (result.code === 0) {
                    this.tableList = result.data.records;
                    this.pagination.current = result.data.page;
                    this.pagination.total = result.data.total;
                    return;
                }
                this.$message.error({ content: result.message });
                if (result.code == 405) {
                    this.$router.push("/");
                }
            });
        },
        pageChange(val) {
            this.search.page = val.current;
            this.pagination.current = val.current;
            this.getTableData();
        },
        searchSubmit() {
            this.search.page = 1;
            this.getTableData();
        },
        rowCreate() {
            this.is_creating = true;
            this.title = '新增记录';
            this.visible = true;
        },
        rowUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id
            this.form.name = r.name
            this.form.code = r.code;
            this.form.state = r.state;
            this.form.sort = r.sort;
            this.form.icon = r.icon;
            this.form.image = r.image;
            this.form.remark = r.remark;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/banks/save`, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        if (result.code == 405) {
                            this.$router.push("/");
                        }
                        return;
                    }
                    this.$refs.ruleForm.resetFields();
                    this.pagination.current = 1;
                    this.visible = false;
                    this.$message.success(result.message);
                    this.getTableData();
                });
            });
        },
        formCancel() {
            this.visible = false;
        },
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>
