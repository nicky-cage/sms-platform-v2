DROP TABLE IF EXISTS `message_templates`;
CREATE TABLE `message_templates` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
    `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
    `app_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
    `app_name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
    `name` varchar(64) not null default '' comment '模板名称',
    `type` tinyint not null default 0 comment '类型',
    `content` varchar(256) not null default '' comment '模板名称',
    `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
    `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
    `remark` varchar(20) NOT NULL DEFAULT '' COMMENT '备注',
    PRIMARY KEY (`id`, `created`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
