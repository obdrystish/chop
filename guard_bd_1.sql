-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: guard_bd
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `client_name` varchar(255) DEFAULT NULL,
  `client_contact` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Client A','111-222-3333'),(2,'Client B','444-555-6666');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(255) NOT NULL,
  `employee_contact` varchar(12) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Employee X','777-888-9999'),(2,'Employee Y','123-456-7890');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `incidentdetails`
--

DROP TABLE IF EXISTS `incidentdetails`;
/*!50001 DROP VIEW IF EXISTS `incidentdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `incidentdetails` AS SELECT 
 1 AS `incident_id`,
 1 AS `incident_type`,
 1 AS `incident_description`,
 1 AS `client_name`,
 1 AS `employee_name`,
 1 AS `location_name`,
 1 AS `patrol_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `incident_type` varchar(255) NOT NULL,
  `incident_description` text NOT NULL,
  `location_id` int DEFAULT NULL,
  `patrol_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `patrol_id` (`patrol_id`),
  KEY `client_id` (`client_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `incidents_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `incidents_ibfk_2` FOREIGN KEY (`patrol_id`) REFERENCES `patrols` (`patrol_id`),
  CONSTRAINT `incidents_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `incidents_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents`
--

LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO `incidents` VALUES (1,'Theft','Stolen goods',1,1,1,1),(2,'Vandalism','Broken windows',2,2,2,2),(3,'daun','daunism',1,3,1,1),(4,'zhest','banka',2,NULL,2,2),(5,'123','123',1,NULL,1,1),(11,'Theft','Stolen goods',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AssignPatrolToIncident` AFTER INSERT ON `incidents` FOR EACH ROW BEGIN
    DECLARE available_patrol_id INT;
    
    -- Находим доступный патруль, который еще не назначен на другой инцидент
    SELECT patrols.patrol_id INTO available_patrol_id
    FROM patrols
    WHERE patrols.patrol_id NOT IN (
        SELECT patrols_patrol_id 
        FROM incidents_has_patrols
    )
    LIMIT 1;
    
    -- Назначаем найденный патруль на текущий инцидент
    INSERT INTO incidents_has_patrols (incidents_incident_id, patrols_patrol_id)
    VALUES (NEW.incident_id, available_patrol_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `incidents_has_patrols`
--

DROP TABLE IF EXISTS `incidents_has_patrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents_has_patrols` (
  `incidents_incident_id` int NOT NULL,
  `patrols_patrol_id` int NOT NULL,
  PRIMARY KEY (`incidents_incident_id`,`patrols_patrol_id`),
  KEY `fk_incidents_has_patrols_patrols1_idx` (`patrols_patrol_id`),
  KEY `fk_incidents_has_patrols_incidents1_idx` (`incidents_incident_id`),
  CONSTRAINT `fk_incidents_has_patrols_incidents1` FOREIGN KEY (`incidents_incident_id`) REFERENCES `incidents` (`incident_id`),
  CONSTRAINT `fk_incidents_has_patrols_patrols1` FOREIGN KEY (`patrols_patrol_id`) REFERENCES `patrols` (`patrol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents_has_patrols`
--

LOCK TABLES `incidents_has_patrols` WRITE;
/*!40000 ALTER TABLE `incidents_has_patrols` DISABLE KEYS */;
INSERT INTO `incidents_has_patrols` VALUES (5,1),(11,2);
/*!40000 ALTER TABLE `incidents_has_patrols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Location X'),(2,'Location Y'),(13,'New Location'),(14,'New Location');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrols`
--

DROP TABLE IF EXISTS `patrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrols` (
  `patrol_id` int NOT NULL AUTO_INCREMENT,
  `patrol_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patrol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrols`
--

LOCK TABLES `patrols` WRITE;
/*!40000 ALTER TABLE `patrols` DISABLE KEYS */;
INSERT INTO `patrols` VALUES (1,'Patrol 1'),(2,'Patrol 2'),(3,'Patrol 3');
/*!40000 ALTER TABLE `patrols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrols_has_employees`
--

DROP TABLE IF EXISTS `patrols_has_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrols_has_employees` (
  `patrols_patrol_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`patrols_patrol_id`,`employees_employee_id`),
  KEY `fk_patrols_has_employees_employees1_idx` (`employees_employee_id`),
  KEY `fk_patrols_has_employees_patrols1_idx` (`patrols_patrol_id`),
  CONSTRAINT `fk_patrols_has_employees_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_patrols_has_employees_patrols1` FOREIGN KEY (`patrols_patrol_id`) REFERENCES `patrols` (`patrol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrols_has_employees`
--

LOCK TABLES `patrols_has_employees` WRITE;
/*!40000 ALTER TABLE `patrols_has_employees` DISABLE KEYS */;
INSERT INTO `patrols_has_employees` VALUES (1,1),(2,2),(3,2);
/*!40000 ALTER TABLE `patrols_has_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'guard_bd'
--

--
-- Dumping routines for database 'guard_bd'
--
/*!50003 DROP FUNCTION IF EXISTS `CountSentPatrols` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CountSentPatrols`() RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE sent_patrols_count INT;
    
    SELECT COUNT(DISTINCT patrols_patrol_id) INTO sent_patrols_count
    FROM incidents_has_patrols;
    
    RETURN sent_patrols_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckPatrolsSentToIncidents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckPatrolsSentToIncidents`()
BEGIN
    DECLARE patrol_count INT;
    
    SELECT COUNT(*) INTO patrol_count
    FROM incidents_has_patrols;
    
    IF patrol_count < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Как минимум один патруль должен быть отправлен на инцидент';
    END IF;
    
    SELECT 'Least one patrol sent to an incident.';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `incidentdetails`
--

/*!50001 DROP VIEW IF EXISTS `incidentdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `incidentdetails` AS select `i`.`incident_id` AS `incident_id`,`i`.`incident_type` AS `incident_type`,`i`.`incident_description` AS `incident_description`,`c`.`client_name` AS `client_name`,`e`.`employee_name` AS `employee_name`,`l`.`location_name` AS `location_name`,`p`.`patrol_name` AS `patrol_name` from ((((`incidents` `i` join `clients` `c` on((`i`.`client_id` = `c`.`client_id`))) join `employees` `e` on((`i`.`employee_id` = `e`.`employee_id`))) join `locations` `l` on((`i`.`location_id` = `l`.`location_id`))) join `patrols` `p` on((`i`.`patrol_id` = `p`.`patrol_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-29 14:23:51
