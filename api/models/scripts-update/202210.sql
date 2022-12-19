
-- 初始化管理员
UPDATE admins SET name = 'admin1', salt = 'bBheUjrUnL3mDwSKXXH6ZOC0pItLqgQ4', password = '61026b7ae3be856370d89c8befeb8091' WHERE id = 1001 LIMIT 1;

-- 增加可国家
alter table merchants add column country_list varchar(256) not null default '' comment '可用国家';
-- 增加可用渠道
alter table merchants add column channel_list varchar(256) not null default '' comment '可用渠道';

-- 统计报表
alter table report_counts add column updated bigint not null default 0 comment '最后修改';

-- 商户报表
alter table report_merchants add column updated bigint not null default 0 comment '最后修改';

-- 授权ip
alter table admins add column remark varchar(256) not null default '' comment '备注';