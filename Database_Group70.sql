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
INSERT INTO `accounts` VALUES ('admin','admin','adminName','admin@email.com','admin','123-456-7890','1995-01-01','chase',1,1),('custrep','custrep','custrepName','custrep@email.com','custrep','098-765-4321','1995-01-01','chase',1,0);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `Alert_ID` varchar(45) NOT NULL,
  `Auction_ID` varchar(45) NOT NULL,
  `Acc_ID` varchar(45) NOT NULL,
  `Message` varchar(300) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`Acc_ID`,`Alert_ID`),
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
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_part`
--

LOCK TABLES `pc_part` WRITE;
/*!40000 ALTER TABLE `pc_part` DISABLE KEYS */;
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

-- Dump completed on 2021-04-25 20:55:51
