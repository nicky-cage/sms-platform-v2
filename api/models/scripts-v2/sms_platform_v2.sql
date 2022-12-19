-- MySQL dump 10.13  Distrib 8.0.31, for macos12.6 (arm64)
--
-- Host: localhost    Database: sms_platforms_v2
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
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platforms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '平台名称',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` int unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` VALUES (1,'天际体育','天际体育平台 - 测试环境',0,2,1582277592,1624244665),(2,'威尼斯人','威尼斯人体育平台 - 测试环境',0,1,1620022210,1624244656),(3,'星空体育','星空体育 - 测试环境',0,1,1624244586,1624244586),(4,'天空体育','alex / dave 专用平台',0,1,1624244604,1624244604),(5,'雷欧体育','leon / robin 专用平台',0,1,1624244619,1624244619),(6,'邦德体育','bond 专用平台',0,1,1624244638,1624244638),(7,'杰森体育','jason 专用平台',0,1,1624244729,1624244729),(8,'乔伊体育','joey 专用平台',0,1,1624244745,1624244745);
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_configs`
--

DROP TABLE IF EXISTS `site_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_configs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` int unsigned NOT NULL DEFAULT '0' COMMENT '平台编号',
  `site_id` int unsigned NOT NULL DEFAULT '0' COMMENT '盘口编号',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '配置名称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态',
  `value` text COMMENT '配置项值',
  `remark` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` int unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `platform_id` (`platform_id`),
  KEY `site_id` (`site_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_configs`
--

LOCK TABLES `site_configs` WRITE;
/*!40000 ALTER TABLE `site_configs` DISABLE KEYS */;
INSERT INTO `site_configs` VALUES (1,1,1,'site_name',2,'天际体育平台一','盘口/站点名称',0,1582278212,1582278212),(2,1,1,'platform',2,'tianji','平台识别号',0,1582278212,1582278212),(3,1,1,'kafka_strings',2,'127.0.0.1:9092','默认数据库类型',0,1582278212,1582278212),(4,1,1,'conn_strings',2,'sms_system:qwe123QWE@tcp(127.0.0.1:3306)/sms_system?charset=utf8','Mysql数据库配置',0,1582278212,1582278212),(5,1,1,'redis_strings',2,'qwe123QWE@127.0.0.1:6383','Redis配置',0,1582355813,1582355813),(6,1,1,'elastic_strings',2,'http://127.0.0.1:9200','Mongo配置',0,1582355824,1582355824),(7,2,2,'site_name',2,'威尼斯人','盘口/站点名称',0,1620022234,1620022234),(8,2,2,'platform',2,'venice','平台标识',0,1620022234,1620022234),(9,2,2,'kafka_strings',2,'127.0.0.1:9092','Kafka',0,1620022234,1620022234),(10,2,2,'conn_strings',2,'admin:qwe123QWE@tcp(127.0.0.1:3306)/integrated_venice?charset=utf8','Mysql',0,1620022234,1620022234),(11,2,2,'redis_strings',2,'qwe123QWE@127.0.0.1:6381','Redis',0,1620022234,1620022234),(12,2,2,'elastic_strings',2,'http://127.0.0.1:9200','ElasticSearch',0,1620022234,1620022234),(13,1,1,'static_url',2,'http://static.sports','',0,0,0),(14,1,1,'upload_url',2,'https://up.pusta.click','',0,0,0),(15,2,2,'static_url',2,'https://static.pusta.click','',0,0,0),(16,2,2,'upload_url',2,'https://up.pusta.click','',0,0,0),(17,1,1,'pay_strings',2,'168005:jOYoYe7zqQsGzSNkI1KcyQVna0tCJErt','',0,0,0),(18,2,2,'pay_strings',2,'168005:jOYoYe7zqQsGzSNkI1KcyQVna0tCJErt','',0,0,0),(19,3,3,'site_name',2,'星空体育平台一','盘口/站点名称',0,1582278212,1582278212),(20,3,3,'platform',2,'xingkong','平台识别号',0,1582278212,1582278212),(21,3,3,'kafka_strings',2,'127.0.0.1:9092','默认数据库类型',0,1582278212,1582278212),(22,3,3,'conn_strings',2,'admin:qwe123QWE@tcp(127.0.0.1:3306)/integrated_xingkong?charset=utf8','Mysql数据库配置',0,1582278212,1582278212),(23,3,3,'redis_strings',2,'qwe123QWE@127.0.0.1:6382','Redis配置',0,1582355813,1582355813),(24,3,3,'elastic_strings',2,'http://127.0.0.1:9200','Mongo配置',0,1582355824,1582355824),(25,3,3,'static_url',2,'https://static.pusta.click','',0,0,0),(26,3,3,'upload_url',2,'https://up.pusta.click','',0,0,0),(27,3,3,'pay_strings',2,'168005:jOYoYe7zqQsGzSNkI1KcyQVna0tCJErt','',0,0,0),(34,1,1,'static_url_admin',2,'https://static.pusta.click/backend/static','',0,0,0),(35,2,2,'static_url_admin',2,'https://static.pusta.click/backend/static','',0,0,0),(36,3,3,'static_url_admin',2,'https://static.pusta.click/backend/static','',0,0,0);
/*!40000 ALTER TABLE `site_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` int unsigned NOT NULL DEFAULT '0' COMMENT '平台编号',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `urls` text COMMENT '域名',
  `api` varchar(200) NOT NULL DEFAULT '' COMMENT 'API地址',
  `admin_url` varchar(200) NOT NULL DEFAULT '' COMMENT '后台地址',
  `admin_api` varchar(200) NOT NULL DEFAULT '' COMMENT '后台API',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` int unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '平台代码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `platform_id` (`platform_id`),
  KEY `name_2` (`name`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,'天际体育','天际站点一',2,0,'tianji.m.pusta.click,tianji.pc.pusta.click','tianji.api.pusta.click,api.sms.local','tianji.backstage-management-system.pusta.click,admin.sports','',1582277620,1582277620,'TJ'),(2,2,'威尼斯人','威尼斯人一',2,0,'venice.pc.pusta.click,venice.m.pusta.click','venice.api.pusta.click','venice.backstage-management-system.pusta.click','',1620022234,1620022234,'VN'),(3,3,'星空体育','星空测试',2,0,'xingkong.pc.pusta.click,xingkong.m.pusta.click','xingkong.api.pusta.click','xingkong.backstage-management-system.pusta.click','',0,0,'XK');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-23 16:51:02
