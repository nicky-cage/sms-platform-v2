<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="类型" prop="type">
                    <a-select v-model="search.type" placeholder="请选择类型">
                        <a-select-option :value="0">短信验证</a-select-option>
                        <a-select-option :value="1">广告推广</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="rowCreate">添加模板</a-button>
            </div>
        </div>

        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id"
                size="small" @change="pageChange">
                <span slot="status" slot-scope="text">{{ text === 1 ? '正常' : '禁用' }}</span>
                <span slot="template_type" slot-scope="text">{{ text === 1 ? '广告推广' : '短信验证' }}</span>
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="updated" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="rowUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
                <a-form-model-item label="模板名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入模板名称" />
                </a-form-model-item>
                <a-form-model-item label="类型" prop="type">
                    <a-select v-model="form.type" placeholder="请选择模板类型">
                        <a-select-option :value="0">短信验证</a-select-option>
                        <a-select-option :value="1">广告推广</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="模板内容" prop="content">
                    <a-textarea v-model:value="form.content" placeholder="请输入活动内容" :rows="8"></a-textarea>
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
    name: "MessageTemplates",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, type: "" },
            form: { type: 0, content: "", name: "",  },
            time_start: null, 
            time_end: null,
            rules: {
                name: [{required: true, message: "必须输入模板名称", trigger: "blur"}],
                type: [{required: true, message: "请选择类型", trigger: "blur"}],
                content: [{required: true, message: "必须输入模板内容", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "商户名称", dataIndex: 'merchant_name', width: 150},
                {title: "模板名称", dataIndex: 'name', width: 200},
                {title: "类型", dataIndex: 'type', width: 100, scopedSlots: {customRender: 'template_type'}},
                {title: "内容", dataIndex: 'content'},
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "修改时间", dataIndex: 'updated', scopedSlots: {customRender: 'updated'}, width: 145},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
            ],
            tableList: [],
            fileList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            merchants: [],
            apps: [],
        };
    },
    created() {
        this.getTableData();
        this.headers = { Authorization: getAuthorization(), };
    },
    methods: {
        datetime_ms: datetime_ms,
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/message_templates`, this.search).then(res => {
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
            this.visible = true;
        },
        rowUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id
            this.form.type = r.type;
            this.form.name = r.name;
            this.form.content = r.content;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/message_templates/save`, this.form).then((res) => {
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