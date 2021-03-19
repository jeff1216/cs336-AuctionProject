-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: auctiondatabase
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
  `Acc_ID` int NOT NULL,
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
INSERT INTO `accounts` VALUES (0,'admin','admin','admin@email.com','123admin','1234567890','1111-01-01','chase',1,1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `Acc_ID` int NOT NULL,
  `Item_ID` int NOT NULL,
  PRIMARY KEY (`Acc_ID`,`Item_ID`),
  KEY `Item_ID_idx` (`Item_ID`),
  CONSTRAINT `Acc_ID2` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`),
  CONSTRAINT `Item_ID2` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `Acc_ID` int NOT NULL,
  `Item_ID` int NOT NULL,
  `Bid_price` varchar(45) NOT NULL,
  PRIMARY KEY (`Acc_ID`,`Item_ID`),
  KEY `Item_ID_idx` (`Item_ID`),
  CONSTRAINT `Acc_ID` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`),
  CONSTRAINT `Item_ID` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cpu`
--

DROP TABLE IF EXISTS `cpu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cpu` (
  `Item_ID` int NOT NULL,
  `Core_count` int NOT NULL,
  `Core_clock` int NOT NULL,
  `Series` varchar(45) NOT NULL,
  PRIMARY KEY (`Item_ID`)
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
  `Acc_ID` int NOT NULL,
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  `Date` date NOT NULL,
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`Item_ID`,`Acc_ID`),
  KEY `Acc_ID4_idx` (`Acc_ID`),
  CONSTRAINT `Acc_ID4` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`),
  CONSTRAINT `Item_ID4` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`)
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
-- Table structure for table `listing`
--

DROP TABLE IF EXISTS `listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing` (
  `Acc_ID` int NOT NULL,
  `Item_ID` int NOT NULL,
  `Max_price` int DEFAULT NULL,
  `Start_price` int NOT NULL,
  `End_date` date NOT NULL,
  PRIMARY KEY (`Acc_ID`,`Item_ID`),
  KEY `Item_ID3_idx` (`Item_ID`),
  CONSTRAINT `Acc_ID3` FOREIGN KEY (`Acc_ID`) REFERENCES `accounts` (`Acc_ID`),
  CONSTRAINT `Item_ID3` FOREIGN KEY (`Item_ID`) REFERENCES `pc_part` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing`
--

LOCK TABLES `listing` WRITE;
/*!40000 ALTER TABLE `listing` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_part`
--

DROP TABLE IF EXISTS `pc_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pc_part` (
  `Item_ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Manufacturer` varchar(45) NOT NULL,
  `Market_price` varchar(45) NOT NULL,
  `Sold_quantity` int NOT NULL DEFAULT '0',
  `Sold_price` int NOT NULL DEFAULT '0',
  `Buyer` varchar(45) DEFAULT NULL,
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
-- Table structure for table `power_supply`
--

DROP TABLE IF EXISTS `power_supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `power_supply` (
  `Item_ID` int NOT NULL,
  `Wattage` int NOT NULL,
  `Modularity` varchar(45) NOT NULL,
  `Efficiency_rating` int NOT NULL,
  PRIMARY KEY (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `power_supply`
--

LOCK TABLES `power_supply` WRITE;
/*!40000 ALTER TABLE `power_supply` DISABLE KEYS */;
/*!40000 ALTER TABLE `power_supply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `EndUser_Acc_ID` int NOT NULL,
  `CustomerRep_Acc_ID` int NOT NULL,
  `Question` varchar(45) NOT NULL,
  `Answer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`EndUser_Acc_ID`,`CustomerRep_Acc_ID`),
  KEY `CustomerRep_Acc_ID_idx` (`CustomerRep_Acc_ID`),
  CONSTRAINT `CustomerRep_Acc_ID` FOREIGN KEY (`CustomerRep_Acc_ID`) REFERENCES `accounts` (`Acc_ID`),
  CONSTRAINT `EndUser_Acc_ID` FOREIGN KEY (`EndUser_Acc_ID`) REFERENCES `accounts` (`Acc_ID`)
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
  `Item_ID` int NOT NULL,
  `Type` varchar(45) NOT NULL,
  `Size` int NOT NULL,
  `Speed` int NOT NULL,
  PRIMARY KEY (`Item_ID`)
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
-- Dumping events for database 'auctiondatabase'
--

--
-- Dumping routines for database 'auctiondatabase'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-19 18:07:49
