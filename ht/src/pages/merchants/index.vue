<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="登录名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入商户登录名称" />
                </a-form-model-item>
                <a-form-model-item label="商户名称" prop="merchant_name">
                    <a-input v-model="search.merchant_name" placeholder="请输入商户名称" />
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="search.state" placeholder="请选择状态">
                        <a-select-option :value="1">启用</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="search.remark" placeholder="请输入备注" />
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="recordCreate">添加商户</a-button>
            </div>
        </div>

        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="merchant_type" slot-scope="text" :style="{color: text == 1 ? 'green': 'grey'}">{{ text === 1 ? '系统总代' : '代理商户' }}</span>
                <span slot="state" slot-scope="text" :style="{color: text == 1 ? 'green' : 'red'}">{{ text === 1 ? '正常' : '禁用' }}</span>
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="updated" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="recordUpdate(record)">编辑</a>
                </span>
            </a-table>
        </div>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 14 }">
                <a-form-model-item label="登录名称" prop="name">
                    <a-input v-model="form.name" placeholder="请输入商户登录名称" :disabled="!is_creating" />
                </a-form-model-item>
                <a-form-model-item label="登录密码" prop="password">
                    <a-input v-model="form.password" placeholder="请输入登录密码/如不修改请留空" />
                </a-form-model-item>
                <a-form-model-item label="上级商户" prop="parent_name" v-if="!is_creating && parent_name != ''">
                    <a-input v-model="parent_name" placeholder="请输入上级商户名称" disabled="true" />
                </a-form-model-item>
                <a-form-model-item label="商户名称" prop="merchant_name">
                    <a-input v-model="form.merchant_name" placeholder="请输入商户名称" />
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="form.state" placeholder="请选择状态">
                        <a-select-option :value="1">正常</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="商户类型" prop="merchant_type">
                    <a-select v-model="form.merchant_type" placeholder="请选择商户类型">
                        <a-select-option :value="1">系统总代</a-select-option>
                        <a-select-option :value="2">代理商户</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="渠道限制" prop="channel_list">
                    <a-select v-model="form.channel_list" placeholder="请选择可用通道">
                        <a-select-option v-for="channel in channels" :key="channel.id" :value="channel.id">{{channel.name}}</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="国家限制" prop="country_list">
                    <template v-for="country in countries">                    
                        <a-checkbox v-model="country_list[country.id]" :value="country.id" :default-checked="true" :style="{ width: '100px' }" > {{country.name }}</a-checkbox>
                        <a-input-number v-model="price_list[country.id]" placeholder="输入单价" :value="0.05" :min="0.01" :max="0.99" :step="0.01" /><br />
                    </template>
                </a-form-model-item>
                <a-form-model-item label="电话号码" prop="phone">
                    <a-input v-model="form.phone" placeholder="请输入电话号码" />
                </a-form-model-item>
                <a-form-model-item label="电子邮箱" prop="mail">
                    <a-input v-model="form.mail" placeholder="请输入电子邮箱" />
                </a-form-model-item>
                <a-form-model-item label="备注" prop="remark">
                    <a-input v-model="form.remark" placeholder="请输入备注" />
                </a-form-model-item>
            </a-form-model>
        </a-modal>
    </div>
</template>

<script>
import { crudService, PAGE_SIZE, UPLOAD_URL, BASE_URL } from '@/services/index.js';
import { datetime_ms } from '@/utils/datetime.js';
import { getAuthorization } from "@/utils/request";

