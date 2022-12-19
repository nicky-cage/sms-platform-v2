-- MySQL dump 10.13  Distrib 8.0.31, for macos12.6 (arm64)
--
-- Host: localhost    Database: payment_platform
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `merchant_accounts`
--

DROP TABLE IF EXISTS `merchant_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_accounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
  `remain` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '可用余额',
  `frozen` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '冻结金额',
  `total` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '可用总额',
  `total_in` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '入账总额',
  `total_out` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '出账总额',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '钱包状态 0:停用;1:启用;',
  `app_count` int NOT NULL DEFAULT '0' COMMENT '应用总数',
  `order_count` int NOT NULL DEFAULT '0' COMMENT '订单总数',
  `order_valid` int NOT NULL DEFAULT '0' COMMENT '有效订单',
  `order_success` decimal(6,2) NOT NULL DEFAULT '0' COMMENT '有效比率',
  `order_total` int NOT NULL DEFAULT '0' COMMENT '订单总数',
  `order_total_valid` int NOT NULL DEFAULT '00' COMMENT '有效总额',
  `total_withdraw` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '提现总额',
  `real_merchant` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '商户纯收',
  `real_platform` decimal(13,3) NOT NULL DEFAULT '0' COMMENT '平台纯收',
  PRIMARY KEY (`id`),
  UNIQUE KEY(merchant_id),
  UNIQUE KEY(merchant_name)
) ENGINE=InnoDB AUTO_INCREMENT=100100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_accounts`
--

LOCK TABLES `merchant_accounts` WRITE;
ALTER TABLE `merchant_accounts` DISABLE KEYS;
INSERT INTO `merchant_accounts` VALUES (1,3,'shipu_ty',0,0,0,0,0,0,3,0,0,0,0,0,0,0,0),(2,4,'Niclolas001',0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(3,5,'Niclolas002',0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),(4,6,'venice',0,0,0,0,0,1,2,0,0,0,0,0,0,0,0),(5,7,'xingkong',0,0,0,0,0,1,2,0,0,0,0,0,0,0,0),(6,23,'admin',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(7,24,'MERNiclolas888',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(8,25,'MERNiclolas001',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(9,35,'bond1',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(10,36,'bond2',0,0,0,0,0,0,1,27,15,55.56,3400,1800,0,1755.00,1773.00);
ALTER TABLE `merchant_accounts` ENABLE KEYS;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:31:47

update merchant_accounts set id = id + 100000;
alter table merchant_accounts add column remark varchar(256) not null default '' comment '备注';
update merchant_accounts set merchant_id = merchant_id + 100000;

alter table merchant_accounts
    add column count_remain int unsigned not null default 0 comment '短信可用数量',
    add column count_frozen int unsigned not null default 0 comment '冻结数量',
    add column count_total int unsigned not null default 0 comment '总计可用',
    add column sent_total int unsigned not null default 0 comment '总计已发',
    add column sent_success int unsigned not null default 0 comment '总计成功',
    add column total_recharge decimal(13, 2) not null default 0 comment '充值总额';

alter table merchant_accounts
    drop column order_count,
    drop column order_valid,
    drop column order_success,
    drop column order_total,
    drop column order_total_valid;


alter table merchant_accounts add column updated bigint not null default 0 comment '最后更新';

alter table merchant_accounts add column parent_id int not null default 0 comment '上级编号';
alter table merchant_accounts add column parent_name varchar(32) not null default '' comment '上级名称';
