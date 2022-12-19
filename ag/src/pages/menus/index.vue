<template>
    <div class="template-page">
        <div class="search">
            <a-form-model :model="search">
                <a-form-model-item label="菜单名称" prop="name">
                    <a-input v-model="search.name" placeholder="请输入菜单名称"/>
                </a-form-model-item>
                <a-form-model-item label="链接地址" prop="url">
                    <a-input v-model="search.url" placeholder="请输入链接地址"/>
                </a-form-model-item>
                <a-form-model-item label="状态" prop="status">
                    <a-select v-model="search.status" placeholder="请选择状态">
                        <a-select-option :value="1">启用</a-select-option>
                        <a-select-option :value="0">禁用</a-select-option>
                    </a-select>
                </a-form-model-item>
                <a-form-model-item>
                    <a-button type="primary" @click="searchSubmit"> 搜索</a-button>
                </a-form-model-item>
            </a-form-model>
        </div>
        
        <div class="table_box">
            <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
                     :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id" size="small" @change="pageChange">
                <span slot="yes_no" slot-scope="text">{{ text == 0 ? '否' : '是' }}</span>
                <span slot="status" slot-scope="text">{{ text === 0 ? '正常' : '禁用' }}</span>
                <span slot="action" slot-scope="text, record">
                    <a @click="recordUpdate(record)">编辑</a>
                    <a-divider type="vertical"/>
                    <a @click="deleteF(record)">删除</a>
                </span>
            </a-table>
        </div>
    </div>
</template>

<script>
import {crudService, MENUS_LIST as URL_LIST, PAGE_SIZE} from '@/services/index.js';

export default {
    name: "Menus",
    data() {
        return {
            confirmLoading: false,
            search: {page: 1, page_size: PAGE_SIZE, name: "", url: "", status: ""},
            rules: {
                name: [{required: true, message: "请输入后台用户名称", trigger: "blur"}],
            },
            columns: [
                {title: "ID", dataIndex: 'id', width: 60},
                {title: "上级菜单", dataIndex: 'parent_id', width: 100},
                {title: "菜单名称", dataIndex: 'name', width: 150},
                {title: "方法", dataIndex: 'method', width: 80},
                {title: "URL", dataIndex: 'url'},
                {title: "新窗打开", dataIndex: 'is_blank', width: 80, scopedSlots: {customRender: 'yes_no'}},
                {title: "是否显示", dataIndex: 'is_view', width: 80, scopedSlots: {customRender: 'yes_no'}},
                {title: "状态", dataIndex: 'status', width: 60, scopedSlots: {customRender: 'status'}},
                {title: "级别", dataIndex: 'level', width: 60},
                {title: "排序", dataIndex: 'sort', width: 80},
                {title: "备注", dataIndex: 'remark'},
                {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 120},
            ],
            tableList: [],
            pagination: {current: 1, pageSize: PAGE_SIZE, total: 0},
        };
    },
    created() {
        this.getTableData()
    },
    methods: {
        getTableData() {
            this.search.page = this.pagination.current;
            crudService.getRecords(URL_LIST, this.search).then(res => {
                let result = res.data;
                if (result.code === 0) {
                    this.tableList = result.data.records;
                    this.pagination.current = result.data.page;
                    this.pagination.total = result.data.total;
                    return;
                }
                this.$message.error({content: result.message});
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
        handleCancel() {
            this.visible = false;
        },
    },
};
</script>

<style lang="less" scoped> @import "../crud/index.less"; </style>
