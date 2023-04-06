create table if not exists mobile_recharges (
    id bigint not null auto_increment,
    order_number varchar(32) not null default '' comment '订单编号',
    merchant_id bigint not null default 0 comment '商户编号',
    merchant_name varchar(32) not null default '' comment '商户名称',
    mobile_agent_id varchar(32) not null default '' comment '充值代理编号',
    mobile_product_code varchar(16) not null default '' comment '产品代码',
    mobile_phone varchar(16) not null default '' comment '手机号码',
    mobile_money decimal(6, 2) not null default 0 comment '充值金额',
    mobile_order varchar(32) not null default '' comment '订单编号',
    mobile_auth varchar(32) not null default '' comment '签名',
    mobile_request_url varchar(256) not null default '' comment '请求地址',
    mobile_request_result text comment '请求结果',
    created bigint not null default 0 comment '添加时间',
    updated bigint not null default 0 comment '最后修改',
    status tinyint not null default 0 comment '状态 0:待充; 1:成功; 2:失败; 3:取消;',
    finished bigint not null default 0 comment '完成时间',
    primary key (id),
    index (merchant_id),
    unique key(order_number),
    unique key(mobile_order),
    index(status)
);