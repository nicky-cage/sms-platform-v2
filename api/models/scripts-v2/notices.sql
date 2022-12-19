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
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '类型, 1:普通;2:特殊;3:财务;',
  `title` varchar(32)  DEFAULT NULL COMMENT '标题',
  `content` varchar(512)  DEFAULT NULL COMMENT '内容',
  `state` tinyint unsigned DEFAULT '2' COMMENT '2:启用;1:停用;',
  `sort` int DEFAULT NULL COMMENT '排序',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `jump_url` varchar(256)  DEFAULT NULL COMMENT '跳转链接',
  `img_url` varchar(256)  DEFAULT NULL COMMENT '图标地址',
  `platform_type` varchar(256)  NOT NULL DEFAULT '' COMMENT '平台类型, 1:全站;2:体育;3:web;4:h5;',
  `vip_ids` varchar(256)  NOT NULL DEFAULT '' COMMENT 'VIP等级',
  `end_at` int unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `start_at` int unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `user_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 user 1 agent',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10100 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notices`
--

LOCK TABLES `notices` WRITE;
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
INSERT INTO `notices` VALUES (39,3,'财务公告','<p>存款吧@@！！！！！！！</p>',2,NULL,1608791597,1617866653,'1','/notices/icon/1.png','1,3,4','1,2,3,4,5,6,7,8,9',1672502399,1608739200,0),(52,1,'大家好！！！！！！！！','<p>额，你们好！！！！</p>',2,NULL,1630912535,1630912535,'1','/notices/icon/1.png','1,3,4','1,2,3,4,5,6,7,8,9',1662479999,1630857600,0),(53,1,'213213','<p>12312</p>',1,NULL,1640527819,1640528250,'2121','/notices/icon/1.png','1,3,4','1,2,3,4,5,6,7,8,9',1640534399,1640448000,0);
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-22  0:24:24

update notices set id = id + 10000;
update notices set created = created * 1000000;
update notices set updated = updated * 1000000;