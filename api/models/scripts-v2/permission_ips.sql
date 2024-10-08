-- MySQL dump 10.13  Distrib 8.0.31, for macos12.6 (arm64)
--
-- Host: localhost    Database: integrated_db
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
-- Table structure for table `permission_ips`
--

DROP TABLE IF EXISTS `permission_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_ips` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `permission_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '授权类型',
  `ip` varchar(64)  NOT NULL DEFAULT '' COMMENT 'IP',
  `remark` varchar(256)  NOT NULL DEFAULT '' COMMENT '备注',
  `state` tinyint NOT NULL DEFAULT '2' COMMENT '状态',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY(ip),
  INDEX(permission_type)
) ENGINE=InnoDB AUTO_INCREMENT=100200 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_ips`
--

LOCK TABLES `permission_ips` WRITE;
/*!40000 ALTER TABLE `permission_ips` DISABLE KEYS */;
INSERT INTO `permission_ips` VALUES (1,1,'127.0.0.1','本地内网-不可删除',2,1598085144,1599621071),(2,0,'130.105.185.145','116.204.186.27',2,1598085643,1598085643),(6,0,'180.190.99.171','180.190.99.171',2,1599448207,1599448216),(11,0,'180.190.87.34','admin',2,1602842612,1602842612),(12,0,'180.191.191.242','156.237.192.186',2,1603597318,1603597318),(16,0,'180.190.116.76','运维',2,1604027409,1604027409),(17,0,'180.191.158.169','测试',2,1604028586,1604028595),(18,0,'180.190.114.242','andy',2,1604314950,1604314950),(19,0,'180.190.117.99','103.80.16.226',2,1604543975,1604543975),(21,0,'127.0.0.2','coco-1',2,1606806957,1606806957),(23,0,'180.190.116.67','临时查看',2,1607082308,1607082308),(24,0,'110.165.35.242','天际运营',2,1609828711,1609828894),(27,0,'180.190.117.22','运营',2,1609855314,1609855314),(28,0,'180.190.117.72','运营',2,1610817237,1610817237),(29,0,'180.190.99.4','运营',2,1610817312,1610817312),(32,0,'180.190.114.135','运营',2,1610888002,1610888002),(33,0,'61.9.110.229','joey',2,1611226956,1611226956),(34,0,'180.190.112.19','joey 泰国',2,1611228105,1611228105),(36,0,'180.190.98.50','运营',2,1611733764,1611733764),(38,0,'180.191.226.84','dave',2,1612166731,1612166731),(40,0,'130.105.154.171','mg',2,1612166731,1612166731),(42,0,'180.190.113.231','测试哦',2,1612346548,1612346548),(43,0,'180.191.226.122','测试',2,1612346801,1612346801),(45,0,'13.127.249.69','13.127.249.69',2,1612411619,1612411619),(50,0,'69.172.93.133','raven',2,1614756396,1614756396),(53,0,'180.190.85.206','124.6.187.134 - king',2,1615109068,1615109068),(54,0,' 27.55.72.95','包网',2,1615971582,1615971582),(55,0,'18.166.60.24','cews',2,1616063850,1616063850),(56,0,'104.23.138.41','包网',2,1616403004,1616403004),(57,0,'103.23.138.41','包网',2,1616405493,1616405493),(58,0,'136.158.25.152','las',2,0,0),(60,0,'175.176.32.60','las',2,0,0),(65,0,'180.191.190.229','kingking',2,1618035358,1618035358),(66,0,'181.190.115.161','robin',2,1618035810,1618035810),(67,0,'180.191.216.52','robin',2,1618037591,1618037591),(68,0,'180.190.114.81','kingking',2,1618037696,1618037696),(70,0,'103.142.141.228','raven',2,1618381521,1618381521),(72,0,'182.190.114.81','kingking',2,1618579871,1618579871),(78,0,'180.191.227.52','robin',2,1619096731,1619096731),(82,0,'183.190.114.81','kingking',2,1619762756,1619762756),(85,0,'180.191.226.52','robin',2,1620277883,1620277883),(86,0,'180.190.115.198','kingking: 邮件绑定',2,1620371401,1620371401),(88,0,'180.190.85.36','kingking: 邮件绑定',2,1620635670,1620635670),(89,0,'180.190.85.9','kingking: 邮件绑定',2,1620725191,1620725191),(90,0,'175.176.32.106','robin: 邮件绑定',2,1620745874,1620745874),(91,0,'180.191.223.119','kingking: 邮件绑定',2,1620974698,1620974698),(92,0,'180.190.97.156','robin: 邮件绑定',2,1621232693,1621232693),(93,0,'180.191.191.86','kingking: 邮件绑定',2,1621418297,1621418297),(94,0,'180.190.86.202','kingking: 邮件绑定',2,1622611252,1622611252),(96,0,'180.190.113.118','robin: 邮件绑定',2,1622708082,1622708082),(97,0,'110.54.134.151','kingking: 邮件绑定',2,1623399523,1623399523),(98,0,'110.54.189.107','kingking: 邮件绑定',2,1623483294,1623483294),(99,0,'180.191.222.143','kingking: 邮件绑定',2,1623656836,1623656836),(100,0,'103.142.140.58','',2,1623947374,1623947374),(101,0,'180.191.227.122','robin: 邮件绑定',2,1624243497,1624243497),(103,0,'103.142.140.228','raven',2,1624352428,1624352428),(104,0,'49.237.21.16','joey\n',2,1624690835,1624690835),(107,0,'223.24.158.254','joey1: 邮件绑定',2,1624710655,1624710655),(108,0,'27.55.72.95','joey1: 邮件绑定',2,1624711408,1624711408),(110,0,'124.6.187.134','kingking: 邮件绑定',2,1624769368,1624769368),(111,0,'175.176.36.233','joey1: 邮件绑定',2,1625129610,1625129610),(112,0,'202.172.18.119','joey1: 邮件绑定',2,1625165348,1625165348),(113,0,'180.190.114.150','kingking: 邮件绑定',2,1625588604,1625588604),(114,0,'78.138.12.15','',2,1625588691,1625588691),(115,0,'13.125.238.61','jason',2,0,0),(116,0,'bood','180.190.115.198',2,1630917996,1630917996),(117,0,'210.193.125.98','eBet',2,0,0),(118,0,'210.193.125.99','eBet',2,0,0),(119,0,'210.193.125.100','eBet',2,0,0),(120,0,'210.193.125.101','eBet',2,0,0),(121,0,'180.190.114.183','eBet',2,0,0),(122,0,'210.193.125.105','eBet',2,0,0),(123,0,'210.193.125.106','eBet',2,0,0),(124,0,'210.193.125.111','eBet',2,0,0),(125,0,'210.193.125.112','eBet',2,0,0),(126,0,'43.245.217.113','检查多语言',2,1647624012,1647624012),(127,0,'212.107.28.9','raven',2,1649748318,1649748318);
/*!40000 ALTER TABLE `permission_ips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:26:29

UPDATE permission_ips SET id = id + 100100;
update permission_ips set created = created * 1000000;
update permission_ips set updated = updated * 1000000;

alter table permission_ips add column admin_id int not null default 0 comment '添加用户id';
alter table permission_ips add column admin_name varchar(32) not null default '' comment '添加用户';
