DROP TABLE IF EXISTS `message_channels`;
CREATE TABLE `message_channels` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `product_type` varchar(32) not null default '' comment '产品类型',
    `name` varchar(32) NOT NULL DEFAULT '' COMMENT '渠道名称',
    `code` char(20)  NOT NULL DEFAULT '' COMMENT '渠道编码',
    `remark` char(20)  NOT NULL DEFAULT '' COMMENT '备注',
    `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态 0:停用;1:启用;',
    `fee`  decimal(6, 2) not null default 0 comment '费率',
    `protocol` varchar(8) not null default 'https' comment '协议',
    `ip` varchar(256) not null default '' comment 'IP列表',
    `path` varchar(256) not null default '' comment 'path',
    `port` int not null default 0 comment '端口',
    `account` varchar(64) not null default '' comment '账号',
    `password` varchar(64) not null default '' comment '密码',
    `tps` int not null default 0 comment '并发',
    `direction` varchar(256) not null default '' comment 'DIRECTION',
    `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
    `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=10000;