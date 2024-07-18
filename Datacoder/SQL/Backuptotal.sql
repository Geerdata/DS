CREATE DATABASE  IF NOT EXISTS `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `articulos`
--

DROP TABLE IF EXISTS `articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cod_articulo` mediumint unsigned DEFAULT NULL,
  `tipo` enum('Libro','CD','Pelicula') DEFAULT 'Libro',
  `autor_id` int unsigned DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `ano` year DEFAULT NULL,
  `resumen` mediumtext,
  `duracion` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cod_articulo_UNIQUE` (`cod_articulo`),
  KEY `articulo_tipo_obra_fk_idx` (`tipo`),
  KEY `articulo_autor_fk_idx` (`autor_id`),
  CONSTRAINT `articulo_autor_fk` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulos`
--

LOCK TABLES `articulos` WRITE;
/*!40000 ALTER TABLE `articulos` DISABLE KEYS */;
INSERT INTO `articulos` VALUES (1,1,'Libro',1,'Harry Potter',1991,NULL,454),(2,2,'Libro',1,'Harry Potter',1991,NULL,454),(3,3,'Libro',2,'El Guardian en el centeno',1999,NULL,390),(4,4,'Libro',2,'El Guardian en el centeno',1999,NULL,390),(5,5,'Libro',2,'Nueve historias',2004,NULL,751),(6,6,'Libro',2,'Nueve historias',2004,NULL,751),(7,7,'Libro',3,'Franny y Zooey',1998,NULL,568),(8,8,'Libro',3,'Franny y Zooey',1998,NULL,568),(9,9,'Libro',4,'Tierna id la noche',1998,NULL,483),(10,10,'Libro',5,'Orgullo y prejuicio',2017,NULL,835),(11,11,'Libro',5,'Orgullo y prejuicio',2017,NULL,835),(13,12,'Libro',5,'Orgullo y prejuicio',2017,NULL,835),(14,13,'Libro',6,'El gran Gatsby',2020,NULL,793),(15,14,'Libro',6,'El gran Gatsby',2020,NULL,793),(16,15,'Libro',6,'El gran Gatsby',2020,NULL,793),(17,16,'Libro',6,'El gran Gatsby',2020,NULL,793),(18,17,'Pelicula',8,'1917',2020,NULL,123),(19,18,'Pelicula',9,'Jojo Rabbit',2020,NULL,146),(20,19,'Pelicula',10,'Bad Boys for Life',2020,NULL,98),(21,20,'Pelicula',10,'Aves de presa',2020,NULL,101),(22,21,'Pelicula',11,'Sonic, la película',2020,NULL,121),(23,22,'Pelicula',12,'Bloodshot',2020,NULL,117),(24,23,'Pelicula',13,'El hombre invisible',2020,NULL,98),(25,24,'Pelicula',14,'The Gentlemen: Los señores de la mafia',2020,NULL,87),(26,25,'Pelicula',15,'Onward',2020,NULL,111),(27,26,'Pelicula',16,'Un lugar tranquilo: Parte 2',2020,NULL,107),(28,27,'Pelicula',17,'Mulan',2020,NULL,131),(55,1258,'Pelicula',3,'Rapido y furioso 8',2021,'',123),(57,1259,'Pelicula',3,'Rapido y furioso 8',2021,NULL,123);
/*!40000 ALTER TABLE `articulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) DEFAULT NULL,
  `apellido` varchar(70) DEFAULT NULL,
  `pais` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'J. K. ','Rowling','Gran Bretaña'),(2,'F. Scott.','Fitzgerald	','Estados Unidos'),(3,'Jason N.','Gaylord','Unidos'),(4,'Jane','Austen','Bretaña'),(5,'Todd ','Miranda','Unidos'),(6,'Christian ','Wenz','Unidos'),(8,'Sam','Mendes','Bretaña'),(9,'Taiki','Waititi ','Nueva Zelanda'),(10,'Bilall','Fallah ','Bélgica'),(11,'Jeff',' Fowler','Estados Unidos'),(12,'David','Wilson','Estados Unidos'),(13,'Leigh','Whannell','Australia'),(14,'Guy','Ritchie','Gran Bretaña'),(15,'Dan','Scanlon','Estados Unidos'),(16,'John','Krasinski','Estados Unidos'),(17,'Niki','Caro','Nueva Zelanda');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deterioros`
--

DROP TABLE IF EXISTS `deterioros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deterioros` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `articulo_id` int unsigned NOT NULL,
  `comentario` tinytext,
  PRIMARY KEY (`id`),
  KEY `deterioros_articulos_fk_idx` (`articulo_id`),
  CONSTRAINT `deterioros_articulos_fk` FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deterioros`
