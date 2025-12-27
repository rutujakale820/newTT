-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: timetabler
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `batch_name` varchar(255) DEFAULT NULL,
  `batch_number` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `division_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK80hsx01ovksq6vutjnio5mgxf` (`division_id`),
  CONSTRAINT `FK80hsx01ovksq6vutjnio5mgxf` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES (9,'A1',1,25,1),(10,'A2',2,25,1),(11,'A3',3,25,1),(12,'A4',4,25,1),(13,'B1',1,25,2),(14,'B2',2,25,2),(15,'B3',3,25,2),(16,'B4',4,25,2),(17,'C1',1,25,3),(18,'C2',2,25,3),(19,'C3',3,25,3),(20,'C4',4,25,3),(21,'A1',1,25,4),(22,'A2',2,25,4),(23,'A3',3,25,4),(24,'A4',4,25,4),(25,'B1',1,25,5),(26,'B2',2,25,5),(27,'B3',3,25,5),(28,'B4',4,25,5),(29,'C1',1,25,6),(30,'C2',2,25,6),(31,'C3',3,25,6),(32,'C4',4,25,6),(33,'A1',1,25,7),(34,'A2',2,25,7),(35,'A3',3,25,7),(36,'A4',4,25,7),(37,'B1',1,25,8),(38,'B2',2,25,8),(39,'B3',3,25,8),(40,'B4',4,25,8),(41,'C1',1,25,9),(42,'C2',2,25,9),(43,'C3',3,25,9),(44,'C4',4,25,9),(45,'A1',1,25,10),(46,'A2',2,25,10),(47,'A3',3,25,10),(48,'A4',4,25,10),(49,'B1',1,25,11),(50,'B2',2,25,11),(51,'B3',3,25,11),(52,'B4',4,25,11),(53,'C1',1,25,12),(54,'C2',2,25,12),(55,'C3',3,25,12),(56,'C4',4,25,12),(57,'A1',1,25,13),(58,'A2',2,25,13),(59,'A3',3,25,13),(60,'A4',4,25,13),(61,'B1',1,25,14),(62,'B2',2,25,14),(63,'B3',3,25,14),(64,'B4',4,25,14),(65,'C1',1,25,15),(66,'C2',2,25,15),(67,'C3',3,25,15),(68,'C4',4,25,15),(69,'A1',1,25,16),(70,'A2',2,25,16),(71,'A3',3,25,16),(72,'A4',4,25,16),(73,'B1',1,25,17),(74,'B2',2,25,17),(75,'B3',3,25,17),(76,'B4',4,25,17),(77,'C1',1,25,18),(78,'C2',2,25,18),(79,'C3',3,25,18),(80,'C4',4,25,18),(81,'A1',1,25,19),(82,'A2',2,25,19),(83,'A3',3,25,19),(84,'A4',4,25,19),(85,'B1',1,25,20),(86,'B2',2,25,20),(87,'B3',3,25,20),(88,'B4',4,25,20),(89,'C1',1,25,21),(90,'C2',2,25,21),(91,'C3',3,25,21),(92,'C4',4,25,21),(93,'A1',1,25,22),(94,'A2',2,25,22),(95,'A3',3,25,22),(96,'A4',4,25,22),(97,'B1',1,25,23),(98,'B2',2,25,23),(99,'B3',3,25,23),(100,'B4',4,25,23),(101,'C1',1,25,24),(102,'C2',2,25,24),(103,'C3',3,25,24),(104,'C4',4,25,24);
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `capacity` int DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `part_of` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `room_number` varchar(255) DEFAULT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (5,25,'BEE LAB','ENTC Dept','BEE Laboratory','BEE LAB','LAB'),(7,25,'PROJECT LAB','ENTC Dept','Project Laboratory','PROJECT LAB','LAB'),(8,25,'COMP4','ENTC Dept','Computer Lab 4','COMP4','LAB'),(9,25,'COMP3','ENTC Dept','Computer Lab 3','COMP3','LAB'),(10,25,'COMP2','ENTC Dept','Computer Lab 2','COMP2','LAB'),(11,25,'POWER LAB','ENTC Dept','Power Laboratory','POWER LAB','LAB'),(12,25,'ANALOG LAB','ENTC Dept','Analog Electronics Lab','ANALOG LAB','LAB'),(13,80,'CLASSROOM1','ENTC Dept','Lecture Hall 1','1','LEC'),(14,80,'CLASSROOM2','ENTC Dept','Lecture Hall 2','2','LEC'),(15,80,'CLASSROOM3','ENTC Dept','Lecture Hall 3','3','LEC'),(16,80,'CLASSROOM4','ENTC Dept','Lecture Hall 4','4','LEC'),(17,80,'CLASSROOM5','ENTC Dept','Lecture Hall 5','5','LEC'),(18,80,'CLASSROOM6','ENTC Dept','Lecture Hall 6','6','LEC'),(19,80,'CLASSROOM7','ENTC Dept','Lecture Hall 7','7','LEC'),(20,80,'CLASSROOM8','ENTC Dept','Lecture Hall 8','8','LEC'),(21,25,'TUT1','ENTC Dept','Tutorial Room 1','TUT1','TUT'),(22,25,'TUT2','ENTC Dept','Tutorial Room 2','TUT2','TUT'),(23,25,'TUT3','ENTC Dept','Tutorial Room 3','TUT3','TUT'),(24,25,'MTECH LAB','ENTC Dept','MTech Laboratory','MTECH LAB','LAB'),(28,25,'PROJECT LAB 2','ENTC Dept','Project Laboratory 2','PROJECT LAB 2','LAB'),(29,25,'EMBEDDED LAB','ENTC Dept','Embedded Systems Laboratory','EMBEDDED LAB','LAB'),(30,80,'CLASSROOM9','ENTC Dept','Lecture Hall 9','9','LEC'),(31,80,'CLASSROOM10','ENTC Dept','Lecture Hall 10','10','LEC'),(32,80,'CLASSROOM11','ENTC Dept','Lecture Hall 11','11','LEC'),(33,80,'CLASSROOM12','ENTC Dept','Lecture Hall 12','12','LEC'),(34,80,'CLASSROOM13','ENTC Dept','Lecture Hall 13','13','LEC'),(44,25,'COMP1','ENTC Dept','Computer Lab 1','COMP1','LAB'),(45,25,'FIBER LAB','ENTC Dept','Fiber Optic Laboratory','FIBER LAB','LAB'),(46,25,'COMM LAB 1','ENTC Dept','Communication Laboratory 1','COMM LAB 1','LAB'),(47,25,'COMM LAB 2','ENTC Dept','Communication Laboratory 2','COMM LAB 2','LAB'),(48,25,'RESEARCH LAB','ENTC Dept','Research Laboratory','RESEARCH LAB','LAB'),(49,25,'AI LAB','ENTC Dept','Artificial Intelligence Lab','AI LAB','LAB');
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_q8ymhgj6pt1msox0o3bg51uvo` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'ENTC','Electronics & Telecommunication'),(5,'BSH','Basic Science and Humanities');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `semester_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlfr66myiy8u63niqnai055kk3` (`semester_id`),
  CONSTRAINT `FKlfr66myiy8u63niqnai055kk3` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `division`
--

LOCK TABLES `division` WRITE;
/*!40000 ALTER TABLE `division` DISABLE KEYS */;
INSERT INTO `division` VALUES (1,'A',1),(2,'B',1),(3,'C',1),(4,'A',2),(5,'B',2),(6,'C',2),(7,'A',3),(8,'B',3),(9,'C',3),(10,'A',4),(11,'B',4),(12,'C',4),(13,'A',5),(14,'B',5),(15,'C',5),(16,'A',6),(17,'B',6),(18,'C',6),(19,'A',7),(20,'B',7),(21,'C',7),(22,'A',8),(23,'B',8),(24,'C',8);
/*!40000 ALTER TABLE `division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elective_batch`
--

DROP TABLE IF EXISTS `elective_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elective_batch` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `batch_index` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `classroom_id` bigint DEFAULT NULL,
  `elective_division_id` bigint DEFAULT NULL,
  `time_slot_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlvihws66ofxl6vgosgqekmaes` (`classroom_id`),
  KEY `FKbw5itiyp00pgsxahbf7bwd7cv` (`elective_division_id`),
  KEY `FKne2jxcm8mlcg9n4j8l5c1uqfy` (`time_slot_id`),
  CONSTRAINT `FKbw5itiyp00pgsxahbf7bwd7cv` FOREIGN KEY (`elective_division_id`) REFERENCES `elective_division` (`id`),
  CONSTRAINT `FKlvihws66ofxl6vgosgqekmaes` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`id`),
  CONSTRAINT `FKne2jxcm8mlcg9n4j8l5c1uqfy` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elective_batch`
--

