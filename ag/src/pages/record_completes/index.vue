<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="商户名称" prop="merchant_name">
                    <a-input v-model="search.merchant_name" placeholder="请输入商户名称" />
                </a-form-model-item>
                <a-form-model-item label="应用名称" prop="app_name">
                    <a-input v-model="search.app_name" placeholder="请输入应用名称" />
                </a-form-model-item>
                <a-form-model-item label="内容" prop="content">
                    <a-input v-model="search.content" placeholder="请输入短信内容" />
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
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
    </div>
</template>

<script>
import { crudService, PAGE_SIZE, BASE_URL } from '@/services/index.js';
import { datetime_ms } from '@/utils/datetime.js';
import { getAuthorization } from "@/utils/request";

export default {
    name: "MessageCompletes",
    data() {
        return {
            visible: false,
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, title: "", status: "", remark: "", code: ""},
            form: { title: "", status: 1, remark: "", code: "", time_start: "", time_end: "", sort: 0, url: "", content: "", image_cover: "" },
            time_start: null, 
            time_end: null,
            rules: {
                tittle: [{required: true, message: "必须输入活动名称", trigger: "blur"}],
                code: [{required: true, message: "必须输入活动代码", trigger: "blur"}],
                sort: [{required: true, message: "必须输入排序", trigger: "blur"}],
                status: [{required: true, message: "请选择状态", trigger: "blur"}],
                remark: [{required: true, message: "必须输入备注", trigger: "blur"}],
                content: [{required: true, message: "必须输入活动内容", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "商户名称", dataIndex: 'merchant_name', width: 150},
                {title: "应用名称", dataIndex: 'app_name', width: 150},
                {title: "渠道代码", dataIndex: 'channel_id', width: 100},
                {title: "手机号码", dataIndex: 'phone_full', width: 150},
                {title: "短信内容", dataIndex: 'content' },
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "发送时间", dataIndex: 'send_time', scopedSlots: {customRender: 'send_time'}, width: 145},
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
            crudService.getRecords(`${BASE_URL}/auth/record_completes`, this.search).then(res => {
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
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>