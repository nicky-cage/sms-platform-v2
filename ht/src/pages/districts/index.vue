<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="城市代码" prop="city_code">
                    <a-input v-model="search.city_code" placeholder="请输入城市代码"/>
                </a-form-model-item>
                <a-form-model-item label="县区名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入备注"/>
                </a-form-model-item>
                <a-form-model-item label="县区代码" prop="code">
                    <a-input v-model="search.code" placeholder="请输入县区代码"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="rowCreate">添加县区</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="action" slot-scope="text, record">
                    <a @click="rowUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form" :rules="rules" :wrapper-col="{ span: 20 }">
                <a-form-model-item label="城市代码" prop="city_code">
                    <a-input v-model="form.city_code" placeholder="请输入城市代码"/>
                </a-form-model-item>
                <a-form-model-item label="县区名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入县区名称"/>
                </a-form-model-item>
                <a-form-model-item label="县区代码" prop="code">
                    <a-input v-model="form.code" placeholder="请输入县区代码"/>
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import {BASE_URL, crudService, PAGE_SIZE} from '@/services/index.js';
import {datetime} from '@/utils/datetime.js';

export default {
    name: "Districts",
    data() {
        return {
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, name: "", city_code: "", code: "" },
            form: {name: "",  city_code: "", code: ""},
            rules: {
                city_code: [{required: true, message: "请输入城市代码", trigger: "blur"}],
                name: [{required: true, message: "请输入县区名称", trigger: "blur"}],
                code: [{required: true, message: "请输入县区代码", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "城市代码", dataIndex: 'city_code', width: 250},
                {title: "县区名称", dataIndex: 'name',  width: 250},
                {title: "县区代码", dataIndex: 'code'},
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
        datetime: datetime,
        getTableData() {
            crudService.getRecords(`${BASE_URL}/auth/districts`, this.search).then(res => {
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
            this.form.city_code = r.city_code;
            this.form.code = r.code;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/districts/save`, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
                        if (result.code == 405) {
                            this.$router.push("/");
                        }
                        return;
                    }
                    this.$refs.ruleForm.resetFields();
                    this.pagination.current = 1;
                    this.visible = false;
                    this.$message.success(result.message);
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
