-- MySQL dump 10.13  Distrib 8.0.31, for macos12.6 (arm64)
--
-- Host: localhost    Database: sms_system
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
-- Table structure for table `admin_login_logs`
--

DROP TABLE IF EXISTS `admin_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_login_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `admin_name` varchar(32) NOT NULL DEFAULT '0' COMMENT '管理员名称',
  `created` bigint NOT NULL DEFAULT '0' COMMENT '创建时间',
  `ip` varchar(256) NOT NULL DEFAULT '' COMMENT 'IP地址',
  `user_agent` varchar(512) NOT NULL DEFAULT '' COMMENT '代理信息',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `admin_name` (`admin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_login_logs`
--

LOCK TABLES `admin_login_logs` WRITE;
/*!40000 ALTER TABLE `admin_login_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_logs`
--

DROP TABLE IF EXISTS `admin_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `admin_name` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `level` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '日志级别',
  `type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '日志类型',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT '调用地址',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `remark` varchar(20) NOT NULL DEFAULT '' COMMENT '备注',
  `object_id` int NOT NULL DEFAULT '0' COMMENT '对象编号',
  `object_name` varchar(64) NOT NULL DEFAULT '' COMMENT '对象名称',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT '模块',
  PRIMARY KEY (`id`,`created`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3
/*!50100 PARTITION BY RANGE (`created`)
(PARTITION P202210 VALUES LESS THAN (1667232000000000) ENGINE = InnoDB,
 PARTITION P202211 VALUES LESS THAN (1669824000000000) ENGINE = InnoDB,
 PARTITION P202212 VALUES LESS THAN (1672502400000000) ENGINE = InnoDB,
 PARTITION P202301 VALUES LESS THAN (1675180800000000) ENGINE = InnoDB,
 PARTITION P202302 VALUES LESS THAN (1677600000000000) ENGINE = InnoDB,
 PARTITION P202303 VALUES LESS THAN (1680278400000000) ENGINE = InnoDB,
 PARTITION P202304 VALUES LESS THAN (1682870400000000) ENGINE = InnoDB,
 PARTITION P202305 VALUES LESS THAN (1685548800000000) ENGINE = InnoDB,
 PARTITION P202306 VALUES LESS THAN (1688140800000000) ENGINE = InnoDB,
 PARTITION P202307 VALUES LESS THAN (1690819200000000) ENGINE = InnoDB,
 PARTITION P202308 VALUES LESS THAN (1693497600000000) ENGINE = InnoDB,
 PARTITION P202309 VALUES LESS THAN (1696089600000000) ENGINE = InnoDB,
 PARTITION P202310 VALUES LESS THAN (1698768000000000) ENGINE = InnoDB,
 PARTITION P202311 VALUES LESS THAN (1701360000000000) ENGINE = InnoDB,
 PARTITION P202312 VALUES LESS THAN (1704038400000000) ENGINE = InnoDB,
 PARTITION P202401 VALUES LESS THAN (1706716800000000) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_logs`
--

