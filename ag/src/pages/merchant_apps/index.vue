<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="应用名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入应用名称" />
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="search.state" placeholder="请选择状态">
                        <a-select-option :value="1">启用</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="search.remark" placeholder="请输入备注" />
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="recordCreate">添加应用</a-button>
            </div>
        </div>

        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id"
                size="small" @change="pageChange">
                <span slot="status" slot-scope="text">{{ text === 1 ? '正常' : '禁用' }}</span>
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="updated" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="rowUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
                <a-form-model-item label="应用名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入活动代码" />
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="form.state" placeholder="请选择活动状态">
                        <a-select-option :value="1">正常</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="授权IP" prop="allow_ip">
                    <a-input v-model="form.allow_ip" placeholder="请输入授权访问IP" />
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注" />
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import { crudService, PAGE_SIZE, BASE_URL } from '@/services/index.js';
import { datetime_ms } from '@/utils/datetime.js';
import { getAuthorization } from "@/utils/request";

export default {
    name: "MerchantApps",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, name: "", state: "", remark: "" },
            form: { name: "", state: 1, remark: "", allow_ip: ""  },
            time_start: null, 
            time_end: null,
            rules: {
                name: [{required: true, message: "必须输入应用", trigger: "blur"}],
                state: [{required: true, message: "必须选择状态", trigger: "blur"}],
                allow_ip: [{required: true, message: "必须输入授权IP", trigger: "blur"}],
                remark: [{required: true, message: "必须输入备注", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "商户名称", dataIndex: 'merchant_name', width: 150},
                {title: "应用名称", dataIndex: 'name', width: 150},
                {title: "状态", dataIndex: 'state', scopedSlots: {customRender: 'status'}, width: 60},
                {title: "授权IP", dataIndex: 'allow_ip', width: 250},
                {title: "备注", dataIndex: 'remark' },
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "修改时间", dataIndex: 'updated', scopedSlots: {customRender: 'updated'}, width: 140},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
            ],
            tableList: [],
            fileList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
        };
    },
    created() {
        this.getTableData();
    },
    methods: {
        datetime_ms: datetime_ms,
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/merchant_apps`, this.search).then(res => {
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
            this.pagination.current = val.current;
            this.getTableData();
        },
        searchSubmit() {
            this.pagination.current = 1;
            this.getTableData();
        },
        recordCreate() {
            let currentTime = new Date();
            let minute = currentTime.getMinutes();
            let second = currentTime.getSeconds();
            let num = '' + (minute > 9 ? minute : '0' + minute) +  (second > 9 ? second : '0' + second);
            this.form.name = 'merchant_app_' + num;
            this.form.allow_ip = '127.0.0.1';
            this.form.remark = '请输入应用备注';
            this.is_creating = true;
            this.title = '新增记录';
            this.visible = true;
        },
        recordUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id
            this.form.name = r.name;
            this.form.state = r.state;
            this.form.allow_ip = r.allow_ip;
            this.form.remark = r.remark;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/merchant_apps/save`, this.form).then((res) => {
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
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>