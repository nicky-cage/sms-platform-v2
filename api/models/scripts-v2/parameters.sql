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
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32)  NOT NULL DEFAULT '' COMMENT '参数名称',
  `value` text  COMMENT '参数值',
  `title` varchar(128)  NOT NULL DEFAULT '' COMMENT '参数说明',
  `remark` varchar(256)  NOT NULL DEFAULT '' COMMENT '备注',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `value_default` text  COMMENT '默认内容',
  `value_type` char(16)  DEFAULT 'string' COMMENT 'golang数据类型，暂时只要string int float64',
  `parent_id` int unsigned NOT NULL DEFAULT '0' COMMENT '父级编号',
  `group_id` int unsigned NOT NULL DEFAULT '0' COMMENT '参数组编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100100 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameters`
--

LOCK TABLES `parameters` WRITE;
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` VALUES (1,'phone-number','2','手机验证码1','1为必填, 2为非必填不可见, 3为必填不可见',0,NULL,'string',0,1),(2,'cards-number','1','银行卡验证2','1为必填, 2为非必填不可见, 3为必填不可见',0,NULL,'string',0,1),(3,'email-number','3','邮箱验证码3','1为必填, 2为非必填不可见, 3为必填不可见',0,NULL,'string',0,1),(4,'asdaasd','asd','临时测试数据','12',12,NULL,'string',0,4),(5,'ky_api_url','https://api.lsjkc25.com','开元前台游戏链接','api接口连接\n不要带 /channelHandle',1,'https://api.ky026.com','string',0,5),(6,'ky_record_url','https://record.lsjkc25.com','开元拉单游戏url','开元拉单游戏url\n不要带 /getRecordHandle',2,'https://kyrecord.ky026.com','string',0,5),(7,'sys_maintain_flag','0','系统维护标记','系统维护标记\n\n0 表示不开启系统维护\n非0 表示开启系统维护 并且必须是\"2020-08-05 16:50:00,2020-08-05 18:50:00\" 格式\n注意应用程序还有个使改标记失效的DisableSysMaintain,为true代表系统维护标记无效，主要用于正式环境维护的时候，给测试去测试',1,NULL,'string',0,6),(8,'sys_internal_white_ip_list','127.0.0.1,10.0.0.3,10.0.0.2','系统内部调用ip白名单','127.0.0.1,10.0.0.3,10.0.0.2\n这样的内网ip,最好是 内网ip',1,NULL,'string',0,6),(15,'vip_url','https://tianji.m.pusta.click/phonehtml/vip/index.html','vip特权','',0,NULL,'string',0,7),(16,'invite_url','https://tianji.m.pusta.click/h5static/phonehtml/inviteFriend/index.html','邀请好友','',0,NULL,'string',0,7),(17,'customer_url','https://gsop.chatnow.mstatik.com/widget/standalone.html?eid=bb74bb90c5984fc7e529d113b04e7a7e','客服地址','客服1',0,NULL,'string',0,7),(18,'help_url','https://tianji.m.pusta.click/phonehtml/help/index.html','帮助中心','',0,NULL,'string',0,7),(19,'gift_detail_url','https://tianji.m.pusta.click/h5static/phonehtml/inviteFriend/giftDetails.html','礼金明细','',0,NULL,'string',0,7),(20,'contact_url',NULL,'联系我们','',0,NULL,'string',0,7),(21,'asd','asd','ads','',0,NULL,'string',0,1),(23,'12','12','1212','12',12,NULL,'string',0,2),(24,'about_us_url','https://tianji.m.pusta.click/phonehtml/aboutUs/index.html','关于我们','',0,NULL,'string',0,7),(25,'customer_service','https://www.tidio.com/talk/watmmahm0j4wnmae04a3pkktuuls4m5d','AI客服','',0,NULL,'string',0,8),(27,'message_channel','1','首选通道','0为关闭 1为开启',0,NULL,'int',0,9),(29,'customer_server_url','https://gsop.chatnow.mstatik.com/widget/standalone.html?eid=bb74bb90c5984fc7e529d113b04e7a7e','客服地址','',0,NULL,'string',0,10),(30,'customer_server_name','客服','客服名称','',1,NULL,'string',0,10),(31,'-','-','-','',0,NULL,'string',0,10),(32,'customer_name','客服','客服名称','',0,NULL,'string',0,7),(33,'qq','8888877','QQ','QQ号码',0,NULL,'string',0,12),(34,'wechat','geiwim30391','微信','微信号码',0,NULL,'string',0,12),(35,'skype','8888877','SKYPE','skype号码',0,NULL,'string',0,12),(36,'common_activity_url','https://tianji.m.pusta.click/phonehtml/activityDetails/index.html','活动链接','',0,NULL,'string',0,7),(37,'withdraw_cost','0.2','提款行政费','',0,NULL,'float64',0,13),(38,'deposit_cost','0.1','存款手续费','',0,NULL,'float64',0,14),(39,'message_channel_spare','0','备用通道','0为关闭 1为开启',0,NULL,'int',0,9),(40,'message_channel_second','0','次用通道	','0为关闭 1为开启',0,NULL,'int',0,9),(41,'agent_number','1231321','代理合作咨询','',0,NULL,'string',0,15),(44,'leader_num','21231312dfs','导师联系方式','',0,NULL,'string',0,15),(45,'chat_app','www.baiodu.com','聊天软件','',0,NULL,'string',0,15),(46,'online_service','www.bao.com','在线客服','',0,NULL,'string',0,15),(47,'we_chat','12312321','微信号码','',0,NULL,'string',0,15),(48,'qq_number','12312','QQ号码','',0,NULL,'string',0,15),(49,'auto_rate_withdraw','2','提款自动获取汇率','',0,NULL,'string',0,6),(50,'min_withdraw','100','单次最小提款金额','',0,NULL,'string',0,16),(51,'max_withdraw','99999','单次最大提款金额','',0,NULL,'string',0,16),(52,'max_withdraw_day','99999.00','单日最大提款金额','',0,NULL,'string',0,6),(53,'withdraw_usdt_min','300.00','单次最小USDT提款金额','',0,NULL,'string',0,6),(54,'withdraw_usdt_max','10000.00','单次最大USDT提款金额','',0,NULL,'string',0,6),(55,'withdraw_usdt_max_day','10000.00','单日最大USDT提款金额','',0,NULL,'string',0,6),(57,'withdraw_rate_float','0.40','提款浮动汇率','',0,NULL,'string',0,6),(58,'withdraw_auto_rate','1','提款自动获取汇率','',0,NULL,'string',0,6),(59,'withdraw_fixed_rate','6.5','提款固定汇率','',0,NULL,'string',0,6),(60,'en','en','英语','',0,NULL,'string',0,18),(61,'vi','vi','越南','',0,NULL,'string',0,18),(62,'th','th','泰国','',0,NULL,'string',0,18);
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-21 16:25:50

UPDATE parameters SET id = id + 100000;
update parameters set group_id = group_id + 10000;
