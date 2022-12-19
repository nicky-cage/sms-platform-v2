<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="商户编号" prop="商户编号">
                    <a-input v-model="search.merchant_id" placeholder="请输入商户编号"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
            </a-table>
        </div>
    </div>
</template>

<script>
import { crudService, PAGE_SIZE, BASE_URL } from '@/services/index.js';
import {datetime_ms} from '@/utils/datetime.js';

export default {
    name: "ReportMerchants",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE },
            form: {},
            rules: {},
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "统计日期", dataIndex: 'date', width: 100},
                {title: "商户名称", dataIndex: 'merchant_name' },
                {title: "短信总计", dataIndex: 'total', width: 90},
                {title: "发送总计", dataIndex: 'total_sent', width: 90},
                {title: "成功发送", dataIndex: 'total_success', width: 90},
                {title: "二级商户", dataIndex: 'merchant_children', width: 90},
                {title: "商户新增", dataIndex: 'merchant_new', width: 90},
                {title: "应用总计", dataIndex: 'app_total', width: 90 },
                {title: "应用新增", dataIndex: 'app_new', width: 90 },
                {title: "模板总计", dataIndex: 'template_total', width: 90 },
                {title: "模板新增", dataIndex: 'template_new', width: 90 },
                {title: "下游费用", dataIndex: 'downstream_fee', width: 90 },
                {title: "商户费用", dataIndex: 'merchant_fee', width: 90 },
                {title: "利润", dataIndex: 'profit', width: 90 },
                {title: "统计时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
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
            crudService.getRecords(`${BASE_URL}/auth/report_merchants`, this.search).then(res => {
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
            this.search.page = 1;
            this.getTableData();
        },
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>
