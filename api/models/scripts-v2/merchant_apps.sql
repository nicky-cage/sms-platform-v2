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
-- Table structure for table `merchant_apps`
--

DROP TABLE IF EXISTS `merchant_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_apps` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '应用名称',
  `app_key` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'APP编号',
  `state` tinyint NOT NULL DEFAULT '0' COMMENT '状态 0:禁用; 1:启用;',
  `allow_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'IP白名单',
  `pay_in` tinyint NOT NULL DEFAULT '0' COMMENT '入款权限',
  `pay_out` tinyint NOT NULL DEFAULT '0' COMMENT '出款权限',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `notify_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '异步回调地址',
  `notify_url_payout` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '代付回调地址',
  PRIMARY KEY (`id`),
  KEY `merchant_id` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=168010 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_apps`
--

LOCK TABLES `merchant_apps` WRITE;
/*!40000 ALTER TABLE `merchant_apps` DISABLE KEYS */;
INSERT INTO `merchant_apps` VALUES (168000,3,'天际体育 - 正式','bnVrM2nszb8Ga9mOraOcjJ0N8vzbsJx7',1,'156.227.26.69',1,1,'狮扑体育平台',1601538107,1640515886,'https://pc.tjbet100.com/user/v1/payments/notify',''),(168001,5,'002名称','s6zrc0NpxObqjdN4TKK5e9eOASgBnBF0',0,'192.168.1.1',0,0,'002',1603693342,1627568158,'http://baidu.com',''),(168002,6,'威尼斯人 - 正式','eD0GT0PCDRYXp5ay8wQJMnM23tEzjuIQ',1,'192.168.1.1',1,1,'1',1622699083,1628001193,'https://pc.2382010.com/user/v1/payments/notify',''),(168003,6,'威尼斯人 - 测试','5Q7d5r6NDvVz8zitLu2shY6fSnqSIkpy',1,'192.168.1.1',1,1,'威尼斯测试',1627137125,1627568144,'https://pc.vipvns.net/user/v1/payments/notify',''),(168004,3,'天际测试1.0 - 测试','VDWVJJMSMLMBBD2X82GGACUN2YN2IS1U',1,'192.168.1.1',1,1,'1',1627137153,1627568136,'https://pc.pusta.clickt/user/v1/payments/notify	',''),(168005,3,'天际测试2.0 - 测试','jOYoYe7zqQsGzSNkI1KcyQVna0tCJErt',1,'127.0.0.1',1,1,'天际体育2.0',1627545816,1640410800,'https://tianji.pc.pusta.click/user/v1/payments/notify',''),(168006,7,'星空体育 - 测试','BoPJXXC2hOvtJtCbxeDoEjztvRocqjR7',1,'127.0.0.1',1,1,'星空体育测试',1627545971,1627568115,'https://xkong.pc.vipvns.net/user/v1/payments/notify',''),(168007,7,'星空体育 - 正式','rGUHTVDuhGW7nqyX4oAIq78sEIaHlCwT',1,'127.0.0.1',1,1,'星空体育 - 正式',1629212892,1629212905,'https://api.168xgg.com/user/v1/payments/notify',''),(168008,37,'ceshi ','',1,'1254554555',1,1,'',0,0,'ddada',''),(168009,36,'色站','cn2nS36ICmVIQXjxKkfhZkIu792GLtkU',1,'127.0.0.1',1,1,'',0,0,'https://api.pusta.click/api/v1/deposit/confirm','');
/*!40000 ALTER TABLE `merchant_apps` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:33:02

update merchant_apps set id = id + 100000;
update merchant_apps set created = created * 1000000;
update merchant_apps set updated = updated * 1000000;
update merchant_apps set merchant_id = merchant_id + 100000;

alter table merchant_apps add column merchant_name varchar(32) not null default '' comment '商户名称';

update merchant_apps, merchants set merchant_apps.merchant_name = merchants.name where merchant_apps.merchant_id = merchants.id;
