<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="内容" prop="content">
                    <a-input v-model="search.content" placeholder="请输入短信内容" />
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="recordCreate">批量发送</a-button>
            </div>
        </div>

        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id"
                size="small" @change="pageChange">
                <span slot="state" slot-scope="text">{{ text === 1 ? '成功' : '失败' }}</span>
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="send_time" slot-scope="text">{{ datetime_ms(text) }}</span>
            </a-table>
        </div>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
                <a-form-model-item label="短信模板" prop="template_id">
                    <a-select v-model="form.template_id" placeholder="请选择短信模板" @change="onChangeTemplate">
                        <a-select-option :value="0">不用短信模板</a-select-option>
                        <a-select-option v-for="item in templates" :key="item.id" :value="item.id">{{item.name}}</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="国家区号" prop="country_id">
                    <a-select v-model="form.country_id" placeholder="请选择国家区号">
                        <a-select-option v-for="item in countries" :key="item.id" :value="item.id">{{item.name}}</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="电话号码" prop="phone_list">
                    <a-textarea v-model:value="form.phone_list" placeholder="请输入要发送的手机号码" :auto-size="{ minRows: 2, maxRows: 6 }" />
                </a-form-model-item>
                <a-form-model-item label="短信渠道" prop="channel_id">
                    <a-select v-model="form.channel_id" placeholder="请选择短信渠道">
                        <a-select-option v-for="item in channels" :key="item.id" :value="item.id">{{item.name}}</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="短信内容" prop="content">
                    <a-textarea v-model:value="form.content" placeholder="请输入要发送的短信内容" :auto-size="{ minRows: 3, maxRows: 6 }" />
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
    name: "MessageBatches",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            submited: false,
            search: {page: 1, page_size: PAGE_SIZE, title: "", status: "", remark: ""},
            form: { template_id: 0, phone_list: "", content: "", channel_id: "", country_id: "" },
            rules: {
                template_id: [{required: true, message: "必须选择短信模板", trigger: "blur"}],
                phone_list: [{required: true, message: "必须输入手机号码", trigger: "blur"}],
                channel_id: [{required: true, message: "必须选择渠道编码", trigger: "blur"}],
                content: [{required: true, message: "必须输入短信内容", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "商户名称", dataIndex: 'merchant_name', width: 150},
                {title: "渠道代码", dataIndex: 'channel_id', width: 80},
                {title: "手机号码", dataIndex: 'phone_list', width: 450, ellipsis: true },
                {title: "短信内容", dataIndex: 'content' },
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
            ],
            tableList: [],
            fileList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            templates: [],
            countries: [],
            channels: [],
        };
    },
    created() {
        this.getTableData();
    },
    methods: {
        datetime_ms: datetime_ms,
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/message_batches`, this.search).then(res => {
                let result = res.data;
                if (result.code === 0) {
                    this.tableList = result.data.records;
                    this.pagination.current = result.data.page;
                    this.pagination.total = result.data.total;
                    if (result.data.templates) { 
                        this.templates = result.data.templates;
                    }
                    if (result.data.countries) { 
                        this.countries = result.data.countries;
                        this.form.country_id = this.countries[0].id;
                    }
                    if (result.data.channels) { 
                        this.channels = result.data.channels;
                        this.form.channel_id = this.channels[0].id;
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
        onChangeTemplate(template_id) { 
            for (let i = 0; i < this.templates.length; i++) { 
                let template = this.templates[i];
                if (template.id == template_id) { 
                    this.form.content = template.content;
                    break;
                }
            }
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
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                if (this.submited) { 
                    this.$message.error("请不要重复提交");
                    return false;
                }
                this.submited = true;
                crudService.editRecord(`${BASE_URL}/auth/message_batches/save`, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        this.submited = false;
                        return false;
                    }
                    this.$refs.ruleForm.resetFields();
                    this.$message.success(result.message);
                    this.pagination.current = 1;
                    this.visible = false;
                    this.getTableData();
                    this.submited = false;
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