--

LOCK TABLES `deterioros` WRITE;
/*!40000 ALTER TABLE `deterioros` DISABLE KEYS */;
INSERT INTO `deterioros` VALUES (1,8,'Tiene doblada la tapa'),(2,1,'Se rompio la tapa');
/*!40000 ALTER TABLE `deterioros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_prestamos`
--

DROP TABLE IF EXISTS `logs_prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_prestamos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `accion` varchar(45) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `detalle` varchar(100) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_prestamos`
--

LOCK TABLES `logs_prestamos` WRITE;
/*!40000 ALTER TABLE `logs_prestamos` DISABLE KEYS */;
INSERT INTO `logs_prestamos` VALUES (3,'INSERT','root@localhost','Se Inserto el prestamo 67para el socio 15','2023-01-12 14:03:49'),(4,'INSERT','root@localhost','Se Inserto el prestamo 68 para el socio 15','2023-01-12 14:04:11'),(5,'DELETE','root@localhost','se elimino el prestamo con Id  65','2023-01-12 14:38:12'),(6,'DELETE','root@localhost','se elimino el prestamo con Id  66','2023-01-12 14:38:12'),(7,'DELETE','root@localhost','se elimino el prestamo con Id  67','2023-01-12 14:38:12'),(8,'DELETE','root@localhost','se elimino el prestamo con Id  68','2023-01-12 14:38:12'),(9,'INSERT','root@localhost','Se Inserto el prestamo 69 para el socio 15','2023-01-12 14:39:01'),(10,'INSERT','root@localhost','Se Inserto el prestamo 70 para el socio 15','2023-01-12 14:39:03'),(11,'INSERT','root@localhost','Se Inserto el prestamo 71 para el socio 15','2023-01-12 14:39:04'),(12,'INSERT','root@localhost','Se Inserto el prestamo 72 para el socio 15','2023-01-12 14:39:05'),(13,'INSERT','root@localhost','Se Inserto el prestamo 73 para el socio 15','2023-01-12 14:39:06'),(14,'INSERT','root@localhost','Se Inserto el prestamo 74 para el socio 15','2023-01-12 14:39:07'),(15,'INSERT','root@localhost','Se Inserto el prestamo 75 para el socio 15','2023-01-16 17:25:33'),(16,'DELETE','root@localhost','se elimino el prestamo con Id  75','2023-01-16 17:27:29');
/*!40000 ALTER TABLE `logs_prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `articulo_id` int unsigned NOT NULL,
  `socio_id` int unsigned NOT NULL,
  `fecha_prestamo` date DEFAULT NULL,
  `fecha_tope` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prestamo_socio_fk_idx` (`socio_id`),
  KEY `prestamo_articulo_fk_idx` (`articulo_id`),
  CONSTRAINT `prestamo_articulo_fk` FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  CONSTRAINT `prestamo_socio_fk` FOREIGN KEY (`socio_id`) REFERENCES `socios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,1,1,'2020-02-19','2020-02-29','2023-01-12'),(2,2,55,'2021-02-28','2021-03-10','2021-03-07'),(3,8,57,'2021-12-30','2022-01-09','2023-01-11'),(4,10,74,'2021-02-19','2021-03-01','2021-02-28'),(5,23,17,'2021-05-10','2021-05-20','2021-05-12'),(6,21,33,'2021-06-02','2021-06-12',NULL),(7,2,5,'2021-11-22','2021-12-02','2021-11-25'),(8,7,100,'2021-09-10','2021-09-20',NULL),(9,3,86,'2020-08-12','2020-08-22','2020-08-16'),(10,7,26,'2021-02-25','2021-03-07','2021-02-28'),(11,5,6,'2020-10-27','2020-11-06','2020-10-31'),(12,25,97,'2021-10-26','2021-11-05','2021-11-28'),(13,22,49,'2021-11-24','2021-12-04','2021-12-01'),(14,26,42,'2021-08-08','2021-08-18','2021-08-26'),(15,4,89,'2020-08-04','2020-08-14','2020-08-09'),(16,7,17,'2021-09-20','2021-09-30','2021-10-07'),(17,13,74,'2021-08-28','2021-09-07','2021-09-05'),(18,1,37,'2020-11-14','2020-11-24','2020-11-21'),(19,23,63,'2020-12-11','2020-12-21',NULL),(20,22,70,'2021-11-01','2021-11-11','2021-11-10'),(21,15,21,'2021-04-15','2021-04-25','2021-04-24'),(22,24,75,'2021-09-29','2021-10-09','2021-11-02'),(23,19,79,'2020-09-15','2020-09-25','2020-09-24'),(24,4,97,'2021-05-26','2021-06-05','2021-06-01'),(25,6,74,'2021-11-20','2021-11-30','2021-11-22'),(26,6,76,'2021-10-21','2021-10-31','2021-10-28'),(27,13,80,'2021-01-27','2021-02-06','2021-01-30'),(28,23,16,'2021-07-07','2021-07-17','2021-07-09'),(29,6,5,'2021-02-14','2021-02-24',NULL),(30,25,60,'2021-07-26','2021-08-05','2021-07-31'),(31,21,75,'2021-04-04','2021-04-14','2021-04-12'),(32,10,17,'2020-10-28','2020-11-07','2020-11-02'),(33,16,32,'2020-08-30','2020-09-09','2020-10-08'),(34,19,57,'2020-11-04','2020-11-14','2020-11-12'),(35,9,16,'2020-10-20','2020-10-30','2020-10-29'),(36,19,92,'2021-04-16','2021-04-26',NULL),(37,21,23,'2020-09-13','2020-09-23','2020-09-15'),(38,23,34,'2021-08-14','2021-08-24','2021-08-17'),(39,9,79,'2020-08-13','2020-08-23',NULL),(40,12,25,'2020-08-01','2020-08-11','2020-08-09'),(41,4,76,'2021-07-02','2021-07-12','2021-07-11'),(69,1,15,'2023-01-12','2023-01-22',NULL),(70,1,15,'2023-01-12','2023-01-22',NULL),(71,1,15,'2023-01-12','2023-01-22',NULL),(72,1,15,'2023-01-12','2023-01-22',NULL),(73,1,15,'2023-01-12','2023-01-22',NULL),(74,1,15,'2023-01-12','2023-01-22',NULL);
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Logs_after_prestamos` AFTER INSERT ON `prestamos` FOR EACH ROW BEGIN

		INSERT INTO logs_prestamos (id, accion, usuario, detalle, fecha) 
		VALUES 
		(NULL, 'INSERT', SYSTEM_USER(), CONCAT('Se Inserto el prestamo ', NEW.id, ' para el socio ', NEW.socio_id), NOW());

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Log_before_delete_prestamos` BEFORE DELETE ON `prestamos` FOR EACH ROW BEGIN
INSERT INTO logs_prestamos(accion, usuario, detalle, fecha)
VALUES ('DELETE', SYSTEM_USER(), CONCAT('se elimino el prestamo con Id  ', OLD.id), NOW());

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socios` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cod_socio` varchar(10) DEFAULT NULL,
  `dni` varchar(15) DEFAULT NULL,
  `nombre` varchar(70) DEFAULT NULL,
  `apellido` varchar(70) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL COMMENT 'Tabla de socios de la biblioteca.',
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(60) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cod_socio_UNIQUE` (`cod_socio`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (1,'l98589','49525672','Luciana','Smith','lucianasmith@outlook.com.ar','Araoz 4945 1 D','272200428','2000-08-10'),(2,'j18161','11553190','Alan','Rivera','alanrivera@outlook.com','Bermejo 2164','416263411',NULL),(3,'c88230','43463982','Jhonattan','Smith','jhonattansmith@outlook.com.ar','Gral M de Azcuenaga 7923','405502617',NULL),(4,'n70234','39843037','Celeste','Baigorria','celestebaigorria@gmail.com','Diagonal Guillermo E Hudson 2517','189248602',NULL),(5,'g8746','48264037','Johana','Emede','johanaemede@outlook.com.ar','Chile 9081 4 A','168261584',NULL),(6,'u77568','34007414','Ernesto','Bartorello','ernestobartorello@outlook.com.ar','Guernica 4412','450366326',NULL),(7,'l71615','22835556','Adolfo','Moncada','adolfomoncada@outlook.com','Jose Marmol 1659','346971113',NULL),(8,'f88096','14291997','Raul','Fino','raulfino@gmail.com','Hernandarias 1808','414078629',NULL),(9,'d55482','40125657','Luciana','Blanco','lucianablanco@gmail.com','20 de Septiembre 3141 1 E','153486297',NULL),(10,'h57346','31000843','Adolfo','Carboni','adolfocarboni@outlook.com','Baldomero 1662','351455277',NULL),(11,'k84702','37628041','Oriana','Casco','orianacasco@gmail.com','Gral Jose Maria Piran 9701','131635460',NULL),(12,'z48886','15952886','Diego','Martinez','diegomartinez@outlook.com','Florentino Ameghino 2049','325231076',NULL),(13,'m20861','31614847','Florencia','Narin','florencianarin@hotmail.com','Gral Rafael de Riego 6344 5 E','223839396',NULL),(14,'h78650','37202432','Patricia','Fino','patriciafino@outlook.com.ar','Guillermo Rawson 7469','387431926',NULL),(15,'a29632','35804422','Patricia','Narin','patricianarin@outlook.com.ar','Juan Calchaqui 7230','438425362',NULL),(16,'j98763','23278261','Patricia','Basile','patriciabasile@outlook.com.ar','Gral Jose Maria Piran 4879','205208712',NULL),(17,'o36737','27154570','Daniel','Gasparini','danielgasparini@outlook.com','Dr Manuel Belgrano 5550 10 B','462115324',NULL),(18,'k21161','11232113','Maria','Oteiza','mariaoteiza@gmail.com','Guernica 2512','63372199',NULL),(19,'a89867','49461468','Maria','Alderson','mariaalderson@outlook.com.ar','Estado de Israel 4018','276230863',NULL),(20,'i83027','18394191','Jose','Narin','josenarin@hotmail.com','Juan Agustin Maza 4966','143460421',NULL),(21,'d93900','24886152','Federico','Blanco','federicoblanco@outlook.com','Juan Larrea 3558 3 D','108273232',NULL),(22,'u66709','17241313','Melanie','Bartorello','melaniebartorello@hotmail.com','Gral M Soler 1016','266874229',NULL),(23,'p75437','21441367','Adolfo','Sanchez','adolfosanchez@gmail.com','3 de Febrero 2238','380866381',NULL),(24,'p21778','21821690','Jhonattan','Smith','jhonattansmith@hotmail.com','Gral Gregorio Velez 5435','417666973',NULL),(25,'t79540','34447356','Ramón','Martinez','ramónmartinez@outlook.com','Chile 8783 4 A','446112862',NULL),(26,'i78533','38591423','Ernesto','Rodriguez','ernestorodriguez@gmail.com','Juan de Ayolas 7000','78700183',NULL),(27,'f18258','12040645','Jose','Sierra','josesierra@outlook.com','Diagonal Cesar Gascon 9875','479531848',NULL),(28,'r73678','48194282','Alejandro','Migueletes','alejandromigueletes@gmail.com','Antonio Galeano 4903','261773582',NULL),(29,'t24324','15903255','Josefina','Emede','josefinaemede@gmail.com','Gral J J de Urquiza 1064 3 F','152416921',NULL),(30,'y15251','28765251','Alejandro','Rivera','alejandrorivera@hotmail.com','Diagonal Cesar Gascon 8451','342853309',NULL),(31,'s54954','11177569','Juan','Moretti','juanmoretti@outlook.com','1 de Mayo 5692','180249339',NULL),(32,'c35064','48756790','Patricia','Hereu','patriciahereu@outlook.com','Gral San Martin 9207','446120939',NULL),(33,'u95248','33716634','Luisa','Hernández','luisahernández@outlook.com','Juan Larrea 4331 2 B','393406498',NULL),(34,'b89008','22129276','Jose','Simpson','josesimpson@outlook.com','Granados 7959','336443654',NULL),(35,'o94542','34184574','Josefina','Basile','josefinabasile@outlook.com','Diagonal Cesar Gascon 8209','36267998',NULL),(36,'n30566','15207534','Maria','Hernández','mariahernández@gmail.com','Garcia Lorca 9722','366954291',NULL),(37,'m7729','12784037','Sofia','Alderson','sofiaalderson@hotmail.com','Antonio Garagiola 9498 1 D','157331123',NULL),(38,'l40526','38511637','Patricia','Fano','patriciafano@outlook.com.ar','Aragon 1516','166369703',NULL),(39,'p19997','25129175','Jorge','Baigorria','jorgebaigorria@outlook.com','Juan A Peña 9935','188236998',NULL),(40,'a79640','28743827','Florencia','Servio','florenciaservio@hotmail.com','Dr Luis Pasteur 592','194007482',NULL),(41,'p35618','40723470','Milena','Rivera','milenarivera@gmail.com','Jose Ortega y Gasset 1067 3 F','40807636',NULL),(42,'a65092','37772392','Alan','Narin','alannarin@outlook.com','Bahia Aguirre 5401','237514918',NULL),(43,'l58143','49397440','Jose','Smith','josesmith@hotmail.com','Grecia 212','79486617',NULL),(44,'e15055','16842266','Valentin','Blanco','valentinblanco@gmail.com','Dr Pablo Groeber 8033','202478580',NULL),(45,'d32642','36887042','Federico','Alderson','federicoalderson@outlook.com','Hipolito Bouchard 2035 3 F','243469722',NULL),(46,'h29440','18669035','Lucrecia','Rivera','lucreciarivera@gmail.com','1 de Mayo 6175','122907327',NULL),(47,'s74082','34383287','Andres','Perez','andresperez@outlook.com.ar','Aragon 3969','152025435',NULL),(48,'m12500','44457480','Alejandro','Carboni','alejandrocarboni@outlook.com.ar','Avenida Dr Juan Jose Paso 977','48715802',NULL),(49,'s57483','49786131','Luciana','Bereterra','lucianabereterra@outlook.com','Hipolito Yrigoyen 7858 9 A','150362777',NULL),(50,'s52083','24411531','Celeste','Lunners','celestelunners@outlook.com','Guardacosta Rio Iguazu 1719','251243899',NULL),(51,'k77422','42972823','Johana','Blanco','johanablanco@hotmail.com','Ariel V Manuwal 664','461472244',NULL),(52,'p18415','42274580','Leandro','Moretti','leandromoretti@gmail.com','Juan Agustin Maza 9735','134901240',NULL),(53,'f5195','30605481','Johana','Emede','johanaemede@hotmail.com','Gral Jose G Artigas 7001 3 C','221411426',NULL),(54,'x22365','24842171','Pedro','Fino','pedrofino@outlook.com','Guillermo Bayley 4982','93425494',NULL),(55,'n98520','22428292','Jhonattan','Urzo','jhonattanurzo@hotmail.com','Garcia Lorca 9099','391267686',NULL),(56,'r23198','41014301','Alejandro','Blanco','alejandroblanco@outlook.com.ar','Falucho 5731','270253875',NULL),(57,'l76462','25884286','Mariana','Narin','mariananarin@hotmail.com','25 de Mayo 5390 8 C','458945945',NULL),(58,'r57551','31307345','Jhonattan','Distefano','jhonattandistefano@gmail.com','Gral Mariano Acha 3750','270146660',NULL),(59,'f31187','41285826','Andres','Sanchez','andressanchez@outlook.com.ar','Hernandarias 4945','343061943',NULL),(60,'r30739','20092699','Jorge','Smith','jorgesmith@outlook.com.ar','Gandhi 3458','440653922',NULL),(61,'y47844','42693399','Raul','Narin','raulnarin@outlook.com.ar','Grecia 2859 4 A','149662246',NULL),(62,'g96272','45811989','Valentin','Migueletes','valentinmigueletes@gmail.com','Jose Rondeau 373','368013515',NULL),(63,'u51273','19484827','Maria','Rial','mariarial@outlook.com','Dr V Alsina 3689','180911415',NULL),(64,'w79049','40626345','Josefina','Sierra','josefinasierra@outlook.com','Antonio Galeano 4831','491716932',NULL),(65,'p17914','15952274','Sofia','Diaz','sofiadiaz@hotmail.com','E Guanahani 1225 10 E','299844596',NULL),(66,'r65301','17804252','Lucrecia','Sanchez','lucreciasanchez@outlook.com.ar','Bermejo 1048','441617726',NULL),(67,'t13064','30618080','Mariana','Rivera','marianarivera@outlook.com.ar','Friuli 1554','70495541',NULL),(68,'u82533','49739567','Daniel','Rodriguez','danielrodriguez@hotmail.com','Andres Mac Gaul 2206','215618077',NULL),(69,'j2837','19400853','Jorge','Sierra','jorgesierra@gmail.com','España 3225 9 D','436924449',NULL),(70,'p77249','26632853','Jhonattan','Perez','jhonattanperez@hotmail.com','Dr Pedro Medrano 5213','455032090',NULL),(71,'n96615','38338561','Ernesto','Rivera','ernestorivera@outlook.com.ar','Diagonal Cesar Gascon 245','266040628',NULL),(72,'l4397','26761509','Florencia','Aldao','florenciaaldao@outlook.com.ar','Jose Zacagnini 5801','464792017',NULL),(73,'s94844','46705472','Federico','Lunners','federicolunners@hotmail.com','Benito Juarez 2127 6 D','158871112',NULL),(74,'u5888','31599399','Patricia','Lunners','patricialunners@gmail.com','Chacabuco 9036','487165555',NULL),(75,'f87712','26965288','Adriana','Gasparoti','adrianagasparoti@outlook.com.ar','Juan Diaz de Solis 3529','481438683',NULL),(76,'b9489','42683565','Pedro','Oteiza','pedrooteiza@gmail.com','Gral Mariano Acha 9550','238251754',NULL),(77,'g51612','12549143','Angela','Sanchez','angelasanchez@outlook.com.ar','Ciancheta 7373 5 F','286647289',NULL),(78,'r38065','37959876','Milena','Simpson','milenasimpson@outlook.com','Jose Marmol 9013','125773956',NULL),(79,'u18530','33830589','Jose','Basile','josebasile@outlook.com.ar','1 de Mayo 2811','489907965',NULL),(80,'d52601','33774393','Adriana','Emede','adrianaemede@outlook.com','Haras Horizonte 546','279301884',NULL),(81,'x92289','49786307','Andres','Distefano','andresdistefano@gmail.com','Dr Marcelo Fitte 6704 9 A','282911880',NULL),(82,'a44490','13849469','Valentin','Bartorello','valentinbartorello@outlook.com.ar','Granados 3191','292430021',NULL),(83,'u2594','27886380','Lucrecia','Gasparini','lucreciagasparini@outlook.com','Gral Gregorio Velez 9966','212017553',NULL),(84,'f91122','13429029','Luisa','Perez','luisaperez@hotmail.com','Jose Ortega y Gasset 6772','321179686',NULL),(85,'o92030','38816096','Andres','Alderson','andresalderson@gmail.com','Armenia 826 4 F','283644953',NULL),(86,'i33113','45271913','Pedro','Bartorello','pedrobartorello@outlook.com','Gral Jose Maria Piran 5422','400267692',NULL),(87,'k74354','49655233','Josefina','Moncada','josefinamoncada@outlook.com','Gral Jose Maria Paz 3992','367385157',NULL),(88,'y37420','43348019','Nicolás','Diaz','nicolásdiaz@hotmail.com','Falucho 660','89287652',NULL),(89,'v1114','35092550','Angela','Garcia','angelagarcia@outlook.com','Dr Pedro Medrano 9857 7 A','51782839',NULL),(90,'l63925','25495537','Diego','Casco','diegocasco@gmail.com','Dr Pedro Medrano 2737','149964797',NULL),(91,'w29951','19865524','Oriana','Sanchez','orianasanchez@outlook.com','Gral M Soler 2827','451242805',NULL),(92,'g72931','20510827','Lionel','Hereu','lionelhereu@outlook.com','Ciudad de Oneglia 4649','440995864',NULL),(93,'w55546','19070610','Melanie','Gasparini','melaniegasparini@outlook.com.ar','14 de Julio 3495 9 B','445333385',NULL),(94,'g56639','45821705','Oriana','Fernandez','orianafernandez@outlook.com','Antonio Martinez 3457','59608219',NULL),(95,'g55808','22310554','Celeste','Basile','celestebasile@gmail.com','Gandhi 3060','175062367',NULL),(96,'i59215','17774644','Adolfo','Simpson','adolfosimpson@gmail.com','Jose Maria Calaza 8348','173581535',NULL),(97,'i17875','36696865','Juan','Garcia','juangarcia@outlook.com','Juan Nestor Guerra 8803 2 B','84140319',NULL),(98,'k82075','38693277','Lucrecia','Sierra','lucreciasierra@outlook.com.ar','Estado de Israel 4450','337047587',NULL),(99,'g81415','36388945','Lujan','Baigorria','lujanbaigorria@outlook.com.ar','Avenida Dr Juan Hector Jara 8301','86153886',NULL),(100,'n83307','44092027','Juan','Bereterra','juanbereterra@outlook.com','Avenida Dr Juan Hector Jara 4209','347227554',NULL),(101,'t6748','27107152','Lucrecia','Gasparoti','lucreciagasparoti@hotmail.com','Gral M de Azcuenaga 3974 3 B','494006635',NULL);
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `tot_autores_x_pais`
--

DROP TABLE IF EXISTS `tot_autores_x_pais`;
/*!50001 DROP VIEW IF EXISTS `tot_autores_x_pais`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_autores_x_pais` AS SELECT 
 1 AS `PAIS`,
 1 AS `TOTAL DE AUTORES`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tot_libros_x_año`
--

DROP TABLE IF EXISTS `tot_libros_x_año`;
/*!50001 DROP VIEW IF EXISTS `tot_libros_x_año`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_libros_x_año` AS SELECT 
 1 AS `LIBRO`,
 1 AS `AÑO`,
 1 AS `TOTAL DE LIBROS`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tot_prestamos_socio_anio_actual`
--

DROP TABLE IF EXISTS `tot_prestamos_socio_anio_actual`;
/*!50001 DROP VIEW IF EXISTS `tot_prestamos_socio_anio_actual`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_prestamos_socio_anio_actual` AS SELECT 
 1 AS `FECHA`,
 1 AS `APELLIDO`,
 1 AS `NOMBRE`,
 1 AS `TOTAL DE PRESTAMOS`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tot_prestamos_x_libros`
--

DROP TABLE IF EXISTS `tot_prestamos_x_libros`;
/*!50001 DROP VIEW IF EXISTS `tot_prestamos_x_libros`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_prestamos_x_libros` AS SELECT 
 1 AS `LIBROS`,
 1 AS `TOTAL DE PRESTAMOS`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tot_prestamos_x_socio`
--

DROP TABLE IF EXISTS `tot_prestamos_x_socio`;
/*!50001 DROP VIEW IF EXISTS `tot_prestamos_x_socio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_prestamos_x_socio` AS SELECT 
 1 AS `APELLIDO`,
 1 AS `NOMBRE`,
 1 AS `TOTAL DE PRESTAMOS`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'biblioteca'
--

--
-- Dumping routines for database 'biblioteca'
--
/*!50003 DROP FUNCTION IF EXISTS `get_mail_socios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_mail_socios`(p_dni varchar(15)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
      DECLARE v_email VARCHAR(100);
      
      SELECT email
      INTO v_email
      FROM socios
      WHERE 
		dni = p_dni;
	  RETURN v_email;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_years_from_socios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_years_from_socios`(p_dni varchar(15)) RETURNS int
    DETERMINISTIC
BEGIN 
      -- Declaracion de variables Fecha de cumpleaños y años de cumpleaños
      DECLARE v_birthday DATE;
      DECLARE v_years INT(3);
      
      -- obtener la fecha de cumpleaños del socio
      SELECT fecha_nacimiento
      INTO v_birthday
      FROM socios
      WHERE dni = p_dni;

      -- Obtener el año de cumpleaños
	  SET v_years = YEAR(CURDATE()) - YEAR(v_birthday);
	  SET v_years = YEAR(CURDATE()) - YEAR(v_birthday);
	
      -- Valido si cumplio años o no en el año en curso.  
      IF MONTH(CURDATE()) <= MONTH(v_birthday) THEN
		IF (DAY(CURDATE()) < DAY(v_birthday))  THEN
			SET v_years = v_years - 1;
        END IF;
	END IF;    
    RETURN v_years;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ordenamiento_articulos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ordenamiento_articulos`(IN p_campo_a_ordenar varchar (20), IN orden BOOLEAN)
BEGIN
	IF p_campo_a_ordenar <> "" AND orden = 1 THEN
		SET @ordenar = concat("ORDER BY ", p_campo_a_ordenar);
	ELSEIF p_campo_a_ordenar <> "" AND orden = 0 THEN
		SET @ordenar = concat("ORDER BY ", p_campo_a_ordenar, ' DESC');
	ELSE
		SET @ordenar = " ";
	END IF;
	SET @clausula_select = concat ("SELECT * FROM ARTICULOS ", @ordenar);
    
-- PROCESO DE EJECUCION 
	PREPARE ejecucion FROM @clausula_select;
    EXECUTE ejecucion;
    DEALLOCATE PREPARE ejecucion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualiza_deterioros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualiza_deterioros`(IN p_prestamo_id INT, IN p_deterioro tinytext)
BEGIN
    DECLARE v_prestamo_id INT;
    DECLARE v_articulo_id INT;

    -- Valido que el prestamo exista en la tabla.
	SELECT id
    INTO v_prestamo_id
    FROM prestamos
    WHERE id = p_prestamo_id;


	-- Si el prestamo No Existe en la tabla, devolvemos un error    
	IF (v_prestamo_id <> NULL AND v_prestamo_id != p_prestamo_id ) THEN
		SELECT 'El prestamo ingresado no se encuentra en la base de datos' AS error;
    ELSE
	-- Actualizamos la Fecha de devolucion del prestamo con la fecha de Hoy
	   UPDATE prestamos
       SET fecha_devolucion = CURDATE()
       WHERE id = p_prestamo_id;
    
       IF (p_deterioro != '') THEN
		  -- Obtengo el articulo ID del prestamo. 
          SELECT articulo_id
          INTO v_articulo_id
          FROM prestamos
          WHERE id = p_prestamo_id;
	
		  INSERT INTO deterioros VALUES (NULL, v_articulo_id , p_deterioro);
       END IF;
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `tot_autores_x_pais`
--

/*!50001 DROP VIEW IF EXISTS `tot_autores_x_pais`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_autores_x_pais` AS select `au`.`pais` AS `PAIS`,count(`au`.`id`) AS `TOTAL DE AUTORES` from `autores` `au` group by `au`.`pais` order by count(`au`.`id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tot_libros_x_año`
--

/*!50001 DROP VIEW IF EXISTS `tot_libros_x_año`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_libros_x_año` AS select `a`.`nombre` AS `LIBRO`,`a`.`ano` AS `AÑO`,count(`a`.`id`) AS `TOTAL DE LIBROS` from `articulos` `a` group by `a`.`nombre`,`a`.`ano` order by `a`.`ano` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tot_prestamos_socio_anio_actual`
--

/*!50001 DROP VIEW IF EXISTS `tot_prestamos_socio_anio_actual`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_prestamos_socio_anio_actual` AS select `p`.`fecha_prestamo` AS `FECHA`,`s`.`apellido` AS `APELLIDO`,`s`.`nombre` AS `NOMBRE`,count(`p`.`id`) AS `TOTAL DE PRESTAMOS` from (`prestamos` `p` join `socios` `s` on((`s`.`id` = `p`.`socio_id`))) where (year(`p`.`fecha_prestamo`) = '2021') group by `s`.`apellido`,`s`.`nombre` order by `p`.`fecha_prestamo` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tot_prestamos_x_libros`
--

/*!50001 DROP VIEW IF EXISTS `tot_prestamos_x_libros`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_prestamos_x_libros` AS select `a`.`nombre` AS `LIBROS`,count(`a`.`id`) AS `TOTAL DE PRESTAMOS` from (`articulos` `a` join `prestamos` `p` on((`a`.`id` = `p`.`id`))) group by `a`.`nombre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tot_prestamos_x_socio`
--

/*!50001 DROP VIEW IF EXISTS `tot_prestamos_x_socio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_prestamos_x_socio` AS select `s`.`apellido` AS `APELLIDO`,`s`.`nombre` AS `NOMBRE`,count(`p`.`id`) AS `TOTAL DE PRESTAMOS` from (`prestamos` `p` join `socios` `s` on((`s`.`id` = `p`.`socio_id`))) group by `s`.`apellido`,`s`.`nombre` order by `s`.`apellido`,`s`.`nombre` */;
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

-- Dump completed on 2023-01-20 20:20:41
