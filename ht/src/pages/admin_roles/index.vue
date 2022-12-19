<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="角色名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入后台角色名称"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="search.remark" placeholder="请输入备注"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="rowCreate">添加后台角色</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id"
                     size="small" @change="pageChange">
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="updated" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="recordUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form" :rules="rules" :wrapper-col="{ span: 20 }">
                <a-form-model-item label="角色名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入后台角色名称"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注"/>
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import { BASE_URL, crudService, PAGE_SIZE } from '@/services/index.js';
import {datetime_ms} from '@/utils/datetime.js';

export default {
    name: "AdminRoles",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, name: "", remark: ""},
            form: {name: "", remark: ""},
            rules: {
                name: [{required: true, message: "请输入后台角色名称", trigger: "blur"}],
                remark: [{required: true, message: "请输入备注", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 60},
                {title: "角色名称", dataIndex: 'name', width: 200},
                {title: "备注", dataIndex: 'remark'},
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 135},
                {title: "修改时间", dataIndex: 'updated', scopedSlots: {customRender: 'updated'}, width: 135},
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
        datetime_ms: datetime_ms,
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/admin_roles`, this.search).then(res => {
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
            this.pagination.current = 1;
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
            this.form.remark = r.remark;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                let url = this.is_creating ? URL_CREATE : URL_UPDATE;
                crudService.editRecord(url, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        return;
                    }
                    this.$refs.ruleForm.resetFields();
                    this.$message.success(result.message);
                    this.pagination.current = 1;
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
