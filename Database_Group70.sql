CREATE DATABASE  IF NOT EXISTS `Database_Group70` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `Database_Group70`;
-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: database_group70
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `Acc_ID` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Address` varchar(45) NOT NULL,
  `Phone` varchar(45) NOT NULL,
  `DOB` date NOT NULL,
  `Payments` varchar(45) NOT NULL,
  `isEmployee` tinyint NOT NULL DEFAULT '0',
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`Acc_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('admin','admin','adminName','admin@email.com','123admin','123-456-7890','1111-01-01','chase',1,1),('custRep1','custRep','custRepName','custRep@email.com','456custRep','098-765-4321','2222-02-02','chase',1,0);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `Acc_ID` varchar(45) NOT NULL,
  `Message` varchar(300) NOT NULL,
  PRIMARY KEY (`Acc_ID`,`Message`),
  CONSTRAINT `Acc_ID5` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `Auction_ID` varchar(45) NOT NULL,
  `Current_price` float DEFAULT NULL,
  `Min_price` float DEFAULT NULL,
  `End_date` datetime DEFAULT NULL,
  `Winner` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Auction_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES ('43844747-c53b-4f09-851d-443e25006220',200,40,'2021-04-25 11:11:11',NULL),('6c35c3d0-7625-426b-88f6-56749714827f',0,33,'3333-03-03 03:03:03',NULL),('867cdf65-ad63-4f0a-85b3-d366279cb6d8',NULL,1,'1111-11-11 11:11:11',NULL),('d8083222-a1c4-4bc3-9838-03cd35f8f169',222,222,'2222-12-22 00:00:00',NULL),('e0a29e4e-776f-43c4-bddb-1a985849dc59',0,123,'1111-11-11 11:11:11',NULL);
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid_on`
--

DROP TABLE IF EXISTS `bid_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid_on` (
  `Auction_ID` varchar(45) NOT NULL,
  `Bid_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Auction_ID`,`Bid_ID`),
  KEY `Bid_ID3` (`Bid_ID`),
  CONSTRAINT `Auction_ID3` FOREIGN KEY (`Auction_ID`) REFERENCES `auction` (`Auction_ID`) ON UPDATE CASCADE,
  CONSTRAINT `Bid_ID3` FOREIGN KEY (`Bid_ID`) REFERENCES `bids` (`Bid_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid_on`
--

LOCK TABLES `bid_on` WRITE;
/*!40000 ALTER TABLE `bid_on` DISABLE KEYS */;
INSERT INTO `bid_on` VALUES ('43844747-c53b-4f09-851d-443e25006220','839ef072-829a-42a1-bfea-69f72e35447a');
/*!40000 ALTER TABLE `bid_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids` (
  `Bid_ID` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Bid_amount` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Date` datetime NOT NULL,
  PRIMARY KEY (`Bid_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
INSERT INTO `bids` VALUES ('839ef072-829a-42a1-bfea-69f72e35447a','200.0','2021-04-25 00:00:24');
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cpu`
--

DROP TABLE IF EXISTS `cpu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cpu` (
  `Item_ID` varchar(45) NOT NULL,
  `Core_count` int NOT NULL,
  `Core_clock` int NOT NULL,
  `Series` varchar(45) NOT NULL,
  PRIMARY KEY (`Item_ID`),
  CONSTRAINT `Item_ID4` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cpu`
--

