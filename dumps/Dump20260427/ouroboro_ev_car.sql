CREATE DATABASE  IF NOT EXISTS `ouroboro_ev` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ouroboro_ev`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ouroboro_ev
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '49eb0c01-0303-11f1-a6e2-00155d1a2d88:1-121';

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES ('C1',12,'Tesla','Automatic','Sedan',95.00,5,'Autopilot',2023,'Model 3',3,'Available'),('C10',21,'BMW','Automatic','Sedan',130.00,5,'Luxury Package',2023,'i4',3,'Available'),('C11',22,'Audi','Automatic','SUV',140.00,5,'Premium Audio',2023,'e-tron',5,'Available'),('C13',24,'Rivian','Automatic','SUV',80.00,5,'haptic controls, Dual glove boxes',2026,'RS2',5,'Available'),('C2',13,'Tesla','Automatic','SUV',120.00,7,'Autopilot',2022,'Model X',5,'Available'),('C3',14,'Nissan','Automatic','Hatchback',60.00,5,'Bluetooth',2021,'Leaf',3,'Unavailable'),('C4',15,'Chevrolet','Automatic','SUV',70.00,5,'GPS',2022,'Bolt EUV',4,'Available'),('C5',16,'Ford','Automatic','SUV',110.00,5,'Navigation',2023,'Mustang Mach-E',4,'Available'),('C6',17,'Hyundai','Automatic','SUV',85.00,5,'Heated Seats',2023,'Ioniq 5',4,'Unavailable'),('C7',18,'Kia','Automatic','SUV',90.00,5,'Sunroof',2023,'EV6',4,'Available'),('C8',19,'Volkswagen','Automatic','SUV',75.00,5,'Touchscreen',2022,'ID.4',4,'Available'),('C9',20,'Polestar','Automatic','Sedan',100.00,5,'Pilot Assist',2023,'Polestar 2',3,'Unavailable');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-27 15:46:54
