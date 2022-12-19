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
-- Table structure for table `merchants`
--

DROP TABLE IF EXISTS `merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '登录名称',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `salt` char(32) NOT NULL DEFAULT '' COMMENT '密钥',
  `merchant_code` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户编码',
  `payment_secret` char(32) NOT NULL DEFAULT '' COMMENT '支付密码',
  `phone` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号码',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT '电子邮件',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态 0:停用;1:启用;',
  `last_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `last_login` bigint unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `login_count` int unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `merchant_type` tinyint NOT NULL DEFAULT '1' COMMENT '商户类型 1:直属商户;2:非直属商户;',
  `pay_in` tinyint NOT NULL DEFAULT '0' COMMENT '入款权限 0:停用;1:启用;',
  `pay_out` tinyint NOT NULL DEFAULT '0' COMMENT '出款权限 0:停用;1:启用;',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(250) NOT NULL DEFAULT '' COMMENT '备注',
  `agent_id` int NOT NULL DEFAULT '0' COMMENT '上级代理',
  `agent_name` varchar(32) NOT NULL DEFAULT '' COMMENT '上级代理名称',
  `allow_ip` varchar(256) NOT NULL DEFAULT '' COMMENT '授权IP',
  `parent_id` int DEFAULT '0',
  `parent_path` varchar(256) DEFAULT NULL,
  `parent_name` varchar(32) DEFAULT '',
  `google_verify` tinyint NOT NULL DEFAULT '1' COMMENT '谷歌验证 0:禁用; 1:启用;',
  `google_secret` varchar(256) NOT NULL DEFAULT '' COMMENT '谷歌密钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `merchant_code` (`merchant_code`),
  UNIQUE KEY `merchant_name` (`merchant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=180000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchants`
--

LOCK TABLES `merchants` WRITE;
/*!40000 ALTER TABLE `merchants` DISABLE KEYS */;
INSERT INTO `merchants` VALUES (3,'shipu_ty','3bb4fffe00496981991e9dd1ec663484','AcLOF74n2BtCaSCxMDX2IFVt631vDifU','MER2021042114441226','天际体育','','13911113333','tianji@gmail.com',1,'',0,0,1601537986,1618987452,1,1,1,0,'天际体育平台',0,'','127.0.0.1',0,'0','',0,''),(4,'Niclolas001','0a445cc43a9f51e31aa172675c353402','wgHpg9Ehe3WP123OmOeI2Hbu3yEXOnVO','MER2021042114450827','恒大体育','','13555555555','001111111@qq.com',1,'',0,0,1603691081,1660114696,2,1,1,0,'恒大体育平台  - 测试',0,'','127.0.0.1',0,'0','',0,''),(5,'Niclolas002','3908e0fd80919c507ac48ff9d4316d35','zzZWlRZR3MZ23iWueiCfCCsIldy833Fi','MER2021072916052898','山水体育','','13566666666','002222222@qq.com',1,'',0,0,1603691203,1627545928,2,1,1,0,'包网 - 山水体育平台',0,'','127.0.0.1',0,'23,3','',0,''),(6,'venice','f68356338e5968245f70031d017ed883','62bv4BxsUxPx2a6bov9BGhBDcMtd1k9f','MER2021060313441254','威尼斯人','','13193939191','venice@gmail.com',1,'',0,0,1622699039,1622699052,2,1,1,0,'aa',0,'','127.0.0.1',0,'0','',0,''),(7,'xingkong','996b792c1e33d8845ea2d208fdeb790f','3Hm1Lx1RrUIa6uN41kYjoqt6tQ3I9zSE','MER2021072916051886','星空体育','','13691919239','aa@gg.com',1,'',0,0,1627545910,1627545918,2,1,1,0,'星空体育',0,'','127.0.0.1',0,'23,3,5','',0,''),(23,'admin','5dec50723d53dfbed58cafbf47045196','wIncQAqrHIP5o5ZIO0FhXIspUNqRd3BM','MER0','MERadmin','','','',1,'',1660545801,10,0,1660545801,1,0,0,0,'',0,'','127.0.0.1',0,'0','',0,''),(24,'MERNiclolas888','6e2231f8d02e4d6efa3118b5650c83a8','v9JBlxvLtYzW33Hd43n4V8VkICiwSUbe','MER1604167070','MERNiclolas888','','','',1,'',0,0,0,0,1,0,0,0,'',0,'','127.0.0.1',0,'0','',0,''),(25,'MERNiclolas001','dec81a43d6ce14b1f197a743f0bbfb21','26nSWkOILNs9sHrnM1ppmT23z9Ajp4fo','MER1604167120','MERNiclolas001','','','',1,'',0,0,0,0,1,0,0,0,'',0,'','127.0.0.1',0,'0','',0,''),(35,'bond1','3f46195d1d32477575d1201a775c4695','ps3LF1BSPyctZZIdHIpABFANw5jlo4vf','MER2022081620162639','bond1','','123123','123@qq.com',1,'',1660656570,1,1660652186,1660656570,1,0,0,0,'1',0,'','',0,'23','',0,''),(36,'bond2','76c9c7b4df69215c51da40c6091a2d67','dp2ghofr9cy1MEEyoeAs7Uc0qNUYOdvK','MER2022081621312512','bond2','','12313','123@qq.com',1,'',1663740888,2,1660656685,1663740888,1,1,1,0,'',0,'','',0,'23,35','',0,''),(37,'ceshi111','0b13f89ab15b164393ce0d570757070d','zCXNztCLVObPJVNds4AhkleAafA9D56G','MER2022091915563627','ceshi','','11111111111','ddd@qq.com',1,'',1663581385,1,1663574196,1665382938,1,1,1,0,'',0,'','',3,'23','shipu_ty',1,'');
/*!40000 ALTER TABLE `merchants` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:31:30

update merchants set id = id + 100000;
update merchants set created = created * 1000000;
update merchants set updated = updated * 1000000;
update merchants set last_login = last_login * 1000000;