LOCK TABLES `elective_batch` WRITE;
/*!40000 ALTER TABLE `elective_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `elective_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elective_division`
--

DROP TABLE IF EXISTS `elective_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elective_division` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_count` int DEFAULT NULL,
  `classroom_id` bigint DEFAULT NULL,
  `parent_elective_id` bigint DEFAULT NULL,
  `teacher_id` bigint DEFAULT NULL,
  `time_slot_id` bigint DEFAULT NULL,
  `elective_group_option_id` bigint DEFAULT NULL,
  `semester_id` bigint DEFAULT NULL,
  `elective_div_code` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKo8xtu8ytva9cx3vasa2lqx6ro` (`classroom_id`),
  KEY `FKmlwoipu5o2bs1xqmubjjvg4c1` (`parent_elective_id`),
  KEY `FKslifaardlt1a4atr7mfu3aseh` (`teacher_id`),
  KEY `FKixd89o2eeni2oih0jhor2bjcy` (`time_slot_id`),
  KEY `FKab0g7hqqe7sc8f1hyjmq52y40` (`elective_group_option_id`),
  KEY `fk_elective_division_semester` (`semester_id`),
  CONSTRAINT `fk_elective_division_semester` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`),
  CONSTRAINT `FKab0g7hqqe7sc8f1hyjmq52y40` FOREIGN KEY (`elective_group_option_id`) REFERENCES `elective_group_option` (`id`),
  CONSTRAINT `FKixd89o2eeni2oih0jhor2bjcy` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`id`),
  CONSTRAINT `FKmlwoipu5o2bs1xqmubjjvg4c1` FOREIGN KEY (`parent_elective_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `FKo8xtu8ytva9cx3vasa2lqx6ro` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`id`),
  CONSTRAINT `FKslifaardlt1a4atr7mfu3aseh` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elective_division`
--

LOCK TABLES `elective_division` WRITE;
/*!40000 ALTER TABLE `elective_division` DISABLE KEYS */;
INSERT INTO `elective_division` VALUES (7166,25,5,66,17,58,20,6,'ROB_LAB-LABA'),(7167,25,7,66,18,58,20,6,'ROB_LAB-LABB'),(7168,25,8,66,19,58,20,6,'ROB_LAB-LABC'),(7169,25,9,66,20,58,20,6,'ROB_LAB-LABD'),(7170,25,10,66,21,58,20,6,'ROB_LAB-LABE'),(7171,23,11,66,22,58,20,6,'ROB_LAB-LABF'),(7172,25,12,66,33,58,22,6,'PE_LAB-LABA'),(7173,25,24,66,34,58,22,6,'PE_LAB-LABB'),(7174,22,28,66,35,58,22,6,'PE_LAB-LABC'),(7175,25,29,66,41,58,23,6,'DL_LAB-LABA'),(7176,19,44,66,42,58,23,6,'DL_LAB-LABB'),(7177,80,13,64,11,11,24,6,'ACE-L1-1'),(7178,25,14,64,12,11,24,6,'ACE-L1-2'),(7179,81,15,64,27,11,28,6,'CV-L1-1'),(7181,69,17,64,39,11,31,6,'EV-L1-1'),(7182,80,13,64,11,18,24,6,'ACE-L2-1'),(7183,25,14,64,12,18,24,6,'ACE-L2-2'),(7184,81,15,64,27,18,28,6,'CV-L2-1'),(7186,69,17,64,39,18,31,6,'EV-L2-1'),(7187,80,13,64,11,28,24,6,'ACE-L3-1'),(7188,25,14,64,12,28,24,6,'ACE-L3-2'),(7189,81,15,64,27,28,28,6,'CV-L3-1'),(7191,69,17,64,39,28,31,6,'EV-L3-1'),(7192,80,13,63,39,12,16,6,'ROB-L1-1'),(7193,68,14,63,40,12,16,6,'ROB-L1-2'),(7194,72,15,63,9,12,18,6,'PE-L1-1'),(7195,44,16,63,13,12,19,6,'DL-L1-1'),(7196,80,13,63,39,19,16,6,'ROB-L2-1'),(7197,68,14,63,40,19,16,6,'ROB-L2-2'),(7198,72,15,63,9,19,18,6,'PE-L2-1'),(7199,44,16,63,13,19,19,6,'DL-L2-1'),(7200,80,13,63,39,29,16,6,'ROB-L3-1'),(7201,68,14,63,40,29,16,6,'ROB-L3-2'),(7202,72,15,63,9,29,18,6,'PE-L3-1'),(7203,44,16,63,13,29,19,6,'DL-L3-1'),(7204,80,13,71,36,8,43,8,'VLSI-L1-1'),(7205,21,14,71,37,8,43,8,'VLSI-L1-2'),(7206,89,15,71,39,8,44,8,'AI-L1-1'),(7208,74,17,71,9,8,46,8,'MC-L1-1'),(7209,80,16,71,35,18,43,8,'VLSI-L2-1'),(7210,21,18,71,36,18,43,8,'VLSI-L2-2'),(7211,89,19,71,40,18,44,8,'AI-L2-1'),(7213,74,30,71,9,18,46,8,'MC-L2-1'),(7214,80,16,71,35,28,43,8,'VLSI-L3-1'),(7215,21,18,71,36,28,43,8,'VLSI-L3-2'),(7216,89,19,71,40,28,44,8,'AI-L3-1'),(7218,74,30,71,9,28,46,8,'MC-L3-1'),(7219,25,5,75,41,59,39,8,'MRE_LAB-LABA'),(7220,25,7,75,42,59,39,8,'MRE_LAB-LABB'),(7221,25,8,75,5,59,39,8,'MRE_LAB-LABC'),(7222,25,9,75,6,59,39,8,'MRE_LAB-LABD'),(7223,25,10,75,7,59,39,8,'MRE_LAB-LABE'),(7224,25,11,75,8,59,39,8,'MRE_LAB-LABF'),(7225,7,12,75,10,59,39,8,'MRE_LAB-LABG'),(7226,25,24,75,28,59,42,8,'RTOS_LAB-LABA'),(7227,25,28,75,29,59,42,8,'RTOS_LAB-LABB'),(7228,12,29,75,30,59,42,8,'RTOS_LAB-LABC'),(7229,80,13,72,13,9,47,8,'BDA-L1-1'),(7230,18,14,72,14,9,47,8,'BDA-L1-2'),(7231,77,15,72,29,9,51,8,'CF-L1-1'),(7232,65,16,72,11,9,56,8,'SC-L1-1'),(7233,80,17,72,14,19,47,8,'BDA-L2-1'),(7234,18,18,72,15,19,47,8,'BDA-L2-2'),(7235,77,19,72,29,19,51,8,'CF-L2-1'),(7236,65,20,72,11,19,56,8,'SC-L2-1'),(7237,80,17,72,14,29,47,8,'BDA-L3-1'),(7238,18,18,72,15,29,47,8,'BDA-L3-2'),(7239,77,19,72,29,29,51,8,'CF-L3-1'),(7240,65,20,72,11,29,56,8,'SC-L3-1'),(7241,80,13,73,19,14,58,8,'ASR-L1-1'),(7242,53,14,73,20,14,58,8,'ASR-L1-2'),(7243,54,15,73,35,14,62,8,'DAV-L1-1'),(7244,48,16,73,13,14,66,8,'WN-L1-1'),(7245,80,13,73,19,21,58,8,'ASR-L2-1'),(7246,53,14,73,20,21,58,8,'ASR-L2-2'),(7247,54,15,73,35,21,62,8,'DAV-L2-1'),(7248,48,16,73,13,21,66,8,'WN-L2-1'),(7249,80,13,73,19,31,58,8,'ASR-L3-1'),(7250,53,14,73,20,31,58,8,'ASR-L3-2'),(7251,54,15,73,35,31,62,8,'DAV-L3-1'),(7252,48,16,73,13,31,66,8,'WN-L3-1'),(7253,80,13,70,17,15,35,8,'MRE-L1-1'),(7254,77,14,70,18,15,35,8,'MRE-L1-2'),(7255,62,15,70,33,15,38,8,'RTOS-L1-1'),(7256,80,13,70,17,22,35,8,'MRE-L2-1'),(7257,77,14,70,18,22,35,8,'MRE-L2-2'),(7258,62,15,70,33,22,38,8,'RTOS-L2-1'),(7259,80,13,70,17,32,35,8,'MRE-L3-1'),(7260,77,14,70,18,32,35,8,'MRE-L3-2'),(7261,62,15,70,33,32,38,8,'RTOS-L3-1');
/*!40000 ALTER TABLE `elective_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elective_group`
--

DROP TABLE IF EXISTS `elective_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elective_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  `parent_subject_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7avomg1l8l1xtdbdeufs15d9n` (`parent_subject_id`),
  CONSTRAINT `FK7avomg1l8l1xtdbdeufs15d9n` FOREIGN KEY (`parent_subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elective_group`
--

LOCK TABLES `elective_group` WRITE;
/*!40000 ALTER TABLE `elective_group` DISABLE KEYS */;
INSERT INTO `elective_group` VALUES (1,'Programme Elective-I',50),(2,'Programme Elective-I Lab',57),(3,'Programme Elective-II',51),(4,'Open Elective-I',52),(5,'Programme Elective-III',63),(6,'Programme Elective-III Lab',66),(7,'Open Elective-II',64),(8,'Programme Elective-IV',70),(9,'Programme Elective-IV Lab',75),(10,'Programme Elective-V',71),(11,'Open Elective-III',72),(12,'Open Elective-IV',73);
/*!40000 ALTER TABLE `elective_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elective_group_option`
--

DROP TABLE IF EXISTS `elective_group_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elective_group_option` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `max_intake` int DEFAULT NULL,
  `min_intake` int DEFAULT NULL,
  `option_code` varchar(255) DEFAULT NULL,
  `option_name` varchar(255) DEFAULT NULL,
  `group_id` bigint DEFAULT NULL,
  `short_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKiv8o15hn294hyadvx1g9dqjam` (`group_id`),
  CONSTRAINT `FKiv8o15hn294hyadvx1g9dqjam` FOREIGN KEY (`group_id`) REFERENCES `elective_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elective_group_option`
--

LOCK TABLES `elective_group_option` WRITE;
/*!40000 ALTER TABLE `elective_group_option` DISABLE KEYS */;
INSERT INTO `elective_group_option` VALUES (1,80,10,'20PEEC501A','Information Theory and Coding Techniques',1,'ITCT'),(2,80,10,'20PEEC501B','Mechatronics',1,'MECH'),(3,80,10,'20PEEC501C','Digital Image Processing',1,'DIP'),(4,80,10,'20PEEC501D','Introduction to Internet of Things',1,'IOT'),(5,80,10,'20PEEC501LA','Information Theory and Coding Techniques Lab',2,'ITCT_LAB'),(6,80,10,'20PEEC501LB','Mechatronics Lab',2,'MECH_LAB'),(7,80,10,'20PEEC501LC','Digital Image Processing Lab',2,'DIP_LAB'),(8,80,10,'20PEEC501LD','Introduction to Internet of Things Lab',2,'IOT_LAB'),(10,80,10,'20OEHS501A','Entrepreneurship Development',4,'ED'),(11,80,10,'20OEHS501B','Intellectual Property Rights',4,'IPR'),(12,80,10,'20OEHS501C','Introduction to Digital Marketing',4,'DM'),(13,80,10,'20OEHS501D','Law for Engineers',4,'LFE'),(14,80,10,'20OEHS501E','Organizational Behaviour',4,'OB'),(15,80,10,'20OEHS501F','Project Management',4,'PM'),(16,80,10,'20PEEC601A','Robotics',5,'ROB'),(17,80,10,'20PEEC601B','Biomedical Electronics',5,'BME'),(18,80,10,'20PEEC601C','Power Electronics',5,'PE'),(19,80,10,'20PEEC601D','Deep Learning',5,'DL'),(20,80,10,'20PEEC601LA','Robotics Lab',6,'ROB_LAB'),(21,80,10,'20PEEC601LB','Biomedical Electronics Lab',6,'BME_LAB'),(22,80,10,'20PEEC601LC','Power Electronics Lab',6,'PE_LAB'),(23,80,10,'20PEEC601LD','Deep Learning Lab',6,'DL_LAB'),(24,80,10,'20OE601A','Automation and Control Engineering',7,'ACE'),(25,80,10,'20OE601B','Automotive Electronics',7,'AE'),(26,80,10,'20OE601C','Avionics',7,'AV'),(27,80,10,'20OE601D','Bioinformatics',7,'BIO'),(28,80,10,'20OE601E','Computer Vision',7,'CV'),(29,80,10,'20OE601F','Design Thinking',7,'DT'),(30,80,10,'20OE601G','e-Business',7,'EBIZ'),(31,80,10,'20OE601H','Electric Vehicles',7,'EV'),(32,80,10,'20OE601I','Gamification',7,'GAME'),(33,80,10,'20OE601J','Geographical Information Systems',7,'GIS'),(34,80,10,'20OE601K','Multimedia Systems',7,'MM'),(35,80,10,'20PEEC801A','Microwave and Radar Engineering',8,'MRE'),(36,80,10,'20PEEC801B','Remote Sensing',8,'RS'),(37,80,10,'20PEEC801C','Industrial Automation',8,'IA'),(38,80,10,'20PEEC801D','Embedded RTOS',8,'RTOS'),(39,80,10,'20PEEC801LA','Microwave and Radar Engineering Lab',9,'MRE_LAB'),(40,80,10,'20PEEC801LB','Remote Sensing Lab',9,'RS_LAB'),(41,80,10,'20PEEC801LC','Industrial Automation Lab',9,'IA_LAB'),(42,80,10,'20PEEC801LD','Embedded RTOS Lab',9,'RTOS_LAB'),(43,80,10,'20PEEC802A','Advanced VLSI Design',10,'VLSI'),(44,80,10,'20PEEC802B','Artificial Intelligence',10,'AI'),(45,80,10,'20PEEC802C','Statistical Signal Processing',10,'SSP'),(46,80,10,'20PEEC802D','Mobile Communication',10,'MC'),(47,80,10,'20OE801A','Big Data and Analytics',11,'BDA'),(48,80,10,'20OE801B','Cyber Physical Systems',11,'CPS'),(49,80,10,'20OE801C','Digital Control',11,'DC'),(50,80,10,'20OE801D','Industrial Engineering and Management',11,'IEM'),(51,80,10,'20OE801E','Intro to Cybercrime and Forensics',11,'CF'),(52,80,10,'20OE801F','Instrumentation in Food and Agriculture',11,'IFA'),(53,80,10,'20OE801G','Medical IoT',11,'MIOT'),(54,80,10,'20OE801H','Quantum Computing',11,'QC'),(55,80,10,'20OE801I','Renewable Energy Sources',11,'RES'),(56,80,10,'20OE801J','Soft Computing',11,'SC'),(57,80,10,'20OE801K','Software Testing and Quality Assurance',11,'STQA'),(58,80,10,'20OE802A','Applied statistics with R Programming',12,'ASR'),(59,80,10,'20OE802B','Automobile Engineering',12,'AUTO'),(60,80,10,'20OE802C','Autonomous Robots',12,'AR'),(61,80,10,'20OE802D','Building Automation and Energy Audit',12,'BAEA'),(62,80,10,'20OE802E','Data Analysis and Visualization',12,'DAV'),(63,80,10,'20OE802F','Data Science using Python',12,'DSPY'),(64,80,10,'20OE802G','Industrial Drives and Control',12,'IDC'),(65,80,10,'20OE802H','Smart Sensors and Systems',12,'SSS'),(66,80,10,'20OE802I','Wireless Networks',12,'WN'),(67,80,10,'20PEEC502A','Cloud Computing',3,'CC'),(68,80,10,'20PEEC502B','Operating Systems',3,'OS'),(69,80,10,'20PEEC502C','Database Management Systems',3,'DBMS');
/*!40000 ALTER TABLE `elective_group_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elective_option`
--

DROP TABLE IF EXISTS `elective_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elective_option` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `option_subject_id` bigint DEFAULT NULL,
  `preferred_teacher_id` bigint DEFAULT NULL,
  `group_option_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8sjq3x0fv20upuo1xyq4vjh8f` (`preferred_teacher_id`),
  KEY `fk_eo_group_option` (`option_subject_id`),
  KEY `FKd7uxmxav1tjj8ycdqsm9nm7f6` (`group_option_id`),
  CONSTRAINT `FK8sjq3x0fv20upuo1xyq4vjh8f` FOREIGN KEY (`preferred_teacher_id`) REFERENCES `teacher` (`id`),
  CONSTRAINT `fk_eo_group_option` FOREIGN KEY (`option_subject_id`) REFERENCES `elective_group_option` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKd7uxmxav1tjj8ycdqsm9nm7f6` FOREIGN KEY (`group_option_id`) REFERENCES `elective_group_option` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=553 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elective_option`
--

LOCK TABLES `elective_option` WRITE;
/*!40000 ALTER TABLE `elective_option` DISABLE KEYS */;
INSERT INTO `elective_option` VALUES (225,1,5,1),(226,1,6,1),(227,1,7,1),(228,1,8,1),(229,2,9,2),(230,2,10,2),(231,2,11,2),(232,2,12,2),(233,3,13,3),(234,3,14,3),(235,3,15,3),(236,3,16,3),(237,4,17,4),(238,4,18,4),(239,4,19,4),(240,4,20,4),(241,5,21,5),(242,5,22,5),(243,5,23,5),(244,5,24,5),(245,5,25,5),(246,5,26,5),(247,5,27,5),(248,5,28,5),(249,6,29,6),(250,6,30,6),(251,6,31,6),(252,6,32,6),(253,6,33,6),(254,6,34,6),(255,6,35,6),(256,6,36,6),(257,7,37,7),(258,7,38,7),(259,7,39,7),(260,7,40,7),(261,7,41,7),(262,7,42,7),(263,7,5,7),(264,7,6,7),(265,8,7,8),(266,8,8,8),(267,8,9,8),(268,8,10,8),(269,8,11,8),(270,8,12,8),(271,8,13,8),(272,8,14,8),(273,10,15,10),(274,10,16,10),(275,10,17,10),(276,10,18,10),(277,11,19,11),(278,11,20,11),(279,11,21,11),(280,11,22,11),(281,12,23,12),(282,12,24,12),(283,12,25,12),(284,12,26,12),(285,13,27,13),(286,13,28,13),(287,13,29,13),(288,13,30,13),(289,14,31,14),(290,14,32,14),(291,14,33,14),(292,14,34,14),(293,15,35,15),(294,15,36,15),(295,15,37,15),(296,15,38,15),(297,16,39,16),(298,16,40,16),(299,16,41,16),(300,16,42,16),(301,17,5,17),(302,17,6,17),(303,17,7,17),(304,17,8,17),(305,18,9,18),(306,18,10,18),(307,18,11,18),(308,18,12,18),(309,19,13,19),(310,19,14,19),(311,19,15,19),(312,19,16,19),(313,20,17,20),(314,20,18,20),(315,20,19,20),(316,20,20,20),(317,20,21,20),(318,20,22,20),(319,20,23,20),(320,20,24,20),(321,21,25,21),(322,21,26,21),(323,21,27,21),(324,21,28,21),(325,21,29,21),(326,21,30,21),(327,21,31,21),(328,21,32,21),(329,22,33,22),(330,22,34,22),(331,22,35,22),(332,22,36,22),(333,22,37,22),(334,22,38,22),(335,22,39,22),(336,22,40,22),(337,23,41,23),(338,23,42,23),(339,23,5,23),(340,23,6,23),(341,23,7,23),(342,23,8,23),(343,23,9,23),(344,23,10,23),(345,24,11,24),(346,24,12,24),(347,24,13,24),(348,24,14,24),(349,25,15,25),(350,25,16,25),(351,25,17,25),(352,25,18,25),(353,26,19,26),(354,26,20,26),(355,26,21,26),(356,26,22,26),(357,27,23,27),(358,27,24,27),(359,27,25,27),(360,27,26,27),(361,28,27,28),(362,28,28,28),(363,28,29,28),(364,28,30,28),(365,29,31,29),(366,29,32,29),(367,29,33,29),(368,29,34,29),(369,30,35,30),(370,30,36,30),(371,30,37,30),(372,30,38,30),(373,31,39,31),(374,31,40,31),(375,31,41,31),(376,31,42,31),(377,32,5,32),(378,32,6,32),(379,32,7,32),(380,32,8,32),(381,33,9,33),(382,33,10,33),(383,33,11,33),(384,33,12,33),(385,34,13,34),(386,34,14,34),(387,34,15,34),(388,34,16,34),(389,35,17,35),(390,35,18,35),(391,35,19,35),(392,35,20,35),(393,36,21,36),(394,36,22,36),(395,36,23,36),(396,36,24,36),(397,37,25,37),(398,37,26,37),(399,37,27,37),(400,37,28,37),(401,37,29,37),(402,37,30,37),(403,37,31,37),(404,37,32,37),(405,38,33,38),(406,38,34,38),(407,38,35,38),(408,38,36,38),(409,38,37,38),(410,38,38,38),(411,38,39,38),(412,38,40,38),(413,39,41,39),(414,39,42,39),(415,39,5,39),(416,39,6,39),(417,39,7,39),(418,39,8,39),(419,39,9,39),(420,39,10,39),(421,40,11,40),(422,40,12,40),(423,40,13,40),(424,40,14,40),(425,40,15,40),(426,40,16,40),(427,40,17,40),(428,40,18,40),(429,41,19,41),(430,41,20,41),(431,41,21,41),(432,41,22,41),(433,41,23,41),(434,41,24,41),(435,41,25,41),(436,41,26,41),(437,42,27,42),(438,42,28,42),(439,42,29,42),(440,42,30,42),(441,42,31,42),(442,42,32,42),(443,42,33,42),(444,42,34,42),(445,43,35,43),(446,43,36,43),(447,43,37,43),(448,43,38,43),(449,44,39,44),(450,44,40,44),(451,44,41,44),(452,44,42,44),(453,45,5,45),(454,45,6,45),(455,45,7,45),(456,45,8,45),(457,46,9,46),(458,46,10,46),(459,46,11,46),(460,46,12,46),(461,47,13,47),(462,47,14,47),(463,47,15,47),(464,47,16,47),(465,48,17,48),(466,48,18,48),(467,48,19,48),(468,48,20,48),(469,49,21,49),(470,49,22,49),(471,49,23,49),(472,49,24,49),(473,50,25,50),(474,50,26,50),(475,50,27,50),(476,50,28,50),(477,51,29,51),(478,51,30,51),(479,51,31,51),(480,51,32,51),(481,52,33,52),(482,52,34,52),(483,52,35,52),(484,52,36,52),(485,53,37,53),(486,53,38,53),(487,53,39,53),(488,53,40,53),(489,54,41,54),(490,54,42,54),(491,54,5,54),(492,54,6,54),(493,55,7,55),(494,55,8,55),(495,55,9,55),(496,55,10,55),(497,56,11,56),(498,56,12,56),(499,56,13,56),(500,56,14,56),(501,57,15,57),(502,57,16,57),(503,57,17,57),(504,57,18,57),(505,58,19,58),(506,58,20,58),(507,58,21,58),(508,58,22,58),(509,59,23,59),(510,59,24,59),(511,59,25,59),(512,59,26,59),(513,60,27,60),(514,60,28,60),(515,60,29,60),(516,60,30,60),(517,61,31,61),(518,61,32,61),(519,61,33,61),(520,61,34,61),(521,62,35,62),(522,62,36,62),(523,62,37,62),(524,62,38,62),(525,63,39,63),(526,63,40,63),(527,63,41,63),(528,63,42,63),(529,64,5,64),(530,64,6,64),(531,64,7,64),(532,64,8,64),(533,65,9,65),(534,65,10,65),(535,65,11,65),(536,65,12,65),(537,66,13,66),(538,66,14,66),(539,66,15,66),(540,66,16,66),(541,67,17,67),(542,67,18,67),(543,67,19,67),(544,67,20,67),(545,68,21,68),(546,68,22,68),(547,68,23,68),(548,68,24,68),(549,69,25,69),(550,69,26,69),(551,69,27,69),(552,69,28,69);
/*!40000 ALTER TABLE `elective_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equi_time_slot`
--

DROP TABLE IF EXISTS `equi_time_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equi_time_slot` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lab_slot` bigint NOT NULL,
  `lec_slot` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_lab_lec` (`lab_slot`,`lec_slot`),
  KEY `fk_equi_lec_slot` (`lec_slot`),
  CONSTRAINT `fk_equi_lab_slot` FOREIGN KEY (`lab_slot`) REFERENCES `time_slot` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_equi_lec_slot` FOREIGN KEY (`lec_slot`) REFERENCES `time_slot` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equi_time_slot`
--

LOCK TABLES `equi_time_slot` WRITE;
/*!40000 ALTER TABLE `equi_time_slot` DISABLE KEYS */;
INSERT INTO `equi_time_slot` VALUES (1,58,8),(2,58,9),(3,59,11),(4,59,12),(5,60,14),(6,60,15),(7,61,16),(8,61,17),(9,62,18),(10,62,19),(11,63,21),(12,63,22),(13,64,24),(14,64,25),(15,65,26),(16,65,27),(17,66,28),(18,66,29),(19,67,31),(20,67,32),(21,68,34),(22,68,35),(23,69,36),(24,69,37),(25,70,38),(26,70,39),(27,71,41),(28,71,42),(29,72,44),(30,72,45),(31,73,46),(32,73,47),(33,74,48),(34,74,49),(35,75,51),(36,75,52),(37,76,54),(38,76,55),(39,77,56),(40,77,57);
/*!40000 ALTER TABLE `equi_time_slot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_class`
--

DROP TABLE IF EXISTS `scheduled_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_class` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_type` varchar(50) NOT NULL,
  `batch_id` bigint DEFAULT NULL,
  `division_id` bigint DEFAULT NULL,
  `classroom_id` bigint DEFAULT NULL,
  `subject_id` bigint NOT NULL,
  `tsa_id` bigint DEFAULT NULL,
  `time_slot_id` bigint DEFAULT NULL,
  `elective_flag` int NOT NULL,
  `semester_id` bigint NOT NULL,
  `pinned` tinyint(1) NOT NULL DEFAULT '0',
  `teacher_group_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sc_batch` (`batch_id`),
  KEY `fk_sc_division` (`division_id`),
  KEY `fk_sc_classroom` (`classroom_id`),
  KEY `fk_sc_subject` (`subject_id`),
  KEY `fk_sc_teacher_tsa` (`tsa_id`),
  KEY `fk_sc_timeslot` (`time_slot_id`),
  KEY `fk_sc_semester` (`semester_id`),
  KEY `idx_teacher_group_id` (`teacher_group_id`),
  CONSTRAINT `fk_sc_batch` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`id`),
  CONSTRAINT `fk_sc_classroom` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`id`),
  CONSTRAINT `fk_sc_division` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `fk_sc_semester` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`),
  CONSTRAINT `fk_sc_subject` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `fk_sc_teacher_tsa` FOREIGN KEY (`tsa_id`) REFERENCES `teacher_subject_allocation` (`id`),
  CONSTRAINT `fk_sc_timeslot` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11751 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_class`
--

LOCK TABLES `scheduled_class` WRITE;
/*!40000 ALTER TABLE `scheduled_class` DISABLE KEYS */;
INSERT INTO `scheduled_class` VALUES (11509,'ELECTIVE',NULL,NULL,NULL,66,NULL,58,1,6,1,NULL),(11510,'ELECTIVE',NULL,NULL,NULL,64,NULL,11,1,6,1,NULL),(11511,'ELECTIVE',NULL,NULL,NULL,64,NULL,18,1,6,1,NULL),(11512,'ELECTIVE',NULL,NULL,NULL,64,NULL,28,1,6,1,NULL),(11513,'ELECTIVE',NULL,NULL,NULL,63,NULL,12,1,6,1,NULL),(11514,'ELECTIVE',NULL,NULL,NULL,63,NULL,19,1,6,1,NULL),(11515,'ELECTIVE',NULL,NULL,NULL,63,NULL,29,1,6,1,NULL),(11516,'ELECTIVE',NULL,NULL,NULL,71,NULL,8,1,8,1,NULL),(11517,'ELECTIVE',NULL,NULL,NULL,71,NULL,18,1,8,1,NULL),(11518,'ELECTIVE',NULL,NULL,NULL,71,NULL,28,1,8,1,NULL),(11519,'ELECTIVE',NULL,NULL,NULL,75,NULL,59,1,8,1,NULL),(11520,'ELECTIVE',NULL,NULL,NULL,72,NULL,9,1,8,1,NULL),(11521,'ELECTIVE',NULL,NULL,NULL,72,NULL,19,1,8,1,NULL),(11522,'ELECTIVE',NULL,NULL,NULL,72,NULL,29,1,8,1,NULL),(11523,'ELECTIVE',NULL,NULL,NULL,73,NULL,14,1,8,1,NULL),(11524,'ELECTIVE',NULL,NULL,NULL,73,NULL,21,1,8,1,NULL),(11525,'ELECTIVE',NULL,NULL,NULL,73,NULL,31,1,8,1,NULL),(11526,'ELECTIVE',NULL,NULL,NULL,70,NULL,15,1,8,1,NULL),(11527,'ELECTIVE',NULL,NULL,NULL,70,NULL,22,1,8,1,NULL),(11528,'ELECTIVE',NULL,NULL,NULL,70,NULL,32,1,8,1,NULL),(11529,'LEC',NULL,10,31,36,2934,16,0,4,0,NULL),(11530,'LEC',NULL,10,18,36,2934,51,0,4,0,NULL),(11531,'LEC',NULL,10,31,36,2934,25,0,4,0,NULL),(11532,'LEC',NULL,11,31,36,2689,37,0,4,0,NULL),(11533,'LEC',NULL,11,32,36,2689,17,0,4,0,NULL),(11534,'LEC',NULL,11,17,36,2689,27,0,4,0,NULL),(11535,'LEC',NULL,12,34,36,2697,16,0,4,0,NULL),(11536,'LEC',NULL,12,15,36,2697,38,0,4,0,NULL),(11537,'LEC',NULL,12,33,36,2697,36,0,4,0,NULL),(11538,'TUT',45,10,18,36,2691,36,0,4,0,NULL),(11539,'TUT',46,10,28,36,2689,54,0,4,0,NULL),(11540,'TUT',47,10,48,36,2689,26,0,4,0,NULL),(11541,'TUT',48,10,49,36,2689,19,0,4,0,NULL),(11542,'TUT',49,11,34,36,2689,39,0,4,0,NULL),(11543,'TUT',50,11,8,36,2694,28,0,4,0,NULL),(11544,'TUT',51,11,33,36,2698,35,0,4,0,NULL),(11545,'TUT',52,11,29,36,2691,25,0,4,0,NULL),(11546,'TUT',53,12,9,36,2941,35,0,4,0,NULL),(11547,'TUT',54,12,12,36,2929,48,0,4,0,NULL),(11548,'TUT',55,12,22,36,2689,46,0,4,0,NULL),(11549,'TUT',56,12,32,36,2984,9,0,4,0,NULL),(11550,'LEC',NULL,10,33,37,2707,52,0,4,0,NULL),(11551,'LEC',NULL,10,15,37,2707,34,0,4,0,NULL),(11552,'LEC',NULL,10,30,37,2707,17,0,4,0,NULL),(11553,'LEC',NULL,11,14,37,2707,44,0,4,0,NULL),(11554,'LEC',NULL,11,17,37,2707,16,0,4,0,NULL),(11555,'LEC',NULL,11,14,37,2707,27,0,4,0,NULL),(11556,'LEC',NULL,12,20,37,2706,37,0,4,0,NULL),(11557,'LEC',NULL,12,34,37,2706,26,0,4,0,NULL),(11558,'LEC',NULL,12,31,37,2706,51,0,4,0,NULL),(11559,'TUT',45,10,31,37,2701,14,0,4,0,NULL),(11560,'TUT',46,10,45,37,2707,42,0,4,0,NULL),(11561,'TUT',47,10,28,37,2703,15,0,4,0,NULL),(11562,'TUT',48,10,29,37,2980,52,0,4,0,NULL),(11563,'TUT',49,11,46,37,2703,38,0,4,0,NULL),(11564,'TUT',50,11,11,37,2980,24,0,4,0,NULL),(11565,'TUT',51,11,21,37,2701,42,0,4,0,NULL),(11566,'TUT',52,11,44,37,2703,27,0,4,0,NULL),(11567,'TUT',53,12,22,37,2699,14,0,4,0,NULL),(11568,'TUT',54,12,19,37,2705,56,0,4,0,NULL),(11569,'TUT',55,12,34,37,2706,45,0,4,0,NULL),(11570,'TUT',56,12,12,37,2699,28,0,4,0,NULL),(11571,'LEC',NULL,10,14,38,2716,24,0,4,0,NULL),(11572,'LEC',NULL,10,19,38,2716,52,0,4,0,NULL),(11573,'LEC',NULL,10,20,38,2716,34,0,4,0,NULL),(11574,'LEC',NULL,11,17,38,2717,26,0,4,0,NULL),(11575,'LEC',NULL,11,19,38,2717,36,0,4,0,NULL),(11576,'LEC',NULL,11,13,38,2717,49,0,4,0,NULL),(11577,'LEC',NULL,12,15,38,2712,17,0,4,0,NULL),(11578,'LEC',NULL,12,15,38,2712,24,0,4,0,NULL),(11579,'LEC',NULL,12,30,38,2712,41,0,4,0,NULL),(11580,'LEC',NULL,10,31,39,2719,34,0,4,0,NULL),(11581,'LEC',NULL,10,33,39,2719,39,0,4,0,NULL),(11582,'LEC',NULL,10,18,39,2719,52,0,4,0,NULL),(11583,'LEC',NULL,11,33,39,2722,15,0,4,0,NULL),(11584,'LEC',NULL,11,17,39,2722,48,0,4,0,NULL),(11585,'LEC',NULL,11,16,39,2722,27,0,4,0,NULL),(11586,'LEC',NULL,12,17,39,2728,25,0,4,0,NULL),(11587,'LEC',NULL,12,17,39,2728,55,0,4,0,NULL),(11588,'LEC',NULL,12,18,39,2728,42,0,4,0,NULL),(11589,'LEC',NULL,10,33,40,2738,38,0,4,0,NULL),(11590,'LEC',NULL,10,18,40,2738,35,0,4,0,NULL),(11591,'LEC',NULL,10,17,40,2738,52,0,4,0,NULL),(11592,'LEC',NULL,11,32,40,2732,27,0,4,0,NULL),(11593,'LEC',NULL,11,30,40,2732,45,0,4,0,NULL),(11594,'LEC',NULL,11,18,40,2732,14,0,4,0,NULL),(11595,'LEC',NULL,12,16,40,2734,39,0,4,0,NULL),(11596,'LEC',NULL,12,34,40,2734,54,0,4,0,NULL),(11597,'LEC',NULL,12,34,40,2734,27,0,4,0,NULL),(11598,'LAB',45,10,5,41,2744,62,0,4,0,NULL),(11599,'LAB',46,10,28,41,2742,74,0,4,0,NULL),(11600,'LAB',47,10,47,41,2748,76,0,4,0,NULL),(11601,'LAB',48,10,29,41,2744,69,0,4,0,NULL),(11602,'LAB',49,11,49,41,2985,64,0,4,0,NULL),(11603,'LAB',50,11,48,41,2985,71,0,4,0,NULL),(11604,'LAB',51,11,11,41,2942,77,0,4,0,NULL),(11605,'LAB',52,11,49,41,2935,73,0,4,0,NULL),(11606,'LAB',53,12,48,41,2739,58,0,4,0,NULL),(11607,'LAB',54,12,47,41,2741,68,0,4,0,NULL),(11608,'LAB',55,12,48,41,2985,66,0,4,0,NULL),(11609,'LAB',56,12,12,41,2930,72,0,4,0,NULL),(11610,'LAB',45,10,5,42,2750,63,0,4,0,NULL),(11611,'LAB',46,10,45,42,2758,72,0,4,0,NULL),(11612,'LAB',47,10,7,42,2753,71,0,4,0,NULL),(11613,'LAB',48,10,45,42,2751,59,0,4,0,NULL),(11614,'LAB',49,11,10,42,2756,76,0,4,0,NULL),(11615,'LAB',50,11,46,42,2981,58,0,4,0,NULL),(11616,'LAB',51,11,44,42,2758,75,0,4,0,NULL),(11617,'LAB',52,11,47,42,2947,67,0,4,0,NULL),(11618,'LAB',53,12,45,42,2981,73,0,4,0,NULL),(11619,'LAB',54,12,8,42,2751,63,0,4,0,NULL),(11620,'LAB',55,12,45,42,2757,63,0,4,0,NULL),(11621,'LAB',56,12,10,42,2981,62,0,4,0,NULL),(11622,'LAB',45,10,10,43,2762,67,0,4,0,NULL),(11623,'LAB',46,10,24,43,2958,65,0,4,0,NULL),(11624,'LAB',47,10,8,43,2767,73,0,4,0,NULL),(11625,'LAB',48,10,48,43,2764,72,0,4,0,NULL),(11626,'LAB',49,11,49,43,2987,66,0,4,0,NULL),(11627,'LAB',50,11,24,43,2958,70,0,4,0,NULL),(11628,'LAB',51,11,9,43,3003,63,0,4,0,NULL),(11629,'LAB',52,11,48,43,2987,68,0,4,0,NULL),(11630,'LAB',53,12,11,43,2987,62,0,4,0,NULL),(11631,'LAB',54,12,44,43,2958,59,0,4,0,NULL),(11632,'LAB',55,12,44,43,3003,60,0,4,0,NULL),(11633,'LAB',56,12,24,43,2767,62,0,4,0,NULL),(11634,'LAB',45,10,44,44,2769,72,0,4,0,NULL),(11635,'LAB',46,10,46,44,2770,73,0,4,0,NULL),(11636,'LAB',47,10,45,44,3008,58,0,4,0,NULL),(11637,'LAB',48,10,10,44,2775,73,0,4,0,NULL),(11638,'LAB',49,11,49,44,2778,59,0,4,0,NULL),(11639,'LAB',50,11,9,44,2771,77,0,4,0,NULL),(11640,'LAB',51,11,5,44,2769,76,0,4,0,NULL),(11641,'LAB',52,11,12,44,2773,77,0,4,0,NULL),(11642,'LAB',53,12,47,44,2968,74,0,4,0,NULL),(11643,'LAB',54,12,12,44,2777,62,0,4,0,NULL),(11644,'LAB',55,12,48,44,2771,62,0,4,0,NULL),(11645,'LAB',56,12,44,44,3008,62,0,4,0,NULL),(11646,'LAB',45,10,24,45,2783,73,0,4,0,NULL),(11647,'LAB',46,10,47,45,2779,60,0,4,0,NULL),(11648,'LAB',47,10,44,45,2784,66,0,4,0,NULL),(11649,'LAB',48,10,29,45,2783,77,0,4,0,NULL),(11650,'LAB',49,11,5,45,2781,77,0,4,0,NULL),(11651,'LAB',50,11,49,45,2783,76,0,4,0,NULL),(11652,'LAB',51,11,8,45,2785,62,0,4,0,NULL),(11653,'LAB',52,11,7,45,2788,76,0,4,0,NULL),(11654,'LAB',53,12,48,45,2784,63,0,4,0,NULL),(11655,'LAB',54,12,9,45,2783,67,0,4,0,NULL),(11656,'LAB',55,12,10,45,2785,77,0,4,0,NULL),(11657,'LAB',56,12,49,45,2781,63,0,4,0,NULL),(11658,'LEC',NULL,16,30,59,2862,25,0,6,0,NULL),(11659,'LEC',NULL,16,14,59,2862,55,0,6,0,NULL),(11660,'LEC',NULL,16,34,59,2862,35,0,6,0,NULL),(11661,'LEC',NULL,17,18,59,2866,15,0,6,0,NULL),(11662,'LEC',NULL,17,18,59,2866,54,0,6,0,NULL),(11663,'LEC',NULL,17,18,59,2866,46,0,6,0,NULL),(11664,'LEC',NULL,18,34,59,2859,34,0,6,0,NULL),(11665,'LEC',NULL,18,33,59,2859,56,0,6,0,NULL),(11666,'LEC',NULL,18,33,59,2859,47,0,6,0,NULL),(11667,'TUT',69,16,47,59,2868,47,0,6,0,NULL),(11668,'TUT',70,16,19,59,2862,49,0,6,0,NULL),(11669,'TUT',71,16,45,59,2861,41,0,6,0,NULL),(11670,'TUT',72,16,23,59,2859,39,0,6,0,NULL),(11671,'TUT',73,17,34,59,2863,32,0,6,0,NULL),(11672,'TUT',74,17,23,59,2863,26,0,6,0,NULL),(11673,'TUT',75,17,48,59,2865,56,0,6,0,NULL),(11674,'TUT',76,17,12,59,2946,49,0,6,0,NULL),(11675,'TUT',77,18,49,59,2863,39,0,6,0,NULL),(11676,'TUT',78,18,21,59,2860,16,0,6,0,NULL),(11677,'TUT',79,18,8,59,2863,42,0,6,0,NULL),(11678,'TUT',80,18,47,59,2865,41,0,6,0,NULL),(11679,'LEC',NULL,16,34,60,2871,36,0,6,0,NULL),(11680,'LEC',NULL,16,18,60,2871,17,0,6,0,NULL),(11681,'LEC',NULL,16,14,60,2871,56,0,6,0,NULL),(11682,'LEC',NULL,17,13,60,2870,52,0,6,0,NULL),(11683,'LEC',NULL,17,18,60,2870,16,0,6,0,NULL),(11684,'LEC',NULL,17,15,60,2870,35,0,6,0,NULL),(11685,'LEC',NULL,18,20,60,2939,21,0,6,0,NULL),(11686,'LEC',NULL,18,32,60,2939,55,0,6,0,NULL),(11687,'LEC',NULL,18,31,60,2939,32,0,6,0,NULL),(11688,'LEC',NULL,16,20,61,2881,16,0,6,0,NULL),(11689,'LEC',NULL,16,14,61,2881,54,0,6,0,NULL),(11690,'LEC',NULL,16,18,61,2881,44,0,6,0,NULL),(11691,'LEC',NULL,17,18,61,2879,21,0,6,0,NULL),(11692,'LEC',NULL,17,13,61,2879,55,0,6,0,NULL),(11693,'LEC',NULL,17,19,61,2879,47,0,6,0,NULL),(11694,'LEC',NULL,18,32,61,2880,46,0,6,0,NULL),(11695,'LEC',NULL,18,17,61,2880,14,0,6,0,NULL),(11696,'LEC',NULL,18,30,61,2880,57,0,6,0,NULL),(11697,'TUT',69,16,33,61,2884,31,0,6,0,NULL),(11698,'TUT',70,16,48,61,2887,48,0,6,0,NULL),(11699,'TUT',71,16,7,61,2883,14,0,6,0,NULL),(11700,'TUT',72,16,33,61,2888,27,0,6,0,NULL),(11701,'TUT',73,17,17,61,2971,45,0,6,0,NULL),(11702,'TUT',74,17,31,61,2882,48,0,6,0,NULL),(11703,'TUT',75,17,18,61,2883,31,0,6,0,NULL),(11704,'TUT',76,17,9,61,2882,38,0,6,0,NULL),(11705,'TUT',77,18,45,61,2887,37,0,6,0,NULL),(11706,'TUT',78,18,19,61,2888,17,0,6,0,NULL),(11707,'TUT',79,18,10,61,2881,49,0,6,0,NULL),(11708,'TUT',80,18,20,61,2971,27,0,6,0,NULL),(11709,'LEC',NULL,16,13,62,2933,24,0,6,0,NULL),(11710,'LEC',NULL,16,17,62,2933,37,0,6,0,NULL),(11711,'LEC',NULL,16,33,62,2933,57,0,6,0,NULL),(11712,'LEC',NULL,17,20,62,2897,36,0,6,0,NULL),(11713,'LEC',NULL,17,16,62,2897,51,0,6,0,NULL),(11714,'LEC',NULL,17,13,62,2897,17,0,6,0,NULL),(11715,'LEC',NULL,18,16,62,2889,45,0,6,0,NULL),(11716,'LEC',NULL,18,31,62,2889,31,0,6,0,NULL),(11717,'LEC',NULL,18,20,62,2889,22,0,6,0,NULL),(11718,'LAB',69,16,28,65,2905,63,0,6,0,NULL),(11719,'LAB',70,16,7,65,2901,73,0,6,0,NULL),(11720,'LAB',71,16,5,65,2905,65,0,6,0,NULL),(11721,'LAB',72,16,7,65,2962,74,0,6,0,NULL),(11722,'LAB',73,17,28,65,2902,70,0,6,0,NULL),(11723,'LAB',74,17,11,65,2899,72,0,6,0,NULL),(11724,'LAB',75,17,28,65,2902,71,0,6,0,NULL),(11725,'LAB',76,17,48,65,2908,67,0,6,0,NULL),(11726,'LAB',77,18,44,65,2962,71,0,6,0,NULL),(11727,'LAB',78,18,11,65,2901,75,0,6,0,NULL),(11728,'LAB',79,18,10,65,2903,65,0,6,0,NULL),(11729,'LAB',80,18,48,65,2905,61,0,6,0,NULL),(11730,'LEC',NULL,22,19,69,2909,26,0,8,0,NULL),(11731,'LEC',NULL,22,33,69,2909,49,0,8,0,NULL),(11732,'LEC',NULL,22,19,69,2909,35,0,8,0,NULL),(11733,'LEC',NULL,23,31,69,2911,57,0,8,0,NULL),(11734,'LEC',NULL,23,16,69,2911,25,0,8,0,NULL),(11735,'LEC',NULL,23,19,69,2911,16,0,8,0,NULL),(11736,'LEC',NULL,24,14,69,2910,26,0,8,0,NULL),(11737,'LEC',NULL,24,13,69,2910,16,0,8,0,NULL),(11738,'LEC',NULL,24,31,69,2910,47,0,8,0,NULL),(11739,'LAB',93,22,5,74,2979,70,0,8,0,NULL),(11740,'LAB',94,22,45,74,2919,75,0,8,0,NULL),(11741,'LAB',95,22,45,74,2979,61,0,8,0,NULL),(11742,'LAB',96,22,11,74,2979,69,0,8,0,NULL),(11743,'LAB',97,23,5,74,2920,69,0,8,0,NULL),(11744,'LAB',98,23,29,74,2921,70,0,8,0,NULL),(11745,'LAB',99,23,46,74,2928,68,0,8,0,NULL),(11746,'LAB',100,23,28,74,2919,72,0,8,0,NULL),(11747,'LAB',101,24,5,74,2920,64,0,8,0,NULL),(11748,'LAB',102,24,10,74,2923,69,0,8,0,NULL),(11749,'LAB',103,24,5,74,2928,71,0,8,0,NULL),(11750,'LAB',104,24,9,74,2923,72,0,8,0,NULL);
/*!40000 ALTER TABLE `scheduled_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_class_backup`
--

DROP TABLE IF EXISTS `scheduled_class_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_class_backup` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_type` varchar(255) DEFAULT NULL,
  `batch_id` bigint DEFAULT NULL,
  `classroom_id` bigint DEFAULT NULL,
  `division_id` bigint DEFAULT NULL,
  `subject_id` bigint DEFAULT NULL,
  `teacher_id` bigint DEFAULT NULL,
  `time_slot_id` bigint DEFAULT NULL,
  `elective_flag` tinyint(1) DEFAULT '0',
  `lab_group_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `semester_id` bigint NOT NULL,
  `pinned` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK7m7ctoesdv42upy6ar9rvcshi` (`batch_id`),
  KEY `FK93a1mhuto9fenp51t99swpxmk` (`classroom_id`),
  KEY `FKhw5qgf3ga8arc5oq4m1pra5by` (`division_id`),
  KEY `FK5pdbf2m0i7nfvqxgpifvanvpq` (`teacher_id`),
  KEY `FKqv9wn0ebt1eydtt8chp27xrgh` (`time_slot_id`),
  KEY `fk_sc_subject` (`subject_id`),
  KEY `fk_sc_semester` (`semester_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30651 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_class_backup`
--

LOCK TABLES `scheduled_class_backup` WRITE;
/*!40000 ALTER TABLE `scheduled_class_backup` DISABLE KEYS */;
INSERT INTO `scheduled_class_backup` VALUES (6875,'LEC',NULL,10,19,36,2941,45,0,'4',0,NULL),(6876,'LEC',NULL,10,37,36,2941,57,0,'4',0,NULL),(6877,'LEC',NULL,10,16,36,2941,15,0,'4',0,NULL),(6878,'LEC',NULL,11,38,36,2691,36,0,'4',0,NULL),(6879,'LEC',NULL,11,40,36,2691,47,0,'4',0,NULL),(6880,'LEC',NULL,11,41,36,2691,12,0,'4',0,NULL),(6881,'LEC',NULL,12,39,36,2697,36,0,'4',0,NULL),(6882,'LEC',NULL,12,18,36,2697,54,0,'4',0,NULL),(6883,'LEC',NULL,12,20,36,2697,16,0,'4',0,NULL),(6884,'TUT',45,10,13,36,2941,39,0,'4',0,NULL),(6885,'TUT',46,10,7,36,2984,28,0,'4',0,NULL),(6886,'TUT',47,10,8,36,2934,29,0,'4',0,NULL),(6887,'TUT',48,10,17,36,2692,46,0,'4',0,NULL),(6888,'TUT',49,11,10,36,2694,42,0,'4',0,NULL),(6889,'TUT',50,11,26,36,2689,54,0,'4',0,NULL),(6890,'TUT',51,11,35,36,2941,31,0,'4',0,NULL),(6891,'TUT',52,11,24,36,2929,35,0,'4',0,NULL),(6892,'TUT',53,12,36,36,2984,11,0,'4',0,NULL),(6893,'TUT',54,12,35,36,2692,56,0,'4',0,NULL),(6894,'TUT',55,12,8,36,2934,57,0,'4',0,NULL),(6895,'TUT',56,12,26,36,2692,19,0,'4',0,NULL),(6896,'LEC',NULL,10,18,37,2703,24,0,'4',0,NULL),(6897,'LEC',NULL,10,17,37,2703,34,0,'4',0,NULL),(6898,'LEC',NULL,10,30,37,2703,56,0,'4',0,NULL),(6899,'LEC',NULL,11,30,37,2700,37,0,'4',0,NULL),(6900,'LEC',NULL,11,36,37,2700,46,0,'4',0,NULL),(6901,'LEC',NULL,11,20,37,2700,11,0,'4',0,NULL),(6902,'LEC',NULL,12,36,37,2706,37,0,'4',0,NULL),(6903,'LEC',NULL,12,37,37,2706,27,0,'4',0,NULL),(6904,'LEC',NULL,12,16,37,2706,38,0,'4',0,NULL),(6905,'TUT',45,10,10,37,2708,17,0,'4',0,NULL),(6906,'TUT',46,10,46,37,2980,21,0,'4',0,NULL),(6907,'TUT',47,10,35,37,2700,9,0,'4',0,NULL),(6908,'TUT',48,10,41,37,2699,22,0,'4',0,NULL),(6909,'TUT',49,11,29,37,2705,17,0,'4',0,NULL),(6910,'TUT',50,11,38,37,2701,56,0,'4',0,NULL),(6911,'TUT',51,11,47,37,2702,57,0,'4',0,NULL),(6912,'TUT',52,11,12,37,2708,32,0,'4',0,NULL),(6913,'TUT',53,12,41,37,2701,46,0,'4',0,NULL),(6914,'TUT',54,12,18,37,2707,52,0,'4',0,NULL),(6915,'TUT',55,12,41,37,2700,31,0,'4',0,NULL),(6916,'TUT',56,12,5,37,2703,32,0,'4',0,NULL),(6917,'LEC',NULL,10,30,38,2711,41,0,'4',0,NULL),(6918,'LEC',NULL,10,13,38,2711,14,0,'4',0,NULL),(6919,'LEC',NULL,10,34,38,2711,51,0,'4',0,NULL),(6920,'LEC',NULL,11,34,38,2711,26,0,'4',0,NULL),(6921,'LEC',NULL,11,13,38,2711,29,0,'4',0,NULL),(6922,'LEC',NULL,11,36,38,2711,9,0,'4',0,NULL),(6923,'LEC',NULL,12,15,38,2717,55,0,'4',0,NULL),(6924,'LEC',NULL,12,37,38,2717,17,0,'4',0,NULL),(6925,'LEC',NULL,12,13,38,2717,34,0,'4',0,NULL),(6926,'LEC',NULL,10,36,39,2721,35,0,'4',0,NULL),(6927,'LEC',NULL,10,39,39,2721,11,0,'4',0,NULL),(6928,'LEC',NULL,10,38,39,2721,25,0,'4',0,NULL),(6929,'LEC',NULL,11,39,39,2967,41,0,'4',0,NULL),(6930,'LEC',NULL,11,40,39,2967,27,0,'4',0,NULL),(6931,'LEC',NULL,11,15,39,2967,49,0,'4',0,NULL),(6932,'LEC',NULL,12,14,39,2728,8,0,'4',0,NULL),(6933,'LEC',NULL,12,37,39,2728,26,0,'4',0,NULL),(6934,'LEC',NULL,12,31,39,2728,49,0,'4',0,NULL),(6935,'LEC',NULL,10,14,40,2952,42,0,'4',0,NULL),(6936,'LEC',NULL,10,31,40,2952,52,0,'4',0,NULL),(6937,'LEC',NULL,10,40,40,2952,12,0,'4',0,NULL),(6938,'LEC',NULL,11,41,40,2738,8,0,'4',0,NULL),(6939,'LEC',NULL,11,17,40,2738,28,0,'4',0,NULL),(6940,'LEC',NULL,11,16,40,2738,48,0,'4',0,NULL),(6941,'LEC',NULL,12,32,40,2730,9,0,'4',0,NULL),(6942,'LEC',NULL,12,32,40,2730,39,0,'4',0,NULL),(6943,'LEC',NULL,12,19,40,2730,35,0,'4',0,NULL),(6944,'LAB',45,10,25,41,2744,62,0,'4',0,NULL),(6945,'LAB',46,10,44,41,2744,70,0,'4',0,NULL),(6946,'LAB',47,10,9,41,2985,65,0,'4',0,NULL),(6947,'LAB',48,10,45,41,2930,66,0,'4',0,NULL),(6948,'LAB',49,11,26,41,2930,72,0,'4',0,NULL),(6949,'LAB',50,11,27,41,2985,61,0,'4',0,NULL),(6950,'LAB',51,11,27,41,2935,75,0,'4',0,NULL),(6951,'LAB',52,11,5,41,2748,63,0,'4',0,NULL),(6952,'LAB',53,12,29,41,2739,72,0,'4',0,NULL),(6953,'LAB',54,12,35,41,2747,62,0,'4',0,NULL),(6954,'LAB',55,12,48,41,2741,72,0,'4',0,NULL),(6955,'LAB',56,12,35,41,2742,66,0,'4',0,NULL),(6956,'LAB',45,10,8,42,2753,70,0,'4',0,NULL),(6957,'LAB',46,10,10,42,2752,76,0,'4',0,NULL),(6958,'LAB',47,10,24,42,2751,69,0,'4',0,NULL),(6959,'LAB',48,10,11,42,2756,76,0,'4',0,NULL),(6960,'LAB',49,11,24,42,2750,63,0,'4',0,NULL),(6961,'LAB',50,11,10,42,2947,68,0,'4',0,NULL),(6962,'LAB',51,11,8,42,2752,67,0,'4',0,NULL),(6963,'LAB',52,11,8,42,2758,64,0,'4',0,NULL),(6964,'LAB',53,12,7,42,2749,77,0,'4',0,NULL),(6965,'LAB',54,12,5,42,2749,66,0,'4',0,NULL),(6966,'LAB',55,12,25,42,2758,60,0,'4',0,NULL),(6967,'LAB',56,12,28,42,2751,72,0,'4',0,NULL),(6968,'LAB',45,10,7,43,2763,63,0,'4',0,NULL),(6969,'LAB',46,10,5,43,2763,74,0,'4',0,NULL),(6970,'LAB',47,10,43,43,2767,62,0,'4',0,NULL),(6971,'LAB',48,10,47,43,2958,62,0,'4',0,NULL),(6972,'LAB',49,11,29,43,2987,77,0,'4',0,NULL),(6973,'LAB',50,11,45,43,3003,72,0,'4',0,NULL),(6974,'LAB',51,11,25,43,2987,68,0,'4',0,NULL),(6975,'LAB',52,11,9,43,2958,68,0,'4',0,NULL),(6976,'LAB',53,12,11,43,2767,66,0,'4',0,NULL),(6977,'LAB',54,12,5,43,2987,73,0,'4',0,NULL),(6978,'LAB',55,12,5,43,2764,59,0,'4',0,NULL),(6979,'LAB',56,12,9,43,2958,64,0,'4',0,NULL),(6980,'LAB',45,10,11,44,2772,61,0,'4',0,NULL),(6981,'LAB',46,10,8,44,2770,73,0,'4',0,NULL),(6982,'LAB',47,10,24,44,2775,76,0,'4',0,NULL),(6983,'LAB',48,10,5,44,2773,58,0,'4',0,NULL),(6984,'LAB',49,11,27,44,2772,60,0,'4',0,NULL),(6985,'LAB',50,11,44,44,2770,63,0,'4',0,NULL),(6986,'LAB',51,11,29,44,2769,63,0,'4',0,NULL),(6987,'LAB',52,11,11,44,2772,62,0,'4',0,NULL),(6988,'LAB',53,12,29,44,2769,64,0,'4',0,NULL),(6989,'LAB',54,12,7,44,2770,64,0,'4',0,NULL),(6990,'LAB',55,12,9,44,3008,67,0,'4',0,NULL),(6991,'LAB',56,12,6,44,3008,63,0,'4',0,NULL),(6992,'LAB',45,10,28,45,2784,76,0,'4',0,NULL),(6993,'LAB',46,10,42,45,2784,67,0,'4',0,NULL),(6994,'LAB',47,10,48,45,2783,70,0,'4',0,NULL),(6995,'LAB',48,10,7,45,2960,70,0,'4',0,NULL),(6996,'LAB',49,11,6,45,2783,68,0,'4',0,NULL),(6997,'LAB',50,11,48,45,2786,76,0,'4',0,NULL),(6998,'LAB',51,11,8,45,2779,72,0,'4',0,NULL),(6999,'LAB',52,11,27,45,2779,70,0,'4',0,NULL),(7000,'LAB',53,12,12,45,2783,71,0,'4',0,NULL),(7001,'LAB',54,12,43,45,2784,72,0,'4',0,NULL),(7002,'LAB',55,12,26,45,2781,64,0,'4',0,NULL),(7003,'LAB',56,12,29,45,2788,75,0,'4',0,NULL),(7004,'LEC',NULL,16,20,59,2861,15,0,'6',0,NULL),(7005,'LEC',NULL,16,14,59,2861,28,0,'6',0,NULL),(7006,'LEC',NULL,16,32,59,2861,51,0,'6',0,NULL),(7007,'LEC',NULL,17,36,59,2868,27,0,'6',0,NULL),(7008,'LEC',NULL,17,14,59,2868,57,0,'6',0,NULL),(7009,'LEC',NULL,17,38,59,2868,35,0,'6',0,NULL),(7010,'LEC',NULL,18,36,59,2946,16,0,'6',0,NULL),(7011,'LEC',NULL,18,18,59,2946,26,0,'6',0,NULL),(7012,'LEC',NULL,18,39,59,2946,47,0,'6',0,NULL),(7013,'TUT',69,16,42,59,2862,39,0,'6',0,NULL),(7014,'TUT',70,16,43,59,2866,34,0,'6',0,NULL),(7015,'TUT',71,16,45,59,2862,47,0,'6',0,NULL),(7016,'TUT',72,16,23,59,2860,25,0,'6',0,NULL),(7017,'TUT',73,17,41,59,2863,29,0,'6',0,NULL),(7018,'TUT',74,17,30,59,2859,25,0,'6',0,NULL),(7019,'TUT',75,17,30,59,2946,11,0,'6',0,NULL),(7020,'TUT',76,17,39,59,2946,38,0,'6',0,NULL),(7021,'TUT',77,18,34,59,2859,21,0,'6',0,NULL),(7022,'TUT',78,18,26,59,2946,9,0,'6',0,NULL),(7023,'TUT',79,18,32,59,2868,28,0,'6',0,NULL),(7024,'TUT',80,18,46,59,2866,51,0,'6',0,NULL),(7025,'LEC',NULL,16,13,60,2871,16,0,'6',0,NULL),(7026,'LEC',NULL,16,40,60,2871,21,0,'6',0,NULL),(7027,'LEC',NULL,16,37,60,2871,45,0,'6',0,NULL),(7028,'LEC',NULL,17,39,60,2939,26,0,'6',0,NULL),(7029,'LEC',NULL,17,32,60,2939,55,0,'6',0,NULL),(7030,'LEC',NULL,17,30,60,2939,34,0,'6',0,NULL),(7031,'LEC',NULL,18,19,60,2872,17,0,'6',0,NULL),(7032,'LEC',NULL,18,16,60,2872,55,0,'6',0,NULL),(7033,'LEC',NULL,18,37,60,2872,46,0,'6',0,NULL),(7034,'LEC',NULL,16,19,61,2882,22,0,'6',0,NULL),(7035,'LEC',NULL,16,15,61,2882,52,0,'6',0,NULL),(7036,'LEC',NULL,16,40,61,2882,41,0,'6',0,NULL),(7037,'LEC',NULL,17,32,61,2887,21,0,'6',0,NULL),(7038,'LEC',NULL,17,14,61,2887,49,0,'6',0,NULL),(7039,'LEC',NULL,17,20,61,2887,42,0,'6',0,NULL),(7040,'LEC',NULL,18,13,61,2885,15,0,'6',0,NULL),(7041,'LEC',NULL,18,31,61,2885,24,0,'6',0,NULL),(7042,'LEC',NULL,18,15,61,2885,36,0,'6',0,NULL),(7043,'TUT',69,16,14,61,2888,35,0,'6',0,NULL),(7044,'TUT',70,16,13,61,2888,57,0,'6',0,NULL),(7045,'TUT',71,16,34,61,2881,17,0,'6',0,NULL),(7046,'TUT',72,16,29,61,2880,38,0,'6',0,NULL),(7047,'TUT',73,17,9,61,2880,15,0,'6',0,NULL),(7048,'TUT',74,17,47,61,2883,47,0,'6',0,NULL),(7049,'TUT',75,17,21,61,2887,9,0,'6',0,NULL),(7050,'TUT',76,17,34,61,2887,56,0,'6',0,NULL),(7051,'TUT',77,18,47,61,2880,42,0,'6',0,NULL),(7052,'TUT',78,18,7,61,2881,8,0,'6',0,NULL),(7053,'TUT',79,18,15,61,2879,39,0,'6',0,NULL),(7054,'TUT',80,18,37,61,2885,35,0,'6',0,NULL),(7055,'LEC',NULL,16,40,62,2891,49,0,'6',0,NULL),(7056,'LEC',NULL,16,34,62,2891,9,0,'6',0,NULL),(7057,'LEC',NULL,16,16,62,2891,19,0,'6',0,NULL),(7058,'LEC',NULL,17,41,62,2933,32,0,'6',0,NULL),(7059,'LEC',NULL,17,32,62,2933,8,0,'6',0,NULL),(7060,'LEC',NULL,17,33,62,2933,48,0,'6',0,NULL),(7061,'LEC',NULL,18,20,62,3001,37,0,'6',0,NULL),(7062,'LEC',NULL,18,32,62,3001,18,0,'6',0,NULL),(7063,'LEC',NULL,18,40,62,3001,54,0,'6',0,NULL),(7064,'LAB',69,16,9,65,2904,76,0,'6',0,NULL),(7065,'LAB',70,16,25,65,2902,77,0,'6',0,NULL),(7066,'LAB',71,16,10,65,2908,67,0,'6',0,NULL),(7067,'LAB',72,16,10,65,2904,69,0,'6',0,NULL),(7068,'LAB',73,17,28,65,2904,70,0,'6',0,NULL),(7069,'LAB',74,17,27,65,2904,66,0,'6',0,NULL),(7070,'LAB',75,17,12,65,2905,60,0,'6',0,NULL),(7071,'LAB',76,17,11,65,2908,73,0,'6',0,NULL),(7072,'LAB',77,18,42,65,2962,66,0,'6',0,NULL),(7073,'LAB',78,18,29,65,2902,68,0,'6',0,NULL),(7074,'LAB',79,18,29,65,2904,67,0,'6',0,NULL),(7075,'LAB',80,18,11,65,2900,58,0,'6',0,NULL),(7076,'LEC',NULL,22,19,69,2982,14,0,'8',0,NULL),(7077,'LEC',NULL,22,18,69,2982,38,0,'8',0,NULL),(7078,'LEC',NULL,22,18,69,2982,56,0,'8',0,NULL),(7079,'LEC',NULL,23,33,69,2982,26,0,'8',0,NULL),(7080,'LEC',NULL,23,31,69,2982,9,0,'8',0,NULL),(7081,'LEC',NULL,23,16,69,2982,54,0,'8',0,NULL),(7082,'LEC',NULL,24,37,69,2945,41,0,'8',0,NULL),(7083,'LEC',NULL,24,15,69,2945,48,0,'8',0,NULL),(7084,'LEC',NULL,24,17,69,2945,24,0,'8',0,NULL),(7085,'LAB',93,22,11,74,2922,74,0,'8',0,NULL),(7086,'LAB',94,22,42,74,2926,73,0,'8',0,NULL),(7087,'LAB',95,22,26,74,2979,59,0,'8',0,NULL),(7088,'LAB',96,22,10,74,2919,65,0,'8',0,NULL),(7089,'LAB',97,23,27,74,2927,59,0,'8',0,NULL),(7090,'LAB',98,23,27,74,2926,68,0,'8',0,NULL),(7091,'LAB',99,23,8,74,2979,69,0,'8',0,NULL),(7092,'LAB',100,23,47,74,2925,66,0,'8',0,NULL),(7093,'LAB',101,24,5,74,2925,65,0,'8',0,NULL),(7094,'LAB',102,24,28,74,2925,73,0,'8',0,NULL),(7095,'LAB',103,24,25,74,2928,63,0,'8',0,NULL),(7096,'LAB',104,24,43,74,2923,61,0,'8',0,NULL);
/*!40000 ALTER TABLE `scheduled_class_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `number` int DEFAULT NULL,
  `year_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_semester_year` (`year_id`),
  CONSTRAINT `fk_semester_year` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (1,'Semester 1',1,1),(2,'Semester 2',2,1),(3,'Semester 3',3,2),(4,'Semester 4',4,2),(5,'Semester 5',5,3),(6,'Semester 6',6,3),(7,'Semester 7',7,4),(8,'Semester 8',8,4);
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_elective_choice`
--

DROP TABLE IF EXISTS `student_elective_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_elective_choice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chosen_option_id` bigint DEFAULT NULL,
  `parent_elective_id` bigint DEFAULT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkffvtdplu9tuvwdadi1ktnb65` (`parent_elective_id`),
  KEY `fk_sec_group_option` (`chosen_option_id`),
  CONSTRAINT `fk_sec_group_option` FOREIGN KEY (`chosen_option_id`) REFERENCES `elective_group_option` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKkffvtdplu9tuvwdadi1ktnb65` FOREIGN KEY (`parent_elective_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_elective_choice`
--

LOCK TABLES `student_elective_choice` WRITE;
/*!40000 ALTER TABLE `student_elective_choice` DISABLE KEYS */;
INSERT INTO `student_elective_choice` VALUES (1,1,50,122),(2,3,50,87),(3,4,50,59),(4,5,57,122),(5,7,57,87),(6,8,57,59),(7,67,51,138),(8,69,51,104),(9,10,52,92),(10,12,52,76),(11,15,52,55),(12,16,63,148),(13,18,63,72),(14,19,63,44),(15,20,66,148),(16,22,66,72),(17,23,66,44),(18,24,64,105),(19,28,64,81),(20,31,64,69),(21,35,70,157),(22,38,70,62),(23,39,75,157),(24,42,75,62),(25,43,71,101),(26,44,71,89),(27,46,71,74),(28,47,72,98),(29,51,72,77),(30,56,72,65),(31,58,73,133),(32,62,73,54),(33,66,73,48);
/*!40000 ALTER TABLE `student_elective_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `weekly_lab_hours` int DEFAULT NULL,
  `weekly_lecture_hours` int DEFAULT NULL,
  `weekly_tutorial_hours` int DEFAULT NULL,
  `semester_id` bigint DEFAULT NULL,
  `elective` int DEFAULT NULL,
  `elective_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_db5g1rfeug7aywnpb6gab85ep` (`code`),
  KEY `FKmphheehxn35mmxxh67nnexukv` (`semester_id`),
  CONSTRAINT `FKmphheehxn35mmxxh67nnexukv` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (28,'Core','20BSEC301','Calculus and Probability',1,NULL,0,3,1,3,0,NULL),(29,'Core','20EC301','Electronic Circuits and Applications',1,NULL,0,3,1,3,0,NULL),(30,'Core','20EC302','Signals and Systems',1,NULL,0,3,1,3,0,NULL),(31,'Core','20EC303','Data Structures and Algorithms',1,NULL,0,3,0,3,0,NULL),(32,'Core','20HS301','Universal Human Values-II',1,NULL,0,2,1,3,0,NULL),(33,'Core','20EC301L','EC Applications Lab',1,NULL,4,0,0,3,0,NULL),(34,'Core','20EC303L','DSA Lab',1,NULL,2,0,0,3,0,NULL),(36,'Core','20EC401','Digital Electronics',1,NULL,0,3,1,4,0,NULL),(37,'Core','20EC402','Analog and Digital Communication',1,NULL,0,3,1,4,0,NULL),(38,'Core','20EC403','ML with Python',1,NULL,0,3,0,4,0,NULL),(39,'Core','20EC404','Embedded Systems',1,NULL,0,3,0,4,0,NULL),(40,'Core','20EC405','Object Oriented Programming',1,NULL,0,3,0,4,0,NULL),(41,'Core','20EC401L','Digital Electronics Lab',1,NULL,2,0,0,4,0,NULL),(42,'Core','20EC402L','ADC Lab',1,NULL,2,0,0,4,0,NULL),(43,'Core','20EC403L','ML Python Lab',1,NULL,2,0,0,4,0,NULL),(44,'Core','20EC404L','Embedded Systems Lab',1,NULL,4,0,0,4,0,NULL),(45,'Core','20EC405L','OOP Lab',1,NULL,2,0,0,4,0,NULL),(47,'Core','20EC501','Digital Signal Processing',1,NULL,0,3,1,5,0,NULL),(48,'Core','20EC502','VLSI Design',1,NULL,0,3,0,5,0,NULL),(49,'Core','20EC503','Advanced Processors',1,NULL,0,3,0,5,0,NULL),(50,'Core','20PEEC501','Programme Elective-I',1,NULL,0,3,0,5,1,'Program'),(51,'Core','20PEEC502','Programme Elective-II',1,NULL,0,3,0,5,1,'Program'),(52,'Core','20OEHS501','Open Elective-I',1,NULL,0,3,0,5,1,'Open'),(53,'Core','20EC501L','DSP Lab',1,NULL,2,0,0,5,0,NULL),(54,'Core','20EC502L','VLSI Lab',1,NULL,2,0,0,5,0,NULL),(55,'Core','20EC503L','Advanced Processors Lab',1,NULL,4,0,0,5,0,NULL),(56,'Core','20EC504L','Mini Project',1,NULL,2,0,0,5,0,NULL),(57,'Core','20PEEC501L','Programme Elective Lab-I',1,NULL,2,0,0,5,1,'Program'),(59,'Core','20EC601','Wave Theory and Antenna',1,NULL,0,3,1,6,0,NULL),(60,'Core','20EC602','Computer Networks and Security',1,NULL,0,3,0,6,0,NULL),(61,'Core','20EC603','Control Systems',1,NULL,0,3,1,6,0,NULL),(62,'Core','20HS601','Management for Engineers',1,NULL,0,3,0,6,0,NULL),(63,'Core','20PEEC601','Programme Elective-III',1,NULL,0,3,0,6,1,'Program'),(64,'Core','20OE601','Open Elective-II',1,NULL,0,3,0,6,1,'Open'),(65,'Core','20EC602L','CNS Lab',1,NULL,2,0,0,6,0,NULL),(66,'Core','20PEEC601L','PE-III Lab',1,NULL,2,0,0,6,1,'Program'),(67,'Core','20EC701','Internship/Project',1,NULL,30,0,0,7,0,NULL),(68,'Core','20HS701','Economics and Personal Finance',1,NULL,0,2,0,7,0,NULL),(69,'Core','20EC801','Broadband Communication Systems',1,NULL,0,3,0,8,0,NULL),(70,'Core','20PEEC801','Program Elective-IV',1,NULL,0,3,0,8,1,'Program'),(71,'Core','20PEEC802','Program Elective-V',1,NULL,0,3,0,8,1,'Program'),(72,'Core','20OE801','Open Elective-III',1,NULL,0,3,0,8,1,'Open'),(73,'Core','20OE802','Open Elective-IV',1,NULL,0,3,0,8,1,'Open'),(74,'Core','20EC801L','BCS Lab',1,NULL,2,0,0,8,0,NULL),(75,'Core','20PEEC801L','PE-IV Lab',1,NULL,2,0,0,8,1,'Program');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  `max_weekly_load` int DEFAULT NULL,
  `max_hours_per_day` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `department_id` bigint DEFAULT NULL,
  `teacher_code` varchar(255) DEFAULT NULL,
  `max_continuous_hours` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd419q6obhj46eoye136y7rjyq` (`department_id`),
  CONSTRAINT `FKd419q6obhj46eoye136y7rjyq` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (5,'sharada.ohatkar@cumminscollege.in','EMP001',16,5,'Dr. Sharada N. Ohatkar',1,'SNO',4),(6,'prachi.mukherji@cumminscollege.in','EMP002',16,5,'Dr. Prachi Mukherji',1,'PM',4),(7,'sandeep.musale@cumminscollege.in','EMP003',16,5,'Dr. Sandeep S. Musale',1,'SSM',4),(8,'seema.rajput@cumminscollege.in','EMP004',16,5,'Dr. Seema Hemantkumar Rajput',1,'SHR',4),(9,'ashwini.deshpande@cumminscollege.in','EMP005',16,5,'Dr. Ashwini M. Deshpande',1,'AMD',4),(10,'anita.patil@cumminscollege.in','EMP006',16,5,'Dr. Anita S. Patil',1,'ASP',4),(11,'nitin.palan@cumminscollege.in','EMP007',16,5,'Dr. Palan Nitin G.',1,'PNG',4),(12,'megha.borse@cummincollege.in','EMP008',16,5,'Dr. Megha S. Borse',1,'MSB',4),(13,'bageshree.pathak@cumminscollege.in','EMP009',16,5,'Dr. Bageshree V. Pathak',1,'BVP',4),(14,'ashok.khedkar@cumminscollege.in','EMP010',16,5,'Dr. Ashok R. Khedkar',1,'ARK',4),(15,'shubhangi.chaudhary@cumminscollege.in','EMP011',16,5,'Dr. Shubhangi R. Chaudhary',1,'SRC',4),(16,'shashikant.sahare@cummincollege.in','EMP012',16,5,'Mr. Shashikant L. Sahare',1,'SLS',4),(17,'mrudul.dixit@cumminscollege.in','EMP013',16,5,'Dr. Dixit Mrudul Anand',1,'DMA',4),(18,'pallavi1.kamble@cumminscollege.in','EMP014',16,5,'Mrs. Pallavi S. Ghatkamble',1,'PSG',4),(19,'sharad.dube@cumminscollege.in','EMP015',16,5,'Mr. Sharad G. Dube',1,'SGD',4),(20,'narendra.kulkarni@cummincollege.in','EMP016',16,5,'Mr. Narendra D. Kulkarni',1,'NDK',4),(21,'sachin.paranjape@cummincollege.in','EMP017',16,5,'Dr. Sachin Paranjape',1,'SP',4),(22,'mahesh.pote@cumminscollege.in','EMP018',16,5,'Dr. Mahesh K Pote',1,'MKP',4),(23,'manasi.pathade@cumminscollege.in','EMP019',16,5,'Dr. Manasi V. Pathade',1,'MVP',4),(24,'ganesh.padalkar@cumminscollege.in','EMP020',16,5,'Mr. Padalkar Ganesh Ravindra',1,'PGR',4),(25,'milind.patankar@cumminscollege.in','EMP021',16,5,'Mr. Milind S. Patankar',1,'MSP',4),(26,'vidya.sisale@cumminscollege.in','EMP022',16,5,'Mrs. Vidya Sisale',1,'VS',4),(27,'sandhya.potadar@cumminscollege.in','EMP023',16,5,'Mrs. S. A. Potadar',1,'SAP',4),(28,'sagar.vanarase@cumminscollege.in','EMP024',16,5,'Mr. Sagar Sudhakar Vanarase',1,'SSV',4),(29,'kalpana.joshi@cumminscollege.in','EMP025',16,5,'Dr. Kalpana Santosh Joshi',1,'KSJ',4),(30,'rpkali.pawar@cumminscollege.in','EMP026',16,5,'Mrs. Rupali S Pawar',1,'RSP',4),(31,'prachi.waghmare@cumminscollege.in','EMP027',16,5,'Mrs. Prachi Waghmare',1,'PW',4),(32,'ratnaprabha.borhade@cumminscollege.in','EMP028',16,5,'Dr. R.R. Borhade',1,'RB',4),(33,'supriya.mangale@cumminscollege.in','EMP029',16,5,'Dr. Supriya Anil Mangale',1,'SAM',4),(34,'snehal.nichale@cumminscollege.in','EMP030',16,5,'Mrs. Snehal Ghodake Nichale',1,'SGN',4),(35,'snehal.natekar@cumminscollege.in','EMP031',16,5,'Ms. Snehal Natekar',1,'SN',4),(36,'ravikant.suryawanshi@cumminscollege.in','EMP032',16,5,'Mr. Ravikant Suryawanshi',1,'RS',4),(37,'tejashree.pawar@cumminscollege.in','EMP033',16,5,'Mrs. Tejashree Vijay Pawar',1,'TVP',4),(38,'harshala.khedlekar@cumminscollege.in','EMP034',16,5,'Mrs. Harshala Khedlekar',1,'HK',4),(39,'gayatri.r.more@cumminscollege.in','EMP035',16,5,'Ms. More Gayatri Rushi',1,'MGR',4),(40,'pooja.ingole@cumminscollege.in','EMP036',16,5,'Mrs. Pooja Shahu Ingole',1,'PSI',4),(41,'smriti.gupta@cumminscollege.in','EMP037',16,5,'Mrs. Smriti Gupta',1,'SG',4),(42,'ketki.behele@cumminscollege.in','EMP038',16,5,'Ms. Ketaki Dattatray Behele',1,'KDB',4);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_subject`
--

DROP TABLE IF EXISTS `teacher_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_subject` (
  `teacher_id` bigint NOT NULL,
  `subject_id` bigint NOT NULL,
  PRIMARY KEY (`teacher_id`,`subject_id`),
  KEY `FKdnhs9kxdlnrvhq5k111c87pna` (`subject_id`),
  CONSTRAINT `FK625xnjha5rs0qqynxsthk646k` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  CONSTRAINT `FKdnhs9kxdlnrvhq5k111c87pna` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_subject`
--

LOCK TABLES `teacher_subject` WRITE;
/*!40000 ALTER TABLE `teacher_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_subject_allocation`
--

DROP TABLE IF EXISTS `teacher_subject_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_subject_allocation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `priority` int DEFAULT NULL,
  `subject_id` bigint DEFAULT NULL,
  `teacher_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_teacher_subject` (`teacher_id`,`subject_id`),
  KEY `fk_tsa_subject` (`subject_id`),
  CONSTRAINT `fk_tsa_subject` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKgs1mdpnfcv0e9ulr1l6ic2hf` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`),
  CONSTRAINT `FKnnjfr50xi3muowmpwp7clli3n` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_subject_allocation`
--

LOCK TABLES `teacher_subject_allocation` WRITE;
/*!40000 ALTER TABLE `teacher_subject_allocation` DISABLE KEYS */;
INSERT INTO `teacher_subject_allocation` VALUES (2619,1,28,17),(2620,2,28,24),(2621,3,28,23),(2622,4,28,26),(2623,5,28,5),(2624,6,28,31),(2625,7,28,38),(2626,8,28,13),(2628,10,28,12),(2629,1,29,10),(2630,2,29,11),(2631,3,29,18),(2632,4,29,19),(2633,5,29,36),(2634,6,29,42),(2635,7,29,25),(2636,8,29,22),(2638,10,29,7),(2639,1,30,30),(2640,2,30,9),(2641,3,30,13),(2642,4,30,16),(2643,5,30,29),(2644,6,30,35),(2645,7,30,39),(2646,8,30,32),(2647,9,30,14),(2649,1,31,21),(2650,2,31,17),(2651,3,31,20),(2652,4,31,24),(2653,5,31,38),(2654,6,31,41),(2656,8,31,23),(2658,10,31,6),(2659,1,32,5),(2660,2,32,6),(2661,3,32,7),(2664,6,32,14),(2665,7,32,17),(2667,9,32,29),(2669,1,33,10),(2670,2,33,11),(2671,3,33,18),(2673,5,33,36),(2674,6,33,42),(2675,7,33,25),(2676,8,33,22),(2678,10,33,7),(2679,1,34,21),(2680,2,34,17),(2681,3,34,20),(2682,4,34,24),(2683,5,34,38),(2684,6,34,41),(2686,8,34,23),(2688,10,34,6),(2689,1,36,8),(2691,3,36,28),(2692,4,36,36),(2694,6,36,20),(2697,9,36,10),(2698,10,36,40),(2699,1,37,30),(2700,2,37,31),(2701,3,37,32),(2702,4,37,14),(2703,5,37,15),(2705,7,37,40),(2706,8,37,13),(2707,9,37,9),(2708,10,37,33),(2711,3,38,9),(2712,4,38,24),(2713,5,38,23),(2714,6,38,41),(2716,8,38,13),(2717,9,38,5),(2719,1,39,11),(2720,2,39,18),(2721,3,39,19),(2722,4,39,22),(2723,5,39,36),(2725,7,39,42),(2727,9,39,25),(2728,10,39,16),(2729,1,40,21),(2730,2,40,17),(2731,3,40,38),(2732,4,40,24),(2733,5,40,23),(2734,6,40,41),(2736,8,40,20),(2738,10,40,6),(2739,1,41,8),(2741,3,41,28),(2742,4,41,36),(2744,6,41,20),(2747,9,41,10),(2748,10,41,40),(2749,1,42,30),(2750,2,42,31),(2751,3,42,32),(2752,4,42,14),(2753,5,42,15),(2756,8,42,13),(2757,9,42,9),(2758,10,42,33),(2761,3,43,9),(2762,4,43,24),(2763,5,43,23),(2764,6,43,41),(2766,8,43,13),(2767,9,43,5),(2769,1,44,11),(2770,2,44,18),(2771,3,44,19),(2772,4,44,22),(2773,5,44,36),(2775,7,44,42),(2777,9,44,25),(2778,10,44,16),(2779,1,45,21),(2780,2,45,17),(2781,3,45,38),(2782,4,45,24),(2783,5,45,23),(2784,6,45,41),(2785,7,45,28),(2786,8,45,20),(2788,10,45,6),(2789,1,47,16),(2790,2,47,29),(2791,3,47,9),(2793,5,47,11),(2794,6,47,35),(2795,7,47,39),(2796,8,47,30),(2797,9,47,32),(2798,10,47,33),(2799,1,48,8),(2801,3,48,28),(2802,4,48,36),(2803,5,48,18),(2806,8,48,10),(2807,9,48,40),(2808,10,48,7),(2809,1,49,11),(2810,2,49,18),(2811,3,49,19),(2812,4,49,22),(2813,5,49,36),(2815,7,49,10),(2816,8,49,25),(2817,9,49,42),(2818,10,49,16),(2819,1,53,16),(2820,2,53,29),(2821,3,53,9),(2823,5,53,11),(2824,6,53,35),(2825,7,53,39),(2826,8,53,30),(2827,9,53,32),(2828,10,53,33),(2829,1,54,8),(2831,3,54,28),(2833,5,54,18),(2836,8,54,10),(2837,9,54,40),(2838,10,54,7),(2839,1,55,11),(2840,2,55,18),(2841,3,55,19),(2842,4,55,22),(2843,5,55,36),(2845,7,55,10),(2846,8,55,25),(2847,9,55,42),(2848,10,55,16),(2852,4,56,24),(2853,5,56,23),(2854,6,56,11),(2857,9,56,36),(2858,10,56,28),(2859,1,59,14),(2860,2,59,22),(2861,3,59,13),(2862,4,59,32),(2863,5,59,25),(2864,6,59,15),(2865,7,59,31),(2866,8,59,30),(2868,10,59,33),(2869,1,60,21),(2870,2,60,20),(2871,3,60,17),(2872,4,60,28),(2873,5,60,19),(2874,6,60,27),(2878,10,60,6),(2879,1,61,10),(2880,2,61,11),(2881,3,61,18),(2882,4,61,19),(2883,5,61,22),(2884,6,61,36),(2885,7,61,25),(2887,9,61,42),(2888,10,61,16),(2889,1,62,5),(2890,2,62,6),(2891,3,62,7),(2892,4,62,14),(2897,9,62,29),(2898,10,62,33),(2899,1,65,21),(2900,2,65,20),(2901,3,65,17),(2902,4,65,28),(2903,5,65,19),(2904,6,65,27),(2905,7,65,40),(2908,10,65,6),(2909,1,69,14),(2910,2,69,15),(2911,3,69,31),(2912,4,69,32),(2913,5,69,30),(2915,7,69,40),(2916,8,69,13),(2918,10,69,33),(2919,1,74,14),(2920,2,74,15),(2921,3,74,31),(2922,4,74,32),(2923,5,74,30),(2925,7,74,40),(2926,8,74,13),(2927,9,74,9),(2928,10,74,33),(2929,2,36,26),(2930,2,41,26),(2931,2,48,26),(2932,2,54,26),(2933,2,62,39),(2934,2,36,12),(2935,2,41,12),(2936,2,33,12),(2937,2,48,12),(2938,2,54,12),(2939,2,60,12),(2940,2,65,12),(2941,2,36,29),(2942,2,41,29),(2943,2,32,39),(2944,2,56,39),(2945,2,69,29),(2946,2,59,8),(2947,2,42,8),(2948,2,60,8),(2949,2,56,8),(2950,2,31,35),(2951,2,34,35),(2952,2,40,35),(2953,2,31,37),(2954,2,34,37),(2957,2,38,37),(2958,2,43,37),(2959,2,40,37),(2960,2,45,37),(2961,2,60,37),(2962,2,65,37),(2965,2,29,34),(2966,2,33,34),(2967,2,39,34),(2968,2,44,34),(2969,2,49,34),(2970,2,55,34),(2971,2,61,34),(2979,2,74,34),(2980,2,37,26),(2981,2,42,26),(2982,2,69,26),(2983,2,56,38),(2984,2,36,38),(2985,2,41,38),(2986,2,54,42),(2987,2,43,21),(2988,2,38,21),(2990,2,62,15),(2991,2,32,15),(2992,2,56,7),(2993,2,28,27),(2994,2,32,27),(2995,2,30,27),(2996,2,38,27),(2997,2,43,27),(2998,2,48,5),(2999,2,54,5),(3000,2,32,35),(3001,2,62,35),(3002,2,38,39),(3003,2,43,39),(3004,2,47,41),(3005,2,53,41),(3006,2,56,31),(3007,2,62,31),(3008,2,44,7),(3009,2,39,27);
/*!40000 ALTER TABLE `teacher_subject_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_slot`
--

DROP TABLE IF EXISTS `time_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_slot` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `day_of_week` int DEFAULT NULL,
  `end_time` time(6) DEFAULT NULL,
  `slot_number` int DEFAULT NULL,
  `start_time` time(6) DEFAULT NULL,
  `lunch` tinyint(1) DEFAULT '0',
  `short_break` tinyint(1) DEFAULT '0',
  `slot_type` enum('LEC','LAB','FOOD_BREAK') DEFAULT NULL,
  `duration` int NOT NULL DEFAULT '1',
  `block_code` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_slot`
--

LOCK TABLES `time_slot` WRITE;
/*!40000 ALTER TABLE `time_slot` DISABLE KEYS */;
INSERT INTO `time_slot` VALUES (8,1,'09:00:00.000000',1,'08:00:00.000000',0,0,'LEC',1,'MON_L1'),(9,1,'10:00:00.000000',2,'09:00:00.000000',0,0,'LEC',1,'MON_L2'),(10,1,'10:15:00.000000',3,'10:00:00.000000',0,1,'FOOD_BREAK',1,'BREAK'),(11,1,'11:15:00.000000',4,'10:15:00.000000',0,0,'LEC',1,'MON_L3'),(12,1,'12:15:00.000000',5,'11:15:00.000000',0,0,'LEC',1,'MON_L4'),(13,1,'13:15:00.000000',6,'12:15:00.000000',1,0,'FOOD_BREAK',1,'BREAK'),(14,1,'14:15:00.000000',7,'13:15:00.000000',0,0,'LEC',1,'MON_L5'),(15,1,'15:15:00.000000',8,'14:15:00.000000',0,0,'LEC',1,'MON_L6'),(16,1,'16:15:00.000000',9,'15:15:00.000000',0,0,'LEC',1,'MON_L7'),(17,1,'17:15:00.000000',10,'16:15:00.000000',0,0,'LEC',1,'MON_L8'),(18,2,'09:00:00.000000',1,'08:00:00.000000',0,0,'LEC',1,'TUE_L1'),(19,2,'10:00:00.000000',2,'09:00:00.000000',0,0,'LEC',1,'TUE_L2'),(20,2,'10:15:00.000000',3,'10:00:00.000000',0,1,'FOOD_BREAK',1,'BREAK'),(21,2,'11:15:00.000000',4,'10:15:00.000000',0,0,'LEC',1,'TUE_L3'),(22,2,'12:15:00.000000',5,'11:15:00.000000',0,0,'LEC',1,'TUE_L4'),(23,2,'13:15:00.000000',6,'12:15:00.000000',1,0,'FOOD_BREAK',1,'BREAK'),(24,2,'14:15:00.000000',7,'13:15:00.000000',0,0,'LEC',1,'TUE_L5'),(25,2,'15:15:00.000000',8,'14:15:00.000000',0,0,'LEC',1,'TUE_L6'),(26,2,'16:15:00.000000',9,'15:15:00.000000',0,0,'LEC',1,'TUE_L7'),(27,2,'17:15:00.000000',10,'16:15:00.000000',0,0,'LEC',1,'TUE_L8'),(28,3,'09:00:00.000000',1,'08:00:00.000000',0,0,'LEC',1,'WED_L1'),(29,3,'10:00:00.000000',2,'09:00:00.000000',0,0,'LEC',1,'WED_L2'),(30,3,'10:15:00.000000',3,'10:00:00.000000',0,1,'FOOD_BREAK',1,'BREAK'),(31,3,'11:15:00.000000',4,'10:15:00.000000',0,0,'LEC',1,'WED_L3'),(32,3,'12:15:00.000000',5,'11:15:00.000000',0,0,'LEC',1,'WED_L4'),(33,3,'13:15:00.000000',6,'12:15:00.000000',1,0,'FOOD_BREAK',1,'BREAK'),(34,3,'14:15:00.000000',7,'13:15:00.000000',0,0,'LEC',1,'WED_L5'),(35,3,'15:15:00.000000',8,'14:15:00.000000',0,0,'LEC',1,'WED_L6'),(36,3,'16:15:00.000000',9,'15:15:00.000000',0,0,'LEC',1,'WED_L7'),(37,3,'17:15:00.000000',10,'16:15:00.000000',0,0,'LEC',1,'WED_L8'),(38,4,'09:00:00.000000',1,'08:00:00.000000',0,0,'LEC',1,'THU_L1'),(39,4,'10:00:00.000000',2,'09:00:00.000000',0,0,'LEC',1,'THU_L2'),(40,4,'10:15:00.000000',3,'10:00:00.000000',0,1,'FOOD_BREAK',1,'BREAK'),(41,4,'11:15:00.000000',4,'10:15:00.000000',0,0,'LEC',1,'THU_L3'),(42,4,'12:15:00.000000',5,'11:15:00.000000',0,0,'LEC',1,'THU_L4'),(43,4,'13:15:00.000000',6,'12:15:00.000000',1,0,'FOOD_BREAK',1,'BREAK'),(44,4,'14:15:00.000000',7,'13:15:00.000000',0,0,'LEC',1,'THU_L5'),(45,4,'15:15:00.000000',8,'14:15:00.000000',0,0,'LEC',1,'THU_L6'),(46,4,'16:15:00.000000',9,'15:15:00.000000',0,0,'LEC',1,'THU_L7'),(47,4,'17:15:00.000000',10,'16:15:00.000000',0,0,'LEC',1,'THU_L8'),(48,5,'09:00:00.000000',1,'08:00:00.000000',0,0,'LEC',1,'FRI_L1'),(49,5,'10:00:00.000000',2,'09:00:00.000000',0,0,'LEC',1,'FRI_L2'),(50,5,'10:15:00.000000',3,'10:00:00.000000',0,1,'FOOD_BREAK',1,'BREAK'),(51,5,'11:15:00.000000',4,'10:15:00.000000',0,0,'LEC',1,'FRI_L3'),(52,5,'12:15:00.000000',5,'11:15:00.000000',0,0,'LEC',1,'FRI_L4'),(53,5,'13:15:00.000000',6,'12:15:00.000000',1,0,'FOOD_BREAK',1,'BREAK'),(54,5,'14:15:00.000000',7,'13:15:00.000000',0,0,'LEC',1,'FRI_L5'),(55,5,'15:15:00.000000',8,'14:15:00.000000',0,0,'LEC',1,'FRI_L6'),(56,5,'16:15:00.000000',9,'15:15:00.000000',0,0,'LEC',1,'FRI_L7'),(57,5,'17:15:00.000000',10,'16:15:00.000000',0,0,'LEC',1,'FRI_L8'),(58,1,'10:00:00.000000',101,'08:00:00.000000',0,0,'LAB',2,'MON_LAB1'),(59,1,'12:15:00.000000',102,'10:15:00.000000',0,0,'LAB',2,'MON_LAB2'),(60,1,'15:15:00.000000',103,'13:15:00.000000',0,0,'LAB',2,'MON_LAB3'),(61,1,'17:15:00.000000',104,'15:15:00.000000',0,0,'LAB',2,'MON_LAB4'),(62,2,'10:00:00.000000',201,'08:00:00.000000',0,0,'LAB',2,'TUE_LAB1'),(63,2,'12:15:00.000000',202,'10:15:00.000000',0,0,'LAB',2,'TUE_LAB2'),(64,2,'15:15:00.000000',203,'13:15:00.000000',0,0,'LAB',2,'TUE_LAB3'),(65,2,'17:15:00.000000',204,'15:15:00.000000',0,0,'LAB',2,'TUE_LAB4'),(66,3,'10:00:00.000000',301,'08:00:00.000000',0,0,'LAB',2,'WED_LAB1'),(67,3,'12:15:00.000000',302,'10:15:00.000000',0,0,'LAB',2,'WED_LAB2'),(68,3,'15:15:00.000000',303,'13:15:00.000000',0,0,'LAB',2,'WED_LAB3'),(69,3,'17:15:00.000000',304,'15:15:00.000000',0,0,'LAB',2,'WED_LAB4'),(70,4,'10:00:00.000000',401,'08:00:00.000000',0,0,'LAB',2,'THU_LAB1'),(71,4,'12:15:00.000000',402,'10:15:00.000000',0,0,'LAB',2,'THU_LAB2'),(72,4,'15:15:00.000000',403,'13:15:00.000000',0,0,'LAB',2,'THU_LAB3'),(73,4,'17:15:00.000000',404,'15:15:00.000000',0,0,'LAB',2,'THU_LAB4'),(74,5,'10:00:00.000000',501,'08:00:00.000000',0,0,'LAB',2,'FRI_LAB1'),(75,5,'12:15:00.000000',502,'10:15:00.000000',0,0,'LAB',2,'FRI_LAB2'),(76,5,'15:15:00.000000',503,'13:15:00.000000',0,0,'LAB',2,'FRI_LAB3'),(77,5,'17:15:00.000000',504,'15:15:00.000000',0,0,'LAB',2,'FRI_LAB4');
/*!40000 ALTER TABLE `time_slot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `year`
--

DROP TABLE IF EXISTS `year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `year` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `year`
--

LOCK TABLES `year` WRITE;
/*!40000 ALTER TABLE `year` DISABLE KEYS */;
INSERT INTO `year` VALUES (1,'FIRST YEAR'),(2,'SECOND YEAR'),(3,'THIRD YEAR'),(4,'FINAL YEAR');
/*!40000 ALTER TABLE `year` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-25 21:23:53