LOCK TABLES `admin_logs` WRITE;
/*!40000 ALTER TABLE `admin_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_roles`
--

DROP TABLE IF EXISTS `admin_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `permission_list` text COMMENT '权限描述JSON',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `menu_ids` text COMMENT '菜单编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_roles`
--

LOCK TABLES `admin_roles` WRITE;
/*!40000 ALTER TABLE `admin_roles` DISABLE KEYS */;
INSERT INTO `admin_roles` VALUES (1078,'超级管理员','超级管理员','1000,1018,1115,1143,1151,1177,1199,1220,1239,1312,1313,1314,1315,1316,1317,1318,1319,1320,1321,1322,1323,1324,1325,1326,1327,1328,1329,1330,1331,1332,1333,1334,1335,1336,1337,1338,1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365,1366,1367,1368,1369,1370,1371,1372,1373',0,1604141617000000,NULL),(1082,'商户管理员','商户管理员','1000,1312,1018,1313,1314,1315,1316,1317,1318,1319,1323,1115,1320,1321,1322,1324,1325,1143,1327,1329,1151,1330,1331,1332,1333,1334,1335,1336,1337,1177,1338,1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,1199,1353,1354',1604157577000000,1604162084000000,NULL);
/*!40000 ALTER TABLE `admin_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '管理员名称',
  `password` char(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` char(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '安全验证',
  `role_id` int DEFAULT '0' COMMENT '管理员所属角色ID',
  `role_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '' COMMENT '管理员所属角色名称',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `deleted` bigint unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `allow_ip` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '允许访问IP',
  `login_count` int unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login` bigint unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `last_ip` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `mail` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱账号',
  `nickname` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `google_code` tinyint NOT NULL DEFAULT '0' COMMENT '启用谷歌证',
  `google_secret` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '谷歌密钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `admin_name_unique` (`name`) USING BTREE COMMENT '管理员唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1001,'admin','5f47b491538c1fdf40897d6cafdd5a75','78',0,'2',255,1665233998000000,0,127000000,'ILQJvXrqjp7Ghe3bZHzM2djPq5kIR15c',1075,1665233998000000,'127.0.0.1','jamesfish188@gmail.com','超级管理员',2,'SY52GRE3BLQJFPKFH6VJTC4NWJIPK53R');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `code` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `remark` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `state` tinyint unsigned NOT NULL DEFAULT '0',
  `sort` tinyint unsigned NOT NULL DEFAULT '0',
  `icon` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标',
  `image` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=10202 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` VALUES (10001,'国家开发银行','CDB','国家开发银行',0,0,'','/frontend/bank/CDB.png'),(10002,'中国工商银行','ICBC','中国工商银行',1,2,'/uploads/2020/10/29/QnXgVTXbKwdIj8xe-icbc.png','/frontend/bank/ICBC.png'),(10003,'中国农业银行','ABC','中国农业银行',1,3,'/uploads/2020/10/29/hwjkRyCnSEzHsupX.png','/frontend/bank/ABC.png'),(10004,'中国银行','BOC','中国银行',1,1,'/uploads/2020/10/29/sipfJfSa4XHcX8WR-boc.png','/frontend/bank/BOC.png'),(10005,'中国建设银行','CCB','中国建设银行',1,4,'/uploads/2020/10/29/RffvRghi80uf6iwX-ccb.png','/frontend/bank/CCB.png'),(10006,'中国邮政储蓄银行','PSBC','中国邮政储蓄银行',1,12,'/uploads/2020/10/29/JEocAsxvqkk7vHAV-psbc.png','/frontend/bank/PSBC.png'),(10007,'交通银行','COMM','交通银行',1,7,'/uploads/2020/10/29/zenYRzcWAyF5hkjq-bocom.png','/frontend/bank/COMM.png'),(10008,'招商银行','CMB','招商银行',1,5,'/uploads/2020/10/29/vSKCIDMuzLDRYnpH-cmb.png','/frontend/bank/CMB.png'),(10009,'上海浦东发展银行','SPDB','上海浦东发展银行',1,17,'','/frontend/bank/SPDB.png'),(10010,'兴业银行','CIB','兴业银行',1,16,'','/frontend/bank/CIB.png'),(10011,'华夏银行','HXBANK','华夏银行',1,9,'','/frontend/bank/HXBANK.png'),(10012,'广东发展银行','GDB','广东发展银行',1,18,'','/frontend/bank/GDB.png'),(10013,'中国民生银行','CMBC','中国民生银行',1,6,'','/frontend/bank/CMBC.png'),(10014,'中信银行','CITIC','中信银行',1,13,'/uploads/2020/10/29/ZTgaStjHkWeEoeO8-cncb.png','/frontend/bank/CITIC.png'),(10015,'中国光大银行','CEB','中国光大银行',1,14,'/uploads/2020/10/29/WN0gO2viC4QBgZwU-gdb.png','/frontend/bank/CEB.png'),(10016,'恒丰银行','EGBANK','恒丰银行',0,0,'','/frontend/bank/EGBANK.png'),(10017,'浙商银行','CZBANK','浙商银行',0,0,'','/frontend/bank/CZBANK.png'),(10018,'渤海银行','BOHAIB','渤海银行',0,0,'','/frontend/bank/BOHAIB.png'),(10019,'平安银行','SPABANK','平安银行',1,10,'','/frontend/bank/SPABANK.png'),(10020,'上海农村商业银行','SHRCB','上海农村商业银行',0,0,'','/frontend/bank/SHRCB.png'),(10021,'玉溪市商业银行','YXCCB','玉溪市商业银行',0,0,'','/frontend/bank/YXCCB.png'),(10022,'尧都农商行','YDRCB','尧都农商行',0,0,'','/frontend/bank/YDRCB.png'),(10023,'北京银行','BJBANK','北京银行',0,0,'','/uploads/2021/02/05/oFV3fn7nRozVxgYn-images.jpeg'),(10024,'上海银行','SHBANK','上海银行',0,0,'','/frontend/bank/SHBANK.png'),(10025,'江苏银行','JSBANK','江苏银行',0,0,'','/frontend/bank/JSBANK.png'),(10026,'杭州银行','HZCB','杭州银行',0,0,'','/frontend/bank/HZCB.png'),(10027,'南京银行','NJCB','南京银行',0,0,'','/frontend/bank/NJCB.png'),(10028,'宁波银行','NBBANK','宁波银行',0,0,'','/frontend/bank/NBBANK.png'),(10029,'徽商银行','HSBANK','徽商银行',0,0,'','/uploads/2021/02/05/AbPOGDZkfwWq6sIb-images.jpeg'),(10030,'长沙银行','CSCB','长沙银行',0,0,'','/frontend/bank/CSCB.png'),(10031,'成都银行','CDCB','成都银行',1,15,'','/frontend/bank/CDCB.png'),(10032,'重庆银行','CQBANK','重庆银行',0,0,'','/frontend/bank/CQBANK.png'),(10033,'大连银行','DLB','大连银行',0,0,'','/frontend/bank/DLB.png'),(10034,'南昌银行','NCB','南昌银行',0,0,'','/frontend/bank/NCB.png'),(10035,'福建海峡银行','FJHXBC','福建海峡银行',0,0,'','/frontend/bank/FJHXBC.png'),(10036,'汉口银行','HKB','汉口银行',0,0,'','/frontend/bank/HKB.png'),(10037,'温州银行','WZCB','温州银行',0,0,'','/frontend/bank/WZCB.png'),(10038,'青岛银行','QDCCB','青岛银行',1,11,'','/frontend/bank/QDCCB.png'),(10039,'台州银行','TZCB','台州银行',0,0,'','/frontend/bank/TZCB.png'),(10040,'嘉兴银行','JXBANK','嘉兴银行',0,0,'','/frontend/bank/JXBANK.png'),(10041,'常熟农村商业银行','CSRCB','常熟农村商业银行',0,0,'','/frontend/bank/CSRCB.png'),(10042,'南海农村信用联社','NHB','南海农村信用联社',0,0,'','/frontend/bank/NHB.png'),(10043,'常州农村信用联社','CZRCB','常州农村信用联社',0,0,'','/frontend/bank/CZRCB.png'),(10044,'内蒙古银行','H3CB','内蒙古银行',0,0,'','/frontend/bank/H3CB.png'),(10045,'绍兴银行','SXCB','绍兴银行',0,0,'','/frontend/bank/SXCB.png'),(10046,'顺德农商银行','SDEB','顺德农商银行',0,0,'','/frontend/bank/SDEB.png'),(10047,'吴江农商银行','WJRCB','吴江农商银行',0,0,'','/frontend/bank/WJRCB.png'),(10048,'齐商银行','ZBCB','齐商银行',0,0,'','/frontend/bank/ZBCB.png'),(10049,'贵阳市商业银行','GYCB','贵阳市商业银行',0,0,'','/frontend/bank/GYCB.png'),(10050,'遵义市商业银行','ZYCBANK','遵义市商业银行',0,0,'','/frontend/bank/ZYCBANK.png'),(10051,'湖州市商业银行','HZCCB','湖州市商业银行',0,0,'','/frontend/bank/HZCCB.png'),(10052,'龙江银行','DAQINGB','龙江银行',0,0,'','/frontend/bank/DAQINGB.png'),(10053,'晋城银行JCBANK','JINCHB','晋城银行JCBANK',0,0,'','/frontend/bank/JINCHB.png'),(10054,'浙江泰隆商业银行','ZJTLCB','浙江泰隆商业银行',0,0,'','/frontend/bank/ZJTLCB.png'),(10055,'广东省农村信用社联合社','GDRCC','广东省农村信用社联合社',0,0,'','/frontend/bank/GDRCC.png'),(10056,'东莞农村商业银行','DRCBCL','东莞农村商业银行',0,0,'','/frontend/bank/DRCBCL.png'),(10057,'浙江民泰商业银行','MTBANK','浙江民泰商业银行',0,0,'','/frontend/bank/MTBANK.png'),(10058,'广州银行','GCB','广州银行',1,8,'','/frontend/bank/GCB.png'),(10059,'辽阳市商业银行','LYCB','辽阳市商业银行',0,0,'','/frontend/bank/LYCB.png'),(10060,'江苏省农村信用联合社','JSRCU','江苏省农村信用联合社',0,0,'','/frontend/bank/JSRCU.png'),(10061,'廊坊银行','LANGFB','廊坊银行',0,0,'','/frontend/bank/LANGFB.png'),(10062,'浙江稠州商业银行','CZCB','浙江稠州商业银行',0,0,'','/frontend/bank/CZCB.png'),(10063,'德阳商业银行','DYCB','德阳商业银行',0,0,'','/frontend/bank/DYCB.png'),(10064,'晋中市商业银行','JZBANK','晋中市商业银行',0,0,'','/frontend/bank/JZBANK.png'),(10065,'苏州银行','BOSZ','苏州银行',0,0,'','/frontend/bank/BOSZ.png'),(10066,'桂林银行','GLBANK','桂林银行',0,0,'','/frontend/bank/GLBANK.png'),(10067,'乌鲁木齐市商业银行','URMQCCB','乌鲁木齐市商业银行',0,0,'','/frontend/bank/URMQCCB.png'),(10068,'成都农商银行','CDRCB','成都农商银行',0,0,'','/frontend/bank/CDRCB.png'),(10069,'张家港农村商业银行','ZRCBANK','张家港农村商业银行',0,0,'','/frontend/bank/ZRCBANK.png'),(10070,'东莞银行','BOD','东莞银行',0,0,'','/frontend/bank/BOD.png'),(10071,'莱商银行','LSBANK','莱商银行',0,0,'','/frontend/bank/LSBANK.png'),(10072,'北京农村商业银行','BJRCB','北京农村商业银行',0,0,'','/frontend/bank/BJRCB.png'),(10073,'天津农商银行','TRCB','天津农商银行',0,0,'','/frontend/bank/TRCB.png'),(10074,'上饶银行','SRBANK','上饶银行',0,0,'','/frontend/bank/SRBANK.png'),(10075,'富滇银行','FDB','富滇银行',0,0,'','/frontend/bank/FDB.png'),(10076,'重庆农村商业银行','CRCBANK','重庆农村商业银行',0,0,'','/frontend/bank/CRCBANK.png'),(10077,'鞍山银行','ASCB','鞍山银行',0,0,'','/frontend/bank/ASCB.png'),(10078,'宁夏银行','NXBANK','宁夏银行',0,0,'','/frontend/bank/NXBANK.png'),(10079,'河北银行','BHB','河北银行',0,0,'','/frontend/bank/BHB.png'),(10080,'华融湘江银行','HRXJB','华融湘江银行',0,0,'','/frontend/bank/HRXJB.png'),(10081,'自贡市商业银行','ZGCCB','自贡市商业银行',0,0,'','/frontend/bank/ZGCCB.png'),(10082,'云南省农村信用社','YNRCC','云南省农村信用社',0,0,'','/frontend/bank/YNRCC.png'),(10083,'吉林银行','JLBANK','吉林银行',0,0,'','/frontend/bank/JLBANK.png'),(10084,'东营市商业银行','DYCCB','东营市商业银行',0,0,'','/frontend/bank/DYCCB.png'),(10085,'昆仑银行','KLB','昆仑银行',0,0,'','/frontend/bank/KLB.png'),(10086,'鄂尔多斯银行','ORBANK','鄂尔多斯银行',0,0,'','/frontend/bank/ORBANK.png'),(10087,'邢台银行','XTB','邢台银行',0,0,'','/frontend/bank/XTB.png'),(10088,'晋商银行','JSB','晋商银行',0,0,'','/frontend/bank/JSB.png'),(10089,'天津银行','TCCB','天津银行',0,0,'','/frontend/bank/TCCB.png'),(10090,'营口银行','BOYK','营口银行',0,0,'','/frontend/bank/BOYK.png'),(10091,'吉林农信','JLRCU','吉林农信',0,0,'','/frontend/bank/JLRCU.png'),(10092,'山东农信','SDRCU','山东农信',0,0,'','/frontend/bank/SDRCU.png'),(10093,'西安银行','XABANK','西安银行',0,0,'','/frontend/bank/XABANK.png'),(10094,'河北省农村信用社','HBRCU','河北省农村信用社',0,0,'','/frontend/bank/HBRCU.png'),(10095,'宁夏黄河农村商业银行','NXRCU','宁夏黄河农村商业银行',0,0,'','/frontend/bank/NXRCU.png'),(10096,'贵州省农村信用社','GZRCU','贵州省农村信用社',0,0,'','/frontend/bank/GZRCU.png'),(10097,'阜新银行','FXCB','阜新银行',0,0,'','/frontend/bank/FXCB.png'),(10098,'湖北银行黄石分行','HBHSBANK','湖北银行黄石分行',0,0,'','/frontend/bank/HBHSBANK.png'),(10099,'浙江省农村信用社联合社','ZJNX','浙江省农村信用社联合社',0,0,'','/frontend/bank/ZJNX.png'),(10100,'新乡银行','XXBANK','新乡银行',0,0,'','/frontend/bank/XXBANK.png'),(10101,'湖北银行宜昌分行','HBYCBANK','湖北银行宜昌分行',0,0,'','/frontend/bank/HBYCBANK.png'),(10102,'乐山市商业银行','LSCCB','乐山市商业银行',0,0,'','/frontend/bank/LSCCB.png'),(10103,'江苏太仓农村商业银行','TCRCB','江苏太仓农村商业银行',0,0,'','/frontend/bank/TCRCB.png'),(10104,'驻马店银行','BZMD','驻马店银行',0,0,'','/frontend/bank/BZMD.png'),(10105,'赣州银行','GZB','赣州银行',0,0,'','/frontend/bank/GZB.png'),(10106,'无锡农村商业银行','WRCB','无锡农村商业银行',0,0,'','/frontend/bank/WRCB.png'),(10107,'广西北部湾银行','BGB','广西北部湾银行',0,0,'','/frontend/bank/BGB.png'),(10108,'广州农商银行','GRCB','广州农商银行',0,0,'','/frontend/bank/GRCB.png'),(10109,'江苏江阴农村商业银行','JRCB','江苏江阴农村商业银行',0,0,'','/frontend/bank/JRCB.png'),(10110,'平顶山银行','BOP','平顶山银行',0,0,'','/frontend/bank/BOP.png'),(10111,'泰安市商业银行','TACCB','泰安市商业银行',0,0,'','/frontend/bank/TACCB.png'),(10112,'南充市商业银行','CGNB','南充市商业银行',0,0,'','/frontend/bank/CGNB.png'),(10113,'重庆三峡银行','CCQTGB','重庆三峡银行',0,0,'','/frontend/bank/CCQTGB.png'),(10114,'中山小榄村镇银行','XLBANK','中山小榄村镇银行',0,0,'','/frontend/bank/XLBANK.png'),(10115,'邯郸银行','HDBANK','邯郸银行',0,0,'','/frontend/bank/HDBANK.png'),(10116,'库尔勒市商业银行','KORLABANK','库尔勒市商业银行',0,0,'','/frontend/bank/KORLABANK.png'),(10117,'锦州银行','BOJZ','锦州银行',0,0,'','/frontend/bank/BOJZ.png'),(10118,'齐鲁银行','QLBANK','齐鲁银行',0,0,'','/frontend/bank/QLBANK.png'),(10119,'青海银行','BOQH','青海银行',0,0,'','/frontend/bank/BOQH.png'),(10120,'阳泉银行','YQCCB','阳泉银行',0,0,'','/frontend/bank/YQCCB.png'),(10121,'盛京银行','SJBANK','盛京银行',0,0,'','/frontend/bank/SJBANK.png'),(10122,'抚顺银行','FSCB','抚顺银行',0,0,'','/frontend/bank/FSCB.png'),(10123,'郑州银行','ZZBANK','郑州银行',0,0,'','/frontend/bank/ZZBANK.png'),(10124,'深圳农村商业银行','SRCB','深圳农村商业银行',0,0,'','/frontend/bank/SRCB.png'),(10125,'潍坊银行','BANKWF','潍坊银行',0,0,'','/frontend/bank/BANKWF.png'),(10126,'九江银行','JJBANK','九江银行',0,0,'','/frontend/bank/JJBANK.png'),(10127,'江西省农村信用','JXRCU','江西省农村信用',0,0,'','/frontend/bank/JXRCU.png'),(10128,'河南省农村信用','HNRCU','河南省农村信用',0,0,'','/frontend/bank/HNRCU.png'),(10129,'甘肃省农村信用','GSRCU','甘肃省农村信用',0,0,'','/frontend/bank/GSRCU.png'),(10130,'四川省农村信用','SCRCU','四川省农村信用',0,0,'','/frontend/bank/SCRCU.png'),(10131,'广西省农村信用','GXRCU','广西省农村信用',0,0,'','/frontend/bank/GXRCU.png'),(10132,'陕西信合','SXRCCU','陕西信合',0,0,'','/frontend/bank/SXRCCU.png'),(10133,'武汉农村商业银行','WHRCB','武汉农村商业银行',0,0,'','/frontend/bank/WHRCB.png'),(10134,'宜宾市商业银行','YBCCB','宜宾市商业银行',0,0,'','/frontend/bank/YBCCB.png'),(10135,'昆山农村商业银行','KSRB','昆山农村商业银行',0,0,'','/frontend/bank/KSRB.png'),(10136,'石嘴山银行','SZSBK','石嘴山银行',0,0,'','/frontend/bank/SZSBK.png'),(10137,'衡水银行','HSBK','衡水银行',0,0,'','/frontend/bank/HSBK.png'),(10138,'信阳银行','XYBANK','信阳银行',0,0,'','/frontend/bank/XYBANK.png'),(10139,'鄞州银行','NBYZ','鄞州银行',0,0,'','/frontend/bank/NBYZ.png'),(10140,'张家口市商业银行','ZJKCCB','张家口市商业银行',0,0,'','/frontend/bank/ZJKCCB.png'),(10141,'许昌银行','XCYH','许昌银行',0,0,'','/frontend/bank/XCYH.png'),(10142,'济宁银行','JNBANK','济宁银行',0,0,'','/frontend/bank/JNBANK.png'),(10143,'开封市商业银行','CBKF','开封市商业银行',0,0,'','/frontend/bank/CBKF.png'),(10144,'威海市商业银行','WHCCB','威海市商业银行',0,0,'','/frontend/bank/WHCCB.png'),(10145,'湖北银行','HBC','湖北银行',0,0,'','/frontend/bank/HBC.png'),(10146,'承德银行','BOCD','承德银行',0,0,'','/frontend/bank/BOCD.png'),(10147,'丹东银行','BODD','丹东银行',0,0,'','/frontend/bank/BODD.png'),(10148,'金华银行','JHBANK','金华银行',0,0,'','/frontend/bank/JHBANK.png'),(10149,'朝阳银行','BOCY','朝阳银行',0,0,'','/frontend/bank/BOCY.png'),(10150,'临商银行','LSBC','临商银行',0,0,'','/frontend/bank/LSBC.png'),(10151,'包商银行','BSB','包商银行',0,0,'','/frontend/bank/BSB.png'),(10152,'兰州银行','LZYH','兰州银行',0,0,'','/frontend/bank/LZYH.png'),(10153,'周口银行','BOZK','周口银行',0,0,'','/frontend/bank/BOZK.png'),(10154,'德州银行','DZBANK','德州银行',0,0,'','/frontend/bank/DZBANK.png'),(10155,'三门峡银行','SCCB','三门峡银行',0,0,'','/frontend/bank/SCCB.png'),(10156,'安阳银行','AYCB','安阳银行',0,0,'','/frontend/bank/AYCB.png'),(10157,'安徽省农村信用社','ARCU','安徽省农村信用社',0,0,'','/frontend/bank/ARCU.png'),(10158,'湖北省农村信用社','HURCB','湖北省农村信用社',0,0,'','/frontend/bank/HURCB.png'),(10159,'湖南省农村信用社','HNRCC','湖南省农村信用社',0,0,'','/frontend/bank/HNRCC.png'),(10160,'广东南粤银行','NYNB','广东南粤银行',0,0,'','/frontend/bank/NYNB.png'),(10161,'洛阳银行','LYBANK','洛阳银行',0,0,'','/frontend/bank/LYBANK.png'),(10162,'农信银清算中心','NHQS','农信银清算中心',0,0,'','/frontend/bank/NHQS.png'),(10163,'城市商业银行资金清算中心','CBBQS','城市商业银行资金清算中心',0,0,'','/frontend/bank/CBBQS.png'),(10164,'其他银行','QT','其他银行',1,19,'','/uploads/2021/02/17/vDFVl5KyoCk6FqVn-test.png'),(10200,'aa','aa','123123123123',0,12,'11','11');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市名称',
  `code` char(20) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `province_code` char(20) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `province_code` (`province_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100344 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (100001,'市辖区','110100','110000'),(100002,'市辖区','120100','120000'),(100003,'石家庄市','130100','130000'),(100004,'唐山市','130200','130000'),(100005,'秦皇岛市','130300','130000'),(100006,'邯郸市','130400','130000'),(100007,'邢台市','130500','130000'),(100008,'保定市','130600','130000'),(100009,'张家口市','130700','130000'),(100010,'承德市','130800','130000'),(100011,'沧州市','130900','130000'),(100012,'廊坊市','131000','130000'),(100013,'衡水市','131100','130000'),(100014,'太原市','140100','140000'),(100015,'大同市','140200','140000'),(100016,'阳泉市','140300','140000'),(100017,'长治市','140400','140000'),(100018,'晋城市','140500','140000'),(100019,'朔州市','140600','140000'),(100020,'晋中市','140700','140000'),(100021,'运城市','140800','140000'),(100022,'忻州市','140900','140000'),(100023,'临汾市','141000','140000'),(100024,'吕梁市','141100','140000'),(100025,'呼和浩特市','150100','150000'),(100026,'包头市','150200','150000'),(100027,'乌海市','150300','150000'),(100028,'赤峰市','150400','150000'),(100029,'通辽市','150500','150000'),(100030,'鄂尔多斯市','150600','150000'),(100031,'呼伦贝尔市','150700','150000'),(100032,'巴彦淖尔市','150800','150000'),(100033,'乌兰察布市','150900','150000'),(100034,'兴安盟','152200','150000'),(100035,'锡林郭勒盟','152500','150000'),(100036,'阿拉善盟','152900','150000'),(100037,'沈阳市','210100','210000'),(100038,'大连市','210200','210000'),(100039,'鞍山市','210300','210000'),(100040,'抚顺市','210400','210000'),(100041,'本溪市','210500','210000'),(100042,'丹东市','210600','210000'),(100043,'锦州市','210700','210000'),(100044,'营口市','210800','210000'),(100045,'阜新市','210900','210000'),(100046,'辽阳市','211000','210000'),(100047,'盘锦市','211100','210000'),(100048,'铁岭市','211200','210000'),(100049,'朝阳市','211300','210000'),(100050,'葫芦岛市','211400','210000'),(100051,'长春市','220100','220000'),(100052,'吉林市','220200','220000'),(100053,'四平市','220300','220000'),(100054,'辽源市','220400','220000'),(100055,'通化市','220500','220000'),(100056,'白山市','220600','220000'),(100057,'松原市','220700','220000'),(100058,'白城市','220800','220000'),(100059,'延边朝鲜族自治州','222400','220000'),(100060,'哈尔滨市','230100','230000'),(100061,'齐齐哈尔市','230200','230000'),(100062,'鸡西市','230300','230000'),(100063,'鹤岗市','230400','230000'),(100064,'双鸭山市','230500','230000'),(100065,'大庆市','230600','230000'),(100066,'伊春市','230700','230000'),(100067,'佳木斯市','230800','230000'),(100068,'七台河市','230900','230000'),(100069,'牡丹江市','231000','230000'),(100070,'黑河市','231100','230000'),(100071,'绥化市','231200','230000'),(100072,'大兴安岭地区','232700','230000'),(100073,'市辖区','310100','310000'),(100074,'南京市','320100','320000'),(100075,'无锡市','320200','320000'),(100076,'徐州市','320300','320000'),(100077,'常州市','320400','320000'),(100078,'苏州市','320500','320000'),(100079,'南通市','320600','320000'),(100080,'连云港市','320700','320000'),(100081,'淮安市','320800','320000'),(100082,'盐城市','320900','320000'),(100083,'扬州市','321000','320000'),(100084,'镇江市','321100','320000'),(100085,'泰州市','321200','320000'),(100086,'宿迁市','321300','320000'),(100087,'杭州市','330100','330000'),(100088,'宁波市','330200','330000'),(100089,'温州市','330300','330000'),(100090,'嘉兴市','330400','330000'),(100091,'湖州市','330500','330000'),(100092,'绍兴市','330600','330000'),(100093,'金华市','330700','330000'),(100094,'衢州市','330800','330000'),(100095,'舟山市','330900','330000'),(100096,'台州市','331000','330000'),(100097,'丽水市','331100','330000'),(100098,'合肥市','340100','340000'),(100099,'芜湖市','340200','340000'),(100100,'蚌埠市','340300','340000'),(100101,'淮南市','340400','340000'),(100102,'马鞍山市','340500','340000'),(100103,'淮北市','340600','340000'),(100104,'铜陵市','340700','340000'),(100105,'安庆市','340800','340000'),(100106,'黄山市','341000','340000'),(100107,'滁州市','341100','340000'),(100108,'阜阳市','341200','340000'),(100109,'宿州市','341300','340000'),(100110,'六安市','341500','340000'),(100111,'亳州市','341600','340000'),(100112,'池州市','341700','340000'),(100113,'宣城市','341800','340000'),(100114,'福州市','350100','350000'),(100115,'厦门市','350200','350000'),(100116,'莆田市','350300','350000'),(100117,'三明市','350400','350000'),(100118,'泉州市','350500','350000'),(100119,'漳州市','350600','350000'),(100120,'南平市','350700','350000'),(100121,'龙岩市','350800','350000'),(100122,'宁德市','350900','350000'),(100123,'南昌市','360100','360000'),(100124,'景德镇市','360200','360000'),(100125,'萍乡市','360300','360000'),(100126,'九江市','360400','360000'),(100127,'新余市','360500','360000'),(100128,'鹰潭市','360600','360000'),(100129,'赣州市','360700','360000'),(100130,'吉安市','360800','360000'),(100131,'宜春市','360900','360000'),(100132,'抚州市','361000','360000'),(100133,'上饶市','361100','360000'),(100134,'济南市','370100','370000'),(100135,'青岛市','370200','370000'),(100136,'淄博市','370300','370000'),(100137,'枣庄市','370400','370000'),(100138,'东营市','370500','370000'),(100139,'烟台市','370600','370000'),(100140,'潍坊市','370700','370000'),(100141,'济宁市','370800','370000'),(100142,'泰安市','370900','370000'),(100143,'威海市','371000','370000'),(100144,'日照市','371100','370000'),(100145,'临沂市','371300','370000'),(100146,'德州市','371400','370000'),(100147,'聊城市','371500','370000'),(100148,'滨州市','371600','370000'),(100149,'菏泽市','371700','370000'),(100150,'郑州市','410100','410000'),(100151,'开封市','410200','410000'),(100152,'洛阳市','410300','410000'),(100153,'平顶山市','410400','410000'),(100154,'安阳市','410500','410000'),(100155,'鹤壁市','410600','410000'),(100156,'新乡市','410700','410000'),(100157,'焦作市','410800','410000'),(100158,'濮阳市','410900','410000'),(100159,'许昌市','411000','410000'),(100160,'漯河市','411100','410000'),(100161,'三门峡市','411200','410000'),(100162,'南阳市','411300','410000'),(100163,'商丘市','411400','410000'),(100164,'信阳市','411500','410000'),(100165,'周口市','411600','410000'),(100166,'驻马店市','411700','410000'),(100167,'省直辖县级行政区划','419000','410000'),(100168,'武汉市','420100','420000'),(100169,'黄石市','420200','420000'),(100170,'十堰市','420300','420000'),(100171,'宜昌市','420500','420000'),(100172,'襄阳市','420600','420000'),(100173,'鄂州市','420700','420000'),(100174,'荆门市','420800','420000'),(100175,'孝感市','420900','420000'),(100176,'荆州市','421000','420000'),(100177,'黄冈市','421100','420000'),(100178,'咸宁市','421200','420000'),(100179,'随州市','421300','420000'),(100180,'恩施土家族苗族自治州','422800','420000'),(100181,'省直辖县级行政区划','429000','420000'),(100182,'长沙市','430100','430000'),(100183,'株洲市','430200','430000'),(100184,'湘潭市','430300','430000'),(100185,'衡阳市','430400','430000'),(100186,'邵阳市','430500','430000'),(100187,'岳阳市','430600','430000'),(100188,'常德市','430700','430000'),(100189,'张家界市','430800','430000'),(100190,'益阳市','430900','430000'),(100191,'郴州市','431000','430000'),(100192,'永州市','431100','430000'),(100193,'怀化市','431200','430000'),(100194,'娄底市','431300','430000'),(100195,'湘西土家族苗族自治州','433100','430000'),(100196,'广州市','440100','440000'),(100197,'韶关市','440200','440000'),(100198,'深圳市','440300','440000'),(100199,'珠海市','440400','440000'),(100200,'汕头市','440500','440000'),(100201,'佛山市','440600','440000'),(100202,'江门市','440700','440000'),(100203,'湛江市','440800','440000'),(100204,'茂名市','440900','440000'),(100205,'肇庆市','441200','440000'),(100206,'惠州市','441300','440000'),(100207,'梅州市','441400','440000'),(100208,'汕尾市','441500','440000'),(100209,'河源市','441600','440000'),(100210,'阳江市','441700','440000'),(100211,'清远市','441800','440000'),(100212,'东莞市','441900','440000'),(100213,'中山市','442000','440000'),(100214,'潮州市','445100','440000'),(100215,'揭阳市','445200','440000'),(100216,'云浮市','445300','440000'),(100217,'南宁市','450100','450000'),(100218,'柳州市','450200','450000'),(100219,'桂林市','450300','450000'),(100220,'梧州市','450400','450000'),(100221,'北海市','450500','450000'),(100222,'防城港市','450600','450000'),(100223,'钦州市','450700','450000'),(100224,'贵港市','450800','450000'),(100225,'玉林市','450900','450000'),(100226,'百色市','451000','450000'),(100227,'贺州市','451100','450000'),(100228,'河池市','451200','450000'),(100229,'来宾市','451300','450000'),(100230,'崇左市','451400','450000'),(100231,'海口市','460100','460000'),(100232,'三亚市','460200','460000'),(100233,'三沙市','460300','460000'),(100234,'儋州市','460400','460000'),(100235,'省直辖县级行政区划','469000','460000'),(100236,'市辖区','500100','500000'),(100237,'县','500200','500000'),(100238,'成都市','510100','510000'),(100239,'自贡市','510300','510000'),(100240,'攀枝花市','510400','510000'),(100241,'泸州市','510500','510000'),(100242,'德阳市','510600','510000'),(100243,'绵阳市','510700','510000'),(100244,'广元市','510800','510000'),(100245,'遂宁市','510900','510000'),(100246,'内江市','511000','510000'),(100247,'乐山市','511100','510000'),(100248,'南充市','511300','510000'),(100249,'眉山市','511400','510000'),(100250,'宜宾市','511500','510000'),(100251,'广安市','511600','510000'),(100252,'达州市','511700','510000'),(100253,'雅安市','511800','510000'),(100254,'巴中市','511900','510000'),(100255,'资阳市','512000','510000'),(100256,'阿坝藏族羌族自治州','513200','510000'),(100257,'甘孜藏族自治州','513300','510000'),(100258,'凉山彝族自治州','513400','510000'),(100259,'贵阳市','520100','520000'),(100260,'六盘水市','520200','520000'),(100261,'遵义市','520300','520000'),(100262,'安顺市','520400','520000'),(100263,'毕节市','520500','520000'),(100264,'铜仁市','520600','520000'),(100265,'黔西南布依族苗族自治州','522300','520000'),(100266,'黔东南苗族侗族自治州','522600','520000'),(100267,'黔南布依族苗族自治州','522700','520000'),(100268,'昆明市','530100','530000'),(100269,'曲靖市','530300','530000'),(100270,'玉溪市','530400','530000'),(100271,'保山市','530500','530000'),(100272,'昭通市','530600','530000'),(100273,'丽江市','530700','530000'),(100274,'普洱市','530800','530000'),(100275,'临沧市','530900','530000'),(100276,'楚雄彝族自治州','532300','530000'),(100277,'红河哈尼族彝族自治州','532500','530000'),(100278,'文山壮族苗族自治州','532600','530000'),(100279,'西双版纳傣族自治州','532800','530000'),(100280,'大理白族自治州','532900','530000'),(100281,'德宏傣族景颇族自治州','533100','530000'),(100282,'怒江傈僳族自治州','533300','530000'),(100283,'迪庆藏族自治州','533400','530000'),(100284,'拉萨市','540100','540000'),(100285,'日喀则市','540200','540000'),(100286,'昌都市','540300','540000'),(100287,'林芝市','540400','540000'),(100288,'山南市','540500','540000'),(100289,'那曲市','540600','540000'),(100290,'阿里地区','542500','540000'),(100291,'西安市','610100','610000'),(100292,'铜川市','610200','610000'),(100293,'宝鸡市','610300','610000'),(100294,'咸阳市','610400','610000'),(100295,'渭南市','610500','610000'),(100296,'延安市','610600','610000'),(100297,'汉中市','610700','610000'),(100298,'榆林市','610800','610000'),(100299,'安康市','610900','610000'),(100300,'商洛市','611000','610000'),(100301,'兰州市','620100','620000'),(100302,'嘉峪关市','620200','620000'),(100303,'金昌市','620300','620000'),(100304,'白银市','620400','620000'),(100305,'天水市','620500','620000'),(100306,'武威市','620600','620000'),(100307,'张掖市','620700','620000'),(100308,'平凉市','620800','620000'),(100309,'酒泉市','620900','620000'),(100310,'庆阳市','621000','620000'),(100311,'定西市','621100','620000'),(100312,'陇南市','621200','620000'),(100313,'临夏回族自治州','622900','620000'),(100314,'甘南藏族自治州','623000','620000'),(100315,'西宁市','630100','630000'),(100316,'海东市','630200','630000'),(100317,'海北藏族自治州','632200','630000'),(100318,'黄南藏族自治州','632300','630000'),(100319,'海南藏族自治州','632500','630000'),(100320,'果洛藏族自治州','632600','630000'),(100321,'玉树藏族自治州','632700','630000'),(100322,'海西蒙古族藏族自治州','632800','630000'),(100323,'银川市','640100','640000'),(100324,'石嘴山市','640200','640000'),(100325,'吴忠市','640300','640000'),(100326,'固原市','640400','640000'),(100327,'中卫市','640500','640000'),(100328,'乌鲁木齐市','650100','650000'),(100329,'克拉玛依市','650200','650000'),(100330,'吐鲁番市','650400','650000'),(100331,'哈密市','650500','650000'),(100332,'昌吉回族自治州','652300','650000'),(100333,'博尔塔拉蒙古自治州','652700','650000'),(100334,'巴音郭楞蒙古自治州','652800','650000'),(100335,'阿克苏地区','652900','650000'),(100336,'克孜勒苏柯尔克孜自治州','653000','650000'),(100337,'喀什地区','653100','650000'),(100338,'和田地区','653200','650000'),(100339,'伊犁哈萨克自治州','654000','650000'),(100340,'塔城地区','654200','650000'),(100341,'阿勒泰地区','654300','650000'),(100342,'自治区直辖县级行政区划','659000','650000'),(100343,'asdf','asdf','asdf');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0' COMMENT '国家名称',
  `name_english` varchar(64) NOT NULL DEFAULT '0' COMMENT '英文名称',
  `code` varchar(32) NOT NULL DEFAULT '0' COMMENT '国家代码',
  `phone_prefix` varchar(8) NOT NULL DEFAULT '0' COMMENT '区号前缀',
  `timezone_offset` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '八区偏移',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  `is_support` tinyint NOT NULL DEFAULT '0' COMMENT '是否支持',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `code` (`code`),
  KEY `phone_prefix` (`phone_prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=18192 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (18000,'安哥拉','Angola','AO','244',-7.00,'',0),(18001,'阿富汗','Afghanistan','AF','93',0.00,'',0),(18002,'阿尔巴尼亚','Albania','AL','355',-7.00,'',0),(18003,'阿尔及利亚','Algeria','DZ','213',-8.00,'',0),(18004,'安道尔共和国','Andorra','AD','376',-8.00,'',0),(18005,'安圭拉岛','Anguilla','AI','1264',-12.00,'',0),(18006,'安提瓜和巴布达','Antigua and Barbuda','AG','1268',-12.00,'',0),(18007,'阿根廷','Argentina','AR','54',-11.00,'',0),(18008,'亚美尼亚','Armenia','AM','374',-6.00,'',0),(18009,'阿森松','Ascension',' ','247',-8.00,'',0),(18010,'澳大利亚','Australia','AU','61',2.00,'',0),(18011,'奥地利','Austria','AT','43',-7.00,'',0),(18012,'阿塞拜疆','Azerbaijan','AZ','994',-5.00,'',0),(18013,'巴哈马','Bahamas','BS','1242',-13.00,'',0),(18014,'巴林','Bahrain','BH','973',-5.00,'',0),(18015,'孟加拉国','Bangladesh','BD','880',-2.00,'',0),(18016,'巴巴多斯','Barbados','BB','1246',-12.00,'',0),(18017,'白俄罗斯','Belarus','BY','375',-6.00,'',0),(18018,'比利时','Belgium','BE','32',-7.00,'',0),(18019,'伯利兹','Belize','BZ','501',-14.00,'',0),(18020,'贝宁','Benin','BJ','229',-7.00,'',0),(18021,'百慕大群岛','Bermuda Is.','BM','1441',-12.00,'',0),(18022,'玻利维亚','Bolivia','BO','591',-12.00,'',0),(18023,'博茨瓦纳','Botswana','BW','267',-6.00,'',0),(18024,'巴西','Brazil','BR','55',-11.00,'',0),(18025,'文莱','Brunei','BN','673',0.00,'',0),(18026,'保加利亚','Bulgaria','BG','359',-6.00,'',0),(18027,'布基纳法索','Burkina-faso','BF','226',-8.00,'',0),(18028,'缅甸','Burma','MM','95',-1.30,'',0),(18029,'布隆迪','Burundi','BI','257',-6.00,'',0),(18030,'喀麦隆','Cameroon','CM','237',-7.00,'',0),(18031,'加拿大','Canada','CA','1',-13.00,'',0),(18032,'开曼群岛','Cayman Is.',' ','1345',-13.00,'',0),(18033,'中非共和国','Central African Republic','CF','236',-7.00,'',0),(18034,'乍得','Chad','TD','235',-7.00,'',0),(18035,'智利','Chile','CL','56',-13.00,'',0),(18036,'中国','China','CN','86',0.00,'',1),(18037,'哥伦比亚','Colombia','CO','57',0.00,'',0),(18038,'刚果','Congo','CG','242',-7.00,'',0),(18039,'库克群岛','Cook Is.','CK','682',-18.30,'',0),(18040,'哥斯达黎加','Costa Rica','CR','506',-14.00,'',0),(18041,'古巴','Cuba','CU','53',-13.00,'',0),(18042,'塞浦路斯','Cyprus','CY','357',-6.00,'',0),(18043,'捷克','Czech Republic','CZ','420',-7.00,'',0),(18044,'丹麦','Denmark','DK','45',-7.00,'',0),(18045,'吉布提','Djibouti','DJ','253',-5.00,'',0),(18046,'多米尼加共和国','Dominica Rep.','DO','1890',-13.00,'',0),(18047,'厄瓜多尔','Ecuador','EC','593',-13.00,'',0),(18048,'埃及','Egypt','EG','20',-6.00,'',0),(18049,'萨尔瓦多','EI Salvador','SV','503',-14.00,'',0),(18050,'爱沙尼亚','Estonia','EE','372',-5.00,'',0),(18051,'埃塞俄比亚','Ethiopia','ET','251',-5.00,'',0),(18052,'斐济','Fiji','FJ','679',4.00,'',0),(18053,'芬兰','Finland','FI','358',-6.00,'',0),(18054,'法国','France','FR','33',-8.00,'',0),(18055,'法属圭亚那','French Guiana','GF','594',-12.00,'',0),(18056,'加蓬','Gabon','GA','241',-7.00,'',0),(18057,'冈比亚','Gambia','GM','220',-8.00,'',0),(18058,'格鲁吉亚','Georgia','GE','995',0.00,'',0),(18059,'德国','Germany','DE','49',-7.00,'',0),(18060,'加纳','Ghana','GH','233',-8.00,'',0),(18061,'直布罗陀','Gibraltar','GI','350',-8.00,'',0),(18062,'希腊','Greece','GR','30',-6.00,'',0),(18063,'格林纳达','Grenada','GD','1809',-14.00,'',0),(18064,'关岛','Guam','GU','1671',2.00,'',0),(18065,'危地马拉','Guatemala','GT','502',-14.00,'',0),(18066,'几内亚','Guinea','GN','224',-8.00,'',0),(18067,'圭亚那','Guyana','GY','592',-11.00,'',0),(18068,'海地','Haiti','HT','509',-13.00,'',0),(18069,'洪都拉斯','Honduras','HN','504',-14.00,'',0),(18070,'香港','Hong kong','HK','852',0.00,'',0),(18071,'匈牙利','Hungary','HU','36',-7.00,'',0),(18072,'冰岛','Iceland','IS','354',-9.00,'',0),(18073,'印度','India','IN','91',-2.30,'',0),(18074,'印度尼西亚','Indonesia','ID','62',-0.30,'',0),(18075,'伊朗','Iran','IR','98',-4.30,'',0),(18076,'伊拉克','Iraq','IQ','964',-5.00,'',0),(18077,'爱尔兰','Ireland','IE','353',-4.30,'',0),(18078,'以色列','Israel','IL','972',-6.00,'',0),(18079,'意大利','Italy','IT','39',-7.00,'',0),(18080,'科特迪瓦','Ivory Coast',' ','225',-6.00,'',0),(18081,'牙买加','Jamaica','JM','1876',-12.00,'',0),(18082,'日本','Japan','JP','81',1.00,'',0),(18083,'约旦','Jordan','JO','962',-6.00,'',0),(18084,'柬埔寨','Kampuchea (Cambodia )','KH','855',-1.00,'',0),(18085,'哈萨克斯坦','Kazakhstan','KZ','327',-5.00,'',0),(18086,'肯尼亚','Kenya','KE','254',-5.00,'',0),(18087,'韩国','Korea','KR','82',1.00,'',0),(18088,'科威特','Kuwait','KW','965',-5.00,'',0),(18089,'吉尔吉斯坦','Kyrgyzstan','KG','331',-5.00,'',0),(18090,'老挝','Laos','LA','856',-1.00,'',0),(18091,'拉脱维亚','Latvia','LV','371',-5.00,'',0),(18092,'黎巴嫩','Lebanon','LB','961',-6.00,'',0),(18093,'莱索托','Lesotho','LS','266',-6.00,'',0),(18094,'利比里亚','Liberia','LR','231',-8.00,'',0),(18095,'利比亚','Libya','LY','218',-6.00,'',0),(18096,'列支敦士登','Liechtenstein','LI','423',-7.00,'',0),(18097,'立陶宛','Lithuania','LT','370',-5.00,'',0),(18098,'卢森堡','Luxembourg','LU','352',-7.00,'',0),(18099,'澳门','Macao','MO','853',0.00,'',0),(18100,'马达加斯加','Madagascar','MG','261',-5.00,'',0),(18101,'马拉维','Malawi','MW','265',-6.00,'',0),(18102,'马来西亚','Malaysia','MY','60',-0.50,'',0),(18103,'马尔代夫','Maldives','MV','960',-7.00,'',0),(18104,'马里','Mali','ML','223',-8.00,'',0),(18105,'马耳他','Malta','MT','356',-7.00,'',0),(18106,'马里亚那群岛','Mariana Is',' ','1670',1.00,'',0),(18107,'马提尼克','Martinique',' ','596',-12.00,'',0),(18108,'毛里求斯','Mauritius','MU','230',-4.00,'',0),(18109,'墨西哥','Mexico','MX','52',-15.00,'',0),(18110,'摩尔多瓦','Moldova, Republic of','MD','373',-5.00,'',0),(18111,'摩纳哥','Monaco','MC','377',-7.00,'',0),(18112,'蒙古','Mongolia','MN','976',0.00,'',0),(18113,'蒙特塞拉特岛','Montserrat Is','MS','1664',-12.00,'',0),(18114,'摩洛哥','Morocco','MA','212',-6.00,'',0),(18115,'莫桑比克','Mozambique','MZ','258',-6.00,'',0),(18116,'纳米比亚','Namibia','NA','264',-7.00,'',0),(18117,'瑙鲁','Nauru','NR','674',4.00,'',0),(18118,'尼泊尔','Nepal','NP','977',-2.30,'',0),(18119,'荷属安的列斯','Netherlands Antilles',' ','599',-12.00,'',0),(18120,'荷兰','Netherlands','NL','31',-7.00,'',0),(18121,'新西兰','New Zealand','NZ','64',4.00,'',0),(18122,'尼加拉瓜','Nicaragua','NI','505',-14.00,'',0),(18123,'尼日尔','Niger','NE','227',-8.00,'',0),(18124,'尼日利亚','Nigeria','NG','234',-7.00,'',0),(18125,'朝鲜','North Korea','KP','850',1.00,'',0),(18126,'挪威','Norway','NO','47',-7.00,'',0),(18127,'阿曼','Oman','OM','968',-4.00,'',0),(18128,'巴基斯坦','Pakistan','PK','92',-2.30,'',0),(18129,'巴拿马','Panama','PA','507',-13.00,'',0),(18130,'巴布亚新几内亚','Papua New Cuinea','PG','675',2.00,'',0),(18131,'巴拉圭','Paraguay','PY','595',-12.00,'',0),(18132,'秘鲁','Peru','PE','51',-13.00,'',0),(18133,'菲律宾','Philippines','PH','63',0.00,'',1),(18134,'波兰','Poland','PL','48',-7.00,'',0),(18135,'法属玻利尼西亚','French Polynesia','PF','689',3.00,'',0),(18136,'葡萄牙','Portugal','PT','351',-8.00,'',0),(18137,'波多黎各','Puerto Rico','PR','1787',-12.00,'',0),(18138,'卡塔尔','Qatar','QA','974',-5.00,'',0),(18139,'留尼旺','Reunion',' ','262',-4.00,'',0),(18140,'罗马尼亚','Romania','RO','40',-6.00,'',0),(18141,'俄罗斯','Russia','RU','7',-5.00,'',0),(18142,'圣卢西亚','Saint Lucia','LC','1758',-12.00,'',0),(18143,'圣文森特岛','Saint Vincent','VC','1784',-12.00,'',0),(18144,'东萨摩亚(美)','Samoa Eastern',' ','684',-19.00,'',0),(18145,'西萨摩亚','Samoa Western',' ','685',-19.00,'',0),(18146,'圣马力诺','San Marino','SM','378',-7.00,'',0),(18147,'圣多美和普林西比','Sao Tome and Principe','ST','239',-8.00,'',0),(18148,'沙特阿拉伯','Saudi Arabia','SA','966',-5.00,'',0),(18149,'塞内加尔','Senegal','SN','221',-8.00,'',0),(18150,'塞舌尔','Seychelles','SC','248',-4.00,'',0),(18151,'塞拉利昂','Sierra Leone','SL','232',-8.00,'',0),(18152,'新加坡','Singapore','SG','65',0.30,'',0),(18153,'斯洛伐克','Slovakia','SK','421',-7.00,'',0),(18154,'斯洛文尼亚','Slovenia','SI','386',-7.00,'',0),(18155,'所罗门群岛','Solomon Is','SB','677',3.00,'',0),(18156,'索马里','Somali','SO','252',-5.00,'',0),(18157,'南非','South Africa','ZA','27',-6.00,'',0),(18158,'西班牙','Spain','ES','34',-8.00,'',0),(18159,'斯里兰卡','Sri Lanka','LK','94',0.00,'',0),(18160,'圣卢西亚','St.Lucia','LC','1758',-12.00,'',0),(18161,'圣文森特','St.Vincent','VC','1784',-12.00,'',0),(18162,'苏丹','Sudan','SD','249',-6.00,'',0),(18163,'苏里南','Suriname','SR','597',-11.30,'',0),(18164,'斯威士兰','Swaziland','SZ','268',-6.00,'',0),(18165,'瑞典','Sweden','SE','46',-7.00,'',0),(18166,'瑞士','Switzerland','CH','41',-7.00,'',0),(18167,'叙利亚','Syria','SY','963',-6.00,'',0),(18168,'台湾省','Taiwan','TW','886',0.00,'',0),(18169,'塔吉克斯坦','Tajikistan','TJ','992',-5.00,'',0),(18170,'坦桑尼亚','Tanzania','TZ','255',-5.00,'',0),(18171,'泰国','Thailand','TH','66',-1.00,'',0),(18172,'多哥','Togo','TG','228',-8.00,'',0),(18173,'汤加','Tonga','TO','676',4.00,'',0),(18174,'特立尼达和多巴哥','Trinidad and Tobago','TT','1809',-12.00,'',0),(18175,'突尼斯','Tunisia','TN','216',-7.00,'',0),(18176,'土耳其','Turkey','TR','90',-6.00,'',0),(18177,'土库曼斯坦','Turkmenistan','TM','993',-5.00,'',0),(18178,'乌干达','Uganda','UG','256',-5.00,'',0),(18179,'乌克兰','Ukraine','UA','380',-5.00,'',0),(18180,'阿拉伯联合酋长国','United Arab Emirates','AE','971',-4.00,'',0),(18181,'英国','United Kingdom','GB','44',-8.00,'',0),(18182,'美国','United States of America','US','1',-13.00,'',0),(18183,'乌拉圭','Uruguay','UY','598',-10.30,'',0),(18184,'乌兹别克斯坦','Uzbekistan','UZ','233',-5.00,'',0),(18185,'委内瑞拉','Venezuela','VE','58',-12.30,'',0),(18186,'越南','Vietnam','VN','84',-1.00,'',0),(18187,'也门','Yemen','YE','967',-5.00,'',0),(18188,'南斯拉夫','Yugoslavia','YU','381',-7.00,'',0),(18189,'津巴布韦','Zimbabwe','ZW','263',-6.00,'',0),(18190,'扎伊尔','Zaire','ZR','243',-7.00,'',0),(18191,'赞比亚','Zambia','ZM','260',-6.00,'',0);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_rates`
--

DROP TABLE IF EXISTS `country_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int NOT NULL DEFAULT '0' COMMENT '渠道名称',
  `channel_id` int NOT NULL DEFAULT '0' COMMENT '渠道编码',
  `rate` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '费率',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_id_2` (`country_id`,`channel_id`),
  KEY `country_id` (`country_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_rates`
--

LOCK TABLES `country_rates` WRITE;
/*!40000 ALTER TABLE `country_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `country_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '县区名称',
  `code` char(20) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '县区编码',
  `city_code` char(20) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `city_code` (`city_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1005001 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (1000001,'东城区','110101','110100'),(1000002,'西城区','110102','110100'),(1000003,'朝阳区','110105','110100'),(1000004,'丰台区','110106','110100'),(1000005,'石景山区','110107','110100'),(1000006,'海淀区','110108','110100'),(1000007,'门头沟区','110109','110100'),(1000008,'房山区','110111','110100'),(1000009,'通州区','110112','110100'),(1000010,'顺义区','110113','110100'),(1000011,'昌平区','110114','110100'),(1000012,'大兴区','110115','110100'),(1000013,'怀柔区','110116','110100'),(1000014,'平谷区','110117','110100'),(1000015,'密云区','110118','110100'),(1000016,'延庆区','110119','110100'),(1000017,'和平区','120101','120100'),(1000018,'河东区','120102','120100'),(1000019,'河西区','120103','120100'),(1000020,'南开区','120104','120100'),(1000021,'河北区','120105','120100'),(1000022,'红桥区','120106','120100'),(1000023,'东丽区','120110','120100'),(1000024,'西青区','120111','120100'),(1000025,'津南区','120112','120100'),(1000026,'北辰区','120113','120100'),(1000027,'武清区','120114','120100'),(1000028,'宝坻区','120115','120100'),(1000029,'滨海新区','120116','120100'),(1000030,'宁河区','120117','120100'),(1000031,'静海区','120118','120100'),(1000032,'蓟州区','120119','120100'),(1000033,'长安区','130102','130100'),(1000034,'桥西区','130104','130100'),(1000035,'新华区','130105','130100'),(1000036,'井陉矿区','130107','130100'),(1000037,'裕华区','130108','130100'),(1000038,'藁城区','130109','130100'),(1000039,'鹿泉区','130110','130100'),(1000040,'栾城区','130111','130100'),(1000041,'井陉县','130121','130100'),(1000042,'正定县','130123','130100'),(1000043,'行唐县','130125','130100'),(1000044,'灵寿县','130126','130100'),(1000045,'高邑县','130127','130100'),(1000046,'深泽县','130128','130100'),(1000047,'赞皇县','130129','130100'),(1000048,'无极县','130130','130100'),(1000049,'平山县','130131','130100'),(1000050,'元氏县','130132','130100'),(1000051,'赵县','130133','130100'),(1000052,'石家庄高新技术产业开发区','130171','130100'),(1000053,'石家庄循环化工园区','130172','130100'),(1000054,'辛集市','130181','130100'),(1000055,'晋州市','130183','130100'),(1000056,'新乐市','130184','130100'),(1000057,'路南区','130202','130200'),(1000058,'路北区','130203','130200'),(1000059,'古冶区','130204','130200'),(1000060,'开平区','130205','130200'),(1000061,'丰南区','130207','130200'),(1000062,'丰润区','130208','130200'),(1000063,'曹妃甸区','130209','130200'),(1000064,'滦南县','130224','130200'),(1000065,'乐亭县','130225','130200'),(1000066,'迁西县','130227','130200'),(1000067,'玉田县','130229','130200'),(1000068,'河北唐山芦台经济开发区','130271','130200'),(1000069,'唐山市汉沽管理区','130272','130200'),(1000070,'唐山高新技术产业开发区','130273','130200'),(1000071,'河北唐山海港经济开发区','130274','130200'),(1000072,'遵化市','130281','130200'),(1000073,'迁安市','130283','130200'),(1000074,'滦州市','130284','130200'),(1000075,'海港区','130302','130300'),(1000076,'山海关区','130303','130300'),(1000077,'北戴河区','130304','130300'),(1000078,'抚宁区','130306','130300'),(1000079,'青龙满族自治县','130321','130300'),(1000080,'昌黎县','130322','130300'),(1000081,'卢龙县','130324','130300'),(1000082,'秦皇岛市经济技术开发区','130371','130300'),(1000083,'北戴河新区','130372','130300'),(1000084,'邯山区','130402','130400'),(1000085,'丛台区','130403','130400'),(1000086,'复兴区','130404','130400'),(1000087,'峰峰矿区','130406','130400'),(1000088,'肥乡区','130407','130400'),(1000089,'永年区','130408','130400'),(1000090,'临漳县','130423','130400'),(1000091,'成安县','130424','130400'),(1000092,'大名县','130425','130400'),(1000093,'涉县','130426','130400'),(1000094,'磁县','130427','130400'),(1000095,'邱县','130430','130400'),(1000096,'鸡泽县','130431','130400'),(1000097,'广平县','130432','130400'),(1000098,'馆陶县','130433','130400'),(1000099,'魏县','130434','130400'),(1000100,'曲周县','130435','130400'),(1000101,'邯郸经济技术开发区','130471','130400'),(1000102,'邯郸冀南新区','130473','130400'),(1000103,'武安市','130481','130400'),(1000104,'襄都区','130502','130500'),(1000105,'信都区','130503','130500'),(1000106,'任泽区','130505','130500'),(1000107,'南和区','130506','130500'),(1000108,'临城县','130522','130500'),(1000109,'内丘县','130523','130500'),(1000110,'柏乡县','130524','130500'),(1000111,'隆尧县','130525','130500'),(1000112,'宁晋县','130528','130500'),(1000113,'巨鹿县','130529','130500'),(1000114,'新河县','130530','130500'),(1000115,'广宗县','130531','130500'),(1000116,'平乡县','130532','130500'),(1000117,'威县','130533','130500'),(1000118,'清河县','130534','130500'),(1000119,'临西县','130535','130500'),(1000120,'河北邢台经济开发区','130571','130500'),(1000121,'南宫市','130581','130500'),(1000122,'沙河市','130582','130500'),(1000123,'竞秀区','130602','130600'),(1000124,'莲池区','130606','130600'),(1000125,'满城区','130607','130600'),(1000126,'清苑区','130608','130600'),(1000127,'徐水区','130609','130600'),(1000128,'涞水县','130623','130600'),(1000129,'阜平县','130624','130600'),(1000130,'定兴县','130626','130600'),(1000131,'唐县','130627','130600'),(1000132,'高阳县','130628','130600'),(1000133,'容城县','130629','130600'),(1000134,'涞源县','130630','130600'),(1000135,'望都县','130631','130600'),(1000136,'安新县','130632','130600'),(1000137,'易县','130633','130600'),(1000138,'曲阳县','130634','130600'),(1000139,'蠡县','130635','130600'),(1000140,'顺平县','130636','130600'),(1000141,'博野县','130637','130600'),(1000142,'雄县','130638','130600'),(1000143,'保定高新技术产业开发区','130671','130600'),(1000144,'保定白沟新城','130672','130600'),(1000145,'涿州市','130681','130600'),(1000146,'定州市','130682','130600'),(1000147,'安国市','130683','130600'),(1000148,'高碑店市','130684','130600'),(1000149,'桥东区','130702','130700'),(1000150,'桥西区','130703','130700'),(1000151,'宣化区','130705','130700'),(1000152,'下花园区','130706','130700'),(1000153,'万全区','130708','130700'),(1000154,'崇礼区','130709','130700'),(1000155,'张北县','130722','130700'),(1000156,'康保县','130723','130700'),(1000157,'沽源县','130724','130700'),(1000158,'尚义县','130725','130700'),(1000159,'蔚县','130726','130700'),(1000160,'阳原县','130727','130700'),(1000161,'怀安县','130728','130700'),(1000162,'怀来县','130730','130700'),(1000163,'涿鹿县','130731','130700'),(1000164,'赤城县','130732','130700'),(1000165,'张家口经济开发区','130771','130700'),(1000166,'张家口市察北管理区','130772','130700'),(1000167,'张家口市塞北管理区','130773','130700'),(1000168,'双桥区','130802','130800'),(1000169,'双滦区','130803','130800'),(1000170,'鹰手营子矿区','130804','130800'),(1000171,'承德县','130821','130800'),(1000172,'兴隆县','130822','130800'),(1000173,'滦平县','130824','130800'),(1000174,'隆化县','130825','130800'),(1000175,'丰宁满族自治县','130826','130800'),(1000176,'宽城满族自治县','130827','130800'),(1000177,'围场满族蒙古族自治县','130828','130800'),(1000178,'承德高新技术产业开发区','130871','130800'),(1000179,'平泉市','130881','130800'),(1000180,'新华区','130902','130900'),(1000181,'运河区','130903','130900'),(1000182,'沧县','130921','130900'),(1000183,'青县','130922','130900'),(1000184,'东光县','130923','130900'),(1000185,'海兴县','130924','130900'),(1000186,'盐山县','130925','130900'),(1000187,'肃宁县','130926','130900'),(1000188,'南皮县','130927','130900'),(1000189,'吴桥县','130928','130900'),(1000190,'献县','130929','130900'),(1000191,'孟村回族自治县','130930','130900'),(1000192,'河北沧州经济开发区','130971','130900'),(1000193,'沧州高新技术产业开发区','130972','130900'),(1000194,'沧州渤海新区','130973','130900'),(1000195,'泊头市','130981','130900'),(1000196,'任丘市','130982','130900'),(1000197,'黄骅市','130983','130900'),(1000198,'河间市','130984','130900'),(1000199,'安次区','131002','131000'),(1000200,'广阳区','131003','131000'),(1000201,'固安县','131022','131000'),(1000202,'永清县','131023','131000'),(1000203,'香河县','131024','131000'),(1000204,'大城县','131025','131000'),(1000205,'文安县','131026','131000'),(1000206,'大厂回族自治县','131028','131000'),(1000207,'廊坊经济技术开发区','131071','131000'),(1000208,'霸州市','131081','131000'),(1000209,'三河市','131082','131000'),(1000210,'桃城区','131102','131100'),(1000211,'冀州区','131103','131100'),(1000212,'枣强县','131121','131100'),(1000213,'武邑县','131122','131100'),(1000214,'武强县','131123','131100'),(1000215,'饶阳县','131124','131100'),(1000216,'安平县','131125','131100'),(1000217,'故城县','131126','131100'),(1000218,'景县','131127','131100'),(1000219,'阜城县','131128','131100'),(1000220,'河北衡水高新技术产业开发区','131171','131100'),(1000221,'衡水滨湖新区','131172','131100'),(1000222,'深州市','131182','131100'),(1000223,'小店区','140105','140100'),(1000224,'迎泽区','140106','140100'),(1000225,'杏花岭区','140107','140100'),(1000226,'尖草坪区','140108','140100'),(1000227,'万柏林区','140109','140100'),(1000228,'晋源区','140110','140100'),(1000229,'清徐县','140121','140100'),(1000230,'阳曲县','140122','140100'),(1000231,'娄烦县','140123','140100'),(1000232,'山西转型综合改革示范区','140171','140100'),(1000233,'古交市','140181','140100'),(1000234,'新荣区','140212','140200'),(1000235,'平城区','140213','140200'),(1000236,'云冈区','140214','140200'),(1000237,'云州区','140215','140200'),(1000238,'阳高县','140221','140200'),(1000239,'天镇县','140222','140200'),(1000240,'广灵县','140223','140200'),(1000241,'灵丘县','140224','140200'),(1000242,'浑源县','140225','140200'),(1000243,'左云县','140226','140200'),(1000244,'山西大同经济开发区','140271','140200'),(1000245,'城区','140302','140300'),(1000246,'矿区','140303','140300'),(1000247,'郊区','140311','140300'),(1000248,'平定县','140321','140300'),(1000249,'盂县','140322','140300'),(1000250,'潞州区','140403','140400'),(1000251,'上党区','140404','140400'),(1000252,'屯留区','140405','140400'),(1000253,'潞城区','140406','140400'),(1000254,'襄垣县','140423','140400'),(1000255,'平顺县','140425','140400'),(1000256,'黎城县','140426','140400'),(1000257,'壶关县','140427','140400'),(1000258,'长子县','140428','140400'),(1000259,'武乡县','140429','140400'),(1000260,'沁县','140430','140400'),(1000261,'沁源县','140431','140400'),(1000262,'山西长治高新技术产业园区','140471','140400'),(1000263,'城区','140502','140500'),(1000264,'沁水县','140521','140500'),(1000265,'阳城县','140522','140500'),(1000266,'陵川县','140524','140500'),(1000267,'泽州县','140525','140500'),(1000268,'高平市','140581','140500'),(1000269,'朔城区','140602','140600'),(1000270,'平鲁区','140603','140600'),(1000271,'山阴县','140621','140600'),(1000272,'应县','140622','140600'),(1000273,'右玉县','140623','140600'),(1000274,'山西朔州经济开发区','140671','140600'),(1000275,'怀仁市','140681','140600'),(1000276,'榆次区','140702','140700'),(1000277,'太谷区','140703','140700'),(1000278,'榆社县','140721','140700'),(1000279,'左权县','140722','140700'),(1000280,'和顺县','140723','140700'),(1000281,'昔阳县','140724','140700'),(1000282,'寿阳县','140725','140700'),(1000283,'祁县','140727','140700'),(1000284,'平遥县','140728','140700'),(1000285,'灵石县','140729','140700'),(1000286,'介休市','140781','140700'),(1000287,'盐湖区','140802','140800'),(1000288,'临猗县','140821','140800'),(1000289,'万荣县','140822','140800'),(1000290,'闻喜县','140823','140800'),(1000291,'稷山县','140824','140800'),(1000292,'新绛县','140825','140800'),(1000293,'绛县','140826','140800'),(1000294,'垣曲县','140827','140800'),(1000295,'夏县','140828','140800'),(1000296,'平陆县','140829','140800'),(1000297,'芮城县','140830','140800'),(1000298,'永济市','140881','140800'),(1000299,'河津市','140882','140800'),(1000300,'忻府区','140902','140900'),(1000301,'定襄县','140921','140900'),(1000302,'五台县','140922','140900'),(1000303,'代县','140923','140900'),(1000304,'繁峙县','140924','140900'),(1000305,'宁武县','140925','140900'),(1000306,'静乐县','140926','140900'),(1000307,'神池县','140927','140900'),(1000308,'五寨县','140928','140900'),(1000309,'岢岚县','140929','140900'),(1000310,'河曲县','140930','140900'),(1000311,'保德县','140931','140900'),(1000312,'偏关县','140932','140900'),(1000313,'五台山风景名胜区','140971','140900'),(1000314,'原平市','140981','140900'),(1000315,'尧都区','141002','141000'),(1000316,'曲沃县','141021','141000'),(1000317,'翼城县','141022','141000'),(1000318,'襄汾县','141023','141000'),(1000319,'洪洞县','141024','141000'),(1000320,'古县','141025','141000'),(1000321,'安泽县','141026','141000'),(1000322,'浮山县','141027','141000'),(1000323,'吉县','141028','141000'),(1000324,'乡宁县','141029','141000'),(1000325,'大宁县','141030','141000'),(1000326,'隰县','141031','141000'),(1000327,'永和县','141032','141000'),(1000328,'蒲县','141033','141000'),(1000329,'汾西县','141034','141000'),(1000330,'侯马市','141081','141000'),(1000331,'霍州市','141082','141000'),(1000332,'离石区','141102','141100'),(1000333,'文水县','141121','141100'),(1000334,'交城县','141122','141100'),(1000335,'兴县','141123','141100'),(1000336,'临县','141124','141100'),(1000337,'柳林县','141125','141100'),(1000338,'石楼县','141126','141100'),(1000339,'岚县','141127','141100'),(1000340,'方山县','141128','141100'),(1000341,'中阳县','141129','141100'),(1000342,'交口县','141130','141100'),(1000343,'孝义市','141181','141100'),(1000344,'汾阳市','141182','141100'),(1000345,'新城区','150102','150100'),(1000346,'回民区','150103','150100'),(1000347,'玉泉区','150104','150100'),(1000348,'赛罕区','150105','150100'),(1000349,'土默特左旗','150121','150100'),(1000350,'托克托县','150122','150100'),(1000351,'和林格尔县','150123','150100'),(1000352,'清水河县','150124','150100'),(1000353,'武川县','150125','150100'),(1000354,'呼和浩特经济技术开发区','150172','150100'),(1000355,'东河区','150202','150200'),(1000356,'昆都仑区','150203','150200'),(1000357,'青山区','150204','150200'),(1000358,'石拐区','150205','150200'),(1000359,'白云鄂博矿区','150206','150200'),(1000360,'九原区','150207','150200'),(1000361,'土默特右旗','150221','150200'),(1000362,'固阳县','150222','150200'),(1000363,'达尔罕茂明安联合旗','150223','150200'),(1000364,'包头稀土高新技术产业开发区','150271','150200'),(1000365,'海勃湾区','150302','150300'),(1000366,'海南区','150303','150300'),(1000367,'乌达区','150304','150300'),(1000368,'红山区','150402','150400'),(1000369,'元宝山区','150403','150400'),(1000370,'松山区','150404','150400'),(1000371,'阿鲁科尔沁旗','150421','150400'),(1000372,'巴林左旗','150422','150400'),(1000373,'巴林右旗','150423','150400'),(1000374,'林西县','150424','150400'),(1000375,'克什克腾旗','150425','150400'),(1000376,'翁牛特旗','150426','150400'),(1000377,'喀喇沁旗','150428','150400'),(1000378,'宁城县','150429','150400'),(1000379,'敖汉旗','150430','150400'),(1000380,'科尔沁区','150502','150500'),(1000381,'科尔沁左翼中旗','150521','150500'),(1000382,'科尔沁左翼后旗','150522','150500'),(1000383,'开鲁县','150523','150500'),(1000384,'库伦旗','150524','150500'),(1000385,'奈曼旗','150525','150500'),(1000386,'扎鲁特旗','150526','150500'),(1000387,'通辽经济技术开发区','150571','150500'),(1000388,'霍林郭勒市','150581','150500'),(1000389,'东胜区','150602','150600'),(1000390,'康巴什区','150603','150600'),(1000391,'达拉特旗','150621','150600'),(1000392,'准格尔旗','150622','150600'),(1000393,'鄂托克前旗','150623','150600'),(1000394,'鄂托克旗','150624','150600'),(1000395,'杭锦旗','150625','150600'),(1000396,'乌审旗','150626','150600'),(1000397,'伊金霍洛旗','150627','150600'),(1000398,'海拉尔区','150702','150700'),(1000399,'扎赉诺尔区','150703','150700'),(1000400,'阿荣旗','150721','150700'),(1000401,'莫力达瓦达斡尔族自治旗','150722','150700'),(1000402,'鄂伦春自治旗','150723','150700'),(1000403,'鄂温克族自治旗','150724','150700'),(1000404,'陈巴尔虎旗','150725','150700'),(1000405,'新巴尔虎左旗','150726','150700'),(1000406,'新巴尔虎右旗','150727','150700'),(1000407,'满洲里市','150781','150700'),(1000408,'牙克石市','150782','150700'),(1000409,'扎兰屯市','150783','150700'),(1000410,'额尔古纳市','150784','150700'),(1000411,'根河市','150785','150700'),(1000412,'临河区','150802','150800'),(1000413,'五原县','150821','150800'),(1000414,'磴口县','150822','150800'),(1000415,'乌拉特前旗','150823','150800'),(1000416,'乌拉特中旗','150824','150800'),(1000417,'乌拉特后旗','150825','150800'),(1000418,'杭锦后旗','150826','150800'),(1000419,'集宁区','150902','150900'),(1000420,'卓资县','150921','150900'),(1000421,'化德县','150922','150900'),(1000422,'商都县','150923','150900'),(1000423,'兴和县','150924','150900'),(1000424,'凉城县','150925','150900'),(1000425,'察哈尔右翼前旗','150926','150900'),(1000426,'察哈尔右翼中旗','150927','150900'),(1000427,'察哈尔右翼后旗','150928','150900'),(1000428,'四子王旗','150929','150900'),(1000429,'丰镇市','150981','150900'),(1000430,'乌兰浩特市','152201','152200'),(1000431,'阿尔山市','152202','152200'),(1000432,'科尔沁右翼前旗','152221','152200'),(1000433,'科尔沁右翼中旗','152222','152200'),(1000434,'扎赉特旗','152223','152200'),(1000435,'突泉县','152224','152200'),(1000436,'二连浩特市','152501','152500'),(1000437,'锡林浩特市','152502','152500'),(1000438,'阿巴嘎旗','152522','152500'),(1000439,'苏尼特左旗','152523','152500'),(1000440,'苏尼特右旗','152524','152500'),(1000441,'东乌珠穆沁旗','152525','152500'),(1000442,'西乌珠穆沁旗','152526','152500'),(1000443,'太仆寺旗','152527','152500'),(1000444,'镶黄旗','152528','152500'),(1000445,'正镶白旗','152529','152500'),(1000446,'正蓝旗','152530','152500'),(1000447,'多伦县','152531','152500'),(1000448,'乌拉盖管委会','152571','152500'),(1000449,'阿拉善左旗','152921','152900'),(1000450,'阿拉善右旗','152922','152900'),(1000451,'额济纳旗','152923','152900'),(1000452,'内蒙古阿拉善经济开发区','152971','152900'),(1000453,'和平区','210102','210100'),(1000454,'沈河区','210103','210100'),(1000455,'大东区','210104','210100'),(1000456,'皇姑区','210105','210100'),(1000457,'铁西区','210106','210100'),(1000458,'苏家屯区','210111','210100'),(1000459,'浑南区','210112','210100'),(1000460,'沈北新区','210113','210100'),(1000461,'于洪区','210114','210100'),(1000462,'辽中区','210115','210100'),(1000463,'康平县','210123','210100'),(1000464,'法库县','210124','210100'),(1000465,'新民市','210181','210100'),(1000466,'中山区','210202','210200'),(1000467,'西岗区','210203','210200'),(1000468,'沙河口区','210204','210200'),(1000469,'甘井子区','210211','210200'),(1000470,'旅顺口区','210212','210200'),(1000471,'金州区','210213','210200'),(1000472,'普兰店区','210214','210200'),(1000473,'长海县','210224','210200'),(1000474,'瓦房店市','210281','210200'),(1000475,'庄河市','210283','210200'),(1000476,'铁东区','210302','210300'),(1000477,'铁西区','210303','210300'),(1000478,'立山区','210304','210300'),(1000479,'千山区','210311','210300'),(1000480,'台安县','210321','210300'),(1000481,'岫岩满族自治县','210323','210300'),(1000482,'海城市','210381','210300'),(1000483,'新抚区','210402','210400'),(1000484,'东洲区','210403','210400'),(1000485,'望花区','210404','210400'),(1000486,'顺城区','210411','210400'),(1000487,'抚顺县','210421','210400'),(1000488,'新宾满族自治县','210422','210400'),(1000489,'清原满族自治县','210423','210400'),(1000490,'平山区','210502','210500'),(1000491,'溪湖区','210503','210500'),(1000492,'明山区','210504','210500'),(1000493,'南芬区','210505','210500'),(1000494,'本溪满族自治县','210521','210500'),(1000495,'桓仁满族自治县','210522','210500'),(1000496,'元宝区','210602','210600'),(1000497,'振兴区','210603','210600'),(1000498,'振安区','210604','210600'),(1000499,'宽甸满族自治县','210624','210600'),(1000500,'东港市','210681','210600'),(1000501,'凤城市','210682','210600'),(1000502,'古塔区','210702','210700'),(1000503,'凌河区','210703','210700'),(1000504,'太和区','210711','210700'),(1000505,'黑山县','210726','210700'),(1000506,'义县','210727','210700'),(1000507,'凌海市','210781','210700'),(1000508,'北镇市','210782','210700'),(1000509,'站前区','210802','210800'),(1000510,'西市区','210803','210800'),(1000511,'鲅鱼圈区','210804','210800'),(1000512,'老边区','210811','210800'),(1000513,'盖州市','210881','210800'),(1000514,'大石桥市','210882','210800'),(1000515,'海州区','210902','210900'),(1000516,'新邱区','210903','210900'),(1000517,'太平区','210904','210900'),(1000518,'清河门区','210905','210900'),(1000519,'细河区','210911','210900'),(1000520,'阜新蒙古族自治县','210921','210900'),(1000521,'彰武县','210922','210900'),(1000522,'白塔区','211002','211000'),(1000523,'文圣区','211003','211000'),(1000524,'宏伟区','211004','211000'),(1000525,'弓长岭区','211005','211000'),(1000526,'太子河区','211011','211000'),(1000527,'辽阳县','211021','211000'),(1000528,'灯塔市','211081','211000'),(1000529,'双台子区','211102','211100'),(1000530,'兴隆台区','211103','211100'),(1000531,'大洼区','211104','211100'),(1000532,'盘山县','211122','211100'),(1000533,'银州区','211202','211200'),(1000534,'清河区','211204','211200'),(1000535,'铁岭县','211221','211200'),(1000536,'西丰县','211223','211200'),(1000537,'昌图县','211224','211200'),(1000538,'调兵山市','211281','211200'),(1000539,'开原市','211282','211200'),(1000540,'双塔区','211302','211300'),(1000541,'龙城区','211303','211300'),(1000542,'朝阳县','211321','211300'),(1000543,'建平县','211322','211300'),(1000544,'喀喇沁左翼蒙古族自治县','211324','211300'),(1000545,'北票市','211381','211300'),(1000546,'凌源市','211382','211300'),(1000547,'连山区','211402','211400'),(1000548,'龙港区','211403','211400'),(1000549,'南票区','211404','211400'),(1000550,'绥中县','211421','211400'),(1000551,'建昌县','211422','211400'),(1000552,'兴城市','211481','211400'),(1000553,'南关区','220102','220100'),(1000554,'宽城区','220103','220100'),(1000555,'朝阳区','220104','220100'),(1000556,'二道区','220105','220100'),(1000557,'绿园区','220106','220100'),(1000558,'双阳区','220112','220100'),(1000559,'九台区','220113','220100'),(1000560,'农安县','220122','220100'),(1000561,'长春经济技术开发区','220171','220100'),(1000562,'长春净月高新技术产业开发区','220172','220100'),(1000563,'长春高新技术产业开发区','220173','220100'),(1000564,'长春汽车经济技术开发区','220174','220100'),(1000565,'榆树市','220182','220100'),(1000566,'德惠市','220183','220100'),(1000567,'公主岭市','220184','220100'),(1000568,'昌邑区','220202','220200'),(1000569,'龙潭区','220203','220200'),(1000570,'船营区','220204','220200'),(1000571,'丰满区','220211','220200'),(1000572,'永吉县','220221','220200'),(1000573,'吉林经济开发区','220271','220200'),(1000574,'吉林高新技术产业开发区','220272','220200'),(1000575,'吉林中国新加坡食品区','220273','220200'),(1000576,'蛟河市','220281','220200'),(1000577,'桦甸市','220282','220200'),(1000578,'舒兰市','220283','220200'),(1000579,'磐石市','220284','220200'),(1000580,'铁西区','220302','220300'),(1000581,'铁东区','220303','220300'),(1000582,'梨树县','220322','220300'),(1000583,'伊通满族自治县','220323','220300'),(1000584,'双辽市','220382','220300'),(1000585,'龙山区','220402','220400'),(1000586,'西安区','220403','220400'),(1000587,'东丰县','220421','220400'),(1000588,'东辽县','220422','220400'),(1000589,'东昌区','220502','220500'),(1000590,'二道江区','220503','220500'),(1000591,'通化县','220521','220500'),(1000592,'辉南县','220523','220500'),(1000593,'柳河县','220524','220500'),(1000594,'梅河口市','220581','220500'),(1000595,'集安市','220582','220500'),(1000596,'浑江区','220602','220600'),(1000597,'江源区','220605','220600'),(1000598,'抚松县','220621','220600'),(1000599,'靖宇县','220622','220600'),(1000600,'长白朝鲜族自治县','220623','220600'),(1000601,'临江市','220681','220600'),(1000602,'宁江区','220702','220700'),(1000603,'前郭尔罗斯蒙古族自治县','220721','220700'),(1000604,'长岭县','220722','220700'),(1000605,'乾安县','220723','220700'),(1000606,'吉林松原经济开发区','220771','220700'),(1000607,'扶余市','220781','220700'),(1000608,'洮北区','220802','220800'),(1000609,'镇赉县','220821','220800'),(1000610,'通榆县','220822','220800'),(1000611,'吉林白城经济开发区','220871','220800'),(1000612,'洮南市','220881','220800'),(1000613,'大安市','220882','220800'),(1000614,'延吉市','222401','222400'),(1000615,'图们市','222402','222400'),(1000616,'敦化市','222403','222400'),(1000617,'珲春市','222404','222400'),(1000618,'龙井市','222405','222400'),(1000619,'和龙市','222406','222400'),(1000620,'汪清县','222424','222400'),(1000621,'安图县','222426','222400'),(1000622,'道里区','230102','230100'),(1000623,'南岗区','230103','230100'),(1000624,'道外区','230104','230100'),(1000625,'平房区','230108','230100'),(1000626,'松北区','230109','230100'),(1000627,'香坊区','230110','230100'),(1000628,'呼兰区','230111','230100'),(1000629,'阿城区','230112','230100'),(1000630,'双城区','230113','230100'),(1000631,'依兰县','230123','230100'),(1000632,'方正县','230124','230100'),(1000633,'宾县','230125','230100'),(1000634,'巴彦县','230126','230100'),(1000635,'木兰县','230127','230100'),(1000636,'通河县','230128','230100'),(1000637,'延寿县','230129','230100'),(1000638,'尚志市','230183','230100'),(1000639,'五常市','230184','230100'),(1000640,'龙沙区','230202','230200'),(1000641,'建华区','230203','230200'),(1000642,'铁锋区','230204','230200'),(1000643,'昂昂溪区','230205','230200'),(1000644,'富拉尔基区','230206','230200'),(1000645,'碾子山区','230207','230200'),(1000646,'梅里斯达斡尔族区','230208','230200'),(1000647,'龙江县','230221','230200'),(1000648,'依安县','230223','230200'),(1000649,'泰来县','230224','230200'),(1000650,'甘南县','230225','230200'),(1000651,'富裕县','230227','230200'),(1000652,'克山县','230229','230200'),(1000653,'克东县','230230','230200'),(1000654,'拜泉县','230231','230200'),(1000655,'讷河市','230281','230200'),(1000656,'鸡冠区','230302','230300'),(1000657,'恒山区','230303','230300'),(1000658,'滴道区','230304','230300'),(1000659,'梨树区','230305','230300'),(1000660,'城子河区','230306','230300'),(1000661,'麻山区','230307','230300'),(1000662,'鸡东县','230321','230300'),(1000663,'虎林市','230381','230300'),(1000664,'密山市','230382','230300'),(1000665,'向阳区','230402','230400'),(1000666,'工农区','230403','230400'),(1000667,'南山区','230404','230400'),(1000668,'兴安区','230405','230400'),(1000669,'东山区','230406','230400'),(1000670,'兴山区','230407','230400'),(1000671,'萝北县','230421','230400'),(1000672,'绥滨县','230422','230400'),(1000673,'尖山区','230502','230500'),(1000674,'岭东区','230503','230500'),(1000675,'四方台区','230505','230500'),(1000676,'宝山区','230506','230500'),(1000677,'集贤县','230521','230500'),(1000678,'友谊县','230522','230500'),(1000679,'宝清县','230523','230500'),(1000680,'饶河县','230524','230500'),(1000681,'萨尔图区','230602','230600'),(1000682,'龙凤区','230603','230600'),(1000683,'让胡路区','230604','230600'),(1000684,'红岗区','230605','230600'),(1000685,'大同区','230606','230600'),(1000686,'肇州县','230621','230600'),(1000687,'肇源县','230622','230600'),(1000688,'林甸县','230623','230600'),(1000689,'杜尔伯特蒙古族自治县','230624','230600'),(1000690,'大庆高新技术产业开发区','230671','230600'),(1000691,'伊美区','230717','230700'),(1000692,'乌翠区','230718','230700'),(1000693,'友好区','230719','230700'),(1000694,'嘉荫县','230722','230700'),(1000695,'汤旺县','230723','230700'),(1000696,'丰林县','230724','230700'),(1000697,'大箐山县','230725','230700'),(1000698,'南岔县','230726','230700'),(1000699,'金林区','230751','230700'),(1000700,'铁力市','230781','230700'),(1000701,'向阳区','230803','230800'),(1000702,'前进区','230804','230800'),(1000703,'东风区','230805','230800'),(1000704,'郊区','230811','230800'),(1000705,'桦南县','230822','230800'),(1000706,'桦川县','230826','230800'),(1000707,'汤原县','230828','230800'),(1000708,'同江市','230881','230800'),(1000709,'富锦市','230882','230800'),(1000710,'抚远市','230883','230800'),(1000711,'新兴区','230902','230900'),(1000712,'桃山区','230903','230900'),(1000713,'茄子河区','230904','230900'),(1000714,'勃利县','230921','230900'),(1000715,'东安区','231002','231000'),(1000716,'阳明区','231003','231000'),(1000717,'爱民区','231004','231000'),(1000718,'西安区','231005','231000'),(1000719,'林口县','231025','231000'),(1000720,'牡丹江经济技术开发区','231071','231000'),(1000721,'绥芬河市','231081','231000'),(1000722,'海林市','231083','231000'),(1000723,'宁安市','231084','231000'),(1000724,'穆棱市','231085','231000'),(1000725,'东宁市','231086','231000'),(1000726,'爱辉区','231102','231100'),(1000727,'逊克县','231123','231100'),(1000728,'孙吴县','231124','231100'),(1000729,'北安市','231181','231100'),(1000730,'五大连池市','231182','231100'),(1000731,'嫩江市','231183','231100'),(1000732,'北林区','231202','231200'),(1000733,'望奎县','231221','231200'),(1000734,'兰西县','231222','231200'),(1000735,'青冈县','231223','231200'),(1000736,'庆安县','231224','231200'),(1000737,'明水县','231225','231200'),(1000738,'绥棱县','231226','231200'),(1000739,'安达市','231281','231200'),(1000740,'肇东市','231282','231200'),(1000741,'海伦市','231283','231200'),(1000742,'漠河市','232701','232700'),(1000743,'呼玛县','232721','232700'),(1000744,'塔河县','232722','232700'),(1000745,'加格达奇区','232761','232700'),(1000746,'松岭区','232762','232700'),(1000747,'新林区','232763','232700'),(1000748,'呼中区','232764','232700'),(1000749,'黄浦区','310101','310100'),(1000750,'徐汇区','310104','310100'),(1000751,'长宁区','310105','310100'),(1000752,'静安区','310106','310100'),(1000753,'普陀区','310107','310100'),(1000754,'虹口区','310109','310100'),(1000755,'杨浦区','310110','310100'),(1000756,'闵行区','310112','310100'),(1000757,'宝山区','310113','310100'),(1000758,'嘉定区','310114','310100'),(1000759,'浦东新区','310115','310100'),(1000760,'金山区','310116','310100'),(1000761,'松江区','310117','310100'),(1000762,'青浦区','310118','310100'),(1000763,'奉贤区','310120','310100'),(1000764,'崇明区','310151','310100'),(1000765,'玄武区','320102','320100'),(1000766,'秦淮区','320104','320100'),(1000767,'建邺区','320105','320100'),(1000768,'鼓楼区','320106','320100'),(1000769,'浦口区','320111','320100'),(1000770,'栖霞区','320113','320100'),(1000771,'雨花台区','320114','320100'),(1000772,'江宁区','320115','320100'),(1000773,'六合区','320116','320100'),(1000774,'溧水区','320117','320100'),(1000775,'高淳区','320118','320100'),(1000776,'锡山区','320205','320200'),(1000777,'惠山区','320206','320200'),(1000778,'滨湖区','320211','320200'),(1000779,'梁溪区','320213','320200'),(1000780,'新吴区','320214','320200'),(1000781,'江阴市','320281','320200'),(1000782,'宜兴市','320282','320200'),(1000783,'鼓楼区','320302','320300'),(1000784,'云龙区','320303','320300'),(1000785,'贾汪区','320305','320300'),(1000786,'泉山区','320311','320300'),(1000787,'铜山区','320312','320300'),(1000788,'丰县','320321','320300'),(1000789,'沛县','320322','320300'),(1000790,'睢宁县','320324','320300'),(1000791,'徐州经济技术开发区','320371','320300'),(1000792,'新沂市','320381','320300'),(1000793,'邳州市','320382','320300'),(1000794,'天宁区','320402','320400'),(1000795,'钟楼区','320404','320400'),(1000796,'新北区','320411','320400'),(1000797,'武进区','320412','320400'),(1000798,'金坛区','320413','320400'),(1000799,'溧阳市','320481','320400'),(1000800,'虎丘区','320505','320500'),(1000801,'吴中区','320506','320500'),(1000802,'相城区','320507','320500'),(1000803,'姑苏区','320508','320500'),(1000804,'吴江区','320509','320500'),(1000805,'苏州工业园区','320571','320500'),(1000806,'常熟市','320581','320500'),(1000807,'张家港市','320582','320500'),(1000808,'昆山市','320583','320500'),(1000809,'太仓市','320585','320500'),(1000810,'崇川区','320602','320600'),(1000811,'港闸区','320611','320600'),(1000812,'通州区','320612','320600'),(1000813,'如东县','320623','320600'),(1000814,'南通经济技术开发区','320671','320600'),(1000815,'启东市','320681','320600'),(1000816,'如皋市','320682','320600'),(1000817,'海门市','320684','320600'),(1000818,'海安市','320685','320600'),(1000819,'连云区','320703','320700'),(1000820,'海州区','320706','320700'),(1000821,'赣榆区','320707','320700'),(1000822,'东海县','320722','320700'),(1000823,'灌云县','320723','320700'),(1000824,'灌南县','320724','320700'),(1000825,'连云港经济技术开发区','320771','320700'),(1000826,'连云港高新技术产业开发区','320772','320700'),(1000827,'淮安区','320803','320800'),(1000828,'淮阴区','320804','320800'),(1000829,'清江浦区','320812','320800'),(1000830,'洪泽区','320813','320800'),(1000831,'涟水县','320826','320800'),(1000832,'盱眙县','320830','320800'),(1000833,'金湖县','320831','320800'),(1000834,'淮安经济技术开发区','320871','320800'),(1000835,'亭湖区','320902','320900'),(1000836,'盐都区','320903','320900'),(1000837,'大丰区','320904','320900'),(1000838,'响水县','320921','320900'),(1000839,'滨海县','320922','320900'),(1000840,'阜宁县','320923','320900'),(1000841,'射阳县','320924','320900'),(1000842,'建湖县','320925','320900'),(1000843,'盐城经济技术开发区','320971','320900'),(1000844,'东台市','320981','320900'),(1000845,'广陵区','321002','321000'),(1000846,'邗江区','321003','321000'),(1000847,'江都区','321012','321000'),(1000848,'宝应县','321023','321000'),(1000849,'扬州经济技术开发区','321071','321000'),(1000850,'仪征市','321081','321000'),(1000851,'高邮市','321084','321000'),(1000852,'京口区','321102','321100'),(1000853,'润州区','321111','321100'),(1000854,'丹徒区','321112','321100'),(1000855,'镇江新区','321171','321100'),(1000856,'丹阳市','321181','321100'),(1000857,'扬中市','321182','321100'),(1000858,'句容市','321183','321100'),(1000859,'海陵区','321202','321200'),(1000860,'高港区','321203','321200'),(1000861,'姜堰区','321204','321200'),(1000862,'泰州医药高新技术产业开发区','321271','321200'),(1000863,'兴化市','321281','321200'),(1000864,'靖江市','321282','321200'),(1000865,'泰兴市','321283','321200'),(1000866,'宿城区','321302','321300'),(1000867,'宿豫区','321311','321300'),(1000868,'沭阳县','321322','321300'),(1000869,'泗阳县','321323','321300'),(1000870,'泗洪县','321324','321300'),(1000871,'宿迁经济技术开发区','321371','321300'),(1000872,'上城区','330102','330100'),(1000873,'下城区','330103','330100'),(1000874,'江干区','330104','330100'),(1000875,'拱墅区','330105','330100'),(1000876,'西湖区','330106','330100'),(1000877,'滨江区','330108','330100'),(1000878,'萧山区','330109','330100'),(1000879,'余杭区','330110','330100'),(1000880,'富阳区','330111','330100'),(1000881,'临安区','330112','330100'),(1000882,'桐庐县','330122','330100'),(1000883,'淳安县','330127','330100'),(1000884,'建德市','330182','330100'),(1000885,'海曙区','330203','330200'),(1000886,'江北区','330205','330200'),(1000887,'北仑区','330206','330200'),(1000888,'镇海区','330211','330200'),(1000889,'鄞州区','330212','330200'),(1000890,'奉化区','330213','330200'),(1000891,'象山县','330225','330200'),(1000892,'宁海县','330226','330200'),(1000893,'余姚市','330281','330200'),(1000894,'慈溪市','330282','330200'),(1000895,'鹿城区','330302','330300'),(1000896,'龙湾区','330303','330300'),(1000897,'瓯海区','330304','330300'),(1000898,'洞头区','330305','330300'),(1000899,'永嘉县','330324','330300'),(1000900,'平阳县','330326','330300'),(1000901,'苍南县','330327','330300'),(1000902,'文成县','330328','330300'),(1000903,'泰顺县','330329','330300'),(1000904,'温州经济技术开发区','330371','330300'),(1000905,'瑞安市','330381','330300'),(1000906,'乐清市','330382','330300'),(1000907,'龙港市','330383','330300'),(1000908,'南湖区','330402','330400'),(1000909,'秀洲区','330411','330400'),(1000910,'嘉善县','330421','330400'),(1000911,'海盐县','330424','330400'),(1000912,'海宁市','330481','330400'),(1000913,'平湖市','330482','330400'),(1000914,'桐乡市','330483','330400'),(1000915,'吴兴区','330502','330500'),(1000916,'南浔区','330503','330500'),(1000917,'德清县','330521','330500'),(1000918,'长兴县','330522','330500'),(1000919,'安吉县','330523','330500'),(1000920,'越城区','330602','330600'),(1000921,'柯桥区','330603','330600'),(1000922,'上虞区','330604','330600'),(1000923,'新昌县','330624','330600'),(1000924,'诸暨市','330681','330600'),(1000925,'嵊州市','330683','330600'),(1000926,'婺城区','330702','330700'),(1000927,'金东区','330703','330700'),(1000928,'武义县','330723','330700'),(1000929,'浦江县','330726','330700'),(1000930,'磐安县','330727','330700'),(1000931,'兰溪市','330781','330700'),(1000932,'义乌市','330782','330700'),(1000933,'东阳市','330783','330700'),(1000934,'永康市','330784','330700'),(1000935,'柯城区','330802','330800'),(1000936,'衢江区','330803','330800'),(1000937,'常山县','330822','330800'),(1000938,'开化县','330824','330800'),(1000939,'龙游县','330825','330800'),(1000940,'江山市','330881','330800'),(1000941,'定海区','330902','330900'),(1000942,'普陀区','330903','330900'),(1000943,'岱山县','330921','330900'),(1000944,'嵊泗县','330922','330900'),(1000945,'椒江区','331002','331000'),(1000946,'黄岩区','331003','331000'),(1000947,'路桥区','331004','331000'),(1000948,'三门县','331022','331000'),(1000949,'天台县','331023','331000'),(1000950,'仙居县','331024','331000'),(1000951,'温岭市','331081','331000'),(1000952,'临海市','331082','331000'),(1000953,'玉环市','331083','331000'),(1000954,'莲都区','331102','331100'),(1000955,'青田县','331121','331100'),(1000956,'缙云县','331122','331100'),(1000957,'遂昌县','331123','331100'),(1000958,'松阳县','331124','331100'),(1000959,'云和县','331125','331100'),(1000960,'庆元县','331126','331100'),(1000961,'景宁畲族自治县','331127','331100'),(1000962,'龙泉市','331181','331100'),(1000963,'瑶海区','340102','340100'),(1000964,'庐阳区','340103','340100'),(1000965,'蜀山区','340104','340100'),(1000966,'包河区','340111','340100'),(1000967,'长丰县','340121','340100'),(1000968,'肥东县','340122','340100'),(1000969,'肥西县','340123','340100'),(1000970,'庐江县','340124','340100'),(1000971,'合肥高新技术产业开发区','340171','340100'),(1000972,'合肥经济技术开发区','340172','340100'),(1000973,'合肥新站高新技术产业开发区','340173','340100'),(1000974,'巢湖市','340181','340100'),(1000975,'镜湖区','340202','340200'),(1000976,'弋江区','340203','340200'),(1000977,'鸠江区','340207','340200'),(1000978,'三山区','340208','340200'),(1000979,'芜湖县','340221','340200'),(1000980,'繁昌县','340222','340200'),(1000981,'南陵县','340223','340200'),(1000982,'芜湖经济技术开发区','340271','340200'),(1000983,'安徽芜湖长江大桥经济开发区','340272','340200'),(1000984,'无为市','340281','340200'),(1000985,'龙子湖区','340302','340300'),(1000986,'蚌山区','340303','340300'),(1000987,'禹会区','340304','340300'),(1000988,'淮上区','340311','340300'),(1000989,'怀远县','340321','340300'),(1000990,'五河县','340322','340300'),(1000991,'固镇县','340323','340300'),(1000992,'蚌埠市高新技术开发区','340371','340300'),(1000993,'蚌埠市经济开发区','340372','340300'),(1000994,'大通区','340402','340400'),(1000995,'田家庵区','340403','340400'),(1000996,'谢家集区','340404','340400'),(1000997,'八公山区','340405','340400'),(1000998,'潘集区','340406','340400'),(1000999,'凤台县','340421','340400'),(1001000,'寿县','340422','340400'),(1001001,'花山区','340503','340500'),(1001002,'雨山区','340504','340500'),(1001003,'博望区','340506','340500'),(1001004,'当涂县','340521','340500'),(1001005,'含山县','340522','340500'),(1001006,'和县','340523','340500'),(1001007,'杜集区','340602','340600'),(1001008,'相山区','340603','340600'),(1001009,'烈山区','340604','340600'),(1001010,'濉溪县','340621','340600'),(1001011,'铜官区','340705','340700'),(1001012,'义安区','340706','340700'),(1001013,'郊区','340711','340700'),(1001014,'枞阳县','340722','340700'),(1001015,'迎江区','340802','340800'),(1001016,'大观区','340803','340800'),(1001017,'宜秀区','340811','340800'),(1001018,'怀宁县','340822','340800'),(1001019,'太湖县','340825','340800'),(1001020,'宿松县','340826','340800'),(1001021,'望江县','340827','340800'),(1001022,'岳西县','340828','340800'),(1001023,'安徽安庆经济开发区','340871','340800'),(1001024,'桐城市','340881','340800'),(1001025,'潜山市','340882','340800'),(1001026,'屯溪区','341002','341000'),(1001027,'黄山区','341003','341000'),(1001028,'徽州区','341004','341000'),(1001029,'歙县','341021','341000'),(1001030,'休宁县','341022','341000'),(1001031,'黟县','341023','341000'),(1001032,'祁门县','341024','341000'),(1001033,'琅琊区','341102','341100'),(1001034,'南谯区','341103','341100'),(1001035,'来安县','341122','341100'),(1001036,'全椒县','341124','341100'),(1001037,'定远县','341125','341100'),(1001038,'凤阳县','341126','341100'),(1001039,'苏滁现代产业园','341171','341100'),(1001040,'滁州经济技术开发区','341172','341100'),(1001041,'天长市','341181','341100'),(1001042,'明光市','341182','341100'),(1001043,'颍州区','341202','341200'),(1001044,'颍东区','341203','341200'),(1001045,'颍泉区','341204','341200'),(1001046,'临泉县','341221','341200'),(1001047,'太和县','341222','341200'),(1001048,'阜南县','341225','341200'),(1001049,'颍上县','341226','341200'),(1001050,'阜阳合肥现代产业园区','341271','341200'),(1001051,'阜阳经济技术开发区','341272','341200'),(1001052,'界首市','341282','341200'),(1001053,'埇桥区','341302','341300'),(1001054,'砀山县','341321','341300'),(1001055,'萧县','341322','341300'),(1001056,'灵璧县','341323','341300'),(1001057,'泗县','341324','341300'),(1001058,'宿州马鞍山现代产业园区','341371','341300'),(1001059,'宿州经济技术开发区','341372','341300'),(1001060,'金安区','341502','341500'),(1001061,'裕安区','341503','341500'),(1001062,'叶集区','341504','341500'),(1001063,'霍邱县','341522','341500'),(1001064,'舒城县','341523','341500'),(1001065,'金寨县','341524','341500'),(1001066,'霍山县','341525','341500'),(1001067,'谯城区','341602','341600'),(1001068,'涡阳县','341621','341600'),(1001069,'蒙城县','341622','341600'),(1001070,'利辛县','341623','341600'),(1001071,'贵池区','341702','341700'),(1001072,'东至县','341721','341700'),(1001073,'石台县','341722','341700'),(1001074,'青阳县','341723','341700'),(1001075,'宣州区','341802','341800'),(1001076,'郎溪县','341821','341800'),(1001077,'泾县','341823','341800'),(1001078,'绩溪县','341824','341800'),(1001079,'旌德县','341825','341800'),(1001080,'宣城市经济开发区','341871','341800'),(1001081,'宁国市','341881','341800'),(1001082,'广德市','341882','341800'),(1001083,'鼓楼区','350102','350100'),(1001084,'台江区','350103','350100'),(1001085,'仓山区','350104','350100'),(1001086,'马尾区','350105','350100'),(1001087,'晋安区','350111','350100'),(1001088,'长乐区','350112','350100'),(1001089,'闽侯县','350121','350100'),(1001090,'连江县','350122','350100'),(1001091,'罗源县','350123','350100'),(1001092,'闽清县','350124','350100'),(1001093,'永泰县','350125','350100'),(1001094,'平潭县','350128','350100'),(1001095,'福清市','350181','350100'),(1001096,'思明区','350203','350200'),(1001097,'海沧区','350205','350200'),(1001098,'湖里区','350206','350200'),(1001099,'集美区','350211','350200'),(1001100,'同安区','350212','350200'),(1001101,'翔安区','350213','350200'),(1001102,'城厢区','350302','350300'),(1001103,'涵江区','350303','350300'),(1001104,'荔城区','350304','350300'),(1001105,'秀屿区','350305','350300'),(1001106,'仙游县','350322','350300'),(1001107,'梅列区','350402','350400'),(1001108,'三元区','350403','350400'),(1001109,'明溪县','350421','350400'),(1001110,'清流县','350423','350400'),(1001111,'宁化县','350424','350400'),(1001112,'大田县','350425','350400'),(1001113,'尤溪县','350426','350400'),(1001114,'沙县','350427','350400'),(1001115,'将乐县','350428','350400'),(1001116,'泰宁县','350429','350400'),(1001117,'建宁县','350430','350400'),(1001118,'永安市','350481','350400'),(1001119,'鲤城区','350502','350500'),(1001120,'丰泽区','350503','350500'),(1001121,'洛江区','350504','350500'),(1001122,'泉港区','350505','350500'),(1001123,'惠安县','350521','350500'),(1001124,'安溪县','350524','350500'),(1001125,'永春县','350525','350500'),(1001126,'德化县','350526','350500'),(1001127,'石狮市','350581','350500'),(1001128,'晋江市','350582','350500'),(1001129,'南安市','350583','350500'),(1001130,'芗城区','350602','350600'),(1001131,'龙文区','350603','350600'),(1001132,'云霄县','350622','350600'),(1001133,'漳浦县','350623','350600'),(1001134,'诏安县','350624','350600'),(1001135,'长泰县','350625','350600'),(1001136,'东山县','350626','350600'),(1001137,'南靖县','350627','350600'),(1001138,'平和县','350628','350600'),(1001139,'华安县','350629','350600'),(1001140,'龙海市','350681','350600'),(1001141,'延平区','350702','350700'),(1001142,'建阳区','350703','350700'),(1001143,'顺昌县','350721','350700'),(1001144,'浦城县','350722','350700'),(1001145,'光泽县','350723','350700'),(1001146,'松溪县','350724','350700'),(1001147,'政和县','350725','350700'),(1001148,'邵武市','350781','350700'),(1001149,'武夷山市','350782','350700'),(1001150,'建瓯市','350783','350700'),(1001151,'新罗区','350802','350800'),(1001152,'永定区','350803','350800'),(1001153,'长汀县','350821','350800'),(1001154,'上杭县','350823','350800'),(1001155,'武平县','350824','350800'),(1001156,'连城县','350825','350800'),(1001157,'漳平市','350881','350800'),(1001158,'蕉城区','350902','350900'),(1001159,'霞浦县','350921','350900'),(1001160,'古田县','350922','350900'),(1001161,'屏南县','350923','350900'),(1001162,'寿宁县','350924','350900'),(1001163,'周宁县','350925','350900'),(1001164,'柘荣县','350926','350900'),(1001165,'福安市','350981','350900'),(1001166,'福鼎市','350982','350900'),(1001167,'东湖区','360102','360100'),(1001168,'西湖区','360103','360100'),(1001169,'青云谱区','360104','360100'),(1001170,'青山湖区','360111','360100'),(1001171,'新建区','360112','360100'),(1001172,'红谷滩区','360113','360100'),(1001173,'南昌县','360121','360100'),(1001174,'安义县','360123','360100'),(1001175,'进贤县','360124','360100'),(1001176,'昌江区','360202','360200'),(1001177,'珠山区','360203','360200'),(1001178,'浮梁县','360222','360200'),(1001179,'乐平市','360281','360200'),(1001180,'安源区','360302','360300'),(1001181,'湘东区','360313','360300'),(1001182,'莲花县','360321','360300'),(1001183,'上栗县','360322','360300'),(1001184,'芦溪县','360323','360300'),(1001185,'濂溪区','360402','360400'),(1001186,'浔阳区','360403','360400'),(1001187,'柴桑区','360404','360400'),(1001188,'武宁县','360423','360400'),(1001189,'修水县','360424','360400'),(1001190,'永修县','360425','360400'),(1001191,'德安县','360426','360400'),(1001192,'都昌县','360428','360400'),(1001193,'湖口县','360429','360400'),(1001194,'彭泽县','360430','360400'),(1001195,'瑞昌市','360481','360400'),(1001196,'共青城市','360482','360400'),(1001197,'庐山市','360483','360400'),(1001198,'渝水区','360502','360500'),(1001199,'分宜县','360521','360500'),(1001200,'月湖区','360602','360600'),(1001201,'余江区','360603','360600'),(1001202,'贵溪市','360681','360600'),(1001203,'章贡区','360702','360700'),(1001204,'南康区','360703','360700'),(1001205,'赣县区','360704','360700'),(1001206,'信丰县','360722','360700'),(1001207,'大余县','360723','360700'),(1001208,'上犹县','360724','360700'),(1001209,'崇义县','360725','360700'),(1001210,'安远县','360726','360700'),(1001211,'定南县','360728','360700'),(1001212,'全南县','360729','360700'),(1001213,'宁都县','360730','360700'),(1001214,'于都县','360731','360700'),(1001215,'兴国县','360732','360700'),(1001216,'会昌县','360733','360700'),(1001217,'寻乌县','360734','360700'),(1001218,'石城县','360735','360700'),(1001219,'瑞金市','360781','360700'),(1001220,'龙南市','360783','360700'),(1001221,'吉州区','360802','360800'),(1001222,'青原区','360803','360800'),(1001223,'吉安县','360821','360800'),(1001224,'吉水县','360822','360800'),(1001225,'峡江县','360823','360800'),(1001226,'新干县','360824','360800'),(1001227,'永丰县','360825','360800'),(1001228,'泰和县','360826','360800'),(1001229,'遂川县','360827','360800'),(1001230,'万安县','360828','360800'),(1001231,'安福县','360829','360800'),(1001232,'永新县','360830','360800'),(1001233,'井冈山市','360881','360800'),(1001234,'袁州区','360902','360900'),(1001235,'奉新县','360921','360900'),(1001236,'万载县','360922','360900'),(1001237,'上高县','360923','360900'),(1001238,'宜丰县','360924','360900'),(1001239,'靖安县','360925','360900'),(1001240,'铜鼓县','360926','360900'),(1001241,'丰城市','360981','360900'),(1001242,'樟树市','360982','360900'),(1001243,'高安市','360983','360900'),(1001244,'临川区','361002','361000'),(1001245,'东乡区','361003','361000'),(1001246,'南城县','361021','361000'),(1001247,'黎川县','361022','361000'),(1001248,'南丰县','361023','361000'),(1001249,'崇仁县','361024','361000'),(1001250,'乐安县','361025','361000'),(1001251,'宜黄县','361026','361000'),(1001252,'金溪县','361027','361000'),(1001253,'资溪县','361028','361000'),(1001254,'广昌县','361030','361000'),(1001255,'信州区','361102','361100'),(1001256,'广丰区','361103','361100'),(1001257,'广信区','361104','361100'),(1001258,'玉山县','361123','361100'),(1001259,'铅山县','361124','361100'),(1001260,'横峰县','361125','361100'),(1001261,'弋阳县','361126','361100'),(1001262,'余干县','361127','361100'),(1001263,'鄱阳县','361128','361100'),(1001264,'万年县','361129','361100'),(1001265,'婺源县','361130','361100'),(1001266,'德兴市','361181','361100'),(1001267,'历下区','370102','370100'),(1001268,'市中区','370103','370100'),(1001269,'槐荫区','370104','370100'),(1001270,'天桥区','370105','370100'),(1001271,'历城区','370112','370100'),(1001272,'长清区','370113','370100'),(1001273,'章丘区','370114','370100'),(1001274,'济阳区','370115','370100'),(1001275,'莱芜区','370116','370100'),(1001276,'钢城区','370117','370100'),(1001277,'平阴县','370124','370100'),(1001278,'商河县','370126','370100'),(1001279,'济南高新技术产业开发区','370171','370100'),(1001280,'市南区','370202','370200'),(1001281,'市北区','370203','370200'),(1001282,'黄岛区','370211','370200'),(1001283,'崂山区','370212','370200'),(1001284,'李沧区','370213','370200'),(1001285,'城阳区','370214','370200'),(1001286,'即墨区','370215','370200'),(1001287,'青岛高新技术产业开发区','370271','370200'),(1001288,'胶州市','370281','370200'),(1001289,'平度市','370283','370200'),(1001290,'莱西市','370285','370200'),(1001291,'淄川区','370302','370300'),(1001292,'张店区','370303','370300'),(1001293,'博山区','370304','370300'),(1001294,'临淄区','370305','370300'),(1001295,'周村区','370306','370300'),(1001296,'桓台县','370321','370300'),(1001297,'高青县','370322','370300'),(1001298,'沂源县','370323','370300'),(1001299,'市中区','370402','370400'),(1001300,'薛城区','370403','370400'),(1001301,'峄城区','370404','370400'),(1001302,'台儿庄区','370405','370400'),(1001303,'山亭区','370406','370400'),(1001304,'滕州市','370481','370400'),(1001305,'东营区','370502','370500'),(1001306,'河口区','370503','370500'),(1001307,'垦利区','370505','370500'),(1001308,'利津县','370522','370500'),(1001309,'广饶县','370523','370500'),(1001310,'东营经济技术开发区','370571','370500'),(1001311,'东营港经济开发区','370572','370500'),(1001312,'芝罘区','370602','370600'),(1001313,'福山区','370611','370600'),(1001314,'牟平区','370612','370600'),(1001315,'莱山区','370613','370600'),(1001316,'蓬莱区','370614','370600'),(1001317,'烟台高新技术产业开发区','370671','370600'),(1001318,'烟台经济技术开发区','370672','370600'),(1001319,'龙口市','370681','370600'),(1001320,'莱阳市','370682','370600'),(1001321,'莱州市','370683','370600'),(1001322,'招远市','370685','370600'),(1001323,'栖霞市','370686','370600'),(1001324,'海阳市','370687','370600'),(1001325,'潍城区','370702','370700'),(1001326,'寒亭区','370703','370700'),(1001327,'坊子区','370704','370700'),(1001328,'奎文区','370705','370700'),(1001329,'临朐县','370724','370700'),(1001330,'昌乐县','370725','370700'),(1001331,'潍坊滨海经济技术开发区','370772','370700'),(1001332,'青州市','370781','370700'),(1001333,'诸城市','370782','370700'),(1001334,'寿光市','370783','370700'),(1001335,'安丘市','370784','370700'),(1001336,'高密市','370785','370700'),(1001337,'昌邑市','370786','370700'),(1001338,'任城区','370811','370800'),(1001339,'兖州区','370812','370800'),(1001340,'微山县','370826','370800'),(1001341,'鱼台县','370827','370800'),(1001342,'金乡县','370828','370800'),(1001343,'嘉祥县','370829','370800'),(1001344,'汶上县','370830','370800'),(1001345,'泗水县','370831','370800'),(1001346,'梁山县','370832','370800'),(1001347,'济宁高新技术产业开发区','370871','370800'),(1001348,'曲阜市','370881','370800'),(1001349,'邹城市','370883','370800'),(1001350,'泰山区','370902','370900'),(1001351,'岱岳区','370911','370900'),(1001352,'宁阳县','370921','370900'),(1001353,'东平县','370923','370900'),(1001354,'新泰市','370982','370900'),(1001355,'肥城市','370983','370900'),(1001356,'环翠区','371002','371000'),(1001357,'文登区','371003','371000'),(1001358,'威海火炬高技术产业开发区','371071','371000'),(1001359,'威海经济技术开发区','371072','371000'),(1001360,'威海临港经济技术开发区','371073','371000'),(1001361,'荣成市','371082','371000'),(1001362,'乳山市','371083','371000'),(1001363,'东港区','371102','371100'),(1001364,'岚山区','371103','371100'),(1001365,'五莲县','371121','371100'),(1001366,'莒县','371122','371100'),(1001367,'日照经济技术开发区','371171','371100'),(1001368,'兰山区','371302','371300'),(1001369,'罗庄区','371311','371300'),(1001370,'河东区','371312','371300'),(1001371,'沂南县','371321','371300'),(1001372,'郯城县','371322','371300'),(1001373,'沂水县','371323','371300'),(1001374,'兰陵县','371324','371300'),(1001375,'费县','371325','371300'),(1001376,'平邑县','371326','371300'),(1001377,'莒南县','371327','371300'),(1001378,'蒙阴县','371328','371300'),(1001379,'临沭县','371329','371300'),(1001380,'临沂高新技术产业开发区','371371','371300'),(1001381,'德城区','371402','371400'),(1001382,'陵城区','371403','371400'),(1001383,'宁津县','371422','371400'),(1001384,'庆云县','371423','371400'),(1001385,'临邑县','371424','371400'),(1001386,'齐河县','371425','371400'),(1001387,'平原县','371426','371400'),(1001388,'夏津县','371427','371400'),(1001389,'武城县','371428','371400'),(1001390,'德州经济技术开发区','371471','371400'),(1001391,'德州运河经济开发区','371472','371400'),(1001392,'乐陵市','371481','371400'),(1001393,'禹城市','371482','371400'),(1001394,'东昌府区','371502','371500'),(1001395,'茌平区','371503','371500'),(1001396,'阳谷县','371521','371500'),(1001397,'莘县','371522','371500'),(1001398,'东阿县','371524','371500'),(1001399,'冠县','371525','371500'),(1001400,'高唐县','371526','371500'),(1001401,'临清市','371581','371500'),(1001402,'滨城区','371602','371600'),(1001403,'沾化区','371603','371600'),(1001404,'惠民县','371621','371600'),(1001405,'阳信县','371622','371600'),(1001406,'无棣县','371623','371600'),(1001407,'博兴县','371625','371600'),(1001408,'邹平市','371681','371600'),(1001409,'牡丹区','371702','371700'),(1001410,'定陶区','371703','371700'),(1001411,'曹县','371721','371700'),(1001412,'单县','371722','371700'),(1001413,'成武县','371723','371700'),(1001414,'巨野县','371724','371700'),(1001415,'郓城县','371725','371700'),(1001416,'鄄城县','371726','371700'),(1001417,'东明县','371728','371700'),(1001418,'菏泽经济技术开发区','371771','371700'),(1001419,'菏泽高新技术开发区','371772','371700'),(1001420,'中原区','410102','410100'),(1001421,'二七区','410103','410100'),(1001422,'管城回族区','410104','410100'),(1001423,'金水区','410105','410100'),(1001424,'上街区','410106','410100'),(1001425,'惠济区','410108','410100'),(1001426,'中牟县','410122','410100'),(1001427,'郑州经济技术开发区','410171','410100'),(1001428,'郑州高新技术产业开发区','410172','410100'),(1001429,'郑州航空港经济综合实验区','410173','410100'),(1001430,'巩义市','410181','410100'),(1001431,'荥阳市','410182','410100'),(1001432,'新密市','410183','410100'),(1001433,'新郑市','410184','410100'),(1001434,'登封市','410185','410100'),(1001435,'龙亭区','410202','410200'),(1001436,'顺河回族区','410203','410200'),(1001437,'鼓楼区','410204','410200'),(1001438,'禹王台区','410205','410200'),(1001439,'祥符区','410212','410200'),(1001440,'杞县','410221','410200'),(1001441,'通许县','410222','410200'),(1001442,'尉氏县','410223','410200'),(1001443,'兰考县','410225','410200'),(1001444,'老城区','410302','410300'),(1001445,'西工区','410303','410300'),(1001446,'瀍河回族区','410304','410300'),(1001447,'涧西区','410305','410300'),(1001448,'吉利区','410306','410300'),(1001449,'洛龙区','410311','410300'),(1001450,'孟津县','410322','410300'),(1001451,'新安县','410323','410300'),(1001452,'栾川县','410324','410300'),(1001453,'嵩县','410325','410300'),(1001454,'汝阳县','410326','410300'),(1001455,'宜阳县','410327','410300'),(1001456,'洛宁县','410328','410300'),(1001457,'伊川县','410329','410300'),(1001458,'洛阳高新技术产业开发区','410371','410300'),(1001459,'偃师市','410381','410300'),(1001460,'新华区','410402','410400'),(1001461,'卫东区','410403','410400'),(1001462,'石龙区','410404','410400'),(1001463,'湛河区','410411','410400'),(1001464,'宝丰县','410421','410400'),(1001465,'叶县','410422','410400'),(1001466,'鲁山县','410423','410400'),(1001467,'郏县','410425','410400'),(1001468,'平顶山高新技术产业开发区','410471','410400'),(1001469,'平顶山市城乡一体化示范区','410472','410400'),(1001470,'舞钢市','410481','410400'),(1001471,'汝州市','410482','410400'),(1001472,'文峰区','410502','410500'),(1001473,'北关区','410503','410500'),(1001474,'殷都区','410505','410500'),(1001475,'龙安区','410506','410500'),(1001476,'安阳县','410522','410500'),(1001477,'汤阴县','410523','410500'),(1001478,'滑县','410526','410500'),(1001479,'内黄县','410527','410500'),(1001480,'安阳高新技术产业开发区','410571','410500'),(1001481,'林州市','410581','410500'),(1001482,'鹤山区','410602','410600'),(1001483,'山城区','410603','410600'),(1001484,'淇滨区','410611','410600'),(1001485,'浚县','410621','410600'),(1001486,'淇县','410622','410600'),(1001487,'鹤壁经济技术开发区','410671','410600'),(1001488,'红旗区','410702','410700'),(1001489,'卫滨区','410703','410700'),(1001490,'凤泉区','410704','410700'),(1001491,'牧野区','410711','410700'),(1001492,'新乡县','410721','410700'),(1001493,'获嘉县','410724','410700'),(1001494,'原阳县','410725','410700'),(1001495,'延津县','410726','410700'),(1001496,'封丘县','410727','410700'),(1001497,'新乡高新技术产业开发区','410771','410700'),(1001498,'新乡经济技术开发区','410772','410700'),(1001499,'新乡市平原城乡一体化示范区','410773','410700'),(1001500,'卫辉市','410781','410700'),(1001501,'辉县市','410782','410700'),(1001502,'长垣市','410783','410700'),(1001503,'解放区','410802','410800'),(1001504,'中站区','410803','410800'),(1001505,'马村区','410804','410800'),(1001506,'山阳区','410811','410800'),(1001507,'修武县','410821','410800'),(1001508,'博爱县','410822','410800'),(1001509,'武陟县','410823','410800'),(1001510,'温县','410825','410800'),(1001511,'焦作城乡一体化示范区','410871','410800'),(1001512,'沁阳市','410882','410800'),(1001513,'孟州市','410883','410800'),(1001514,'华龙区','410902','410900'),(1001515,'清丰县','410922','410900'),(1001516,'南乐县','410923','410900'),(1001517,'范县','410926','410900'),(1001518,'台前县','410927','410900'),(1001519,'濮阳县','410928','410900'),(1001520,'河南濮阳工业园区','410971','410900'),(1001521,'濮阳经济技术开发区','410972','410900'),(1001522,'魏都区','411002','411000'),(1001523,'建安区','411003','411000'),(1001524,'鄢陵县','411024','411000'),(1001525,'襄城县','411025','411000'),(1001526,'许昌经济技术开发区','411071','411000'),(1001527,'禹州市','411081','411000'),(1001528,'长葛市','411082','411000'),(1001529,'源汇区','411102','411100'),(1001530,'郾城区','411103','411100'),(1001531,'召陵区','411104','411100'),(1001532,'舞阳县','411121','411100'),(1001533,'临颍县','411122','411100'),(1001534,'漯河经济技术开发区','411171','411100'),(1001535,'湖滨区','411202','411200'),(1001536,'陕州区','411203','411200'),(1001537,'渑池县','411221','411200'),(1001538,'卢氏县','411224','411200'),(1001539,'河南三门峡经济开发区','411271','411200'),(1001540,'义马市','411281','411200'),(1001541,'灵宝市','411282','411200'),(1001542,'宛城区','411302','411300'),(1001543,'卧龙区','411303','411300'),(1001544,'南召县','411321','411300'),(1001545,'方城县','411322','411300'),(1001546,'西峡县','411323','411300'),(1001547,'镇平县','411324','411300'),(1001548,'内乡县','411325','411300'),(1001549,'淅川县','411326','411300'),(1001550,'社旗县','411327','411300'),(1001551,'唐河县','411328','411300'),(1001552,'新野县','411329','411300'),(1001553,'桐柏县','411330','411300'),(1001554,'南阳高新技术产业开发区','411371','411300'),(1001555,'南阳市城乡一体化示范区','411372','411300'),(1001556,'邓州市','411381','411300'),(1001557,'梁园区','411402','411400'),(1001558,'睢阳区','411403','411400'),(1001559,'民权县','411421','411400'),(1001560,'睢县','411422','411400'),(1001561,'宁陵县','411423','411400'),(1001562,'柘城县','411424','411400'),(1001563,'虞城县','411425','411400'),(1001564,'夏邑县','411426','411400'),(1001565,'豫东综合物流产业聚集区','411471','411400'),(1001566,'河南商丘经济开发区','411472','411400'),(1001567,'永城市','411481','411400'),(1001568,'浉河区','411502','411500'),(1001569,'平桥区','411503','411500'),(1001570,'罗山县','411521','411500'),(1001571,'光山县','411522','411500'),(1001572,'新县','411523','411500'),(1001573,'商城县','411524','411500'),(1001574,'固始县','411525','411500'),(1001575,'潢川县','411526','411500'),(1001576,'淮滨县','411527','411500'),(1001577,'息县','411528','411500'),(1001578,'信阳高新技术产业开发区','411571','411500'),(1001579,'川汇区','411602','411600'),(1001580,'淮阳区','411603','411600'),(1001581,'扶沟县','411621','411600'),(1001582,'西华县','411622','411600'),(1001583,'商水县','411623','411600'),(1001584,'沈丘县','411624','411600'),(1001585,'郸城县','411625','411600'),(1001586,'太康县','411627','411600'),(1001587,'鹿邑县','411628','411600'),(1001588,'河南周口经济开发区','411671','411600'),(1001589,'项城市','411681','411600'),(1001590,'驿城区','411702','411700'),(1001591,'西平县','411721','411700'),(1001592,'上蔡县','411722','411700'),(1001593,'平舆县','411723','411700'),(1001594,'正阳县','411724','411700'),(1001595,'确山县','411725','411700'),(1001596,'泌阳县','411726','411700'),(1001597,'汝南县','411727','411700'),(1001598,'遂平县','411728','411700'),(1001599,'新蔡县','411729','411700'),(1001600,'河南驻马店经济开发区','411771','411700'),(1001601,'济源市','419001','419000'),(1001602,'江岸区','420102','420100'),(1001603,'江汉区','420103','420100'),(1001604,'硚口区','420104','420100'),(1001605,'汉阳区','420105','420100'),(1001606,'武昌区','420106','420100'),(1001607,'青山区','420107','420100'),(1001608,'洪山区','420111','420100'),(1001609,'东西湖区','420112','420100'),(1001610,'汉南区','420113','420100'),(1001611,'蔡甸区','420114','420100'),(1001612,'江夏区','420115','420100'),(1001613,'黄陂区','420116','420100'),(1001614,'新洲区','420117','420100'),(1001615,'黄石港区','420202','420200'),(1001616,'西塞山区','420203','420200'),(1001617,'下陆区','420204','420200'),(1001618,'铁山区','420205','420200'),(1001619,'阳新县','420222','420200'),(1001620,'大冶市','420281','420200'),(1001621,'茅箭区','420302','420300'),(1001622,'张湾区','420303','420300'),(1001623,'郧阳区','420304','420300'),(1001624,'郧西县','420322','420300'),(1001625,'竹山县','420323','420300'),(1001626,'竹溪县','420324','420300'),(1001627,'房县','420325','420300'),(1001628,'丹江口市','420381','420300'),(1001629,'西陵区','420502','420500'),(1001630,'伍家岗区','420503','420500'),(1001631,'点军区','420504','420500'),(1001632,'猇亭区','420505','420500'),(1001633,'夷陵区','420506','420500'),(1001634,'远安县','420525','420500'),(1001635,'兴山县','420526','420500'),(1001636,'秭归县','420527','420500'),(1001637,'长阳土家族自治县','420528','420500'),(1001638,'五峰土家族自治县','420529','420500'),(1001639,'宜都市','420581','420500'),(1001640,'当阳市','420582','420500'),(1001641,'枝江市','420583','420500'),(1001642,'襄城区','420602','420600'),(1001643,'樊城区','420606','420600'),(1001644,'襄州区','420607','420600'),(1001645,'南漳县','420624','420600'),(1001646,'谷城县','420625','420600'),(1001647,'保康县','420626','420600'),(1001648,'老河口市','420682','420600'),(1001649,'枣阳市','420683','420600'),(1001650,'宜城市','420684','420600'),(1001651,'梁子湖区','420702','420700'),(1001652,'华容区','420703','420700'),(1001653,'鄂城区','420704','420700'),(1001654,'东宝区','420802','420800'),(1001655,'掇刀区','420804','420800'),(1001656,'沙洋县','420822','420800'),(1001657,'钟祥市','420881','420800'),(1001658,'京山市','420882','420800'),(1001659,'孝南区','420902','420900'),(1001660,'孝昌县','420921','420900'),(1001661,'大悟县','420922','420900'),(1001662,'云梦县','420923','420900'),(1001663,'应城市','420981','420900'),(1001664,'安陆市','420982','420900'),(1001665,'汉川市','420984','420900'),(1001666,'沙市区','421002','421000'),(1001667,'荆州区','421003','421000'),(1001668,'公安县','421022','421000'),(1001669,'监利县','421023','421000'),(1001670,'江陵县','421024','421000'),(1001671,'荆州经济技术开发区','421071','421000'),(1001672,'石首市','421081','421000'),(1001673,'洪湖市','421083','421000'),(1001674,'松滋市','421087','421000'),(1001675,'黄州区','421102','421100'),(1001676,'团风县','421121','421100'),(1001677,'红安县','421122','421100'),(1001678,'罗田县','421123','421100'),(1001679,'英山县','421124','421100'),(1001680,'浠水县','421125','421100'),(1001681,'蕲春县','421126','421100'),(1001682,'黄梅县','421127','421100'),(1001683,'龙感湖管理区','421171','421100'),(1001684,'麻城市','421181','421100'),(1001685,'武穴市','421182','421100'),(1001686,'咸安区','421202','421200'),(1001687,'嘉鱼县','421221','421200'),(1001688,'通城县','421222','421200'),(1001689,'崇阳县','421223','421200'),(1001690,'通山县','421224','421200'),(1001691,'赤壁市','421281','421200'),(1001692,'曾都区','421303','421300'),(1001693,'随县','421321','421300'),(1001694,'广水市','421381','421300'),(1001695,'恩施市','422801','422800'),(1001696,'利川市','422802','422800'),(1001697,'建始县','422822','422800'),(1001698,'巴东县','422823','422800'),(1001699,'宣恩县','422825','422800'),(1001700,'咸丰县','422826','422800'),(1001701,'来凤县','422827','422800'),(1001702,'鹤峰县','422828','422800'),(1001703,'仙桃市','429004','429000'),(1001704,'潜江市','429005','429000'),(1001705,'天门市','429006','429000'),(1001706,'神农架林区','429021','429000'),(1001707,'芙蓉区','430102','430100'),(1001708,'天心区','430103','430100'),(1001709,'岳麓区','430104','430100'),(1001710,'开福区','430105','430100'),(1001711,'雨花区','430111','430100'),(1001712,'望城区','430112','430100'),(1001713,'长沙县','430121','430100'),(1001714,'浏阳市','430181','430100'),(1001715,'宁乡市','430182','430100'),(1001716,'荷塘区','430202','430200'),(1001717,'芦淞区','430203','430200'),(1001718,'石峰区','430204','430200'),(1001719,'天元区','430211','430200'),(1001720,'渌口区','430212','430200'),(1001721,'攸县','430223','430200'),(1001722,'茶陵县','430224','430200'),(1001723,'炎陵县','430225','430200'),(1001724,'云龙示范区','430271','430200'),(1001725,'醴陵市','430281','430200'),(1001726,'雨湖区','430302','430300'),(1001727,'岳塘区','430304','430300'),(1001728,'湘潭县','430321','430300'),(1001729,'湖南湘潭高新技术产业园区','430371','430300'),(1001730,'湘潭昭山示范区','430372','430300'),(1001731,'湘潭九华示范区','430373','430300'),(1001732,'湘乡市','430381','430300'),(1001733,'韶山市','430382','430300'),(1001734,'珠晖区','430405','430400'),(1001735,'雁峰区','430406','430400'),(1001736,'石鼓区','430407','430400'),(1001737,'蒸湘区','430408','430400'),(1001738,'南岳区','430412','430400'),(1001739,'衡阳县','430421','430400'),(1001740,'衡南县','430422','430400'),(1001741,'衡山县','430423','430400'),(1001742,'衡东县','430424','430400'),(1001743,'祁东县','430426','430400'),(1001744,'衡阳综合保税区','430471','430400'),(1001745,'湖南衡阳高新技术产业园区','430472','430400'),(1001746,'湖南衡阳松木经济开发区','430473','430400'),(1001747,'耒阳市','430481','430400'),(1001748,'常宁市','430482','430400'),(1001749,'双清区','430502','430500'),(1001750,'大祥区','430503','430500'),(1001751,'北塔区','430511','430500'),(1001752,'新邵县','430522','430500'),(1001753,'邵阳县','430523','430500'),(1001754,'隆回县','430524','430500'),(1001755,'洞口县','430525','430500'),(1001756,'绥宁县','430527','430500'),(1001757,'新宁县','430528','430500'),(1001758,'城步苗族自治县','430529','430500'),(1001759,'武冈市','430581','430500'),(1001760,'邵东市','430582','430500'),(1001761,'岳阳楼区','430602','430600'),(1001762,'云溪区','430603','430600'),(1001763,'君山区','430611','430600'),(1001764,'岳阳县','430621','430600'),(1001765,'华容县','430623','430600'),(1001766,'湘阴县','430624','430600'),(1001767,'平江县','430626','430600'),(1001768,'岳阳市屈原管理区','430671','430600'),(1001769,'汨罗市','430681','430600'),(1001770,'临湘市','430682','430600'),(1001771,'武陵区','430702','430700'),(1001772,'鼎城区','430703','430700'),(1001773,'安乡县','430721','430700'),(1001774,'汉寿县','430722','430700'),(1001775,'澧县','430723','430700'),(1001776,'临澧县','430724','430700'),(1001777,'桃源县','430725','430700'),(1001778,'石门县','430726','430700'),(1001779,'常德市西洞庭管理区','430771','430700'),(1001780,'津市市','430781','430700'),(1001781,'永定区','430802','430800'),(1001782,'武陵源区','430811','430800'),(1001783,'慈利县','430821','430800'),(1001784,'桑植县','430822','430800'),(1001785,'资阳区','430902','430900'),(1001786,'赫山区','430903','430900'),(1001787,'南县','430921','430900'),(1001788,'桃江县','430922','430900'),(1001789,'安化县','430923','430900'),(1001790,'益阳市大通湖管理区','430971','430900'),(1001791,'湖南益阳高新技术产业园区','430972','430900'),(1001792,'沅江市','430981','430900'),(1001793,'北湖区','431002','431000'),(1001794,'苏仙区','431003','431000'),(1001795,'桂阳县','431021','431000'),(1001796,'宜章县','431022','431000'),(1001797,'永兴县','431023','431000'),(1001798,'嘉禾县','431024','431000'),(1001799,'临武县','431025','431000'),(1001800,'汝城县','431026','431000'),(1001801,'桂东县','431027','431000'),(1001802,'安仁县','431028','431000'),(1001803,'资兴市','431081','431000'),(1001804,'零陵区','431102','431100'),(1001805,'冷水滩区','431103','431100'),(1001806,'祁阳县','431121','431100'),(1001807,'东安县','431122','431100'),(1001808,'双牌县','431123','431100'),(1001809,'道县','431124','431100'),(1001810,'江永县','431125','431100'),(1001811,'宁远县','431126','431100'),(1001812,'蓝山县','431127','431100'),(1001813,'新田县','431128','431100'),(1001814,'江华瑶族自治县','431129','431100'),(1001815,'永州经济技术开发区','431171','431100'),(1001816,'永州市金洞管理区','431172','431100'),(1001817,'永州市回龙圩管理区','431173','431100'),(1001818,'鹤城区','431202','431200'),(1001819,'中方县','431221','431200'),(1001820,'沅陵县','431222','431200'),(1001821,'辰溪县','431223','431200'),(1001822,'溆浦县','431224','431200'),(1001823,'会同县','431225','431200'),(1001824,'麻阳苗族自治县','431226','431200'),(1001825,'新晃侗族自治县','431227','431200'),(1001826,'芷江侗族自治县','431228','431200'),(1001827,'靖州苗族侗族自治县','431229','431200'),(1001828,'通道侗族自治县','431230','431200'),(1001829,'怀化市洪江管理区','431271','431200'),(1001830,'洪江市','431281','431200'),(1001831,'娄星区','431302','431300'),(1001832,'双峰县','431321','431300'),(1001833,'新化县','431322','431300'),(1001834,'冷水江市','431381','431300'),(1001835,'涟源市','431382','431300'),(1001836,'吉首市','433101','433100'),(1001837,'泸溪县','433122','433100'),(1001838,'凤凰县','433123','433100'),(1001839,'花垣县','433124','433100'),(1001840,'保靖县','433125','433100'),(1001841,'古丈县','433126','433100'),(1001842,'永顺县','433127','433100'),(1001843,'龙山县','433130','433100'),(1001844,'荔湾区','440103','440100'),(1001845,'越秀区','440104','440100'),(1001846,'海珠区','440105','440100'),(1001847,'天河区','440106','440100'),(1001848,'白云区','440111','440100'),(1001849,'黄埔区','440112','440100'),(1001850,'番禺区','440113','440100'),(1001851,'花都区','440114','440100'),(1001852,'南沙区','440115','440100'),(1001853,'从化区','440117','440100'),(1001854,'增城区','440118','440100'),(1001855,'武江区','440203','440200'),(1001856,'浈江区','440204','440200'),(1001857,'曲江区','440205','440200'),(1001858,'始兴县','440222','440200'),(1001859,'仁化县','440224','440200'),(1001860,'翁源县','440229','440200'),(1001861,'乳源瑶族自治县','440232','440200'),(1001862,'新丰县','440233','440200'),(1001863,'乐昌市','440281','440200'),(1001864,'南雄市','440282','440200'),(1001865,'罗湖区','440303','440300'),(1001866,'福田区','440304','440300'),(1001867,'南山区','440305','440300'),(1001868,'宝安区','440306','440300'),(1001869,'龙岗区','440307','440300'),(1001870,'盐田区','440308','440300'),(1001871,'龙华区','440309','440300'),(1001872,'坪山区','440310','440300'),(1001873,'光明区','440311','440300'),(1001874,'香洲区','440402','440400'),(1001875,'斗门区','440403','440400'),(1001876,'金湾区','440404','440400'),(1001877,'龙湖区','440507','440500'),(1001878,'金平区','440511','440500'),(1001879,'濠江区','440512','440500'),(1001880,'潮阳区','440513','440500'),(1001881,'潮南区','440514','440500'),(1001882,'澄海区','440515','440500'),(1001883,'南澳县','440523','440500'),(1001884,'禅城区','440604','440600'),(1001885,'南海区','440605','440600'),(1001886,'顺德区','440606','440600'),(1001887,'三水区','440607','440600'),(1001888,'高明区','440608','440600'),(1001889,'蓬江区','440703','440700'),(1001890,'江海区','440704','440700'),(1001891,'新会区','440705','440700'),(1001892,'台山市','440781','440700'),(1001893,'开平市','440783','440700'),(1001894,'鹤山市','440784','440700'),(1001895,'恩平市','440785','440700'),(1001896,'赤坎区','440802','440800'),(1001897,'霞山区','440803','440800'),(1001898,'坡头区','440804','440800'),(1001899,'麻章区','440811','440800'),(1001900,'遂溪县','440823','440800'),(1001901,'徐闻县','440825','440800'),(1001902,'廉江市','440881','440800'),(1001903,'雷州市','440882','440800'),(1001904,'吴川市','440883','440800'),(1001905,'茂南区','440902','440900'),(1001906,'电白区','440904','440900'),(1001907,'高州市','440981','440900'),(1001908,'化州市','440982','440900'),(1001909,'信宜市','440983','440900'),(1001910,'端州区','441202','441200'),(1001911,'鼎湖区','441203','441200'),(1001912,'高要区','441204','441200'),(1001913,'广宁县','441223','441200'),(1001914,'怀集县','441224','441200'),(1001915,'封开县','441225','441200'),(1001916,'德庆县','441226','441200'),(1001917,'四会市','441284','441200'),(1001918,'惠城区','441302','441300'),(1001919,'惠阳区','441303','441300'),(1001920,'博罗县','441322','441300'),(1001921,'惠东县','441323','441300'),(1001922,'龙门县','441324','441300'),(1001923,'梅江区','441402','441400'),(1001924,'梅县区','441403','441400'),(1001925,'大埔县','441422','441400'),(1001926,'丰顺县','441423','441400'),(1001927,'五华县','441424','441400'),(1001928,'平远县','441426','441400'),(1001929,'蕉岭县','441427','441400'),(1001930,'兴宁市','441481','441400'),(1001931,'城区','441502','441500'),(1001932,'海丰县','441521','441500'),(1001933,'陆河县','441523','441500'),(1001934,'陆丰市','441581','441500'),(1001935,'源城区','441602','441600'),(1001936,'紫金县','441621','441600'),(1001937,'龙川县','441622','441600'),(1001938,'连平县','441623','441600'),(1001939,'和平县','441624','441600'),(1001940,'东源县','441625','441600'),(1001941,'江城区','441702','441700'),(1001942,'阳东区','441704','441700'),(1001943,'阳西县','441721','441700'),(1001944,'阳春市','441781','441700'),(1001945,'清城区','441802','441800'),(1001946,'清新区','441803','441800'),(1001947,'佛冈县','441821','441800'),(1001948,'阳山县','441823','441800'),(1001949,'连山壮族瑶族自治县','441825','441800'),(1001950,'连南瑶族自治县','441826','441800'),(1001951,'英德市','441881','441800'),(1001952,'连州市','441882','441800'),(1001953,'东城街道','441900003','441900'),(1001954,'南城街道','441900004','441900'),(1001955,'万江街道','441900005','441900'),(1001956,'莞城街道','441900006','441900'),(1001957,'石碣镇','441900101','441900'),(1001958,'石龙镇','441900102','441900'),(1001959,'茶山镇','441900103','441900'),(1001960,'石排镇','441900104','441900'),(1001961,'企石镇','441900105','441900'),(1001962,'横沥镇','441900106','441900'),(1001963,'桥头镇','441900107','441900'),(1001964,'谢岗镇','441900108','441900'),(1001965,'东坑镇','441900109','441900'),(1001966,'常平镇','44190011','441900'),(1001967,'寮步镇','441900111','441900'),(1001968,'樟木头镇','441900112','441900'),(1001969,'大朗镇','441900113','441900'),(1001970,'黄江镇','441900114','441900'),(1001971,'清溪镇','441900115','441900'),(1001972,'塘厦镇','441900116','441900'),(1001973,'凤岗镇','441900117','441900'),(1001974,'大岭山镇','441900118','441900'),(1001975,'长安镇','441900119','441900'),(1001976,'虎门镇','441900121','441900'),(1001977,'厚街镇','441900122','441900'),(1001978,'沙田镇','441900123','441900'),(1001979,'道滘镇','441900124','441900'),(1001980,'洪梅镇','441900125','441900'),(1001981,'麻涌镇','441900126','441900'),(1001982,'望牛墩镇','441900127','441900'),(1001983,'中堂镇','441900128','441900'),(1001984,'高埗镇','441900129','441900'),(1001985,'松山湖','441900401','441900'),(1001986,'东莞港','441900402','441900'),(1001987,'东莞生态园','441900403','441900'),(1001988,'石岐街道','442000001','442000'),(1001989,'东区街道','442000002','442000'),(1001990,'中山港街道','442000003','442000'),(1001991,'西区街道','442000004','442000'),(1001992,'南区街道','442000005','442000'),(1001993,'五桂山街道','442000006','442000'),(1001994,'小榄镇','4420001','442000'),(1001995,'黄圃镇','442000101','442000'),(1001996,'民众镇','442000102','442000'),(1001997,'东凤镇','442000103','442000'),(1001998,'东升镇','442000104','442000'),(1001999,'古镇镇','442000105','442000'),(1002000,'沙溪镇','442000106','442000'),(1002001,'坦洲镇','442000107','442000'),(1002002,'港口镇','442000108','442000'),(1002003,'三角镇','442000109','442000'),(1002004,'横栏镇','44200011','442000'),(1002005,'南头镇','442000111','442000'),(1002006,'阜沙镇','442000112','442000'),(1002007,'南朗镇','442000113','442000'),(1002008,'三乡镇','442000114','442000'),(1002009,'板芙镇','442000115','442000'),(1002010,'大涌镇','442000116','442000'),(1002011,'神湾镇','442000117','442000'),(1002012,'湘桥区','445102','445100'),(1002013,'潮安区','445103','445100'),(1002014,'饶平县','445122','445100'),(1002015,'榕城区','445202','445200'),(1002016,'揭东区','445203','445200'),(1002017,'揭西县','445222','445200'),(1002018,'惠来县','445224','445200'),(1002019,'普宁市','445281','445200'),(1002020,'云城区','445302','445300'),(1002021,'云安区','445303','445300'),(1002022,'新兴县','445321','445300'),(1002023,'郁南县','445322','445300'),(1002024,'罗定市','445381','445300'),(1002025,'兴宁区','450102','450100'),(1002026,'青秀区','450103','450100'),(1002027,'江南区','450105','450100'),(1002028,'西乡塘区','450107','450100'),(1002029,'良庆区','450108','450100'),(1002030,'邕宁区','450109','450100'),(1002031,'武鸣区','450110','450100'),(1002032,'隆安县','450123','450100'),(1002033,'马山县','450124','450100'),(1002034,'上林县','450125','450100'),(1002035,'宾阳县','450126','450100'),(1002036,'横县','450127','450100'),(1002037,'城中区','450202','450200'),(1002038,'鱼峰区','450203','450200'),(1002039,'柳南区','450204','450200'),(1002040,'柳北区','450205','450200'),(1002041,'柳江区','450206','450200'),(1002042,'柳城县','450222','450200'),(1002043,'鹿寨县','450223','450200'),(1002044,'融安县','450224','450200'),(1002045,'融水苗族自治县','450225','450200'),(1002046,'三江侗族自治县','450226','450200'),(1002047,'秀峰区','450302','450300'),(1002048,'叠彩区','450303','450300'),(1002049,'象山区','450304','450300'),(1002050,'七星区','450305','450300'),(1002051,'雁山区','450311','450300'),(1002052,'临桂区','450312','450300'),(1002053,'阳朔县','450321','450300'),(1002054,'灵川县','450323','450300'),(1002055,'全州县','450324','450300'),(1002056,'兴安县','450325','450300'),(1002057,'永福县','450326','450300'),(1002058,'灌阳县','450327','450300'),(1002059,'龙胜各族自治县','450328','450300'),(1002060,'资源县','450329','450300'),(1002061,'平乐县','450330','450300'),(1002062,'恭城瑶族自治县','450332','450300'),(1002063,'荔浦市','450381','450300'),(1002064,'万秀区','450403','450400'),(1002065,'长洲区','450405','450400'),(1002066,'龙圩区','450406','450400'),(1002067,'苍梧县','450421','450400'),(1002068,'藤县','450422','450400'),(1002069,'蒙山县','450423','450400'),(1002070,'岑溪市','450481','450400'),(1002071,'海城区','450502','450500'),(1002072,'银海区','450503','450500'),(1002073,'铁山港区','450512','450500'),(1002074,'合浦县','450521','450500'),(1002075,'港口区','450602','450600'),(1002076,'防城区','450603','450600'),(1002077,'上思县','450621','450600'),(1002078,'东兴市','450681','450600'),(1002079,'钦南区','450702','450700'),(1002080,'钦北区','450703','450700'),(1002081,'灵山县','450721','450700'),(1002082,'浦北县','450722','450700'),(1002083,'港北区','450802','450800'),(1002084,'港南区','450803','450800'),(1002085,'覃塘区','450804','450800'),(1002086,'平南县','450821','450800'),(1002087,'桂平市','450881','450800'),(1002088,'玉州区','450902','450900'),(1002089,'福绵区','450903','450900'),(1002090,'容县','450921','450900'),(1002091,'陆川县','450922','450900'),(1002092,'博白县','450923','450900'),(1002093,'兴业县','450924','450900'),(1002094,'北流市','450981','450900'),(1002095,'右江区','451002','451000'),(1002096,'田阳区','451003','451000'),(1002097,'田东县','451022','451000'),(1002098,'德保县','451024','451000'),(1002099,'那坡县','451026','451000'),(1002100,'凌云县','451027','451000'),(1002101,'乐业县','451028','451000'),(1002102,'田林县','451029','451000'),(1002103,'西林县','451030','451000'),(1002104,'隆林各族自治县','451031','451000'),(1002105,'靖西市','451081','451000'),(1002106,'平果市','451082','451000'),(1002107,'八步区','451102','451100'),(1002108,'平桂区','451103','451100'),(1002109,'昭平县','451121','451100'),(1002110,'钟山县','451122','451100'),(1002111,'富川瑶族自治县','451123','451100'),(1002112,'金城江区','451202','451200'),(1002113,'宜州区','451203','451200'),(1002114,'南丹县','451221','451200'),(1002115,'天峨县','451222','451200'),(1002116,'凤山县','451223','451200'),(1002117,'东兰县','451224','451200'),(1002118,'罗城仫佬族自治县','451225','451200'),(1002119,'环江毛南族自治县','451226','451200'),(1002120,'巴马瑶族自治县','451227','451200'),(1002121,'都安瑶族自治县','451228','451200'),(1002122,'大化瑶族自治县','451229','451200'),(1002123,'兴宾区','451302','451300'),(1002124,'忻城县','451321','451300'),(1002125,'象州县','451322','451300'),(1002126,'武宣县','451323','451300'),(1002127,'金秀瑶族自治县','451324','451300'),(1002128,'合山市','451381','451300'),(1002129,'江州区','451402','451400'),(1002130,'扶绥县','451421','451400'),(1002131,'宁明县','451422','451400'),(1002132,'龙州县','451423','451400'),(1002133,'大新县','451424','451400'),(1002134,'天等县','451425','451400'),(1002135,'凭祥市','451481','451400'),(1002136,'秀英区','460105','460100'),(1002137,'龙华区','460106','460100'),(1002138,'琼山区','460107','460100'),(1002139,'美兰区','460108','460100'),(1002140,'海棠区','460202','460200'),(1002141,'吉阳区','460203','460200'),(1002142,'天涯区','460204','460200'),(1002143,'崖州区','460205','460200'),(1002144,'西沙群岛','460321','460300'),(1002145,'南沙群岛','460322','460300'),(1002146,'中沙群岛的岛礁及其海域','460323','460300'),(1002147,'那大镇','4604001','460400'),(1002148,'和庆镇','460400101','460400'),(1002149,'南丰镇','460400102','460400'),(1002150,'大成镇','460400103','460400'),(1002151,'雅星镇','460400104','460400'),(1002152,'兰洋镇','460400105','460400'),(1002153,'光村镇','460400106','460400'),(1002154,'木棠镇','460400107','460400'),(1002155,'海头镇','460400108','460400'),(1002156,'峨蔓镇','460400109','460400'),(1002157,'王五镇','460400111','460400'),(1002158,'白马井镇','460400112','460400'),(1002159,'中和镇','460400113','460400'),(1002160,'排浦镇','460400114','460400'),(1002161,'东成镇','460400115','460400'),(1002162,'新州镇','460400116','460400'),(1002163,'洋浦经济开发区','460400499','460400'),(1002164,'华南热作学院','4604005','460400'),(1002165,'五指山市','469001','469000'),(1002166,'琼海市','469002','469000'),(1002167,'文昌市','469005','469000'),(1002168,'万宁市','469006','469000'),(1002169,'东方市','469007','469000'),(1002170,'定安县','469021','469000'),(1002171,'屯昌县','469022','469000'),(1002172,'澄迈县','469023','469000'),(1002173,'临高县','469024','469000'),(1002174,'白沙黎族自治县','469025','469000'),(1002175,'昌江黎族自治县','469026','469000'),(1002176,'乐东黎族自治县','469027','469000'),(1002177,'陵水黎族自治县','469028','469000'),(1002178,'保亭黎族苗族自治县','469029','469000'),(1002179,'琼中黎族苗族自治县','469030','469000'),(1002180,'万州区','500101','500100'),(1002181,'涪陵区','500102','500100'),(1002182,'渝中区','500103','500100'),(1002183,'大渡口区','500104','500100'),(1002184,'江北区','500105','500100'),(1002185,'沙坪坝区','500106','500100'),(1002186,'九龙坡区','500107','500100'),(1002187,'南岸区','500108','500100'),(1002188,'北碚区','500109','500100'),(1002189,'綦江区','500110','500100'),(1002190,'大足区','500111','500100'),(1002191,'渝北区','500112','500100'),(1002192,'巴南区','500113','500100'),(1002193,'黔江区','500114','500100'),(1002194,'长寿区','500115','500100'),(1002195,'江津区','500116','500100'),(1002196,'合川区','500117','500100'),(1002197,'永川区','500118','500100'),(1002198,'南川区','500119','500100'),(1002199,'璧山区','500120','500100'),(1002200,'铜梁区','500151','500100'),(1002201,'潼南区','500152','500100'),(1002202,'荣昌区','500153','500100'),(1002203,'开州区','500154','500100'),(1002204,'梁平区','500155','500100'),(1002205,'武隆区','500156','500100'),(1002206,'城口县','500229','500200'),(1002207,'丰都县','500230','500200'),(1002208,'垫江县','500231','500200'),(1002209,'忠县','500233','500200'),(1002210,'云阳县','500235','500200'),(1002211,'奉节县','500236','500200'),(1002212,'巫山县','500237','500200'),(1002213,'巫溪县','500238','500200'),(1002214,'石柱土家族自治县','500240','500200'),(1002215,'秀山土家族苗族自治县','500241','500200'),(1002216,'酉阳土家族苗族自治县','500242','500200'),(1002217,'彭水苗族土家族自治县','500243','500200'),(1002218,'锦江区','510104','510100'),(1002219,'青羊区','510105','510100'),(1002220,'金牛区','510106','510100'),(1002221,'武侯区','510107','510100'),(1002222,'成华区','510108','510100'),(1002223,'龙泉驿区','510112','510100'),(1002224,'青白江区','510113','510100'),(1002225,'新都区','510114','510100'),(1002226,'温江区','510115','510100'),(1002227,'双流区','510116','510100'),(1002228,'郫都区','510117','510100'),(1002229,'新津区','510118','510100'),(1002230,'金堂县','510121','510100'),(1002231,'大邑县','510129','510100'),(1002232,'蒲江县','510131','510100'),(1002233,'都江堰市','510181','510100'),(1002234,'彭州市','510182','510100'),(1002235,'邛崃市','510183','510100'),(1002236,'崇州市','510184','510100'),(1002237,'简阳市','510185','510100'),(1002238,'自流井区','510302','510300'),(1002239,'贡井区','510303','510300'),(1002240,'大安区','510304','510300'),(1002241,'沿滩区','510311','510300'),(1002242,'荣县','510321','510300'),(1002243,'富顺县','510322','510300'),(1002244,'东区','510402','510400'),(1002245,'西区','510403','510400'),(1002246,'仁和区','510411','510400'),(1002247,'米易县','510421','510400'),(1002248,'盐边县','510422','510400'),(1002249,'江阳区','510502','510500'),(1002250,'纳溪区','510503','510500'),(1002251,'龙马潭区','510504','510500'),(1002252,'泸县','510521','510500'),(1002253,'合江县','510522','510500'),(1002254,'叙永县','510524','510500'),(1002255,'古蔺县','510525','510500'),(1002256,'旌阳区','510603','510600'),(1002257,'罗江区','510604','510600'),(1002258,'中江县','510623','510600'),(1002259,'广汉市','510681','510600'),(1002260,'什邡市','510682','510600'),(1002261,'绵竹市','510683','510600'),(1002262,'涪城区','510703','510700'),(1002263,'游仙区','510704','510700'),(1002264,'安州区','510705','510700'),(1002265,'三台县','510722','510700'),(1002266,'盐亭县','510723','510700'),(1002267,'梓潼县','510725','510700'),(1002268,'北川羌族自治县','510726','510700'),(1002269,'平武县','510727','510700'),(1002270,'江油市','510781','510700'),(1002271,'利州区','510802','510800'),(1002272,'昭化区','510811','510800'),(1002273,'朝天区','510812','510800'),(1002274,'旺苍县','510821','510800'),(1002275,'青川县','510822','510800'),(1002276,'剑阁县','510823','510800'),(1002277,'苍溪县','510824','510800'),(1002278,'船山区','510903','510900'),(1002279,'安居区','510904','510900'),(1002280,'蓬溪县','510921','510900'),(1002281,'大英县','510923','510900'),(1002282,'射洪市','510981','510900'),(1002283,'市中区','511002','511000'),(1002284,'东兴区','511011','511000'),(1002285,'威远县','511024','511000'),(1002286,'资中县','511025','511000'),(1002287,'内江经济开发区','511071','511000'),(1002288,'隆昌市','511083','511000'),(1002289,'市中区','511102','511100'),(1002290,'沙湾区','511111','511100'),(1002291,'五通桥区','511112','511100'),(1002292,'金口河区','511113','511100'),(1002293,'犍为县','511123','511100'),(1002294,'井研县','511124','511100'),(1002295,'夹江县','511126','511100'),(1002296,'沐川县','511129','511100'),(1002297,'峨边彝族自治县','511132','511100'),(1002298,'马边彝族自治县','511133','511100'),(1002299,'峨眉山市','511181','511100'),(1002300,'顺庆区','511302','511300'),(1002301,'高坪区','511303','511300'),(1002302,'嘉陵区','511304','511300'),(1002303,'南部县','511321','511300'),(1002304,'营山县','511322','511300'),(1002305,'蓬安县','511323','511300'),(1002306,'仪陇县','511324','511300'),(1002307,'西充县','511325','511300'),(1002308,'阆中市','511381','511300'),(1002309,'东坡区','511402','511400'),(1002310,'彭山区','511403','511400'),(1002311,'仁寿县','511421','511400'),(1002312,'洪雅县','511423','511400'),(1002313,'丹棱县','511424','511400'),(1002314,'青神县','511425','511400'),(1002315,'翠屏区','511502','511500'),(1002316,'南溪区','511503','511500'),(1002317,'叙州区','511504','511500'),(1002318,'江安县','511523','511500'),(1002319,'长宁县','511524','511500'),(1002320,'高县','511525','511500'),(1002321,'珙县','511526','511500'),(1002322,'筠连县','511527','511500'),(1002323,'兴文县','511528','511500'),(1002324,'屏山县','511529','511500'),(1002325,'广安区','511602','511600'),(1002326,'前锋区','511603','511600'),(1002327,'岳池县','511621','511600'),(1002328,'武胜县','511622','511600'),(1002329,'邻水县','511623','511600'),(1002330,'华蓥市','511681','511600'),(1002331,'通川区','511702','511700'),(1002332,'达川区','511703','511700'),(1002333,'宣汉县','511722','511700'),(1002334,'开江县','511723','511700'),(1002335,'大竹县','511724','511700'),(1002336,'渠县','511725','511700'),(1002337,'达州经济开发区','511771','511700'),(1002338,'万源市','511781','511700'),(1002339,'雨城区','511802','511800'),(1002340,'名山区','511803','511800'),(1002341,'荥经县','511822','511800'),(1002342,'汉源县','511823','511800'),(1002343,'石棉县','511824','511800'),(1002344,'天全县','511825','511800'),(1002345,'芦山县','511826','511800'),(1002346,'宝兴县','511827','511800'),(1002347,'巴州区','511902','511900'),(1002348,'恩阳区','511903','511900'),(1002349,'通江县','511921','511900'),(1002350,'南江县','511922','511900'),(1002351,'平昌县','511923','511900'),(1002352,'巴中经济开发区','511971','511900'),(1002353,'雁江区','512002','512000'),(1002354,'安岳县','512021','512000'),(1002355,'乐至县','512022','512000'),(1002356,'马尔康市','513201','513200'),(1002357,'汶川县','513221','513200'),(1002358,'理县','513222','513200'),(1002359,'茂县','513223','513200'),(1002360,'松潘县','513224','513200'),(1002361,'九寨沟县','513225','513200'),(1002362,'金川县','513226','513200'),(1002363,'小金县','513227','513200'),(1002364,'黑水县','513228','513200'),(1002365,'壤塘县','513230','513200'),(1002366,'阿坝县','513231','513200'),(1002367,'若尔盖县','513232','513200'),(1002368,'红原县','513233','513200'),(1002369,'康定市','513301','513300'),(1002370,'泸定县','513322','513300'),(1002371,'丹巴县','513323','513300'),(1002372,'九龙县','513324','513300'),(1002373,'雅江县','513325','513300'),(1002374,'道孚县','513326','513300'),(1002375,'炉霍县','513327','513300'),(1002376,'甘孜县','513328','513300'),(1002377,'新龙县','513329','513300'),(1002378,'德格县','513330','513300'),(1002379,'白玉县','513331','513300'),(1002380,'石渠县','513332','513300'),(1002381,'色达县','513333','513300'),(1002382,'理塘县','513334','513300'),(1002383,'巴塘县','513335','513300'),(1002384,'乡城县','513336','513300'),(1002385,'稻城县','513337','513300'),(1002386,'得荣县','513338','513300'),(1002387,'西昌市','513401','513400'),(1002388,'木里藏族自治县','513422','513400'),(1002389,'盐源县','513423','513400'),(1002390,'德昌县','513424','513400'),(1002391,'会理县','513425','513400'),(1002392,'会东县','513426','513400'),(1002393,'宁南县','513427','513400'),(1002394,'普格县','513428','513400'),(1002395,'布拖县','513429','513400'),(1002396,'金阳县','513430','513400'),(1002397,'昭觉县','513431','513400'),(1002398,'喜德县','513432','513400'),(1002399,'冕宁县','513433','513400'),(1002400,'越西县','513434','513400'),(1002401,'甘洛县','513435','513400'),(1002402,'美姑县','513436','513400'),(1002403,'雷波县','513437','513400'),(1002404,'南明区','520102','520100'),(1002405,'云岩区','520103','520100'),(1002406,'花溪区','520111','520100'),(1002407,'乌当区','520112','520100'),(1002408,'白云区','520113','520100'),(1002409,'观山湖区','520115','520100'),(1002410,'开阳县','520121','520100'),(1002411,'息烽县','520122','520100'),(1002412,'修文县','520123','520100'),(1002413,'清镇市','520181','520100'),(1002414,'钟山区','520201','520200'),(1002415,'六枝特区','520203','520200'),(1002416,'水城县','520221','520200'),(1002417,'盘州市','520281','520200'),(1002418,'红花岗区','520302','520300'),(1002419,'汇川区','520303','520300'),(1002420,'播州区','520304','520300'),(1002421,'桐梓县','520322','520300'),(1002422,'绥阳县','520323','520300'),(1002423,'正安县','520324','520300'),(1002424,'道真仡佬族苗族自治县','520325','520300'),(1002425,'务川仡佬族苗族自治县','520326','520300'),(1002426,'凤冈县','520327','520300'),(1002427,'湄潭县','520328','520300'),(1002428,'余庆县','520329','520300'),(1002429,'习水县','520330','520300'),(1002430,'赤水市','520381','520300'),(1002431,'仁怀市','520382','520300'),(1002432,'西秀区','520402','520400'),(1002433,'平坝区','520403','520400'),(1002434,'普定县','520422','520400'),(1002435,'镇宁布依族苗族自治县','520423','520400'),(1002436,'关岭布依族苗族自治县','520424','520400'),(1002437,'紫云苗族布依族自治县','520425','520400'),(1002438,'七星关区','520502','520500'),(1002439,'大方县','520521','520500'),(1002440,'黔西县','520522','520500'),(1002441,'金沙县','520523','520500'),(1002442,'织金县','520524','520500'),(1002443,'纳雍县','520525','520500'),(1002444,'威宁彝族回族苗族自治县','520526','520500'),(1002445,'赫章县','520527','520500'),(1002446,'碧江区','520602','520600'),(1002447,'万山区','520603','520600'),(1002448,'江口县','520621','520600'),(1002449,'玉屏侗族自治县','520622','520600'),(1002450,'石阡县','520623','520600'),(1002451,'思南县','520624','520600'),(1002452,'印江土家族苗族自治县','520625','520600'),(1002453,'德江县','520626','520600'),(1002454,'沿河土家族自治县','520627','520600'),(1002455,'松桃苗族自治县','520628','520600'),(1002456,'兴义市','522301','522300'),(1002457,'兴仁市','522302','522300'),(1002458,'普安县','522323','522300'),(1002459,'晴隆县','522324','522300'),(1002460,'贞丰县','522325','522300'),(1002461,'望谟县','522326','522300'),(1002462,'册亨县','522327','522300'),(1002463,'安龙县','522328','522300'),(1002464,'凯里市','522601','522600'),(1002465,'黄平县','522622','522600'),(1002466,'施秉县','522623','522600'),(1002467,'三穗县','522624','522600'),(1002468,'镇远县','522625','522600'),(1002469,'岑巩县','522626','522600'),(1002470,'天柱县','522627','522600'),(1002471,'锦屏县','522628','522600'),(1002472,'剑河县','522629','522600'),(1002473,'台江县','522630','522600'),(1002474,'黎平县','522631','522600'),(1002475,'榕江县','522632','522600'),(1002476,'从江县','522633','522600'),(1002477,'雷山县','522634','522600'),(1002478,'麻江县','522635','522600'),(1002479,'丹寨县','522636','522600'),(1002480,'都匀市','522701','522700'),(1002481,'福泉市','522702','522700'),(1002482,'荔波县','522722','522700'),(1002483,'贵定县','522723','522700'),(1002484,'瓮安县','522725','522700'),(1002485,'独山县','522726','522700'),(1002486,'平塘县','522727','522700'),(1002487,'罗甸县','522728','522700'),(1002488,'长顺县','522729','522700'),(1002489,'龙里县','522730','522700'),(1002490,'惠水县','522731','522700'),(1002491,'三都水族自治县','522732','522700'),(1002492,'五华区','530102','530100'),(1002493,'盘龙区','530103','530100'),(1002494,'官渡区','530111','530100'),(1002495,'西山区','530112','530100'),(1002496,'东川区','530113','530100'),(1002497,'呈贡区','530114','530100'),(1002498,'晋宁区','530115','530100'),(1002499,'富民县','530124','530100'),(1002500,'宜良县','530125','530100'),(1002501,'石林彝族自治县','530126','530100'),(1002502,'嵩明县','530127','530100'),(1002503,'禄劝彝族苗族自治县','530128','530100'),(1002504,'寻甸回族彝族自治县','530129','530100'),(1002505,'安宁市','530181','530100'),(1002506,'麒麟区','530302','530300'),(1002507,'沾益区','530303','530300'),(1002508,'马龙区','530304','530300'),(1002509,'陆良县','530322','530300'),(1002510,'师宗县','530323','530300'),(1002511,'罗平县','530324','530300'),(1002512,'富源县','530325','530300'),(1002513,'会泽县','530326','530300'),(1002514,'宣威市','530381','530300'),(1002515,'红塔区','530402','530400'),(1002516,'江川区','530403','530400'),(1002517,'通海县','530423','530400'),(1002518,'华宁县','530424','530400'),(1002519,'易门县','530425','530400'),(1002520,'峨山彝族自治县','530426','530400'),(1002521,'新平彝族傣族自治县','530427','530400'),(1002522,'元江哈尼族彝族傣族自治县','530428','530400'),(1002523,'澄江市','530481','530400'),(1002524,'隆阳区','530502','530500'),(1002525,'施甸县','530521','530500'),(1002526,'龙陵县','530523','530500'),(1002527,'昌宁县','530524','530500'),(1002528,'腾冲市','530581','530500'),(1002529,'昭阳区','530602','530600'),(1002530,'鲁甸县','530621','530600'),(1002531,'巧家县','530622','530600'),(1002532,'盐津县','530623','530600'),(1002533,'大关县','530624','530600'),(1002534,'永善县','530625','530600'),(1002535,'绥江县','530626','530600'),(1002536,'镇雄县','530627','530600'),(1002537,'彝良县','530628','530600'),(1002538,'威信县','530629','530600'),(1002539,'水富市','530681','530600'),(1002540,'古城区','530702','530700'),(1002541,'玉龙纳西族自治县','530721','530700'),(1002542,'永胜县','530722','530700'),(1002543,'华坪县','530723','530700'),(1002544,'宁蒗彝族自治县','530724','530700'),(1002545,'思茅区','530802','530800'),(1002546,'宁洱哈尼族彝族自治县','530821','530800'),(1002547,'墨江哈尼族自治县','530822','530800'),(1002548,'景东彝族自治县','530823','530800'),(1002549,'景谷傣族彝族自治县','530824','530800'),(1002550,'镇沅彝族哈尼族拉祜族自治县','530825','530800'),(1002551,'江城哈尼族彝族自治县','530826','530800'),(1002552,'孟连傣族拉祜族佤族自治县','530827','530800'),(1002553,'澜沧拉祜族自治县','530828','530800'),(1002554,'西盟佤族自治县','530829','530800'),(1002555,'临翔区','530902','530900'),(1002556,'凤庆县','530921','530900'),(1002557,'云县','530922','530900'),(1002558,'永德县','530923','530900'),(1002559,'镇康县','530924','530900'),(1002560,'双江拉祜族佤族布朗族傣族自治县','530925','530900'),(1002561,'耿马傣族佤族自治县','530926','530900'),(1002562,'沧源佤族自治县','530927','530900'),(1002563,'楚雄市','532301','532300'),(1002564,'双柏县','532322','532300'),(1002565,'牟定县','532323','532300'),(1002566,'南华县','532324','532300'),(1002567,'姚安县','532325','532300'),(1002568,'大姚县','532326','532300'),(1002569,'永仁县','532327','532300'),(1002570,'元谋县','532328','532300'),(1002571,'武定县','532329','532300'),(1002572,'禄丰县','532331','532300'),(1002573,'个旧市','532501','532500'),(1002574,'开远市','532502','532500'),(1002575,'蒙自市','532503','532500'),(1002576,'弥勒市','532504','532500'),(1002577,'屏边苗族自治县','532523','532500'),(1002578,'建水县','532524','532500'),(1002579,'石屏县','532525','532500'),(1002580,'泸西县','532527','532500'),(1002581,'元阳县','532528','532500'),(1002582,'红河县','532529','532500'),(1002583,'金平苗族瑶族傣族自治县','532530','532500'),(1002584,'绿春县','532531','532500'),(1002585,'河口瑶族自治县','532532','532500'),(1002586,'文山市','532601','532600'),(1002587,'砚山县','532622','532600'),(1002588,'西畴县','532623','532600'),(1002589,'麻栗坡县','532624','532600'),(1002590,'马关县','532625','532600'),(1002591,'丘北县','532626','532600'),(1002592,'广南县','532627','532600'),(1002593,'富宁县','532628','532600'),(1002594,'景洪市','532801','532800'),(1002595,'勐海县','532822','532800'),(1002596,'勐腊县','532823','532800'),(1002597,'大理市','532901','532900'),(1002598,'漾濞彝族自治县','532922','532900'),(1002599,'祥云县','532923','532900'),(1002600,'宾川县','532924','532900'),(1002601,'弥渡县','532925','532900'),(1002602,'南涧彝族自治县','532926','532900'),(1002603,'巍山彝族回族自治县','532927','532900'),(1002604,'永平县','532928','532900'),(1002605,'云龙县','532929','532900'),(1002606,'洱源县','532930','532900'),(1002607,'剑川县','532931','532900'),(1002608,'鹤庆县','532932','532900'),(1002609,'瑞丽市','533102','533100'),(1002610,'芒市','533103','533100'),(1002611,'梁河县','533122','533100'),(1002612,'盈江县','533123','533100'),(1002613,'陇川县','533124','533100'),(1002614,'泸水市','533301','533300'),(1002615,'福贡县','533323','533300'),(1002616,'贡山独龙族怒族自治县','533324','533300'),(1002617,'兰坪白族普米族自治县','533325','533300'),(1002618,'香格里拉市','533401','533400'),(1002619,'德钦县','533422','533400'),(1002620,'维西傈僳族自治县','533423','533400'),(1002621,'城关区','540102','540100'),(1002622,'堆龙德庆区','540103','540100'),(1002623,'达孜区','540104','540100'),(1002624,'林周县','540121','540100'),(1002625,'当雄县','540122','540100'),(1002626,'尼木县','540123','540100'),(1002627,'曲水县','540124','540100'),(1002628,'墨竹工卡县','540127','540100'),(1002629,'格尔木藏青工业园区','540171','540100'),(1002630,'拉萨经济技术开发区','540172','540100'),(1002631,'西藏文化旅游创意园区','540173','540100'),(1002632,'达孜工业园区','540174','540100'),(1002633,'桑珠孜区','540202','540200'),(1002634,'南木林县','540221','540200'),(1002635,'江孜县','540222','540200'),(1002636,'定日县','540223','540200'),(1002637,'萨迦县','540224','540200'),(1002638,'拉孜县','540225','540200'),(1002639,'昂仁县','540226','540200'),(1002640,'谢通门县','540227','540200'),(1002641,'白朗县','540228','540200'),(1002642,'仁布县','540229','540200'),(1002643,'康马县','540230','540200'),(1002644,'定结县','540231','540200'),(1002645,'仲巴县','540232','540200'),(1002646,'亚东县','540233','540200'),(1002647,'吉隆县','540234','540200'),(1002648,'聂拉木县','540235','540200'),(1002649,'萨嘎县','540236','540200'),(1002650,'岗巴县','540237','540200'),(1002651,'卡若区','540302','540300'),(1002652,'江达县','540321','540300'),(1002653,'贡觉县','540322','540300'),(1002654,'类乌齐县','540323','540300'),(1002655,'丁青县','540324','540300'),(1002656,'察雅县','540325','540300'),(1002657,'八宿县','540326','540300'),(1002658,'左贡县','540327','540300'),(1002659,'芒康县','540328','540300'),(1002660,'洛隆县','540329','540300'),(1002661,'边坝县','540330','540300'),(1002662,'巴宜区','540402','540400'),(1002663,'工布江达县','540421','540400'),(1002664,'米林县','540422','540400'),(1002665,'墨脱县','540423','540400'),(1002666,'波密县','540424','540400'),(1002667,'察隅县','540425','540400'),(1002668,'朗县','540426','540400'),(1002669,'乃东区','540502','540500'),(1002670,'扎囊县','540521','540500'),(1002671,'贡嘎县','540522','540500'),(1002672,'桑日县','540523','540500'),(1002673,'琼结县','540524','540500'),(1002674,'曲松县','540525','540500'),(1002675,'措美县','540526','540500'),(1002676,'洛扎县','540527','540500'),(1002677,'加查县','540528','540500'),(1002678,'隆子县','540529','540500'),(1002679,'错那县','540530','540500'),(1002680,'浪卡子县','540531','540500'),(1002681,'色尼区','540602','540600'),(1002682,'嘉黎县','540621','540600'),(1002683,'比如县','540622','540600'),(1002684,'聂荣县','540623','540600'),(1002685,'安多县','540624','540600'),(1002686,'申扎县','540625','540600'),(1002687,'索县','540626','540600'),(1002688,'班戈县','540627','540600'),(1002689,'巴青县','540628','540600'),(1002690,'尼玛县','540629','540600'),(1002691,'双湖县','540630','540600'),(1002692,'普兰县','542521','542500'),(1002693,'札达县','542522','542500'),(1002694,'噶尔县','542523','542500'),(1002695,'日土县','542524','542500'),(1002696,'革吉县','542525','542500'),(1002697,'改则县','542526','542500'),(1002698,'措勤县','542527','542500'),(1002699,'新城区','610102','610100'),(1002700,'碑林区','610103','610100'),(1002701,'莲湖区','610104','610100'),(1002702,'灞桥区','610111','610100'),(1002703,'未央区','610112','610100'),(1002704,'雁塔区','610113','610100'),(1002705,'阎良区','610114','610100'),(1002706,'临潼区','610115','610100'),(1002707,'长安区','610116','610100'),(1002708,'高陵区','610117','610100'),(1002709,'鄠邑区','610118','610100'),(1002710,'蓝田县','610122','610100'),(1002711,'周至县','610124','610100'),(1002712,'王益区','610202','610200'),(1002713,'印台区','610203','610200'),(1002714,'耀州区','610204','610200'),(1002715,'宜君县','610222','610200'),(1002716,'渭滨区','610302','610300'),(1002717,'金台区','610303','610300'),(1002718,'陈仓区','610304','610300'),(1002719,'凤翔县','610322','610300'),(1002720,'岐山县','610323','610300'),(1002721,'扶风县','610324','610300'),(1002722,'眉县','610326','610300'),(1002723,'陇县','610327','610300'),(1002724,'千阳县','610328','610300'),(1002725,'麟游县','610329','610300'),(1002726,'凤县','610330','610300'),(1002727,'太白县','610331','610300'),(1002728,'秦都区','610402','610400'),(1002729,'杨陵区','610403','610400'),(1002730,'渭城区','610404','610400'),(1002731,'三原县','610422','610400'),(1002732,'泾阳县','610423','610400'),(1002733,'乾县','610424','610400'),(1002734,'礼泉县','610425','610400'),(1002735,'永寿县','610426','610400'),(1002736,'长武县','610428','610400'),(1002737,'旬邑县','610429','610400'),(1002738,'淳化县','610430','610400'),(1002739,'武功县','610431','610400'),(1002740,'兴平市','610481','610400'),(1002741,'彬州市','610482','610400'),(1002742,'临渭区','610502','610500'),(1002743,'华州区','610503','610500'),(1002744,'潼关县','610522','610500'),(1002745,'大荔县','610523','610500'),(1002746,'合阳县','610524','610500'),(1002747,'澄城县','610525','610500'),(1002748,'蒲城县','610526','610500'),(1002749,'白水县','610527','610500'),(1002750,'富平县','610528','610500'),(1002751,'韩城市','610581','610500'),(1002752,'华阴市','610582','610500'),(1002753,'宝塔区','610602','610600'),(1002754,'安塞区','610603','610600'),(1002755,'延长县','610621','610600'),(1002756,'延川县','610622','610600'),(1002757,'志丹县','610625','610600'),(1002758,'吴起县','610626','610600'),(1002759,'甘泉县','610627','610600'),(1002760,'富县','610628','610600'),(1002761,'洛川县','610629','610600'),(1002762,'宜川县','610630','610600'),(1002763,'黄龙县','610631','610600'),(1002764,'黄陵县','610632','610600'),(1002765,'子长市','610681','610600'),(1002766,'汉台区','610702','610700'),(1002767,'南郑区','610703','610700'),(1002768,'城固县','610722','610700'),(1002769,'洋县','610723','610700'),(1002770,'西乡县','610724','610700'),(1002771,'勉县','610725','610700'),(1002772,'宁强县','610726','610700'),(1002773,'略阳县','610727','610700'),(1002774,'镇巴县','610728','610700'),(1002775,'留坝县','610729','610700'),(1002776,'佛坪县','610730','610700'),(1002777,'榆阳区','610802','610800'),(1002778,'横山区','610803','610800'),(1002779,'府谷县','610822','610800'),(1002780,'靖边县','610824','610800'),(1002781,'定边县','610825','610800'),(1002782,'绥德县','610826','610800'),(1002783,'米脂县','610827','610800'),(1002784,'佳县','610828','610800'),(1002785,'吴堡县','610829','610800'),(1002786,'清涧县','610830','610800'),(1002787,'子洲县','610831','610800'),(1002788,'神木市','610881','610800'),(1002789,'汉滨区','610902','610900'),(1002790,'汉阴县','610921','610900'),(1002791,'石泉县','610922','610900'),(1002792,'宁陕县','610923','610900'),(1002793,'紫阳县','610924','610900'),(1002794,'岚皋县','610925','610900'),(1002795,'平利县','610926','610900'),(1002796,'镇坪县','610927','610900'),(1002797,'旬阳县','610928','610900'),(1002798,'白河县','610929','610900'),(1002799,'商州区','611002','611000'),(1002800,'洛南县','611021','611000'),(1002801,'丹凤县','611022','611000'),(1002802,'商南县','611023','611000'),(1002803,'山阳县','611024','611000'),(1002804,'镇安县','611025','611000'),(1002805,'柞水县','611026','611000'),(1002806,'城关区','620102','620100'),(1002807,'七里河区','620103','620100'),(1002808,'西固区','620104','620100'),(1002809,'安宁区','620105','620100'),(1002810,'红古区','620111','620100'),(1002811,'永登县','620121','620100'),(1002812,'皋兰县','620122','620100'),(1002813,'榆中县','620123','620100'),(1002814,'兰州新区','620171','620100'),(1002815,'市辖区','620201','620200'),(1002816,'金川区','620302','620300'),(1002817,'永昌县','620321','620300'),(1002818,'白银区','620402','620400'),(1002819,'平川区','620403','620400'),(1002820,'靖远县','620421','620400'),(1002821,'会宁县','620422','620400'),(1002822,'景泰县','620423','620400'),(1002823,'秦州区','620502','620500'),(1002824,'麦积区','620503','620500'),(1002825,'清水县','620521','620500'),(1002826,'秦安县','620522','620500'),(1002827,'甘谷县','620523','620500'),(1002828,'武山县','620524','620500'),(1002829,'张家川回族自治县','620525','620500'),(1002830,'凉州区','620602','620600'),(1002831,'民勤县','620621','620600'),(1002832,'古浪县','620622','620600'),(1002833,'天祝藏族自治县','620623','620600'),(1002834,'甘州区','620702','620700'),(1002835,'肃南裕固族自治县','620721','620700'),(1002836,'民乐县','620722','620700'),(1002837,'临泽县','620723','620700'),(1002838,'高台县','620724','620700'),(1002839,'山丹县','620725','620700'),(1002840,'崆峒区','620802','620800'),(1002841,'泾川县','620821','620800'),(1002842,'灵台县','620822','620800'),(1002843,'崇信县','620823','620800'),(1002844,'庄浪县','620825','620800'),(1002845,'静宁县','620826','620800'),(1002846,'华亭市','620881','620800'),(1002847,'肃州区','620902','620900'),(1002848,'金塔县','620921','620900'),(1002849,'瓜州县','620922','620900'),(1002850,'肃北蒙古族自治县','620923','620900'),(1002851,'阿克塞哈萨克族自治县','620924','620900'),(1002852,'玉门市','620981','620900'),(1002853,'敦煌市','620982','620900'),(1002854,'西峰区','621002','621000'),(1002855,'庆城县','621021','621000'),(1002856,'环县','621022','621000'),(1002857,'华池县','621023','621000'),(1002858,'合水县','621024','621000'),(1002859,'正宁县','621025','621000'),(1002860,'宁县','621026','621000'),(1002861,'镇原县','621027','621000'),(1002862,'安定区','621102','621100'),(1002863,'通渭县','621121','621100'),(1002864,'陇西县','621122','621100'),(1002865,'渭源县','621123','621100'),(1002866,'临洮县','621124','621100'),(1002867,'漳县','621125','621100'),(1002868,'岷县','621126','621100'),(1002869,'武都区','621202','621200'),(1002870,'成县','621221','621200'),(1002871,'文县','621222','621200'),(1002872,'宕昌县','621223','621200'),(1002873,'康县','621224','621200'),(1002874,'西和县','621225','621200'),(1002875,'礼县','621226','621200'),(1002876,'徽县','621227','621200'),(1002877,'两当县','621228','621200'),(1002878,'临夏市','622901','622900'),(1002879,'临夏县','622921','622900'),(1002880,'康乐县','622922','622900'),(1002881,'永靖县','622923','622900'),(1002882,'广河县','622924','622900'),(1002883,'和政县','622925','622900'),(1002884,'东乡族自治县','622926','622900'),(1002885,'积石山保安族东乡族撒拉族自治县','622927','622900'),(1002886,'合作市','623001','623000'),(1002887,'临潭县','623021','623000'),(1002888,'卓尼县','623022','623000'),(1002889,'舟曲县','623023','623000'),(1002890,'迭部县','623024','623000'),(1002891,'玛曲县','623025','623000'),(1002892,'碌曲县','623026','623000'),(1002893,'夏河县','623027','623000'),(1002894,'城东区','630102','630100'),(1002895,'城中区','630103','630100'),(1002896,'城西区','630104','630100'),(1002897,'城北区','630105','630100'),(1002898,'湟中区','630106','630100'),(1002899,'大通回族土族自治县','630121','630100'),(1002900,'湟源县','630123','630100'),(1002901,'乐都区','630202','630200'),(1002902,'平安区','630203','630200'),(1002903,'民和回族土族自治县','630222','630200'),(1002904,'互助土族自治县','630223','630200'),(1002905,'化隆回族自治县','630224','630200'),(1002906,'循化撒拉族自治县','630225','630200'),(1002907,'门源回族自治县','632221','632200'),(1002908,'祁连县','632222','632200'),(1002909,'海晏县','632223','632200'),(1002910,'刚察县','632224','632200'),(1002911,'同仁县','632321','632300'),(1002912,'尖扎县','632322','632300'),(1002913,'泽库县','632323','632300'),(1002914,'河南蒙古族自治县','632324','632300'),(1002915,'共和县','632521','632500'),(1002916,'同德县','632522','632500'),(1002917,'贵德县','632523','632500'),(1002918,'兴海县','632524','632500'),(1002919,'贵南县','632525','632500'),(1002920,'玛沁县','632621','632600'),(1002921,'班玛县','632622','632600'),(1002922,'甘德县','632623','632600'),(1002923,'达日县','632624','632600'),(1002924,'久治县','632625','632600'),(1002925,'玛多县','632626','632600'),(1002926,'玉树市','632701','632700'),(1002927,'杂多县','632722','632700'),(1002928,'称多县','632723','632700'),(1002929,'治多县','632724','632700'),(1002930,'囊谦县','632725','632700'),(1002931,'曲麻莱县','632726','632700'),(1002932,'格尔木市','632801','632800'),(1002933,'德令哈市','632802','632800'),(1002934,'茫崖市','632803','632800'),(1002935,'乌兰县','632821','632800'),(1002936,'都兰县','632822','632800'),(1002937,'天峻县','632823','632800'),(1002938,'大柴旦行政委员会','632857','632800'),(1002939,'兴庆区','640104','640100'),(1002940,'西夏区','640105','640100'),(1002941,'金凤区','640106','640100'),(1002942,'永宁县','640121','640100'),(1002943,'贺兰县','640122','640100'),(1002944,'灵武市','640181','640100'),(1002945,'大武口区','640202','640200'),(1002946,'惠农区','640205','640200'),(1002947,'平罗县','640221','640200'),(1002948,'利通区','640302','640300'),(1002949,'红寺堡区','640303','640300'),(1002950,'盐池县','640323','640300'),(1002951,'同心县','640324','640300'),(1002952,'青铜峡市','640381','640300'),(1002953,'原州区','640402','640400'),(1002954,'西吉县','640422','640400'),(1002955,'隆德县','640423','640400'),(1002956,'泾源县','640424','640400'),(1002957,'彭阳县','640425','640400'),(1002958,'沙坡头区','640502','640500'),(1002959,'中宁县','640521','640500'),(1002960,'海原县','640522','640500'),(1002961,'天山区','650102','650100'),(1002962,'沙依巴克区','650103','650100'),(1002963,'新市区','650104','650100'),(1002964,'水磨沟区','650105','650100'),(1002965,'头屯河区','650106','650100'),(1002966,'达坂城区','650107','650100'),(1002967,'米东区','650109','650100'),(1002968,'乌鲁木齐县','650121','650100'),(1002969,'独山子区','650202','650200'),(1002970,'克拉玛依区','650203','650200'),(1002971,'白碱滩区','650204','650200'),(1002972,'乌尔禾区','650205','650200'),(1002973,'高昌区','650402','650400'),(1002974,'鄯善县','650421','650400'),(1002975,'托克逊县','650422','650400'),(1002976,'伊州区','650502','650500'),(1002977,'巴里坤哈萨克自治县','650521','650500'),(1002978,'伊吾县','650522','650500'),(1002979,'昌吉市','652301','652300'),(1002980,'阜康市','652302','652300'),(1002981,'呼图壁县','652323','652300'),(1002982,'玛纳斯县','652324','652300'),(1002983,'奇台县','652325','652300'),(1002984,'吉木萨尔县','652327','652300'),(1002985,'木垒哈萨克自治县','652328','652300'),(1002986,'博乐市','652701','652700'),(1002987,'阿拉山口市','652702','652700'),(1002988,'精河县','652722','652700'),(1002989,'温泉县','652723','652700'),(1002990,'库尔勒市','652801','652800'),(1002991,'轮台县','652822','652800'),(1002992,'尉犁县','652823','652800'),(1002993,'若羌县','652824','652800'),(1002994,'且末县','652825','652800'),(1002995,'焉耆回族自治县','652826','652800'),(1002996,'和静县','652827','652800'),(1002997,'和硕县','652828','652800'),(1002998,'博湖县','652829','652800'),(1002999,'库尔勒经济技术开发区','652871','652800'),(1003000,'阿克苏市','652901','652900'),(1003001,'库车市','652902','652900'),(1003002,'温宿县','652922','652900'),(1003003,'沙雅县','652924','652900'),(1003004,'新和县','652925','652900'),(1003005,'拜城县','652926','652900'),(1003006,'乌什县','652927','652900'),(1003007,'阿瓦提县','652928','652900'),(1003008,'柯坪县','652929','652900'),(1003009,'阿图什市','653001','653000'),(1003010,'阿克陶县','653022','653000'),(1003011,'阿合奇县','653023','653000'),(1003012,'乌恰县','653024','653000'),(1003013,'喀什市','653101','653100'),(1003014,'疏附县','653121','653100'),(1003015,'疏勒县','653122','653100'),(1003016,'英吉沙县','653123','653100'),(1003017,'泽普县','653124','653100'),(1003018,'莎车县','653125','653100'),(1003019,'叶城县','653126','653100'),(1003020,'麦盖提县','653127','653100'),(1003021,'岳普湖县','653128','653100'),(1003022,'伽师县','653129','653100'),(1003023,'巴楚县','653130','653100'),(1003024,'塔什库尔干塔吉克自治县','653131','653100'),(1003025,'和田市','653201','653200'),(1003026,'和田县','653221','653200'),(1003027,'墨玉县','653222','653200'),(1003028,'皮山县','653223','653200'),(1003029,'洛浦县','653224','653200'),(1003030,'策勒县','653225','653200'),(1003031,'于田县','653226','653200'),(1003032,'民丰县','653227','653200'),(1003033,'伊宁市','654002','654000'),(1003034,'奎屯市','654003','654000'),(1003035,'霍尔果斯市','654004','654000'),(1003036,'伊宁县','654021','654000'),(1003037,'察布查尔锡伯自治县','654022','654000'),(1003038,'霍城县','654023','654000'),(1003039,'巩留县','654024','654000'),(1003040,'新源县','654025','654000'),(1003041,'昭苏县','654026','654000'),(1003042,'特克斯县','654027','654000'),(1003043,'尼勒克县','654028','654000'),(1003044,'塔城市','654201','654200'),(1003045,'乌苏市','654202','654200'),(1003046,'额敏县','654221','654200'),(1003047,'沙湾县','654223','654200'),(1003048,'托里县','654224','654200'),(1003049,'裕民县','654225','654200'),(1003050,'和布克赛尔蒙古自治县','654226','654200'),(1003051,'阿勒泰市','654301','654300'),(1003052,'布尔津县','654321','654300'),(1003053,'富蕴县','654322','654300'),(1003054,'福海县','654323','654300'),(1003055,'哈巴河县','654324','654300'),(1003056,'青河县','654325','654300'),(1003057,'吉木乃县','654326','654300'),(1003058,'石河子市','659001','659000'),(1003059,'阿拉尔市','659002','659000'),(1003060,'图木舒克市','659003','659000'),(1003061,'五家渠市','659004','659000'),(1003062,'北屯市','659005','659000'),(1003063,'铁门关市','659006','659000'),(1003064,'双河市','659007','659000'),(1003065,'可克达拉市','659008','659000'),(1003066,'昆玉市','659009','659000'),(1003067,'胡杨河市','659010','659000'),(1005000,'asdf','asdf','asdf');
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

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
  `remain` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '可用余额',
  `frozen` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '冻结金额',
  `total` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '可用总额',
  `total_in` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '入账总额',
  `total_out` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '出账总额',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '钱包状态 0:停用;1:启用;',
  `app_count` int NOT NULL DEFAULT '0' COMMENT '应用总数',
  `total_withdraw` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '提现总额',
  `real_merchant` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '商户纯收',
  `real_platform` decimal(13,3) NOT NULL DEFAULT '0.000' COMMENT '平台纯收',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  `count_remain` int unsigned NOT NULL DEFAULT '0' COMMENT '短信可用数量',
  `count_frozen` int unsigned NOT NULL DEFAULT '0' COMMENT '冻结数量',
  `count_total` int unsigned NOT NULL DEFAULT '0' COMMENT '总计可用',
  `sent_total` int unsigned NOT NULL DEFAULT '0' COMMENT '总计已发',
  `sent_success` int unsigned NOT NULL DEFAULT '0' COMMENT '总计成功',
  `total_recharge` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '充值总额',
  `updated` bigint NOT NULL DEFAULT '0' COMMENT '最后更新',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchant_id` (`merchant_id`),
  UNIQUE KEY `merchant_name` (`merchant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_accounts`
--

LOCK TABLES `merchant_accounts` WRITE;
/*!40000 ALTER TABLE `merchant_accounts` DISABLE KEYS */;
INSERT INTO `merchant_accounts` VALUES (10000,10000,'test1',33.000,0.000,33.000,0.000,0.000,0,0,0.000,0.000,0.000,'',66,0,66,0,0,0.00,1666720732408353);
/*!40000 ALTER TABLE `merchant_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_app_logs`
--

DROP TABLE IF EXISTS `merchant_app_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_app_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `app_id` int unsigned NOT NULL DEFAULT '0' COMMENT '应用编号',
  `app_name` varchar(32) NOT NULL DEFAULT '' COMMENT '应用名称',
  `level` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '日志级别',
  `type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '日志类型',
  `url` varchar(256) NOT NULL DEFAULT '' COMMENT '调用地址',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT 'ip',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_app_logs`
--

LOCK TABLES `merchant_app_logs` WRITE;
/*!40000 ALTER TABLE `merchant_app_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_app_logs` ENABLE KEYS */;
UNLOCK TABLES;

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
  `merchant_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户名称',
  PRIMARY KEY (`id`),
  KEY `merchant_id` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_apps`
