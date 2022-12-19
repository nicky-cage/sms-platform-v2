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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32)  NOT NULL DEFAULT '' COMMENT '管理员名称',
  `password` char(32)  NOT NULL DEFAULT '' COMMENT '密码',
  `salt` char(32)  NOT NULL DEFAULT '' COMMENT '安全验证',
  `role_id` int DEFAULT '0' COMMENT '管理员所属角色ID',
  `role_name` varchar(64)  DEFAULT '' COMMENT '管理员所属角色名称',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `deleted` bigint unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `allow_ip` varchar(256)  COMMENT '允许访问IP',
  `login_count` int unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login` bigint unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `last_ip` varchar(64)  NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `mail` varchar(256)  NOT NULL DEFAULT '' COMMENT '邮箱账号',
  `nickname` varchar(32)  NOT NULL DEFAULT '' COMMENT '昵称',
  `google_code` tinyint NOT NULL DEFAULT '0' COMMENT '启用谷歌证',
  `google_secret` varchar(64)  NOT NULL DEFAULT '' COMMENT '谷歌密钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `admin_name_unique` (`name`) USING BTREE COMMENT '管理员唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1001,'admin','5f47b491538c1fdf40897d6cafdd5a75',78,'超级管理员',2,1592546402,1665233998,0,'127.0.0.1','ILQJvXrqjp7Ghe3bZHzM2djPq5kIR15c',1075,1665233998,'127.0.0.1','jamesfish188@gmail.com','超级管理员',2,'SY52GRE3BLQJFPKFH6VJTC4NWJIPK53R');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:25:22

update admins set created = created * 1000000;
update admins set updated = updated * 1000000;
update admins set deleted = deleted * 1000000;
update admins set last_login = last_login * 1000000;