LOCK TABLES `cpu` WRITE;
/*!40000 ALTER TABLE `cpu` DISABLE KEYS */;
INSERT INTO `cpu` VALUES ('b5160e7d-59ac-411b-a9c9-9fbb30d6ba61',123,123,'123'),('d59e7776-b91f-41f2-b0e8-c9407021f8c6',2,2,'2000');
/*!40000 ALTER TABLE `cpu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generates`
--

DROP TABLE IF EXISTS `generates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generates` (
  `Item_ID` int NOT NULL,
  `Acc_ID` varchar(45) NOT NULL,
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  `Date` datetime NOT NULL,
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`Item_ID`,`Acc_ID`),
  KEY `Acc_ID4_idx` (`Acc_ID`),
  CONSTRAINT `Acc_ID4` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generates`
--

LOCK TABLES `generates` WRITE;
/*!40000 ALTER TABLE `generates` DISABLE KEYS */;
/*!40000 ALTER TABLE `generates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `has_item`
--

DROP TABLE IF EXISTS `has_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_item` (
  `Auction_ID` varchar(45) NOT NULL,
  `Item_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Auction_ID`,`Item_ID`),
  KEY `Item_ID_idx` (`Item_ID`),
  CONSTRAINT `Auction_ID` FOREIGN KEY (`Auction_ID`) REFERENCES `auction` (`Auction_ID`) ON UPDATE CASCADE,
  CONSTRAINT `Item_ID` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has_item`
--

LOCK TABLES `has_item` WRITE;
/*!40000 ALTER TABLE `has_item` DISABLE KEYS */;
INSERT INTO `has_item` VALUES ('6c35c3d0-7625-426b-88f6-56749714827f','10d622d2-4b45-402d-9c5c-47b59127b129'),('e0a29e4e-776f-43c4-bddb-1a985849dc59','495b9edd-b869-467a-a8ec-9b91fe256078'),('867cdf65-ad63-4f0a-85b3-d366279cb6d8','7755f3a4-2b35-410d-920f-920ddc26f069'),('43844747-c53b-4f09-851d-443e25006220','b5160e7d-59ac-411b-a9c9-9fbb30d6ba61'),('d8083222-a1c4-4bc3-9838-03cd35f8f169','d59e7776-b91f-41f2-b0e8-c9407021f8c6');
/*!40000 ALTER TABLE `has_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interested_item`
--

DROP TABLE IF EXISTS `interested_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interested_item` (
  `Acc_ID` varchar(45) NOT NULL,
  `Item_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Acc_ID`,`Item_ID`),
  KEY `Item_ID_idx` (`Item_ID`),
  CONSTRAINT `Acc_ID3` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`) ON UPDATE CASCADE,
  CONSTRAINT `Item_ID3` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interested_item`
--

LOCK TABLES `interested_item` WRITE;
/*!40000 ALTER TABLE `interested_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `interested_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `makes_bid`
--

DROP TABLE IF EXISTS `makes_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `makes_bid` (
  `Acc_ID` varchar(45) NOT NULL,
  `Bid_ID` varchar(45) NOT NULL,
  `Increment` float DEFAULT NULL,
  `Upper_limit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Acc_ID`,`Bid_ID`),
  KEY `Bid_ID_idx` (`Bid_ID`),
  CONSTRAINT `Acc_ID` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`) ON UPDATE CASCADE,
  CONSTRAINT `Bid_ID` FOREIGN KEY (`Bid_ID`) REFERENCES `bids` (`Bid_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `makes_bid`
--

LOCK TABLES `makes_bid` WRITE;
/*!40000 ALTER TABLE `makes_bid` DISABLE KEYS */;
INSERT INTO `makes_bid` VALUES ('admin','839ef072-829a-42a1-bfea-69f72e35447a',NULL,NULL);
/*!40000 ALTER TABLE `makes_bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_part`
--

DROP TABLE IF EXISTS `pc_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pc_part` (
  `Item_ID` varchar(45) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Condition` varchar(45) NOT NULL,
  PRIMARY KEY (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_part`
--

LOCK TABLES `pc_part` WRITE;
/*!40000 ALTER TABLE `pc_part` DISABLE KEYS */;
INSERT INTO `pc_part` VALUES ('10d622d2-4b45-402d-9c5c-47b59127b129','broken','used'),('495b9edd-b869-467a-a8ec-9b91fe256078','Test','used'),('7755f3a4-2b35-410d-920f-920ddc26f069','test','used'),('b5160e7d-59ac-411b-a9c9-9fbb30d6ba61','repAuc','new'),('d59e7776-b91f-41f2-b0e8-c9407021f8c6','test2','new'),('item1','ram1','wow'),('item2','ram2','wow'),('item3','ram3','wow');
/*!40000 ALTER TABLE `pc_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `Auction_ID` varchar(45) NOT NULL,
  `Acc_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Auction_ID`,`Acc_ID`),
  KEY `Acc_ID_idx` (`Acc_ID`),
  CONSTRAINT `Acc_ID2` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`) ON UPDATE CASCADE,
  CONSTRAINT `Auction_ID2` FOREIGN KEY (`Auction_ID`) REFERENCES `auction` (`Auction_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES ('6c35c3d0-7625-426b-88f6-56749714827f','admin'),('867cdf65-ad63-4f0a-85b3-d366279cb6d8','admin'),('d8083222-a1c4-4bc3-9838-03cd35f8f169','admin'),('e0a29e4e-776f-43c4-bddb-1a985849dc59','admin'),('43844747-c53b-4f09-851d-443e25006220','custRep1');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `psu`
--

DROP TABLE IF EXISTS `psu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `psu` (
  `Item_ID` varchar(45) NOT NULL,
  `Wattage` int NOT NULL,
  `Modularity` varchar(45) NOT NULL,
  `Efficiency_rating` int NOT NULL,
  PRIMARY KEY (`Item_ID`),
  CONSTRAINT `Item_ID6` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `psu`
--

LOCK TABLES `psu` WRITE;
/*!40000 ALTER TABLE `psu` DISABLE KEYS */;
INSERT INTO `psu` VALUES ('10d622d2-4b45-402d-9c5c-47b59127b129',3,'3',3),('495b9edd-b869-467a-a8ec-9b91fe256078',1000,'123',123);
/*!40000 ALTER TABLE `psu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `EndUser_Acc_ID` varchar(45) NOT NULL,
  `CustomerRep_Acc_ID` varchar(45) NOT NULL,
  `Question` varchar(45) NOT NULL,
  `Answer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`EndUser_Acc_ID`,`CustomerRep_Acc_ID`),
  KEY `CustomerRep_Acc_ID_idx` (`CustomerRep_Acc_ID`),
  CONSTRAINT `CustomerRep_Acc_ID` FOREIGN KEY (`CustomerRep_Acc_ID`) REFERENCES `accounts` (`Acc_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `EndUser_Acc_ID` FOREIGN KEY (`EndUser_Acc_ID`) REFERENCES `accounts` (`Acc_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ram`
--

DROP TABLE IF EXISTS `ram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ram` (
  `Item_ID` varchar(45) NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Size` int NOT NULL,
  `Speed` int NOT NULL,
  PRIMARY KEY (`Item_ID`),
  CONSTRAINT `Item_ID5` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ram`
--

LOCK TABLES `ram` WRITE;
/*!40000 ALTER TABLE `ram` DISABLE KEYS */;
INSERT INTO `ram` VALUES ('7755f3a4-2b35-410d-920f-920ddc26f069','ram1',1,1),('item1','type',1,1),('item2','type',2,2),('item3','type',3,3);
/*!40000 ALTER TABLE `ram` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'database_group70'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-25  0:09:11