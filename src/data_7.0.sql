CREATE DATABASE  IF NOT EXISTS `team32` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `team32`;
-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: team32
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `comName` varchar(45) NOT NULL,
  PRIMARY KEY (`comName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('4400 Theater Company'),('AI Theater Company'),('Awesome Theater Company'),('EZ Theater Company');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customercreditcard`
--

DROP TABLE IF EXISTS `customercreditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customercreditcard` (
  `username` varchar(45) NOT NULL,
  `creditCardNum` char(16) NOT NULL,
  PRIMARY KEY (`creditCardNum`),
  KEY `fk4_idx` (`username`),
  CONSTRAINT `fk4` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customercreditcard`
--

LOCK TABLES `customercreditcard` WRITE;
/*!40000 ALTER TABLE `customercreditcard` DISABLE KEYS */;
INSERT INTO `customercreditcard` VALUES ('calcultron','1111111111000000'),('calcultron2','1111111100000000'),('calcultron2','1111111110000000'),('calcwizard','1111111111100000'),('cool_class4400','2222222222000000'),('DNAhelix','2220000000000000'),('does2Much','2222222200000000'),('eeqmcsquare','2222222222222200'),('entropyRox','2222222222200000'),('entropyRox','2222222222220000'),('fullMetal','1100000000000000'),('georgep','1111111111110000'),('georgep','1111111111111000'),('georgep','1111111111111100'),('georgep','1111111111111110'),('georgep','1111111111111111'),('ilikemoney$$','2222222222222220'),('ilikemoney$$','2222222222222222'),('ilikemoney$$','9000000000000000'),('imready','1111110000000000'),('isthisthekrustykrab','1110000000000000'),('isthisthekrustykrab','1111000000000000'),('isthisthekrustykrab','1111100000000000'),('notFullMetal','1000000000000000'),('programerAAL','2222222000000000'),('RitzLover28','3333333333333300'),('thePiGuy3.14','2222222220000000'),('theScienceGuy','2222222222222000');
/*!40000 ALTER TABLE `customercreditcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerviewmovie`
--

DROP TABLE IF EXISTS `customerviewmovie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerviewmovie` (
  `movName` varchar(45) NOT NULL,
  `movReleaseDate` date NOT NULL,
  `movPlayDate` date NOT NULL,
  `comName` varchar(45) NOT NULL,
  `thName` varchar(45) NOT NULL,
  `creditCardNum` char(16) NOT NULL,
  PRIMARY KEY (`movName`,`movReleaseDate`,`movPlayDate`,`creditCardNum`,`comName`,`thName`),
  KEY `fk11_idx` (`creditCardNum`),
  KEY `fk12_idx` (`movName`,`movReleaseDate`,`movPlayDate`,`comName`,`thName`),
  CONSTRAINT `fk11` FOREIGN KEY (`creditCardNum`) REFERENCES `customercreditcard` (`creditCardNum`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk12` FOREIGN KEY (`movName`, `movReleaseDate`, `movPlayDate`, `comName`, `thName`) REFERENCES `movieplay` (`movName`, `movReleaseDate`, `movPlayDate`, `comName`, `thName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerviewmovie`
--

LOCK TABLES `customerviewmovie` WRITE;
/*!40000 ALTER TABLE `customerviewmovie` DISABLE KEYS */;
INSERT INTO `customerviewmovie` VALUES ('How to Train Your Dragon','2010-03-21','2010-03-25','EZ Theater Company','Star Movies','1111111111111100'),('How to Train Your Dragon','2010-03-21','2010-03-22','EZ Theater Company','Main Movies','1111111111111111'),('How to Train Your Dragon','2010-03-21','2010-03-23','EZ Theater Company','Main Movies','1111111111111111'),('How to Train Your Dragon','2010-03-21','2010-04-02','4400 Theater Company','Cinema Star','1111111111111111');
/*!40000 ALTER TABLE `customerviewmovie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `username` varchar(45) NOT NULL,
  `manStreet` varchar(45) NOT NULL,
  `manCity` varchar(45) NOT NULL,
  `manState` char(2) NOT NULL,
  `manZipcode` char(5) NOT NULL,
  `employeeType` enum('Manager','Admin') NOT NULL,
  `comName` varchar(45) NOT NULL,
  `thName` varchar(45) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `fk2_idx` (`comName`),
  CONSTRAINT `fk1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('calcultron','123 Peachtree St','Atlanta','GA','30308','Manager','EZ Theater Company','Star Movies'),('cool_class4400','','','','','Admin','',''),('entropyRox','200 Cool Place','San Francisco','CA','94016','Manager','4400 Theater Company','Cinema Star'),('fatherAI','456 Main St','New York','NY','10001','Manager','EZ Theater Company','Main Movies'),('georgep','10 Pearl Dr','Seattle','WA','98105','Manager','4400 Theater Company','Jonathan\'s Movies'),('ghcghc','100 Pi St','Pallet Town','KS','31415','Manager','AI Theater Company','ML Movies'),('imbatman','800 Color Dr','Austin','TX','78653','Manager','Awesome Theater Company','ABC Theater'),('manager1','123 Ferst Drive','Atlanta','GA','30332','Manager','4400 Theater Company',''),('manager2','456 Ferst Drive','Atlanta','GA','30332','Manager','AI Theater Company',''),('manager3','789 Ferst Drive','Atlanta','GA','30332','Manager','4400 Theater Company',''),('manager4','000 Ferst Drive','Atlanta','GA','30332','Manager','4400 Theater Company',''),('radioactivePoRa','100 Blu St','Sunnyvale','CA','94088','Manager','4400 Theater Company','Star Movies');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `username` varchar(45) NOT NULL,
  `manStreet` varchar(45) NOT NULL,
  `manCity` varchar(45) NOT NULL,
  `manState` char(2) NOT NULL,
  `manZipcode` char(5) NOT NULL,
  `employeeType` enum('Manager','Admin') NOT NULL,
  `comName` varchar(45) NOT NULL,
  `thName` varchar(45) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `fk3_idx` (`comName`),
  CONSTRAINT `fk2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk3` FOREIGN KEY (`comName`) REFERENCES `company` (`comName`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('calcultron','123 Peachtree St','Atlanta','GA','30308','Manager','EZ Theater Company','Star Movies'),('entropyRox','200 Cool Place','San Francisco','CA','94016','Manager','4400 Theater Company','Cinema Star'),('fatherAI','456 Main St','New York','NY','10001','Manager','EZ Theater Company','Main Movies'),('georgep','10 Pearl Dr','Seattle','WA','98105','Manager','4400 Theater Company','Jonathan\'s Movies'),('ghcghc','100 Pi St','Pallet Town','KS','31415','Manager','AI Theater Company','ML Movies'),('imbatman','800 Color Dr','Austin','TX','78653','Manager','Awesome Theater Company','ABC Theater'),('manager1','123 Ferst Drive','Atlanta','GA','30332','Manager','4400 Theater Company',''),('manager2','456 Ferst Drive','Atlanta','GA','30332','Manager','AI Theater Company',''),('manager3','789 Ferst Drive','Atlanta','GA','30332','Manager','4400 Theater Company',''),('manager4','000 Ferst Drive','Atlanta','GA','30332','Manager','4400 Theater Company',''),('radioactivePoRa','100 Blu St','Sunnyvale','CA','94088','Manager','4400 Theater Company','Star Movies');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `movName` varchar(45) NOT NULL,
  `movReleaseDate` date NOT NULL,
  `duration` int(11) NOT NULL,
  PRIMARY KEY (`movName`,`movReleaseDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES ('4400 The Movie','2019-08-12',130),('Avengers: Endgame','2019-04-26',181),('Calculus Returns: A ML Story','2019-09-19',314),('George P Burdell\'s Life Story','1927-08-12',100),('Georgia Tech The Movie','1985-08-13',100),('How to Train Your Dragon','2010-03-21',98),('Spaceballs','1987-06-24',96),('Spider-Man: Into the Spider-Verse','2018-12-01',117),('The First Pokemon Movie','1998-07-19',75),('The King\'s Speech','2010-11-26',119);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movieplay`
--

DROP TABLE IF EXISTS `movieplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movieplay` (
  `movName` varchar(45) NOT NULL,
  `movReleaseDate` date NOT NULL,
  `movPlayDate` date NOT NULL,
  `comName` varchar(45) NOT NULL,
  `thName` varchar(45) NOT NULL,
  PRIMARY KEY (`movName`,`movReleaseDate`,`movPlayDate`,`comName`,`thName`),
  KEY `fk7_idx` (`comName`,`thName`),
  CONSTRAINT `fk7` FOREIGN KEY (`comName`, `thName`) REFERENCES `theater` (`comName`, `thName`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk8` FOREIGN KEY (`movName`, `movReleaseDate`) REFERENCES `movie` (`movName`, `movReleaseDate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movieplay`
--

LOCK TABLES `movieplay` WRITE;
/*!40000 ALTER TABLE `movieplay` DISABLE KEYS */;
INSERT INTO `movieplay` VALUES ('4400 The Movie','2019-08-12','2019-09-12','4400 Theater Company','Cinema Star'),('George P Burdell\'s Life Story','1927-08-12','2010-05-20','4400 Theater Company','Cinema Star'),('Georgia Tech The Movie','1985-08-13','2019-09-30','4400 Theater Company','Cinema Star'),('How to Train Your Dragon','2010-03-21','2010-04-02','4400 Theater Company','Cinema Star'),('Spaceballs','1987-06-24','2000-02-02','4400 Theater Company','Cinema Star'),('The King\'s Speech','2010-11-26','2019-12-20','4400 Theater Company','Cinema Star'),('Calculus Returns: A ML Story','2019-09-19','2019-10-10','AI Theater Company','ML Movies'),('Calculus Returns: A ML Story','2019-09-19','2019-12-30','AI Theater Company','ML Movies'),('Spaceballs','1987-06-24','2010-04-02','AI Theater Company','ML Movies'),('Spaceballs','1987-06-24','2023-01-23','AI Theater Company','ML Movies'),('Spider-Man: Into the Spider-Verse','2018-12-01','2019-09-30','AI Theater Company','ML Movies'),('4400 The Movie','2019-08-12','2019-10-12','Awesome Theater Company','ABC Theater'),('Georgia Tech The Movie','1985-08-13','1985-08-13','Awesome Theater Company','ABC Theater'),('The First Pokemon Movie','1998-07-19','2018-07-19','Awesome Theater Company','ABC Theater'),('George P Burdell\'s Life Story','1927-08-12','2019-07-14','EZ Theater Company','Main Movies'),('George P Burdell\'s Life Story','1927-08-12','2019-10-22','EZ Theater Company','Main Movies'),('How to Train Your Dragon','2010-03-21','2010-03-22','EZ Theater Company','Main Movies'),('How to Train Your Dragon','2010-03-21','2010-03-23','EZ Theater Company','Main Movies'),('Spaceballs','1987-06-24','1999-06-24','EZ Theater Company','Main Movies'),('The King\'s Speech','2010-11-26','2019-12-20','EZ Theater Company','Main Movies'),('4400 The Movie','2019-08-12','2019-08-12','EZ Theater Company','Star Movies'),('How to Train Your Dragon','2010-03-21','2010-03-25','EZ Theater Company','Star Movies');
/*!40000 ALTER TABLE `movieplay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theater`
--

DROP TABLE IF EXISTS `theater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theater` (
  `comName` varchar(45) NOT NULL,
  `thName` varchar(45) NOT NULL,
  `capacity` int(11) NOT NULL,
  `thStreet` varchar(45) NOT NULL,
  `thCity` varchar(45) NOT NULL,
  `thState` char(2) NOT NULL,
  `thZipcode` char(5) NOT NULL,
  `manUsername` varchar(45) NOT NULL,
  PRIMARY KEY (`comName`,`thName`),
  KEY `fk6_idx` (`manUsername`),
  CONSTRAINT `fk5` FOREIGN KEY (`comName`) REFERENCES `company` (`comName`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk6` FOREIGN KEY (`manUsername`) REFERENCES `manager` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theater`
--

LOCK TABLES `theater` WRITE;
/*!40000 ALTER TABLE `theater` DISABLE KEYS */;
INSERT INTO `theater` VALUES ('4400 Theater Company','Cinema Star',4,'100 Cool Place','San Francisco','CA','94016','entropyRox'),('4400 Theater Company','Jonathan\'s Movies',2,'67 Pearl Dr','Seattle','WA','98101','georgep'),('4400 Theater Company','Star Movies',5,'4400 Rocks Ave','Boulder','CA','80301','radioactivePoRa'),('AI Theater Company','ML Movies',3,'314 Pi St','Pallet Town','KS','31415','ghcghc'),('Awesome Theater Company','ABC Theater',5,'880 Color Dr','Austin','TX','73301','imbatman'),('EZ Theater Company','Main Movies',3,'123 Main St','New York','NY','10001','fatherAI'),('EZ Theater Company','Star Movies',2,'745 GT St','Atlanta','GA','30332','calcultron');
/*!40000 ALTER TABLE `theater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `userType` enum('Employee','Customer','User','CustomerAdmin','CustomerManager','Manager') NOT NULL,
  `status` enum('Approved','Declined','Pending') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('calcultron','Dwight','Schrute','77c9749b451ab8c713c48037ddfbb2c4','CustomerManager','Approved'),('calcultron2','Jim','Halpert','8792b8cf71d27dc96173b2ac79b96e0d','Customer','Approved'),('calcwizard','Issac','Newton','0d777e9e30b918e9034ab610712c90cf','Customer','Approved'),('clarinetbeast','Squidward','Tentacles','c8c605999f3d8352d7bb792cf3fdb25b','Customer','Declined'),('cool_class4400','A. TA','Washere','77c9749b451ab8c713c48037ddfbb2c4','CustomerAdmin','Approved'),('DNAhelix','Rosalind','Franklin','ca94efe2a58c27168edf3d35102dbb6d','Customer','Approved'),('does2Much','Carl','Gauss','00cedcf91beffa9ee69f6cfe23a4602d','Customer','Approved'),('eeqmcsquare','Albert','Einstein','7c5858f7fcf63ec268f42565be3abb95','Customer','Approved'),('entropyRox','Claude','Shannon','c8c605999f3d8352d7bb792cf3fdb25b','CustomerManager','Approved'),('fatherAI','Alan','Turing','0d777e9e30b918e9034ab610712c90cf','Manager','Approved'),('fullMetal','Edward','Elric','d009d70ae4164e8989725e828db8c7c2','Customer','Approved'),('gdanger','Gary','Danger','3665a76e271ada5a75368b99f774e404','User','Declined'),('georgep','George P.','Burdell','bbb8aae57c104cda40c93843ad5e6db8','CustomerManager','Approved'),('ghcghc','Grace','Hopper','9f0863dd5f0256b0f586a7b523f8cfe8','Manager','Approved'),('ilikemoney$$','Eugene','Krabs','7c5858f7fcf63ec268f42565be3abb95','Customer','Approved'),('imbatman','Bruce','Wayne','9f0863dd5f0256b0f586a7b523f8cfe8','Manager','Approved'),('imready','Spongebob','Squarepants','ca94efe2a58c27168edf3d35102dbb6d','Customer','Approved'),('isthisthekrustykrab','Patrick','Star','134fb0bf3bdd54ee9098f4cbc4351b9a','Customer','Approved'),('manager1','Manager','One','e58cce4fab03d2aea056398750dee16b','Manager','Approved'),('manager2','manager','two','ba9485f02fc98cdbd2edadb0aa8f6390','Manager','Approved'),('manager3','Three','Three','6e4fb18b49aa3219bef65195dac7be8c','Manager','Approved'),('manager4','Four','Four','d61dfee83aa2a6f9e32f268d60e789f5','Manager','Approved'),('notFullMetal','Alphonse','Elric','d009d70ae4164e8989725e828db8c7c2','Customer','Approved'),('programerAAL','Abby','Normal','ba9485f02fc98cdbd2edadb0aa8f6390','Customer','Approved'),('radioactivePoRa','Marie','Curie','e5d4b739db1226088177e6f8b70c3a6f','Manager','Approved'),('RitzLover28','Abby','Normal','8792b8cf71d27dc96173b2ac79b96e0d','Customer','Approved'),('smith_j','John','Smith','77c9749b451ab8c713c48037ddfbb2c4','User','Pending'),('texasStarKarate','Sandy','Cheeks','7c5858f7fcf63ec268f42565be3abb95','User','Declined'),('thePiGuy3.14','Archimedes','Syracuse','e11170b8cbd2d74102651cb967fa28e5','Customer','Approved'),('theScienceGuy','Bill','Nye','c8c605999f3d8352d7bb792cf3fdb25b','Customer','Approved');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uservisittheater`
--

DROP TABLE IF EXISTS `uservisittheater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uservisittheater` (
  `username` varchar(45) NOT NULL,
  `comName` varchar(45) NOT NULL,
  `thName` varchar(45) NOT NULL,
  `visitDate` date NOT NULL,
  `[VisitID]` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`[VisitID]`),
  KEY `fk9_idx` (`username`),
  KEY `fk10_idx` (`comName`,`thName`),
  CONSTRAINT `fk10` FOREIGN KEY (`comName`, `thName`) REFERENCES `theater` (`comName`, `thName`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk9` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uservisittheater`
--

LOCK TABLES `uservisittheater` WRITE;
/*!40000 ALTER TABLE `uservisittheater` DISABLE KEYS */;
INSERT INTO `uservisittheater` VALUES ('georgep','EZ Theater Company','Main Movies','2010-03-22',1),('calcwizard','EZ Theater Company','Main Movies','2010-03-22',2),('calcwizard','EZ Theater Company','Star Movies','2010-03-25',3),('imready','EZ Theater Company','Star Movies','2010-03-25',4),('calcwizard','AI Theater Company','ML Movies','2010-03-20',5);
/*!40000 ALTER TABLE `uservisittheater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'team32'
--

--
-- Dumping routines for database 'team32'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-02 14:44:59
