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
-- Table structure for table `parameter_groups`
--

DROP TABLE IF EXISTS `parameter_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameter_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64)  NOT NULL DEFAULT '' COMMENT '参数名称',
  `name` varchar(64)  NOT NULL DEFAULT '' COMMENT 'KEY',
  `remark` varchar(256)  NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10100 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameter_groups`
--

LOCK TABLES `parameter_groups` WRITE;
/*!40000 ALTER TABLE `parameter_groups` DISABLE KEYS */;
INSERT INTO `parameter_groups` VALUES (1,'注册信息校验','zhuce','会员注册信息校验'),(2,'首存信息校验','first_charge','存款信息校验'),(3,'首提信息校验','first_withdraw','提款信息校验'),(4,'异常登录','djfj_dasd','大苏打'),(5,'开元棋牌链接配置','ky_chess','开元棋牌链接配置'),(6,'系统配置','sysconfig','系统配置'),(7,'h5页面','h5_url',''),(8,'客服系统','customer_service','客服系统'),(9,'短信通道','message_channel','短信通道'),(10,'客服地址','customer_service_url','客服地址'),(11,'代理APP下载','proxy_download','111.222'),(12,'合营计划联系方式','partner_number',''),(13,'存款行政费','withdraw_cost',''),(14,'存款手续费','deposit_cost',''),(15,'横幅配置','banner_list',''),(16,'提款配置',' withdraw_config',''),(17,'代理分享链接','https://tianji.down.pusta.click/register/index.html?a_code=',''),(18,'语言','lang','');
/*!40000 ALTER TABLE `parameter_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:25:41


UPDATE parameter_groups SET id = id + 10000;