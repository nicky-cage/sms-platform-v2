<template>
  <div class="template-page">
    <div class="search">
      <a-form-model ref="search" :model="search">
        <a-form-model-item label="手机号码" prop="mobile_phone">
          <a-input v-model="search.mobile_phone" placeholder="请输入充值手机号码" />
        </a-form-model-item>
        <a-form-model-item>
          <a-button type="primary" @click="searchSubmit">搜索</a-button>
        </a-form-model-item>
      </a-form-model>
      <div class="btns">
        <a-button type="primary" @click="recordCreate">添加充值</a-button>
      </div>
    </div>

    <div class="table_box">
      <a-table :columns="columns" :data-source="tableList" :pagination="pagination"
               :row-class-name="(_record, index) => (index % 2 === 1 ? 'table-striped' : null)" rowKey="id"
               size="small" @change="pageChange">
        <span slot="state" slot-scope="text" :style="{color: text == 1 ? 'green' : 'red'}">{{ text === 1 ? '成功' : (text == 2 ? '失败' : '待处理') }}</span>
        <span slot="created" slot-scope="text">{{ datetime_ms(text) }}</span>
      </a-table>
    </div>

    <a-modal :centered="true" :confirm-loading="confirmLoading" :title="title" :visible="visible" @cancel="formCancel" @ok="formSubmit">
      <a-form-model ref="ruleForm" :label-col="{ span: 6 }" :model="form" :rules="rules" :wrapper-col="{ span: 16 }">
        <a-form-model-item label="电话号码" prop="mobile_phone">
          <a-input v-model="form.mobile_phone" placeholder="请输入充值手机号码" />
        </a-form-model-item>
        <a-form-model-item label="充值金额" prop="channel_id">
          <a-select v-model="form.mobile_money" placeholder="请选择短信渠道">
            <a-select-option :value="100">100</a-select-option>
            <a-select-option :value="300">300</a-select-option>
            <a-select-option :value="500">500</a-select-option>
          </a-select>
        </a-form-model-item>
      </a-form-model>
    </a-modal>
  </div>
</template>

<script>
import { crudService, PAGE_SIZE, BASE_URL } from '@/services/index.js';
import { datetime_ms } from '@/utils/datetime.js';

export default {
  name: "MobileRecharges",
  data() {
    return {
      visible: false,
      title: '新增记录',
      is_creating: false,
      confirmLoading: false,
      submitted: false,
      search: {page: 1, page_size: PAGE_SIZE, mobile_phone: "" },
      form: { mobile_phone: "", mobile_money: 100 },
      rules: {
        mobile_phone: [{required: true, message: "必须输入手机号码", trigger: "blur"}],
        mobile_money: [{required: true, message: "必须选择充值金额", trigger: "blur"}],
      },
      columns: [
        {title: "ID", dataIndex: 'id', width: 80},
        {title: "订单编号", dataIndex: 'order_number', width: 170},
        {title: "商户名称", dataIndex: 'merchant_name', width: 80},
        {title: "充值代理ID", dataIndex: 'mobile_agent_id', width: 80},
        {title: "充值产品编号", dataIndex: 'mobile_product_code', width: 100},
        {title: "充值手机号码", dataIndex: 'mobile_phone', width: 150},
        {title: "充值金额", dataIndex: 'phone_full', width: 140},
        {title: "充值状态", dataIndex: 'status', scopedSlots: {customRender: 'state'}, width: 60 },
        {title: "充值订单号码", dataIndex: 'mobile_order_id', width: 70},
        {title: "充值时间", dataIndex: 'created', scopedSlots: {customRender: 'created'}, width: 145 },
        {title: "完成时间", dataIndex: 'finished', scopedSlots: {customRender: 'created'}, width: 145 },
        {title: "操作", dataIndex: 'action', scopedSlots: {customRender: 'action'}, width: 60},
      ],
      tableList: [],
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
      crudService.getRecords(`${BASE_URL}/auth/mobile_recharges`, this.search).then(res => {
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
        if (this.submitted) {
          this.$message.error("请不要重复提交");
          return
        }
        this.submitted = true;
        crudService.editRecord(`${BASE_URL}/auth/mobile_recharges/save`, this.form).then((res) => {
          let result = res.data;
          if (result.code > 0) {
            this.$message.error(result.message);
            this.submitted = false;
            return;
          }
          this.$refs.ruleForm.resetFields();
          this.$message.success(result.message);
          this.pagination.current = 1;
          this.visible = false;
          this.getTableData();
          this.submitted = false;
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