--

LOCK TABLES `merchant_apps` WRITE;
/*!40000 ALTER TABLE `merchant_apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_country_rates`
--

DROP TABLE IF EXISTS `merchant_country_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_country_rates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int NOT NULL DEFAULT '0' COMMENT '商户编号',
  `country_id` int NOT NULL DEFAULT '0' COMMENT '国家编号',
  `channel_id` int NOT NULL DEFAULT '0' COMMENT '渠道编号',
  `rate` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '费率',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_id_2` (`country_id`,`channel_id`),
  KEY `country_id` (`country_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_country_rates`
--

LOCK TABLES `merchant_country_rates` WRITE;
/*!40000 ALTER TABLE `merchant_country_rates` DISABLE KEYS */;
INSERT INTO `merchant_country_rates` VALUES (100000,10000,18036,1000,0.70,1666718097323967,1666718298351593),(100001,10000,18133,1000,0.80,1666718097327331,1666718298358869),(100002,10000,18036,1001,0.50,1666718309718692,1666718309717702),(100003,10000,18133,1001,0.30,1666718309720393,1666718309719883);
/*!40000 ALTER TABLE `merchant_country_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_login_logs`
--

DROP TABLE IF EXISTS `merchant_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_login_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(64) NOT NULL DEFAULT '' COMMENT '域名',
  `login_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录IP',
  `login_area` varchar(256) NOT NULL DEFAULT '' COMMENT '登录地区',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `merchant_id` int NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_agent` text COMMENT '代理信息',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名称',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_login_logs`
--

LOCK TABLES `merchant_login_logs` WRITE;
/*!40000 ALTER TABLE `merchant_login_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_logs`
--

DROP TABLE IF EXISTS `merchant_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `level` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '日志级别',
  `type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '日志类型',
  `url` varchar(256) NOT NULL DEFAULT '' COMMENT '调用地址',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT 'ip',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  `object_id` int NOT NULL DEFAULT '0' COMMENT '对象编号',
  `object_name` varchar(64) NOT NULL DEFAULT '' COMMENT '对象名称',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT '模块',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_logs`
--

LOCK TABLES `merchant_logs` WRITE;
/*!40000 ALTER TABLE `merchant_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchant_logs` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchants`
--

LOCK TABLES `merchants` WRITE;
/*!40000 ALTER TABLE `merchants` DISABLE KEYS */;
INSERT INTO `merchants` VALUES (10000,'test1','','','','测试商户','','13911113335','mail@gmail.com',1,'',0,0,0,1666706436459490,1,0,0,0,'备注',0,'','',0,NULL,'',1,'');
/*!40000 ALTER TABLE `merchants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_batches`
--

DROP TABLE IF EXISTS `message_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_batches` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
  `app_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `app_name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `channel_id` int NOT NULL DEFAULT '0' COMMENT '渠道编号',
  `phone_list` text COMMENT '批量号码',
  `template_id` int unsigned NOT NULL DEFAULT '0' COMMENT '模板编号',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `plan_time` bigint NOT NULL DEFAULT '0' COMMENT '发送时间',
  `finished` bigint NOT NULL DEFAULT '0' COMMENT '完成时间',
  `content` varchar(256) NOT NULL DEFAULT '' COMMENT '内容',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `remark` varchar(20) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `merchant_id` (`merchant_id`),
  KEY `app_id` (`app_id`),
  KEY `channel_id` (`channel_id`),
  KEY `template_id` (`template_id`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_batches`
--

LOCK TABLES `message_batches` WRITE;
/*!40000 ALTER TABLE `message_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_channels`
--

DROP TABLE IF EXISTS `message_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_channels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_type` varchar(32) NOT NULL DEFAULT '' COMMENT '产品类型',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '渠道名称',
  `code` char(20) NOT NULL DEFAULT '' COMMENT '渠道编码',
  `remark` char(20) NOT NULL DEFAULT '' COMMENT '备注',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态 0:停用;1:启用;',
  `fee` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '费率',
  `protocol` varchar(8) NOT NULL DEFAULT 'https' COMMENT '协议',
  `ip` varchar(256) NOT NULL DEFAULT '' COMMENT 'IP列表',
  `path` varchar(256) NOT NULL DEFAULT '' COMMENT 'path',
  `port` int NOT NULL DEFAULT '0' COMMENT '端口',
  `account` varchar(64) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `tps` int NOT NULL DEFAULT '0' COMMENT '并发',
  `direction` varchar(256) NOT NULL DEFAULT '' COMMENT 'DIRECTION',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_channels`
--

LOCK TABLES `message_channels` WRITE;
/*!40000 ALTER TABLE `message_channels` DISABLE KEYS */;
INSERT INTO `message_channels` VALUES (10000,'MKT Product','Gaming Curacao/MKT ROUTE','UCG','备注',1,0.05,'http','203.160.95.115,47.242.200.116','/api',8001,'GCCugMKT','F)##8sB7t',0,'',1666770239276007,1666770239276059);
/*!40000 ALTER TABLE `message_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_templates`
--

DROP TABLE IF EXISTS `message_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
  `app_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `app_name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '模板名称',
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '类型',
  `content` varchar(256) NOT NULL DEFAULT '' COMMENT '模板名称',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `remark` varchar(20) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`,`created`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_templates`
--

LOCK TABLES `message_templates` WRITE;
/*!40000 ALTER TABLE `message_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
  `app_id` int unsigned NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `app_name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `channel_id` int NOT NULL DEFAULT '0' COMMENT '渠道编号',
  `country_id` int NOT NULL DEFAULT '0' COMMENT '国家编号',
  `phone_prefix` varchar(16) NOT NULL DEFAULT '号码前缀',
  `phone` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号码',
  `phone_full` varchar(32) NOT NULL DEFAULT '' COMMENT '手机号码',
  `template_id` int unsigned NOT NULL DEFAULT '0' COMMENT '模板编号',
  `state` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `content` varchar(256) NOT NULL DEFAULT '' COMMENT '内容',
  `request_url` varchar(256) NOT NULL DEFAULT '' COMMENT '请求URL',
  `request_result` varchar(512) NOT NULL DEFAULT '' COMMENT '请求结果',
  `message_id` varchar(128) NOT NULL DEFAULT '' COMMENT '短信id',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `send_time` bigint unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`,`created`),
  KEY `merchant_id` (`merchant_id`),
  KEY `app_id` (`app_id`),
  KEY `channel_id` (`channel_id`),
  KEY `template_id` (`template_id`),
  KEY `state` (`state`),
  KEY `phone` (`phone`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3
/*!50100 PARTITION BY RANGE (`created`)
(PARTITION P202210 VALUES LESS THAN (1667232000000000) ENGINE = InnoDB,
 PARTITION P202211 VALUES LESS THAN (1669824000000000) ENGINE = InnoDB,
 PARTITION P202212 VALUES LESS THAN (1672502400000000) ENGINE = InnoDB,
 PARTITION P202301 VALUES LESS THAN (1675180800000000) ENGINE = InnoDB,
 PARTITION P202302 VALUES LESS THAN (1677600000000000) ENGINE = InnoDB,
 PARTITION P202303 VALUES LESS THAN (1680278400000000) ENGINE = InnoDB,
 PARTITION P202304 VALUES LESS THAN (1682870400000000) ENGINE = InnoDB,
 PARTITION P202305 VALUES LESS THAN (1685548800000000) ENGINE = InnoDB,
 PARTITION P202306 VALUES LESS THAN (1688140800000000) ENGINE = InnoDB,
 PARTITION P202307 VALUES LESS THAN (1690819200000000) ENGINE = InnoDB,
 PARTITION P202308 VALUES LESS THAN (1693497600000000) ENGINE = InnoDB,
 PARTITION P202309 VALUES LESS THAN (1696089600000000) ENGINE = InnoDB,
 PARTITION P202310 VALUES LESS THAN (1698768000000000) ENGINE = InnoDB,
 PARTITION P202311 VALUES LESS THAN (1701360000000000) ENGINE = InnoDB,
 PARTITION P202312 VALUES LESS THAN (1704038400000000) ENGINE = InnoDB,
 PARTITION P202401 VALUES LESS THAN (1706716800000000) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '类型, 1:普通;2:特殊;3:财务;',
  `title` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '内容',
  `state` tinyint unsigned DEFAULT '2' COMMENT '2:启用;1:停用;',
  `sort` int DEFAULT NULL COMMENT '排序',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `jump_url` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '跳转链接',
  `img_url` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标地址',
  `platform_type` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '平台类型, 1:全站;2:体育;3:web;4:h5;',
  `vip_ids` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'VIP等级',
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
INSERT INTO `notices` VALUES (10039,3,'财务公告','<p>存款吧@@！！！！！！！</p>',2,NULL,1608791597000000,1617866653000000,'1','/notices/icon/1.png','1,3,4','1,2,3,4,5,6,7,8,9',1672502399,1608739200,0),(10052,1,'大家好！！！！！！！！','<p>额，你们好！！！！</p>',2,NULL,1630912535000000,1630912535000000,'1','/notices/icon/1.png','1,3,4','1,2,3,4,5,6,7,8,9',1662479999,1630857600,0),(10053,1,'213213','<p>12312</p>',1,NULL,1640527819000000,1640528250000000,'2121','/notices/icon/1.png','1,3,4','1,2,3,4,5,6,7,8,9',1640534399,1640448000,0);
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameter_groups`
--

DROP TABLE IF EXISTS `parameter_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameter_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'KEY',
  `remark` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameter_groups`
--

LOCK TABLES `parameter_groups` WRITE;
/*!40000 ALTER TABLE `parameter_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `parameter_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parameters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '参数值',
  `title` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数说明',
  `remark` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `value_default` text CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '默认内容',
  `value_type` char(16) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT 'string' COMMENT 'golang数据类型，暂时只要string int float64',
  `parent_id` int unsigned NOT NULL DEFAULT '0' COMMENT '父级编号',
  `group_id` int unsigned NOT NULL DEFAULT '0' COMMENT '参数组编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameters`
--

LOCK TABLES `parameters` WRITE;
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_ips`
--

DROP TABLE IF EXISTS `permission_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_ips` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `permission_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '授权类型',
  `ip` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `remark` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `state` tinyint NOT NULL DEFAULT '2' COMMENT '状态',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `updated` bigint unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '添加用户id',
  `admin_name` varchar(32) NOT NULL DEFAULT '' COMMENT '添加用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`),
  KEY `permission_type` (`permission_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_ips`
--

LOCK TABLES `permission_ips` WRITE;
/*!40000 ALTER TABLE `permission_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinces` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份名称',
  `code` char(20) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=101001 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` VALUES (100001,'北京市','110000'),(100002,'天津市','120000'),(100003,'河北省','130000'),(100004,'山西省','140000'),(100005,'内蒙古自治区','150000'),(100006,'辽宁省','210000'),(100007,'吉林省','220000'),(100008,'黑龙江省','230000'),(100009,'上海市','310000'),(100010,'江苏省','320000'),(100011,'浙江省','330000'),(100012,'安徽省','340000'),(100013,'福建省','350000'),(100014,'江西省','360000'),(100015,'山东省','370000'),(100016,'河南省','410000'),(100017,'湖北省','420000'),(100018,'湖南省','430000'),(100019,'广东省','440000'),(100020,'广西壮族自治区','450000'),(100021,'海南省','460000'),(100022,'重庆市','500000'),(100023,'四川省','510000'),(100024,'贵州省','520000'),(100025,'云南省','530000'),(100026,'西藏自治区','540000'),(100027,'陕西省','610000'),(100028,'甘肃省','620000'),(100029,'青海省','630000'),(100030,'宁夏回族自治区','640000'),(100031,'新疆维吾尔自治区','650000'),(101000,'aa','aa');
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_counts`
--

DROP TABLE IF EXISTS `report_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_counts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT '2000-01-01' COMMENT '统计日期',
  `total` int unsigned NOT NULL DEFAULT '0' COMMENT '总计发送',
  `total_sent` int unsigned NOT NULL DEFAULT '0' COMMENT '总计发送',
  `total_success` int unsigned NOT NULL DEFAULT '0' COMMENT '成功发送',
  `merchant_total` int unsigned NOT NULL DEFAULT '0' COMMENT '商家总计',
  `merchant_new` int unsigned NOT NULL DEFAULT '0' COMMENT '新增商家',
  `merchant_live` int unsigned NOT NULL DEFAULT '0' COMMENT '活跃商家',
  `app_total` int NOT NULL DEFAULT '0' COMMENT '应用数量',
  `app_new` int NOT NULL DEFAULT '0' COMMENT '应用新增',
  `template_total` int NOT NULL DEFAULT '0' COMMENT '模板总计',
  `template_new` int NOT NULL DEFAULT '0' COMMENT '模板新增',
  `channel_fee` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '通道费用',
  `merchant_fee` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '商家费用',
  `profit` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '利润',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '统计时间',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`,`created`),
  KEY `date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3
/*!50100 PARTITION BY RANGE (`created`)
(PARTITION P202210 VALUES LESS THAN (1667232000000000) ENGINE = InnoDB,
 PARTITION P202211 VALUES LESS THAN (1669824000000000) ENGINE = InnoDB,
 PARTITION P202212 VALUES LESS THAN (1672502400000000) ENGINE = InnoDB,
 PARTITION P202301 VALUES LESS THAN (1675180800000000) ENGINE = InnoDB,
 PARTITION P202302 VALUES LESS THAN (1677600000000000) ENGINE = InnoDB,
 PARTITION P202303 VALUES LESS THAN (1680278400000000) ENGINE = InnoDB,
 PARTITION P202304 VALUES LESS THAN (1682870400000000) ENGINE = InnoDB,
 PARTITION P202305 VALUES LESS THAN (1685548800000000) ENGINE = InnoDB,
 PARTITION P202306 VALUES LESS THAN (1688140800000000) ENGINE = InnoDB,
 PARTITION P202307 VALUES LESS THAN (1690819200000000) ENGINE = InnoDB,
 PARTITION P202308 VALUES LESS THAN (1693497600000000) ENGINE = InnoDB,
 PARTITION P202309 VALUES LESS THAN (1696089600000000) ENGINE = InnoDB,
 PARTITION P202310 VALUES LESS THAN (1698768000000000) ENGINE = InnoDB,
 PARTITION P202311 VALUES LESS THAN (1701360000000000) ENGINE = InnoDB,
 PARTITION P202312 VALUES LESS THAN (1704038400000000) ENGINE = InnoDB,
 PARTITION P202401 VALUES LESS THAN (1706716800000000) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_counts`
--

LOCK TABLES `report_counts` WRITE;
/*!40000 ALTER TABLE `report_counts` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_merchants`
--

DROP TABLE IF EXISTS `report_merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_merchants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `merchant_id` int unsigned NOT NULL DEFAULT '0' COMMENT '商家编号',
  `merchant_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商户名称',
  `date` date DEFAULT '2000-01-01' COMMENT '统计日期',
  `total` int unsigned NOT NULL DEFAULT '0' COMMENT '短信总数',
  `total_sent` int unsigned NOT NULL DEFAULT '0' COMMENT '总计发送',
  `total_success` int unsigned NOT NULL DEFAULT '0' COMMENT '成功发送',
  `merchant_children` int unsigned NOT NULL DEFAULT '0' COMMENT '下属商家',
  `merchant_new` int unsigned NOT NULL DEFAULT '0' COMMENT '新增商家',
  `merchant_live` int unsigned NOT NULL DEFAULT '0' COMMENT '活跃商家',
  `app_total` int NOT NULL DEFAULT '0' COMMENT '应用数量',
  `app_new` int NOT NULL DEFAULT '0' COMMENT '应用新增',
  `template_total` int NOT NULL DEFAULT '0' COMMENT '模板总计',
  `template_new` int NOT NULL DEFAULT '0' COMMENT '模板新增',
  `merchant_fee` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '商家费用',
  `downstream_fee` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '下游费用',
  `profit` decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '利润',
  `created` bigint unsigned NOT NULL DEFAULT '0' COMMENT '统计时间',
  `remark` varchar(256) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`,`created`),
  KEY `date` (`date`),
  KEY `merchant_id` (`merchant_id`),
  KEY `merchant_name` (`merchant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb3
/*!50100 PARTITION BY RANGE (`created`)
(PARTITION P202210 VALUES LESS THAN (1667232000000000) ENGINE = InnoDB,
 PARTITION P202211 VALUES LESS THAN (1669824000000000) ENGINE = InnoDB,
 PARTITION P202212 VALUES LESS THAN (1672502400000000) ENGINE = InnoDB,
 PARTITION P202301 VALUES LESS THAN (1675180800000000) ENGINE = InnoDB,
 PARTITION P202302 VALUES LESS THAN (1677600000000000) ENGINE = InnoDB,
 PARTITION P202303 VALUES LESS THAN (1680278400000000) ENGINE = InnoDB,
 PARTITION P202304 VALUES LESS THAN (1682870400000000) ENGINE = InnoDB,
 PARTITION P202305 VALUES LESS THAN (1685548800000000) ENGINE = InnoDB,
 PARTITION P202306 VALUES LESS THAN (1688140800000000) ENGINE = InnoDB,
 PARTITION P202307 VALUES LESS THAN (1690819200000000) ENGINE = InnoDB,
 PARTITION P202308 VALUES LESS THAN (1693497600000000) ENGINE = InnoDB,
 PARTITION P202309 VALUES LESS THAN (1696089600000000) ENGINE = InnoDB,
 PARTITION P202310 VALUES LESS THAN (1698768000000000) ENGINE = InnoDB,
 PARTITION P202311 VALUES LESS THAN (1701360000000000) ENGINE = InnoDB,
 PARTITION P202312 VALUES LESS THAN (1704038400000000) ENGINE = InnoDB,
 PARTITION P202401 VALUES LESS THAN (1706716800000000) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_merchants`
--

LOCK TABLES `report_merchants` WRITE;
/*!40000 ALTER TABLE `report_merchants` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_merchants` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-26 17:20:09