export default {
    name: "Merchants",
    data() {
        return {
            upload_url: UPLOAD_URL,
            visible: false,
            title: '新增记录',
            is_creating: false,
            parent_name: "",
            confirmLoading: false,
            search: { page: 1, page_size: PAGE_SIZE, name: "", state: "", remark: "", merchant_name: "" },
            default_fee: 0.05,
            form: {
                name: "merchant", state: 1, remark: "", password: "", 
                merchant_name: "", merchant_type: 1, phone: "1234578", mail: "merchant@mail.com", remark: "请输入备注",
                country_list: "", channel_list: "",
            },
            rules: {
                name: [{required: true, message: "必须输入登录名称", trigger: "blur"}],
                merchant_name: [{required: true, message: "必须输入商户名称", trigger: "blur"}],
                state: [{required: true, message: "请选择状态", trigger: "blur"}],
                merchant_type: [{required: true, message: "请选择商户类型", trigger: "blur"}],
                phone: [{required: true, message: "请输入电话号码", trigger: "blur"}],
                mail: [{required: true, message: "请输入电子邮箱", trigger: "blur"}],
                remark: [{required: true, message: "必须输入备注", trigger: "blur"}],
                channel_list: [{ required: true, message: "必须选可用渠道", trigger: "blur" }],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "登录名称", dataIndex: 'name', width: 150},
                {title: "上级商户", dataIndex: 'parent_name', width: 150},
                {title: "商户名称", dataIndex: 'merchant_name', width: 150},
                {title: "最后登录", dataIndex: 'last_login', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "登录次数", dataIndex: 'login_count', width: 80},
                {title: "商户类型", dataIndex: 'merchant_type', scopedSlots: {customRender: 'merchant_type'}, width: 80},
                {title: "状态", dataIndex: 'state', scopedSlots: {customRender: 'state'}, width: 80},
                {title: "备注", dataIndex: 'remark' },
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "修改时间", dataIndex: 'updated', scopedSlots: {customRender: 'updated'}, width: 145},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
            ],
            tableList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            channels: [],
            countries: [],
            country_list: [],
            price_list: [],
            checked_list: [],
        };
    },
    created() {
        this.getTableData();
    },
    methods: {
        datetime_ms: datetime_ms,
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(`${BASE_URL}/auth/merchants`, this.search).then(res => {
                let result = res.data;
                if (result.code === 0) {
                    this.tableList = result.data.records;
                    this.pagination.current = result.data.page;
                    this.pagination.total = result.data.total;

                    if (result.data.channels) { 
                        this.channels = result.data.channels;
                        this.form.channel_list = this.channels[0].id;
                    }

                    if (result.data.countries) { 
                        this.countries = [];
                        for (let i = 0; i < result.data.countries.length; i++) { 
                            let country = result.data.countries[i];
                            this.countries.push(country);
                            this.country_list[country.id] = false; // 初始化选中状态
                            this.price_list[country.id] = 0.05; // 初始化相关的值
                        }
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
        searchSubmit() {
            this.pagination.current = 1;
            this.getTableData();
        },
        recordCreate() {
            let currentTime = new Date();
            let minute = currentTime.getMinutes();
            let second = currentTime.getSeconds();
            let num = '' + (minute > 9 ? minute : '0' + minute) +  (second > 9 ? second : '0' + second);
            this.form.name = 'merchant' + num;
            this.form.merchant_name = '商户名称' + num;
            this.form.mail = "merchant" + num + "@gmail.com";
            this.is_creating = true;
            this.title = '新增记录';
            this.visible = true;
        },
        recordUpdate(r) {
            this.is_creating = false;
            this.title = '修改记录';
            this.parent_name = r.parent_name;
            this.form.id = r.id
            this.form.name = r.name;
            this.form.merchant_name = r.merchant_name;
            this.form.state = r.state;
            this.form.merchant_type = r.merchant_type;
            this.form.sort = r.sort;
            this.form.phone = r.phone;
            this.form.mail = r.mail;
            this.form.remark = r.remark;
            if (!isNaN(r.channel_list)) { 
                this.form.channel_list = parseInt(r.channel_list);
            }
            if (r.country_list != "") { 
                this.price_list = [];
                let list = JSON.parse(r.country_list);
                for (let i = 0; i < list.length; i++) {
                    let item = list[i];
                    this.price_list[item.country_id] = item.fee;
                    this.country_list[item.country_id] = true;
                }
            }
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }

                let rArr = [];
                for (let country_id in this.country_list) { 
                    let checked = this.country_list[country_id]; // 是否选中
                    let fee = this.price_list[country_id];
                    if (checked && fee > 0.0)  { 
                        rArr.push({
                            "country_id": country_id,
                            "fee": fee,
                        });
                    }
                }
                if (rArr.length == 0) {
                    this.$message.error('请至少选定一个国家, 并设置费率');
                    return;
                }

                this.form.country_list = JSON.stringify(rArr);
                crudService.editRecord(`${BASE_URL}/auth/merchants/save`, this.form).then((res) => {
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
<style type="text/css">
</style>