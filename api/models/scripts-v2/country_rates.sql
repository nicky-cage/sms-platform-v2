DROP TABLE IF EXISTS `country_rates`;
CREATE TABLE `country_rates` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `country_id` int NOT NULL DEFAULT '0' COMMENT '渠道名称',
    `channel_id` int NOT NULL DEFAULT '0' COMMENT '渠道编码',
    `rate`  decimal(6, 2) not null default 0 comment '费率',
    `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
    `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
    PRIMARY KEY (`id`),
    KEY(`country_id`),
    KEY(`channel_id`),
    UNIQUE KEY(`country_id`, `channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000;