<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="商户名称" prop="merchant_name">
                    <a-input v-model="search.merchant_name" placeholder="请输入商户名称"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination" :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="action" slot-scope="text, record">
                    <a @click="addMessageCount(record)" v-if="(admin.id != record.merchant_id)">充值</a>
                </span>
            </a-table>
        </div>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
                <a-form-model-item label="增加数量" prop="counter">
                    <a-input v-model="form.counter" placeholder="请输入添加短信数量" />
                    <a-input type="hidden" v-model="form.merchant_id" />
                </a-form-model-item>
            </a-form-model>
        </a-modal>

    </div>
</template>

<script>
import {BASE_URL, crudService, PAGE_SIZE} from '@/services/index.js';

export default {
    name: "MerchantAccounts",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: { page: 1, page_size: PAGE_SIZE, merchant_name: "" },
            rules: {
                counter: [{ required: true, message: "请输入短信数量", trigger: "blur" }],
            },
            form: { counter: "", merchant_id: "" },
            columns: [
                { title: "ID", dataIndex: 'id', width: 80 },
                { title: "商户编号", dataIndex: 'merchant_id', width: 100 },
                { title: "商户名称", dataIndex: 'merchant_name', width: 150 },
                // { title: "应用数量", dataIndex: 'app_count', width: 100 },
                // { title: "可用余额", dataIndex: 'remain', width: 100  },
                // { title: "冻结余额", dataIndex: 'frozen', width: 100 },
                // { title: "可用总额", dataIndex: 'total', width: 100 },
                // { title: "入账总额", dataIndex: 'total_in', width: 100  },
                // { title: "出账总额", dataIndex: 'total_out', width: 100  },
                { title: "可用短信", dataIndex: 'count_remain', width: 100  },
                { title: "冻结短信", dataIndex: 'count_frozen', width: 100  },
                { title: "总计短信", dataIndex: 'count_total', width: 100  },
                { title: "发送总计", dataIndex: 'sent_total', width: 100  },
                { title: "成功发送", dataIndex: 'sent_success', width: 100  },
                { title: "备注", dataIndex: 'remark' },
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
            ],
            tableList: [],
            pagination: {current: 1, pageSize: PAGE_SIZE, total: 0},
        };
    },
    computed: {
        admin() { 
            return JSON.parse(localStorage.getItem("admin.user"));
        },
    },
    created() { this.getTableData() },
    methods: {
        getTableData() {
            crudService.getRecords(`${BASE_URL}/auth/merchant_accounts`, this.search).then(res => {
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
        formCancel() {
            this.visible = false;
        },
        addMessageCount(r) {
            this.is_creating = true;
            this.title = '增加短信数量';
            this.visible = true;
            this.form.merchant_id = r.merchant_id;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/merchant_accounts/add_count`, this.form).then((res) => {
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
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>
