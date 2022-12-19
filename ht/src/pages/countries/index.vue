<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="国家名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入国家名称"/>
                </a-form-model-item>
                <a-form-model-item label="国家代码" prop="code">
                    <a-input v-model="search.code" placeholder="请输入备注"/>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="rowCreate">添加国家</a-button>
            </div>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="is_support" slot-scope="text">{{ text === 1 ? '是' : '否' }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="rateSet(record)">设置单价</a>
                    <a-divider type="vertical" />
                    <a @click="rowUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>
        
        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form" :rules="rules" :wrapper-col="{ span: 20 }">
                <a-form-model-item label="国家名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入省份代码"/>
                </a-form-model-item>
                <a-form-model-item label="国家名称" prop="name_english">
                    <a-input v-model="form.name_english" placeholder="请输入英文名称"/>
                </a-form-model-item>
                <a-form-model-item label="国家代码" prop="code">
                    <a-input v-model="form.code" placeholder="请输入国家代码"/>
                </a-form-model-item>
                <a-form-model-item label="电话前缀" prop="phone_prefix">
                    <a-input v-model="form.phone_prefix" placeholder="请输入电话前缀"/>
                </a-form-model-item>
                <a-form-model-item label="支持发送" prop="is_support">
                    <a-select v-model="form.is_support" placeholder="请选择是否支持">
                        <a-select-option :value="0">否</a-select-option>
                        <a-select-option :value="1">是</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="时区偏移" prop="timezone_offset">
                    <a-input v-model="form.timezone_offset" placeholder="请输入时区偏移"/>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注"/>
                </a-form-model-item>
            </a-form-model>
        </a-modal>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="'设置通道费率'" :visible="show_rate" @cancel="rateHide" @ok="rateSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 4 }" :model="form_fee" :rules="rules_fee" :wrapper-col="{ span: 20 }">
                <div v-for="item in channels">
                    <a-form-model-item label="通道名称" prop="fee_names"> {{item.name}} </a-form-model-item>
                    <a-form-model-item label="短信单价" prop="rates">
                        <a-input v-model="form_fee[item.id]" placeholder="请输入此国家单价"/>
                    </a-form-model-item>
                </div>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import {BASE_URL, crudService, PAGE_SIZE} from '@/services/index.js';

export default {
    name: "Countries",
    data() {
        return {
            visible: false,
            show_rate: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, name: "", code: "" },
            form: { name: "",  name_english: "", code: "", phone_prefix: "", timezone_offset: "", remark:"", is_support: ""},
            form_fee: {},
            rules: {
                name: [{required: true, message: "请输入国家名称", trigger: "blur"}],
                name_english: [{required: true, message: "请输入英文名称", trigger: "blur"}],
                code: [{required: true, message: "请输入国家代码", trigger: "blur"}],
                phone_prefix: [{required: true, message: "请输入电话前缀", trigger: "blur"}],
                timezone_offset: [{required: true, message: "请输入时区偏移", trigger: "blur"}],
                remark: [{required: true, message: "请输入备注", trigger: "blur"}],
                is_support : [{required: true, message: "请选择是否支持", trigger: "blur"}],
            },
            rules_fee: {},
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "国家名称", dataIndex: 'name', width: 150},
                {title: "英文名称", dataIndex: 'name_english',  width: 250},
                {title: "国家代码", dataIndex: 'code', width: 100},
                {title: "电话前缀", dataIndex: 'phone_prefix', width: 150},
                {title: "时区偏移", dataIndex: 'timezone_offset', width: 100},
                {title: "是否支持", dataIndex: 'is_support', width: 100, scopedSlots: {customRender: 'is_support'}},
                {title: "备注", dataIndex: 'remark'},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 110},
            ],
            tableList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            channels: [],
            country_id: 0,
        };
    },
    created() {
        this.getTableData()
    },
    methods: {
        getTableData() {
            crudService.getRecords(`${BASE_URL}/auth/countries`, this.search).then(res => {
                let result = res.data;
                if (result.code === 0) {
                    this.tableList = result.data.records;
                    this.pagination.current = result.data.page;
                    this.pagination.total = result.data.total;

                    if (result.data.channels) { 
                        this.channels = result.data.channels;
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
            this.search.page = val.current;
            this.pagination.current = val.current;
            this.getTableData();
        },
        searchSubmit() {
            this.search.page = this.pagination.current;
            this.getTableData();
        },
        rowCreate() {
            this.is_creating = true;
            this.title = '新增记录';
            this.visible = true;
        },
        rateSet(r) { 
            this.country_id = r.id;
            this.show_rate = true;
        },
        rateHide() { 
            this.country_id = 0;
            this.show_rate = false;
        },
        rateSubmit() { 
            let rArr = {};
            let counter = 0;
            for (let k in this.form_fee) { 
                let rate = this.form_fee[k];
                for (let j = 0; j < this.channels.length; j++) { 
                    let channel = this.channels[j];
                    if (k == channel.id) { 
                        rArr["country_" + this.country_id + "_" + channel.id] = rate;
                        break;
                    }
                }
                counter += 1;
            }
            if (counter == 0) {
                return;
            }
            crudService.editRecord(`${BASE_URL}/auth/countries/save_rate`, rArr).then((res) => { 
                let result = res.data;
                if (result.code > 0) { 
                    this.$message.error(result.message);
                    if (result.code == 405) {
                        this.$router.push("/");
                    }
                    return;
                }
                this.show_rate = false;
                this.$message.success(result.message);
            });
        },
        rowUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.form.id = r.id
            this.form.name = r.name
            this.form.name_english = r.name_english
            this.form.code = r.code;
            this.form.phone_prefix = r.phone_prefix;
            this.form.timezone_offset = r.timezone_offset;
            this.form.remark = r.remark;
            this.form.is_support = r.is_support;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                crudService.editRecord(`${BASE_URL}/auth/countries/save`, this.form).then((res) => {
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
