DROP TABLE IF EXISTS `merchant_country_rates`;
CREATE TABLE `merchant_country_rates` (
     `id` int unsigned NOT NULL AUTO_INCREMENT,
     `merchant_id` int NOT NULL DEFAULT '0' COMMENT '商户编号',
     `country_id` int NOT NULL DEFAULT '0' COMMENT '国家编号',
     `channel_id` int NOT NULL DEFAULT '0' COMMENT '渠道编号',
     `rate`  decimal(6, 2) not null default 0 comment '费率',
     `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
     `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
     PRIMARY KEY (`id`),
     KEY(`country_id`),
     KEY(`channel_id`),
     UNIQUE KEY(`country_id`, `channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000;