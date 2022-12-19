<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="商户名称" prop="merchant_name">
                    <a-input v-model="search.admin_name" placeholder="请输入商户名称"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)"
                     rowKey="id" size="small" @change="pageChange">
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
            </a-table>
        </div>
    </div>
</template>

<script>
import {BASE_URL, crudService, PAGE_SIZE} from '@/services/index.js';
import {datetime_ms} from '@/utils/datetime.js';

export default {
    name: "MerchantLoginLogs",
    data() {
        return {
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, admin_name: "", login_ip: "", user_agent: "", remark: ""},
            rules: {
                merchant_name: [{required: true, message: "请输入商户名称", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "商户名称", dataIndex: 'merchant_name', width: 120},
                {title: "登录IP", dataIndex: 'login_ip', width: 200},
                {title: "登录地区", dataIndex: 'login_area', width: 150},
                {title: "域名", dataIndex: 'domain', width: 150},
                {title: "浏览器头信息", dataIndex: 'user_agent', ellipsis: true},
                {title: "登录时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
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
            crudService.getRecords(`${BASE_URL}/auth/merchant_login_logs`, this.search).then(res => {
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
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>