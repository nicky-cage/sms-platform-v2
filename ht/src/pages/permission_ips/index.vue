<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="授权地址" prop="ip">
                    <a-input v-model="search.ip" placeholder="请输入IP地址"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="search.remark" placeholder="请输入备注"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="recordCreate">添加授权地址</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="permission_type" slot-scope="text" :style="{color: text == 1 ? 'green': 'red'}" >{{ text == 1 ? '允许' :'拒绝' }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="recordUpdate(record)">编辑</a>
                    <a-divider type="vertical"></a-divider>
                    <a @click="recordDelete(record)">删除</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form" :rules="rules" :wrapper-col="{ span: 20 }">
                <a-form-model-item label="授权IP" prop="ip">
                    <a-input v-model="form.ip" placeholder="请输入授权IP"/>
                </a-form-model-item>
                <a-form-model-item label="授权类型" prop="permission_type">
                    <a-select v-model="form.permission_type" placeholder="请选择授权类型">
                        <a-select-option :value="1">允许</a-select-option>
                        <a-select-option :value="0">拒绝</a-select-option>
                    </a-select>
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
import {datetime_ms} from '@/utils/datetime.js';

export default {
    name: "PermissionIps",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, ip: "", remark: ""},
            form: { ip: "", remark: "", permission_type: 1 },
            rules: {
                ip: [{required: true, message: "请输入IP地址", trigger: "blur"}],
                permission_type: [{required: true, message: "必须选择授权类型", trigger: "blur"}],
                remark: [{required: true, message: "请输入备注", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "授权类型", dataIndex: 'permission_type', scopedSlots: {customRender: 'permission_type'}, width: 100},
                {title: "IP地址", dataIndex: 'ip', width: 350},
                {title: "添加用户", dataIndex: 'admin_name', width: 150},
                {title: "备注", dataIndex: 'remark'},
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "添加时间", dataIndex: 'updated', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 90},
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
            crudService.getRecords(`${BASE_URL}/auth/permission_ips`, this.search).then(res => {
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
            this.is_creating = true;
            this.title = '新增记录';
            this.visible = true;
        },
        recordUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id
            this.form.ip = r.ip
            this.form.permission_type = r.permission_type
            this.form.remark = r.remark;
            this.visible = true;
        },
        recordDelete(r) {
            this.$confirm({
                title: '删除', content: '确定删除该数据？', okText: '确认', cancelText: '取消',
                onOk() {
                    crudService.deleteRecord(`${BASE_URL}/auth/permission_ips/delete`, {id: r.id}).then(res => {
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
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/permission_ips/save`, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        if (result.code == 405) {
                            this.$router.push("/");
                        }
                        return;
                    }
                    this.$refs.ruleForm.resetFields();
                    this.visible = false;
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
