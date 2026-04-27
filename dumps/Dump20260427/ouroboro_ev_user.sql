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
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'pass123','john_doe','5551234567','john@email.com','D1234567','2027-06-15'),(2,'mypassword','sarah_k','5559876543','sarah@email.com','S9876543','2028-09-20'),(3,'securepass','alex_t','5552223344','alex@email.com','A5678123','2026-03-10'),(4,'password1','maria_l','5554448899','maria@email.com','M2233445','2029-11-05'),(5,'adminpass','admin_user','5550001111','admin@email.com','ADMIN001','2030-01-01'),(6,'pass789','kevin_r','5553217788','kevin@email.com','K3344556','2027-02-14'),(7,'hello123','linda_w','5556543321','linda@email.com','L9988776','2028-07-30'),(8,'mypw456','david_c','5551122334','david@email.com','D5566778','2026-12-19'),(9,'secure789','nina_b','5557788990','nina@email.com','N4455667','2029-04-25'),(10,'testpass','chris_p','5556677889','chris@email.com','C1122334','2027-10-08'),(11,'passward','John_freeman','911','FREEMAN@email.com','K33412316','2029-02-14'),(12,'beta456','emma_s','5553034040','emma@email.com','E6677889','2027-05-22'),(13,'gamma789','liam_h','5555056060','liam@email.com','L1122445','2029-08-14'),(14,'delta321','olivia_g','5557078080','olivia@email.com','O9988112','2026-11-30'),(15,'theta654','noah_b','5559090001','noah@email.com','N5566771','2028-03-09'),(16,'omega111','ethan_j','5551112233','ethan@email.com','E3344556','2027-12-11'),(17,'sigma222','ava_k','5552223344','ava@email.com','A7788990','2029-06-25'),(18,'lambda333','mason_l','5553334455','mason@email.com','M2233556','2026-04-17'),(19,'zeta444','sophia_n','5554445566','sophia@email.com','S8899001','2028-10-03'),(20,'kappa555','logan_p','5555556677','logan@email.com','L6677882','2027-07-19'),(21,'psi666','mia_r','5556667788','mia@email.com','M1122335','2029-02-28'),(22,'chi777','jacob_t','5557778899','jacob@email.com','J4455667','2026-09-14'),(23,'phi888','isabella_v','5558889900','isabella@email.com','I9900112','2028-12-05'),(24,'4200','van','4085550952','vance.nguyen@sjsu.edu','DQ123123','2026-12-03');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
