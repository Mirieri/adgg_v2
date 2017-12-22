-- MySQL dump 10.16  Distrib 10.2.7-MariaDB, for osx10.12 (x86_64)
--
-- Host: localhost    Database: axgg
-- ------------------------------------------------------
-- Server version	10.2.7-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `all_attribute_types`
--

DROP TABLE IF EXISTS `all_attribute_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_attribute_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `attribute_category` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT 'routine',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_attribute_types`
--

LOCK TABLES `all_attribute_types` WRITE;
/*!40000 ALTER TABLE `all_attribute_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_attribute_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal_attributes`
--

DROP TABLE IF EXISTS `animal_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_meta_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `attribute_value` text DEFAULT NULL,
  `attribute_date` datetime NOT NULL,
  `record_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `instance_meta_id` (`instance_meta_id`),
  KEY `attribute_type_id` (`attribute_type_id`),
  KEY `animal_id` (`animal_id`),
  CONSTRAINT `animal_attributes_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  CONSTRAINT `animal_attributes_ibfk_4` FOREIGN KEY (`attribute_type_id`) REFERENCES `dictionary_items` (`id`),
  CONSTRAINT `animal_attributes_ibfk_5` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_attributes`
--

LOCK TABLES `animal_attributes` WRITE;
/*!40000 ALTER TABLE `animal_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `animal_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal_event_types`
--

DROP TABLE IF EXISTS `animal_event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_event_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(255) NOT NULL DEFAULT '',
  `event_value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_event_types`
--

LOCK TABLES `animal_event_types` WRITE;
/*!40000 ALTER TABLE `animal_event_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `animal_event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal_events`
--

DROP TABLE IF EXISTS `animal_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_meta_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `event_value` text DEFAULT NULL,
  `event_date` date NOT NULL,
  `record_date` datetime NOT NULL,
  `performed_by` int(11) DEFAULT NULL,
  `recorded_by` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instance_meta_id` (`instance_meta_id`),
  KEY `animal_id` (`animal_id`),
  KEY `event_type_id` (`event_type_id`),
  CONSTRAINT `animal_events_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  CONSTRAINT `animal_events_ibfk_2` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`),
  CONSTRAINT `animal_events_ibfk_3` FOREIGN KEY (`event_type_id`) REFERENCES `animal_events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_events`
--

LOCK TABLES `animal_events` WRITE;
/*!40000 ALTER TABLE `animal_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `animal_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animals`
--

DROP TABLE IF EXISTS `animals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hh_id` int(11) NOT NULL,
  `datetime_added` datetime NOT NULL,
  `instance_meta_id` int(11) NOT NULL,
  `animal_id` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Primary id of the animal. Should be unique',
  `other_id` varchar(50) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Can be the bola id or any other name/marking the animal is referred to',
  `rfid` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `species_id` int(11) NOT NULL DEFAULT 1,
  `sex` enum('Male','Female','3','4') CHARACTER SET latin1 NOT NULL,
  `origin` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sire` int(11) DEFAULT NULL,
  `dam` int(11) DEFAULT NULL,
  `status` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `animal_id` (`animal_id`),
  KEY `sire` (`sire`),
  KEY `dam` (`dam`),
  KEY `HH` (`hh_id`),
  KEY `instance_meta_id` (`instance_meta_id`),
  CONSTRAINT `animals_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  CONSTRAINT `animals_ibfk_2` FOREIGN KEY (`hh_id`) REFERENCES `households` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animals`
--

LOCK TABLES `animals` WRITE;
/*!40000 ALTER TABLE `animals` DISABLE KEYS */;
/*!40000 ALTER TABLE `animals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinators`
--

DROP TABLE IF EXISTS `coordinators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coordinators` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name1` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `name2` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `language` enum('english','french') CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role1` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role2` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `organisation` int(11) unsigned NOT NULL,
  `country` char(2) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organisation` (`organisation`),
  KEY `FK_coordinators_countries` (`country`),
  CONSTRAINT `FK_coordinators_countries` FOREIGN KEY (`country`) REFERENCES `countries` (`id`),
  CONSTRAINT `coordinators_ibfk_1` FOREIGN KEY (`organisation`) REFERENCES `partners` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinators`
--

LOCK TABLES `coordinators` WRITE;
/*!40000 ALTER TABLE `coordinators` DISABLE KEYS */;
/*!40000 ALTER TABLE `coordinators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `name` varchar(80) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `iso3` char(3) CHARACTER SET latin1 DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `phonecode` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionary_items`
--

DROP TABLE IF EXISTS `dictionary_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionary_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `date_modified` datetime(6) NOT NULL,
  `form_group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `t_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_locale` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `t_value` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dictionary_items_form_group_parent_node_t_key_82d21950_uniq` (`form_group`,`parent_node`,`t_key`),
  KEY `dictionary_items_form_group_8dc3739a` (`form_group`),
  KEY `dictionary_items_parent_node_fc06afa3` (`parent_node`),
  KEY `dictionary_items_t_key_4ed87fa1` (`t_key`),
  KEY `dictionary_items_t_type_6929fe4d` (`t_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary_items`
--

LOCK TABLES `dictionary_items` WRITE;
/*!40000 ALTER TABLE `dictionary_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `dictionary_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districts` (
  `district_code` char(2) NOT NULL,
  `district_name` int(11) DEFAULT NULL,
  `region` char(2) NOT NULL,
  PRIMARY KEY (`district_code`),
  KEY `region_idx` (`region`),
  CONSTRAINT `region` FOREIGN KEY (`region`) REFERENCES `regions` (`reg_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hh_attributes`
--

DROP TABLE IF EXISTS `hh_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hh_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_meta_id` int(11) NOT NULL,
  `hh_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `attribute_value` varchar(1000) DEFAULT NULL,
  `date_collected` date NOT NULL,
  `datetime_added` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `hh_id_2` (`hh_id`,`attribute_type_id`,`attribute_value`),
  KEY `instance_meta_id` (`instance_meta_id`),
  KEY `hh_id` (`hh_id`),
  KEY `attribute_type_id` (`attribute_type_id`),
  CONSTRAINT `hh_attributes_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  CONSTRAINT `hh_attributes_ibfk_2` FOREIGN KEY (`hh_id`) REFERENCES `households` (`id`),
  CONSTRAINT `hh_attributes_ibfk_3` FOREIGN KEY (`attribute_type_id`) REFERENCES `dictionary_items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hh_attributes`
--

LOCK TABLES `hh_attributes` WRITE;
/*!40000 ALTER TABLE `hh_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `hh_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hh_events`
--

DROP TABLE IF EXISTS `hh_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hh_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_meta_id` int(11) NOT NULL,
  `hh_id` int(11) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `event_value` text DEFAULT NULL,
  `event_date` datetime NOT NULL,
  `record_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `hh_id` (`hh_id`),
  KEY `event_type_id` (`event_type_id`),
  KEY `instance_meta_id` (`instance_meta_id`),
  CONSTRAINT `hh_events_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`),
  CONSTRAINT `hh_events_ibfk_2` FOREIGN KEY (`hh_id`) REFERENCES `households` (`id`),
  CONSTRAINT `hh_events_ibfk_3` FOREIGN KEY (`event_type_id`) REFERENCES `hh_events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hh_events`
--

LOCK TABLES `hh_events` WRITE;
/*!40000 ALTER TABLE `hh_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `hh_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `households`
--

DROP TABLE IF EXISTS `households`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `households` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_meta_id` int(11) NOT NULL,
  `hh_id` varchar(100) NOT NULL COMMENT 'Can be phone number, voters card, etc',
  `language` enum('english','french','amharic','kiswahili') DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `hh_id` (`hh_id`),
  KEY `instance_meta_id` (`instance_meta_id`),
  CONSTRAINT `households_ibfk_1` FOREIGN KEY (`instance_meta_id`) REFERENCES `instance_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `households`
--

LOCK TABLES `households` WRITE;
/*!40000 ALTER TABLE `households` DISABLE KEYS */;
/*!40000 ALTER TABLE `households` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_meta`
--

DROP TABLE IF EXISTS `instance_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(50) NOT NULL,
  `source_device` varchar(50) NOT NULL,
  `date_submitted` date NOT NULL,
  `latitude` double(15,12) NOT NULL,
  `longitude` double(15,12) NOT NULL,
  `altitude` double(16,12) NOT NULL,
  `gps_accuracy` double(9,3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_meta`
--

LOCK TABLES `instance_meta` WRITE;
/*!40000 ALTER TABLE `instance_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partners` (
  `partner_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `short_name` varchar(55) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `organisation` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `contact` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT '',
  `phone` varchar(255) CHARACTER SET latin1 DEFAULT '',
  `country` char(2) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`partner_id`),
  KEY `countries` (`country`),
  CONSTRAINT `partners_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partners`
--

LOCK TABLES `partners` WRITE;
/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `last_name` varchar(55) CHARACTER SET latin1 DEFAULT NULL,
  `language` enum('english','french') CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role1` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `role2` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `organisation` int(11) NOT NULL,
  `coordinator` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `reg_code` char(2) NOT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  `country` char(2) NOT NULL,
  PRIMARY KEY (`reg_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `species_types`
--

DROP TABLE IF EXISTS `species_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `species_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET latin1 NOT NULL,
  `nominal_value` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species_types`
--

LOCK TABLES `species_types` WRITE;
/*!40000 ALTER TABLE `species_types` DISABLE KEYS */;
INSERT INTO `species_types` VALUES (5,'Cattle',0);
/*!40000 ALTER TABLE `species_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ward`
--

DROP TABLE IF EXISTS `ward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ward` (
  `idWARD` char(2) NOT NULL,
  `ward_name` varchar(45) DEFAULT NULL,
  `disctrict` char(2) NOT NULL,
  PRIMARY KEY (`idWARD`),
  KEY `district_idx` (`disctrict`),
  CONSTRAINT `district` FOREIGN KEY (`disctrict`) REFERENCES `districts` (`district_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ward`
--

LOCK TABLES `ward` WRITE;
/*!40000 ALTER TABLE `ward` DISABLE KEYS */;
/*!40000 ALTER TABLE `ward` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-13  5:51:49
