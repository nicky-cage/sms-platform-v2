<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="渠道名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入渠道名称"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="search.remark" placeholder="请输入备注"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="rowCreate">添加短信渠道</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small"
                     @change="pageChange">
                <span slot="state" slot-scope="text" :style="{color: text == 1 ? 'green' : 'red'}">{{ text === 1 ? '启用' : '禁用' }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="rowUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
                <a-form-model-item label="产品类型" prop="product_type">
                    <a-input v-model="form.product_type" placeholder="请输入产品类型"/>
                </a-form-model-item>
                <a-form-model-item label="渠道名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入渠道名称"/>
                </a-form-model-item>
                <a-form-model-item label="渠道代码" prop="code">
                    <a-input v-model="form.code" placeholder="请输入渠道代码"/>
                </a-form-model-item>
                <a-form-model-item label="登录账号" prop="account">
                    <a-input v-model="form.account" placeholder="请输入登录账号"/>
                </a-form-model-item>
                <a-form-model-item label="登录密码" prop="password">
                    <a-input v-model="form.password" placeholder="请输入登录密码"/>
                </a-form-model-item>
                <a-form-model-item label="网络协议" prop="protocol">
                    <a-select v-model="form.protocol" placeholder="请选择网络协议">
                        <a-select-option :value="'http'">HTTP</a-select-option>
                        <a-select-option :value="'https'">HTTPS </a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="IP" prop="ip">
                    <a-input v-model="form.ip" placeholder="请输入IP地址列表"/>
                </a-form-model-item>
                <a-form-model-item label="端口" prop="port">
                    <a-input v-model="form.port" placeholder="请输入端口" :value="'8001'"/>
                </a-form-model-item>
                <a-form-model-item label="路径" prop="path">
                    <a-input v-model="form.path" placeholder="请输入操作路径" :value="'/'"/>
                </a-form-model-item>
                <a-form-model-item label="费率" prop="fee">
                    <a-input v-model="form.fee" placeholder="请输入费率" :value="'0.01'"/>
                </a-form-model-item>
                <a-form-model-item label="状态" prop="merchant_type">
                    <a-select v-model="form.state" placeholder="请选择状态">
                        <a-select-option :value="0">禁用</a-select-option>
                        <a-select-option :value="1">启用 </a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注" :value="'请输入备注'"/>
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import { crudService, PAGE_SIZE, BASE_URL } from '@/services/index.js';

export default {
    name: "MessageChannels",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: { page: 1, page_size: PAGE_SIZE, name: "", remark: "" },
            form: { name: "", remark: "请输入备注", code: "", state: 1, fee: 0.01, product_type: "", account: "", password: "", ip: "127.0.0.1", port: 80, path: "/api", protocol: "http" },
            rules: {
                name: [{required: true, message: "必须输入渠道名称", trigger: "blur"}],
                code: [{required: true, message: "必须输入渠道代码", trigger: "blur"}],
                state: [{required: true, message: "必须选择状态", trigger: "blur"}],
                fee: [{required: true, message: "必须输入费率", trigger: "blur"}],
                remark: [{required: true, message: "必须输入备注", trigger: "blur"}],
                protocol: [{required: true, message: "必须选择协议", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "产品类型", dataIndex: 'product_type', width: 250},
                {title: "渠道名称", dataIndex: 'name', width: 150},
                {title: "渠道代码", dataIndex: 'code', width: 110},
                {title: "登录账号", dataIndex: 'account', width: 130},
                {title: "协议", dataIndex: 'protocol', width: 60},
                {title: "IP", dataIndex: 'ip', width: 250},
                {title: "端口", dataIndex: 'port', width: 70},
                {title: "状态", dataIndex: 'state', width: 70, scopedSlots: {customRender: 'state'}},
                {title: "费率($)", dataIndex: 'fee', width: 70},
                {title: "备注", dataIndex: 'remark' },
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
            ],
            tableList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            form_init: {},
        };
    },
    created() {
        this.getTableData()
        this.form_init = this.form;
    },
    methods: {
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/message_channels`, this.search).then(res => {
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
        rowCreate() {
            this.is_creating = true;
            this.title = '新增记录';
            this.form = this.form_init;
            this.visible = true;
        },
        rowUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id;
            this.form.product_type = r.product_type;
            this.form.name = r.name;
            this.form.account = r.account;
            this.form.password = r.password;
            this.form.protocol = r.protocol;
            this.form.ip = r.ip;
            this.form.port = r.port;
            this.form.path = r.path;
            this.form.code = r.code;
            this.form.state = r.state;
            this.form.fee = r.fee;
            this.form.remark = r.remark;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/message_channels/save`, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        if (result.code == 405) {
                            this.$router.push("/");
                        }
                        return;
                    }
                    this.$message.success(result.message);
                    this.$refs.ruleForm.resetFields();
                    this.visible = false;
                    this.pagination.current = 1;
                    this.getTableData();
                });
            });
        },
        formCancel() {
            this.$refs.ruleForm.resetFields();
            this.form = this.form_init;
            this.visible = false;
        },
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>
