<template>
    <div class="template-page">
        <div class="search">
            <a-form-model ref="search" :model="search">
                <a-form-model-item label="活动标题" prop="title">
                    <a-input v-model="search.title" placeholder="请输入活动标题" />
                </a-form-model-item>
                <a-form-model-item label="状态" prop="status">
                    <a-select v-model="search.status" placeholder="请选择状态">
                        <a-select-option :value="1">启用</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit">搜索</a-button>
                </a-form-model-item>
            </a-form-model>
            <div class="btns">
                <a-button type="primary" @click="recordCreate">添加公告</a-button>
            </div>
        </div>

        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="state" slot-scope="text" :style="{color: text == 1 ? 'green':'red'}">{{ text === 1 ? '正常' : '禁用' }}</span>
                <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="updated" slot-scope="text">{{ datetime_ms(text) }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="recordUpdate(record)">编辑</a>
                    <a-divider type="vertical" />
                    <a @click="recordDelete(record)">删除</a>
                </span>
            </a-table>
        </div>

        <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible"
            @cancel="formCancel" @ok="formSubmit">
            <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules"
                :wrapper-col="{ span: 16 }">
                <a-form-model-item label="公告标题" prop="title">
                    <a-input v-model="form.title" placeholder="请输入活动标题" />
                </a-form-model-item>
                <a-form-model-item label="状态" prop="state">
                    <a-select v-model="form.state" placeholder="请选择活动状态">
                        <a-select-option :value="1">正常</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item label="排序" prop="sort">
                    <a-input-number v-model="form.sort" placeholder="请输入排序" :min="1" />
                </a-form-model-item>
                <a-form-model-item label="URL" prop="url">
                    <a-input v-model="form.url" placeholder="请输入活动URL" />
                </a-form-model-item>
                <a-form-model-item label="内容" prop="content">
                    <a-textarea v-model:value="form.content" placeholder="请输入活动内容" :rows="5"></a-textarea>
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
    name: "Notices",
    data() {
        return {
            upload_url: UPLOAD_URL,
            visible: false,
            title: '新增记录',
            is_creating: false,
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, title: "", state: ""},
            form: { title: "", state: 1, type: 1, sort: 0, url: "", content: "" },
            time_start: null, 
            time_end: null,
            rules: {
                tittle: [{required: true, message: "必须输入标题名称", trigger: "blur"}],
                type: [{required: true, message: "必须输入类型", trigger: "blur"}],
                sort: [{required: true, message: "必须输入排序", trigger: "blur"}],
                state: [{required: true, message: "请选择状态", trigger: "blur"}],
                content: [{required: true, message: "必须输入活动内容", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 80},
                {title: "公告标题", dataIndex: 'title'},
                {title: "排序", dataIndex: 'sort', width: 80},
                {title: "URL", dataIndex: 'url', wdith: 300},
                {title: "状态", dataIndex: 'state', scopedSlots: {customRender: 'state'}, width: 60},
                {title: "添加时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145},
                {title: "修改时间", dataIndex: 'updated', scopedSlots: {customRender: 'updated'}, width: 145},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 90},
            ],
            tableList: [],
            fileList: [],
            pagination: { current: 1, pageSize: PAGE_SIZE, total: 0 },
            headers: { authorization: 'authorization-text', },
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
            crudService.getRecords(`${BASE_URL}/auth/notices`, this.search).then(res => {
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
        handleChange(info) {
            if (info.file.status !== 'uploading') {
                console.log(info.file, info.fileList);
            }
            if (info.file.status === 'done') {
                if (info.response) {
                    let result = info.response;
                    if (result.code != 0) { 
                        this.$message.error(`${result.message}`);
                        return;
                    }

                    this.$message.success(`文件上传成功`);
                    this.form.image_cover = result.data.path;
                }
            } else if (info.file.status === 'error') {
                this.$message.error(`${info.file.name} 文件上传失败`);
            }
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
            this.form.title = r.title;
            this.form.type = r.type;
            this.form.state = r.state;
            this.form.content = r.content;
            this.visible = true;
        },
        formSubmit() {
            this.$refs.ruleForm.validate((valid) => {
                if (!valid) {
                    return false;
                }
                let time_start = Math.floor((new Date(this.form.time_start)).getTime() / 1000);
                let time_end = Math.floor((new Date(this.form.time_end)).getTime() / 1000);
                this.form.time_start = time_start;
                this.form.time_end = time_end;
                let url = this.is_creating ? `${BASE_URL}/notices/create`: `${BASE_URL}/notices/update`;
                crudService.editRecord(url, this.form).then((res) => {
                    let result = res.data;
                    if (result.code > 0) {
                        this.$message.error(result.message);
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
        recordDelete(r) {
            this.$confirm({
                title: '删除', content: '确定删除该数据？', okText: '确认', cancelText: '取消',
                onOk() {
                    crudService.deleteRecord(URL_DELETE, {id: r.id}).then(res => {
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
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>