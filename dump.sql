-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: faf_lobby
-- ------------------------------------------------------
-- Server version   5.7.18

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
-- Table structure for table `AI_names`
--

DROP TABLE IF EXISTS `AI_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AI_names` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key : ID .\nUnsigned car pas de valeurs negative.\nMEDIUMINT : 16 millions d''entrÃ©es maxi, meilleures perfs que INT\nSMALLINT : 65.000 entrÃ©es, ce qui peut etre largement suffisant.\nDoit etre contraint a l''id de la table info_clients.',
  `login` varchar(60) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL COMMENT 'login du clientMinimum 5 caracteres, VARCHAR peut fragmenter la DB, mais pas d''autres moyens ici.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=16777215 DEFAULT CHARSET=latin1 COMMENT='login';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AI_rating`
--

DROP TABLE IF EXISTS `AI_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AI_rating` (
  `id` mediumint(8) unsigned NOT NULL,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `numGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `AI_rating_ibfk_1` FOREIGN KEY (`id`) REFERENCES `AI_names` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `achievement_definitions`
--

DROP TABLE IF EXISTS `achievement_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achievement_definitions` (
  `id` varchar(36) NOT NULL COMMENT 'The ID of the achievement.',
  `order` int(10) unsigned NOT NULL COMMENT 'The order in which the achievement is displayed to the user.',
  `name_key` varchar(255) NOT NULL COMMENT 'The message key for the name of the achievement.',
  `description_key` varchar(255) NOT NULL COMMENT 'The message key for the description of the achievement.',
  `type` enum('STANDARD','INCREMENTAL') NOT NULL COMMENT 'The type of the achievement. \nPossible values are:\n"STANDARD" - Achievement is either locked or unlocked.\n"INCREMENTAL" - Achievement is incremental.',
  `total_steps` int(10) unsigned DEFAULT NULL COMMENT 'The total steps for an incremental achievement, NULL for standard achievements.',
  `revealed_icon_url` varchar(2000) DEFAULT NULL COMMENT 'The image URL for the revealed achievement icon.',
  `unlocked_icon_url` varchar(2000) DEFAULT NULL COMMENT 'The image URL for the unlocked achievement icon.',
  `initial_state` enum('HIDDEN','REVEALED') NOT NULL COMMENT 'The initial state of the achievement. \nPossible values are:\n"HIDDEN" - Achievement is hidden.\n"REVEALED" - Achievement is revealed.\n"UNLOCKED" - Achievement is unlocked.',
  `experience_points` int(10) unsigned NOT NULL COMMENT 'Experience points which will be earned when unlocking this achievement. Multiple of 5. Reference:\n5 - Easy to achieve\n20 - Medium\n50 - Hard to achieve',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_key_UNIQUE` (`name_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `achievement_statistics`
--

DROP TABLE IF EXISTS `achievement_statistics`;
/*!50001 DROP VIEW IF EXISTS `achievement_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `achievement_statistics` AS SELECT 
 1 AS `achievement_id`,
 1 AS `unlockers_count`,
 1 AS `unlockers_percent`,
 1 AS `unlockers_min_duration`,
 1 AS `unlockers_avg_duration`,
 1 AS `unlockers_max_duration`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avatars`
--

DROP TABLE IF EXISTS `avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avatars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `idAvatar` int(10) unsigned NOT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'If null the avatar is permanent',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idUser` (`idUser`,`idAvatar`),
  KEY `friendCnst` (`idAvatar`),
  CONSTRAINT `avatars_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `login` (`id`),
  CONSTRAINT `avatars_ibfk_2` FOREIGN KEY (`idAvatar`) REFERENCES `avatars_list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199385 DEFAULT CHARSET=latin1 COMMENT='Assign avatars (avatars_list) to users (login)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avatars_list`
--

DROP TABLE IF EXISTS `avatars_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avatars_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `tooltip` varchar(50) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`,`tooltip`)
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=latin1 COMMENT='List of all available avatars';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bugreport_status`
--

DROP TABLE IF EXISTS `bugreport_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bugreport_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bugreport` int(11) NOT NULL,
  `status_code` enum('unfiled','filed','dismissed') NOT NULL,
  `url` varchar(255) DEFAULT NULL COMMENT 'If status is filed, then this should be a reference to a github issue',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `bugreport` (`bugreport`),
  CONSTRAINT `bugreport` FOREIGN KEY (`bugreport`) REFERENCES `bugreports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bugreport_targets`
--

DROP TABLE IF EXISTS `bugreport_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bugreport_targets` (
  `id` varchar(255) NOT NULL COMMENT 'Unique reference to the target, e.g. FAForever/client/tree/(hash)',
  `name` varchar(255) NOT NULL COMMENT 'Name of the target, a github repository name',
  `ref` varchar(255) NOT NULL COMMENT 'Reference of the target',
  `url` varchar(255) NOT NULL COMMENT 'Url to the target',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bugreports`
--

DROP TABLE IF EXISTS `bugreports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bugreports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `automatic` tinyint(1) NOT NULL COMMENT 'Whether the report was automated or not',
  `description` text COMMENT 'A (potentially markdown-formatted) description of the bug',
  `log` text COMMENT 'Log associated with the report',
  `traceback` text COMMENT 'Traceback associated with the report',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `bugreport_target` (`target`),
  CONSTRAINT `bugreport_target` FOREIGN KEY (`target`) REFERENCES `bugreport_targets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clan`
--

DROP TABLE IF EXISTS `clan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `tag` varchar(3) NOT NULL,
  `founder_id` mediumint(8) unsigned DEFAULT NULL COMMENT 'The initial creator of the clan',
  `leader_id` mediumint(8) unsigned DEFAULT NULL COMMENT 'Current leader/admin of the clan',
  `description` text,
  `tag_color` varchar(6) DEFAULT NULL COMMENT 'RGB color code for the clan''s tag in chat',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `founder_id` (`founder_id`),
  KEY `leader_id` (`leader_id`),
  CONSTRAINT `clan_ibfk_1` FOREIGN KEY (`founder_id`) REFERENCES `login` (`id`),
  CONSTRAINT `clan_ibfk_2` FOREIGN KEY (`leader_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clan_membership`
--

DROP TABLE IF EXISTS `clan_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan_membership` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `clan_id` mediumint(8) unsigned NOT NULL,
  `player_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_id` (`player_id`),
  KEY `clan_id` (`clan_id`),
  CONSTRAINT `clan_membership_ibfk_1` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`),
  CONSTRAINT `clan_membership_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coop_leaderboard`
--

DROP TABLE IF EXISTS `coop_leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coop_leaderboard` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `mission` smallint(6) unsigned NOT NULL,
  `gameuid` bigint(20) unsigned NOT NULL,
  `secondary` tinyint(3) unsigned NOT NULL,
  `time` time NOT NULL,
  `player_count` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gameuid` (`gameuid`)
) ENGINE=InnoDB AUTO_INCREMENT=29189 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coop_map`
--

DROP TABLE IF EXISTS `coop_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coop_map` (
  `type` tinyint(3) unsigned NOT NULL,
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `description` longtext,
  `version` decimal(4,0) DEFAULT NULL,
  `filename` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filename` (`filename`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_domain_blacklist`
--

DROP TABLE IF EXISTS `email_domain_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_domain_blacklist` (
  `domain` varchar(255) NOT NULL,
  UNIQUE KEY `domain_index` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_definitions`
--

DROP TABLE IF EXISTS `event_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_definitions` (
  `id` varchar(36) NOT NULL COMMENT 'The ID of the event.',
  `name_key` varchar(255) NOT NULL COMMENT 'The message key for the name of the event.',
  `image_url` varchar(45) DEFAULT NULL COMMENT 'The base URL for the image that represents the event.',
  `type` enum('NUMERIC','TIME') NOT NULL COMMENT 'The type of the event.\nPossible values are:\n"NUMERIC" - Event is a plain number.\n"TIME" - Event is a measure of time.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_key_UNIQUE` (`name_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faction`
--

DROP TABLE IF EXISTS `faction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faction` (
  `id` tinyint(3) unsigned DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_mods_owners`
--

DROP TABLE IF EXISTS `featured_mods_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured_mods_owners` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) unsigned NOT NULL,
  `moduid` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `moduid` (`moduid`),
  CONSTRAINT `featured_mods_owners_ibfk_1` FOREIGN KEY (`moduid`) REFERENCES `game_featuredMods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `featured_mods_owners_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friends_and_foes`
--

DROP TABLE IF EXISTS `friends_and_foes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends_and_foes` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `subject_id` mediumint(8) unsigned NOT NULL,
  `status` enum('FRIEND','FOE') DEFAULT NULL,
  PRIMARY KEY (`user_id`,`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_featuredMods`
--

DROP TABLE IF EXISTS `game_featuredMods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_featuredMods` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `gamemod` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'Order in the featured mods list',
  `git_url` varchar(255) DEFAULT NULL COMMENT 'The git repository URL to load this mod from',
  `git_branch` varchar(255) DEFAULT NULL COMMENT 'The repository branch that contains the latest version',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_name_idx` (`gamemod`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_player_stats`
--

DROP TABLE IF EXISTS `game_player_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_player_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gameId` int(10) unsigned NOT NULL,
  `playerId` mediumint(8) unsigned NOT NULL,
  `AI` tinyint(1) NOT NULL,
  `faction` tinyint(3) unsigned NOT NULL,
  `color` tinyint(4) NOT NULL,
  `team` tinyint(3) NOT NULL,
  `place` tinyint(3) unsigned NOT NULL,
  `mean` float unsigned NOT NULL,
  `deviation` float unsigned NOT NULL,
  `after_mean` float DEFAULT NULL,
  `after_deviation` float DEFAULT NULL,
  `score` tinyint(3) NOT NULL,
  `scoreTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playerId` (`playerId`),
  KEY `gameIdIdx` (`gameId`),
  CONSTRAINT `fk_game_player_stats_player` FOREIGN KEY (`playerId`) REFERENCES `login` (`id`),
  CONSTRAINT `game_id_fk` FOREIGN KEY (`gameId`) REFERENCES `game_stats` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11538163 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_player_stats_bak`
--

DROP TABLE IF EXISTS `game_player_stats_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_player_stats_bak` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gameId` bigint(20) unsigned NOT NULL,
  `playerId` mediumint(8) unsigned NOT NULL,
  `AI` tinyint(1) NOT NULL,
  `faction` tinyint(3) unsigned NOT NULL,
  `color` tinyint(4) NOT NULL,
  `team` tinyint(3) NOT NULL,
  `place` tinyint(3) unsigned NOT NULL,
  `mean` float unsigned NOT NULL,
  `deviation` float unsigned NOT NULL,
  `after_mean` float DEFAULT NULL,
  `after_deviation` float DEFAULT NULL,
  `score` tinyint(3) NOT NULL,
  `scoreTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playerId` (`playerId`),
  KEY `gameIdIdx` (`gameId`),
  CONSTRAINT `game_player_stats_bak_ibfk_1` FOREIGN KEY (`gameId`) REFERENCES `game_stats_bak` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_player_stats_bak_ibfk_2` FOREIGN KEY (`playerId`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3461162 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_stats`
--

DROP TABLE IF EXISTS `game_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_stats` (
  `id` int(10) unsigned NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gameType` enum('0','1','2','3') NOT NULL,
  `gameMod` tinyint(3) unsigned NOT NULL,
  `host` mediumint(8) unsigned NOT NULL,
  `mapId` mediumint(8) unsigned DEFAULT NULL,
  `gameName` varchar(128) NOT NULL,
  `validity` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `startTime` (`startTime`),
  KEY `fk_game_stats_host` (`host`),
  CONSTRAINT `fk_game_stats_host` FOREIGN KEY (`host`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER map_play_count AFTER INSERT ON game_stats FOR EACH ROW UPDATE table_map_features set times_played = (times_played +1) WHERE map_id = NEW.mapId */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `game_stats_bak`
--

DROP TABLE IF EXISTS `game_stats_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_stats_bak` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `startTime` timestamp NULL DEFAULT NULL,
  `EndTime` timestamp NULL DEFAULT NULL,
  `gameType` enum('0','1','2','3') DEFAULT '0',
  `gameMod` tinyint(3) unsigned DEFAULT NULL,
  `host` mediumint(8) unsigned DEFAULT NULL,
  `mapId` mediumint(8) unsigned DEFAULT NULL COMMENT 'map id',
  `gameName` tinytext,
  `valid` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `gameMod` (`gameMod`),
  KEY `host` (`host`),
  KEY `mapId` (`mapId`),
  KEY `startTime` (`startTime`),
  KEY `endTime` (`EndTime`),
  CONSTRAINT `game_stats_bak_ibfk_1` FOREIGN KEY (`mapId`) REFERENCES `map_version` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `game_stats_bak_ibfk_4` FOREIGN KEY (`gameMod`) REFERENCES `game_featuredMods` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `game_stats_bak_ibfk_5` FOREIGN KEY (`host`) REFERENCES `login` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1996398 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_rating`
--

DROP TABLE IF EXISTS `global_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_rating` (
  `id` mediumint(8) unsigned NOT NULL,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `numGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `IdCnst` FOREIGN KEY (`id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_constraint` FOREIGN KEY (`id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `global_rating_distribution`
--

DROP TABLE IF EXISTS `global_rating_distribution`;
/*!50001 DROP VIEW IF EXISTS `global_rating_distribution`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `global_rating_distribution` AS SELECT 
 1 AS `rating`,
 1 AS `count`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `invalid_game_reasons`
--

DROP TABLE IF EXISTS `invalid_game_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invalid_game_reasons` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `message` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jwt_users`
--

DROP TABLE IF EXISTS `jwt_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jwt_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `public_key` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder1v1_rating`
--

DROP TABLE IF EXISTS `ladder1v1_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder1v1_rating` (
  `id` mediumint(8) unsigned NOT NULL,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `numGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  `winGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `ladder1v1_rating_ibfk_1` FOREIGN KEY (`id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `ladder1v1_rating_distribution`
--

DROP TABLE IF EXISTS `ladder1v1_rating_distribution`;
/*!50001 DROP VIEW IF EXISTS `ladder1v1_rating_distribution`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ladder1v1_rating_distribution` AS SELECT 
 1 AS `rating`,
 1 AS `count`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ladder_division`
--

DROP TABLE IF EXISTS `ladder_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_division` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `league` tinyint(3) unsigned NOT NULL,
  `threshold` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_map`
--

DROP TABLE IF EXISTS `ladder_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_map` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idmap` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idmap` (`idmap`)
) ENGINE=InnoDB AUTO_INCREMENT=414 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_map_2017_01_12`
--

DROP TABLE IF EXISTS `ladder_map_2017_01_12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_map_2017_01_12` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idmap` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idmap` (`idmap`),
  CONSTRAINT `ladder_map_2017_01_12_ibfk_1` FOREIGN KEY (`idmap`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_season_1`
--

DROP TABLE IF EXISTS `ladder_season_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_season_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `league` tinyint(1) unsigned NOT NULL,
  `division` smallint(5) unsigned NOT NULL,
  `score` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idUser` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=3424 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_season_2`
--

DROP TABLE IF EXISTS `ladder_season_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_season_2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `league` tinyint(1) unsigned NOT NULL,
  `division` smallint(5) unsigned NOT NULL,
  `score` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idUser` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=5085 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_season_3`
--

DROP TABLE IF EXISTS `ladder_season_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_season_3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `league` tinyint(1) unsigned NOT NULL,
  `division` smallint(5) unsigned NOT NULL,
  `score` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `league` (`league`),
  KEY `division` (`division`)
) ENGINE=InnoDB AUTO_INCREMENT=8065 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_season_4`
--

DROP TABLE IF EXISTS `ladder_season_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_season_4` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `league` tinyint(1) unsigned NOT NULL,
  `division` smallint(5) unsigned NOT NULL,
  `score` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `league` (`league`),
  KEY `division` (`division`)
) ENGINE=InnoDB AUTO_INCREMENT=5958 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_season_5`
--

DROP TABLE IF EXISTS `ladder_season_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_season_5` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `league` tinyint(1) unsigned NOT NULL,
  `score` float unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `league` (`league`)
) ENGINE=InnoDB AUTO_INCREMENT=34225 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lobby_admin`
--

DROP TABLE IF EXISTS `lobby_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lobby_admin` (
  `user_id` int(11) NOT NULL,
  `group` tinyint(4) NOT NULL COMMENT '0 - no privileges; 1 - moderator, can delete/edit comments and approve broken maps reports; 2 - admin, same as moderator plus can add global bans',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lobby_ban`
--

DROP TABLE IF EXISTS `lobby_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lobby_ban` (
  `idUser` mediumint(8) unsigned NOT NULL,
  `reason` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL DEFAULT '2222-07-21 00:00:00',
  UNIQUE KEY `idUser` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `password` char(77) NOT NULL,
  `email` varchar(254) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `steamid` bigint(20) unsigned DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_agent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_login` (`login`),
  UNIQUE KEY `unique_email` (`email`),
  UNIQUE KEY `steamid` (`steamid`)
) ENGINE=InnoDB AUTO_INCREMENT=211175 DEFAULT CHARSET=latin1 COMMENT='login';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map`
--

DROP TABLE IF EXISTS `map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) NOT NULL,
  `map_type` varchar(15) NOT NULL,
  `battle_type` varchar(15) NOT NULL,
  `author` mediumint(8) unsigned DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `author` (`author`),
  CONSTRAINT `author` FOREIGN KEY (`author`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4760 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `map_statistics`
--

DROP TABLE IF EXISTS `map_statistics`;
/*!50001 DROP VIEW IF EXISTS `map_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `map_statistics` AS SELECT 
 1 AS `map_id`,
 1 AS `downloads`,
 1 AS `plays`,
 1 AS `draws`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `map_version`
--

DROP TABLE IF EXISTS `map_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_version` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `max_players` decimal(2,0) NOT NULL,
  `width` decimal(4,0) NOT NULL,
  `height` decimal(4,0) NOT NULL,
  `version` decimal(4,0) NOT NULL,
  `filename` varchar(200) NOT NULL,
  `ranked` tinyint(1) NOT NULL DEFAULT '1',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `map_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `map_id_version` (`map_id`,`version`),
  CONSTRAINT `map` FOREIGN KEY (`map_id`) REFERENCES `map` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7030 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `map_version_statistics`
--

DROP TABLE IF EXISTS `map_version_statistics`;
/*!50001 DROP VIEW IF EXISTS `map_version_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `map_version_statistics` AS SELECT 
 1 AS `map_version_id`,
 1 AS `downloads`,
 1 AS `plays`,
 1 AS `draws`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `matchmaker_ban`
--

DROP TABLE IF EXISTS `matchmaker_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchmaker_ban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID of this entry.',
  `key` varchar(255) NOT NULL COMMENT 'The message resource key that identifies this entry along with language and region.',
  `language` char(2) NOT NULL COMMENT 'The language that identifies this entry along with key and region.',
  `region` char(2) DEFAULT NULL COMMENT 'The region that identifies this entry along with key and language.',
  `value` text COMMENT 'The message value.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `key_language_region_UNIQUE` (`key`,`language`,`region`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod`
--

DROP TABLE IF EXISTS `mod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `uploader` mediumint(8) unsigned DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `uploader` (`uploader`),
  CONSTRAINT `mod_ibfk_1` FOREIGN KEY (`uploader`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5647 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod_stats`
--

DROP TABLE IF EXISTS `mod_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_stats` (
  `mod_id` mediumint(8) unsigned NOT NULL,
  `likes` float NOT NULL DEFAULT '0',
  `likers` longblob NOT NULL,
  `downloads` mediumint(8) NOT NULL DEFAULT '0',
  `times_played` mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mod_id`),
  CONSTRAINT `mod_stats_ibfk_1` FOREIGN KEY (`mod_id`) REFERENCES `mod` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod_version`
--

DROP TABLE IF EXISTS `mod_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_version` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(40) NOT NULL,
  `type` enum('UI','SIM') NOT NULL COMMENT 'This field can be defined for every version because maybe the author finds a way to turn his SIM mod into an UI mod.',
  `description` longtext NOT NULL,
  `version` smallint(5) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `ranked` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `mod_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `mod_id_version` (`mod_id`,`version`),
  CONSTRAINT `mod_version_ibfk_1` FOREIGN KEY (`mod_id`) REFERENCES `mod` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7685 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `name_history`
--

DROP TABLE IF EXISTS `name_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `name_history` (
  `change_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` mediumint(8) unsigned NOT NULL,
  `previous_name` varchar(20) NOT NULL,
  PRIMARY KEY (`change_time`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `name_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` varchar(36) NOT NULL COMMENT 'A string that identifies the client, preferably a UUID.',
  `name` varchar(100) NOT NULL COMMENT 'Human readable client name.',
  `client_secret` varchar(55) NOT NULL COMMENT 'The client''s secret, a random string.',
  `client_type` enum('confidential','public') NOT NULL DEFAULT 'public' COMMENT 'A string represents if the client is confidential or public.',
  `redirect_uris` text NOT NULL COMMENT 'A space delimited list of redirect URIs.',
  `default_redirect_uri` varchar(2000) NOT NULL COMMENT 'One of the redirect uris.',
  `default_scope` text NOT NULL COMMENT 'A space delimited list of default scopes of the client.',
  `icon_url` varchar(2000) DEFAULT NULL COMMENT 'URL to a square image representing the client.',
  `auto_approve_scopes` text COMMENT 'A space delimited list of scopes that don''t need to be approved by the user.',
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `client_id_UNIQUE` (`id`),
  UNIQUE KEY `client_secret_UNIQUE` (`client_secret`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_tokens`
--

DROP TABLE IF EXISTS `oauth_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented, technical ID.',
  `token_type` varchar(45) NOT NULL,
  `access_token` varchar(36) NOT NULL COMMENT 'A string token (UUID).',
  `refresh_token` varchar(36) DEFAULT NULL COMMENT 'A string token (UUID).',
  `client_id` varchar(36) NOT NULL COMMENT 'ID of the client (FK).',
  `scope` text NOT NULL COMMENT 'A space delimited list of scopes.',
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Expiration time of the token.',
  `user_id` int(10) unsigned NOT NULL COMMENT 'ID of the user (FK).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35500 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patchs_table`
--

DROP TABLE IF EXISTS `patchs_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patchs_table` (
  `idpatchs_table` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fromMd5` varchar(45) DEFAULT NULL,
  `toMd5` varchar(45) DEFAULT NULL,
  `patchFile` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idpatchs_table`)
) ENGINE=InnoDB AUTO_INCREMENT=11225 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_achievements`
--

DROP TABLE IF EXISTS `player_achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_achievements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The ID of the player achievement.',
  `player_id` mediumint(8) unsigned NOT NULL,
  `achievement_id` varchar(36) NOT NULL COMMENT 'The ID of the referenced achievement (FK).',
  `current_steps` int(10) unsigned DEFAULT NULL COMMENT 'The current steps for an incremental achievement.',
  `state` enum('HIDDEN','REVEALED','UNLOCKED') NOT NULL COMMENT 'The state of the achievement. \nPossible values are:\n"HIDDEN" - Achievement is hidden.\n"REVEALED" - Achievement is revealed.\n"UNLOCKED" - Achievement is unlocked.',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `player_achievement_UNIQUE` (`player_id`,`achievement_id`),
  KEY `fk_achievement` (`achievement_id`),
  CONSTRAINT `fk_achievement` FOREIGN KEY (`achievement_id`) REFERENCES `achievement_definitions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_login` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_events`
--

DROP TABLE IF EXISTS `player_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID of this entry.',
  `player_id` int(10) unsigned NOT NULL COMMENT 'The ID of the player that triggered this event.',
  `event_id` varchar(36) NOT NULL COMMENT 'The ID of the event definition.',
  `count` int(10) unsigned NOT NULL COMMENT 'The current number of times this event has occurred.',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `event_player_UNIQUE` (`player_id`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recoveryemails_enc`
--

DROP TABLE IF EXISTS `recoveryemails_enc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recoveryemails_enc` (
  `ID` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `UserID` mediumint(8) unsigned NOT NULL,
  `Key` varchar(32) NOT NULL,
  `expDate` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `recoveryemails_enc_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62469 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `steam_link_request`
--

DROP TABLE IF EXISTS `steam_link_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `steam_link_request` (
  `uid` varchar(255) NOT NULL,
  `Key` varchar(255) NOT NULL,
  `expDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_answers`
--

DROP TABLE IF EXISTS `survey_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `option_id` int(11) NOT NULL,
  `response` text CHARACTER SET utf8 COMMENT 'Should be populated only if corresponding survey_question_option.open_response column is true',
  `valid` tinyint(4) NOT NULL DEFAULT '1',
  `ip` varchar(15) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `option_id` (`option_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `survey_answers_ibfk_1` FOREIGN KEY (`option_id`) REFERENCES `survey_question_options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `survey_answers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_question_options`
--

DROP TABLE IF EXISTS `survey_question_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_question_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `option` text CHARACTER SET utf8 NOT NULL,
  `open_response` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If the answer allows for custom user input, user reponse should be put in corresponding survey_ansers.response column',
  `display_order` smallint(6) DEFAULT NULL COMMENT 'Relative to all questions found under one qustion_id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `survey_question_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `survey_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_questions`
--

DROP TABLE IF EXISTS `survey_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) NOT NULL,
  `question` text CHARACTER SET utf8 NOT NULL,
  `multi_answer` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If user can select multiple options',
  `display_order` smallint(6) DEFAULT NULL COMMENT 'Relative to all questions found under one survey_id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `survey_id` (`survey_id`),
  CONSTRAINT `survey_questions_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `author_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `surveys_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `swiss_tournaments`
--

DROP TABLE IF EXISTS `swiss_tournaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swiss_tournaments` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `host` mediumint(8) unsigned DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `minplayers` smallint(6) DEFAULT NULL,
  `maxplayers` smallint(6) DEFAULT NULL,
  `minrating` int(11) DEFAULT NULL,
  `maxrating` int(11) DEFAULT NULL,
  `tourney_date` datetime DEFAULT NULL,
  `tourney_state` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host` (`host`),
  CONSTRAINT `swiss_tournaments_ibfk_1` FOREIGN KEY (`host`) REFERENCES `login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `swiss_tournaments_players`
--

DROP TABLE IF EXISTS `swiss_tournaments_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swiss_tournaments_players` (
  `id` smallint(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idtourney` mediumint(8) unsigned NOT NULL,
  `iduser` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idtourney` (`idtourney`,`iduser`),
  KEY `tournament` (`idtourney`),
  KEY `iduser` (`iduser`),
  CONSTRAINT `swiss_tournaments_players_ibfk_3` FOREIGN KEY (`idtourney`) REFERENCES `swiss_tournaments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `swiss_tournaments_players_ibfk_4` FOREIGN KEY (`iduser`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=597 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `table_map`
--

DROP TABLE IF EXISTS `table_map`;
/*!50001 DROP VIEW IF EXISTS `table_map`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `table_map` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `description`,
 1 AS `max_players`,
 1 AS `map_type`,
 1 AS `battle_type`,
 1 AS `map_sizeX`,
 1 AS `map_sizeY`,
 1 AS `version`,
 1 AS `filename`,
 1 AS `hidden`,
 1 AS `mapuid`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `table_map_comments`
--

DROP TABLE IF EXISTS `table_map_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_map_comments` (
  `comment_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `map_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `comment_text` text NOT NULL,
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `map_id` (`map_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `table_map_comments_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `table_map_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3594 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `table_map_features`
--

DROP TABLE IF EXISTS `table_map_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_map_features` (
  `map_id` mediumint(8) unsigned NOT NULL,
  `rating` float NOT NULL DEFAULT '0',
  `voters` text NOT NULL,
  `downloads` int(11) NOT NULL DEFAULT '0',
  `times_played` int(11) NOT NULL DEFAULT '0',
  `num_draws` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`map_id`),
  CONSTRAINT `table_map_features_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `table_mod`
--

DROP TABLE IF EXISTS `table_mod`;
/*!50001 DROP VIEW IF EXISTS `table_mod`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `table_mod` AS SELECT 
 1 AS `id`,
 1 AS `uid`,
 1 AS `name`,
 1 AS `version`,
 1 AS `author`,
 1 AS `ui`,
 1 AS `date`,
 1 AS `downloads`,
 1 AS `likes`,
 1 AS `played`,
 1 AS `description`,
 1 AS `likers`,
 1 AS `filename`,
 1 AS `icon`,
 1 AS `ranked`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `teamkills`
--

DROP TABLE IF EXISTS `teamkills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teamkills` (
  `id` int(11) NOT NULL,
  `teamkiller` mediumint(8) unsigned NOT NULL COMMENT 'login of the player who performed the teamkill',
  `victim` mediumint(8) unsigned NOT NULL COMMENT 'login of the player who got teamkilled and reported the tk',
  `game_id` int(10) unsigned NOT NULL COMMENT 'game-id where teamkill was performed',
  `gametime` mediumint(8) unsigned NOT NULL COMMENT 'time of game in seconds when tk was performed',
  `reported_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  KEY `teamkiller_fk` (`teamkiller`),
  KEY `victim_fk` (`victim`),
  CONSTRAINT `teamkiller_fk` FOREIGN KEY (`teamkiller`) REFERENCES `login` (`id`),
  CONSTRAINT `victim_fk` FOREIGN KEY (`victim`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutorial_sections`
--

DROP TABLE IF EXISTS `tutorial_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorial_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutorials`
--

DROP TABLE IF EXISTS `tutorials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL,
  `url` varchar(45) NOT NULL,
  `map` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sectionIdx` (`section`),
  CONSTRAINT `tutorials_ibfk_1` FOREIGN KEY (`section`) REFERENCES `tutorial_sections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unique_id_users`
--

DROP TABLE IF EXISTS `unique_id_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_id_users` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `uniqueid_hash` char(32) NOT NULL,
  PRIMARY KEY (`user_id`,`uniqueid_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unique_id_users_old`
--

DROP TABLE IF EXISTS `unique_id_users_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_id_users_old` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `uniqueid_hash` char(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uniqueid`
--

DROP TABLE IF EXISTS `uniqueid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uniqueid` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `hash` char(32) DEFAULT NULL,
  `uuid` varchar(255) NOT NULL,
  `mem_SerialNumber` varchar(255) NOT NULL,
  `deviceID` varchar(255) NOT NULL,
  `manufacturer` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `processorId` varchar(255) NOT NULL,
  `SMBIOSBIOSVersion` varchar(255) NOT NULL,
  `serialNumber` varchar(255) NOT NULL,
  `volumeSerialNumber` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_hash_index` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uniqueid_exempt`
--

DROP TABLE IF EXISTS `uniqueid_exempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uniqueid_exempt` (
  `user_id` mediumint(8) unsigned DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  UNIQUE KEY `idUser` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_balancetesting`
--

DROP TABLE IF EXISTS `updates_balancetesting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_balancetesting` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_balancetesting_files`
--

DROP TABLE IF EXISTS `updates_balancetesting_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_balancetesting_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=1128 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_blackops`
--

DROP TABLE IF EXISTS `updates_blackops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_blackops` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_blackops_files`
--

DROP TABLE IF EXISTS `updates_blackops_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_blackops_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_civilians`
--

DROP TABLE IF EXISTS `updates_civilians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_civilians` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_civilians_files`
--

DROP TABLE IF EXISTS `updates_civilians_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_civilians_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_claustrophobia`
--

DROP TABLE IF EXISTS `updates_claustrophobia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_claustrophobia` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_claustrophobia_files`
--

DROP TABLE IF EXISTS `updates_claustrophobia_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_claustrophobia_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_coop`
--

DROP TABLE IF EXISTS `updates_coop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_coop` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_coop_files`
--

DROP TABLE IF EXISTS `updates_coop_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_coop_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_diamond`
--

DROP TABLE IF EXISTS `updates_diamond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_diamond` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_diamond_files`
--

DROP TABLE IF EXISTS `updates_diamond_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_diamond_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_engyredesign`
--

DROP TABLE IF EXISTS `updates_engyredesign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_engyredesign` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_engyredesign_files`
--

DROP TABLE IF EXISTS `updates_engyredesign_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_engyredesign_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_equilibrium`
--

DROP TABLE IF EXISTS `updates_equilibrium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_equilibrium` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_equilibrium_files`
--

DROP TABLE IF EXISTS `updates_equilibrium_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_equilibrium_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_faf`
--

DROP TABLE IF EXISTS `updates_faf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_faf` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_faf_files`
--

DROP TABLE IF EXISTS `updates_faf_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_faf_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafbeta`
--

DROP TABLE IF EXISTS `updates_fafbeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafbeta` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafbeta_files`
--

DROP TABLE IF EXISTS `updates_fafbeta_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafbeta_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=813 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafdevelop`
--

DROP TABLE IF EXISTS `updates_fafdevelop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafdevelop` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafdevelop_files`
--

DROP TABLE IF EXISTS `updates_fafdevelop_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafdevelop_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=1902 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_gw`
--

DROP TABLE IF EXISTS `updates_gw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_gw` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_gw_files`
--

DROP TABLE IF EXISTS `updates_gw_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_gw_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_koth`
--

DROP TABLE IF EXISTS `updates_koth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_koth` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_koth_files`
--

DROP TABLE IF EXISTS `updates_koth_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_koth_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_labwars`
--

DROP TABLE IF EXISTS `updates_labwars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_labwars` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_labwars_files`
--

DROP TABLE IF EXISTS `updates_labwars_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_labwars_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_matchmaker`
--

DROP TABLE IF EXISTS `updates_matchmaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_matchmaker` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_matchmaker_files`
--

DROP TABLE IF EXISTS `updates_matchmaker_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_matchmaker_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_murderparty`
--

DROP TABLE IF EXISTS `updates_murderparty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_murderparty` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_murderparty_files`
--

DROP TABLE IF EXISTS `updates_murderparty_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_murderparty_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_nomads`
--

DROP TABLE IF EXISTS `updates_nomads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_nomads` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_nomads_files`
--

DROP TABLE IF EXISTS `updates_nomads_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_nomads_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_phantomx`
--

DROP TABLE IF EXISTS `updates_phantomx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_phantomx` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_phantomx_files`
--

DROP TABLE IF EXISTS `updates_phantomx_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_phantomx_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_supremeDestruction`
--

DROP TABLE IF EXISTS `updates_supremeDestruction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_supremeDestruction` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_supremeDestruction_files`
--

DROP TABLE IF EXISTS `updates_supremeDestruction_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_supremeDestruction_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_vanilla`
--

DROP TABLE IF EXISTS `updates_vanilla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_vanilla` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_vanilla_files`
--

DROP TABLE IF EXISTS `updates_vanilla_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_vanilla_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_wyvern`
--

DROP TABLE IF EXISTS `updates_wyvern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_wyvern` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_wyvern_files`
--

DROP TABLE IF EXISTS `updates_wyvern_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_wyvern_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_xtremewars`
--

DROP TABLE IF EXISTS `updates_xtremewars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_xtremewars` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_xtremewars_files`
--

DROP TABLE IF EXISTS `updates_xtremewars_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_xtremewars_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version_lobby`
--

DROP TABLE IF EXISTS `version_lobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_lobby` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file` varchar(100) DEFAULT NULL,
  `version` varchar(100) NOT NULL COMMENT 'Current version of the official client',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vm_exempt`
--

DROP TABLE IF EXISTS `vm_exempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_exempt` (
  `idUser` mediumint(8) unsigned DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  UNIQUE KEY `idUser` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `achievement_statistics`
--

/*!50001 DROP VIEW IF EXISTS `achievement_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER */
/*!50001 VIEW `achievement_statistics` AS select `unlock_stats`.`achievement_id` AS `achievement_id`,coalesce(`unlock_stats`.`COUNT`,0) AS `unlockers_count`,coalesce(round((100 * (`unlock_stats`.`COUNT` / `achievers_count`.`COUNT`)),2),0) AS `unlockers_percent`,`unlock_stats`.`min_time` AS `unlockers_min_duration`,`unlock_stats`.`avg_time` AS `unlockers_avg_duration`,`unlock_stats`.`max_time` AS `unlockers_max_duration` from ((`faf_lobby`.`achievement_definitions` `ach` join (select `pa`.`achievement_id` AS `achievement_id`,count(0) AS `COUNT`,round(min(timestampdiff(SECOND,greatest(`ach`.`create_time`,`faf_lobby`.`login`.`create_time`),`pa`.`update_time`)),0) AS `min_time`,round(avg(timestampdiff(SECOND,greatest(`ach`.`create_time`,`faf_lobby`.`login`.`create_time`),`pa`.`update_time`)),0) AS `avg_time`,round(max(timestampdiff(SECOND,greatest(`ach`.`create_time`,`faf_lobby`.`login`.`create_time`),`pa`.`update_time`)),0) AS `max_time` from ((`faf_lobby`.`achievement_definitions` `ach` left join `faf_lobby`.`player_achievements` `pa` on((`pa`.`achievement_id` = `ach`.`id`))) left join `faf_lobby`.`login` on((`faf_lobby`.`login`.`id` = `pa`.`player_id`))) where (`pa`.`state` = 'UNLOCKED') group by `pa`.`achievement_id`) `unlock_stats` on((`unlock_stats`.`achievement_id` = `ach`.`id`))) join (select count(0) AS `COUNT` from `faf_lobby`.`login` where `faf_lobby`.`login`.`id` in (select `faf_lobby`.`player_achievements`.`player_id` from `faf_lobby`.`player_achievements`)) `achievers_count`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `global_rating_distribution`
--

/*!50001 DROP VIEW IF EXISTS `global_rating_distribution`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `global_rating_distribution` AS select (floor(((`global_rating`.`mean` - (3 * `global_rating`.`deviation`)) / 100)) * 100) AS `rating`,count(0) AS `count` from `global_rating` where ((`global_rating`.`is_active` = 1) and (`global_rating`.`numGames` > 0)) group by `rating` order by cast(`rating` as signed) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ladder1v1_rating_distribution`
--

/*!50001 DROP VIEW IF EXISTS `ladder1v1_rating_distribution`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ladder1v1_rating_distribution` AS select (floor(((`ladder1v1_rating`.`mean` - (3 * `ladder1v1_rating`.`deviation`)) / 100)) * 100) AS `rating`,count(0) AS `count` from `ladder1v1_rating` where ((`ladder1v1_rating`.`is_active` = 1) and (`ladder1v1_rating`.`numGames` > 0)) group by `rating` order by cast(`rating` as signed) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `map_statistics`
--

/*!50001 DROP VIEW IF EXISTS `map_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `map_statistics` AS select `map_version`.`map_id` AS `map_id`,sum(`table_map_features`.`downloads`) AS `downloads`,sum(`table_map_features`.`times_played`) AS `plays`,sum(`table_map_features`.`num_draws`) AS `draws` from (`table_map_features` join `map_version` on((`map_version`.`id` = `table_map_features`.`map_id`))) group by `map_version`.`map_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `map_version_statistics`
--

/*!50001 DROP VIEW IF EXISTS `map_version_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `map_version_statistics` AS select `table_map_features`.`map_id` AS `map_version_id`,`table_map_features`.`downloads` AS `downloads`,`table_map_features`.`times_played` AS `plays`,`table_map_features`.`num_draws` AS `draws` from `table_map_features` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `table_map`
--

/*!50001 DROP VIEW IF EXISTS `table_map`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `table_map` AS (select `v`.`id` AS `id`,`m`.`display_name` AS `name`,`v`.`description` AS `description`,`v`.`max_players` AS `max_players`,`m`.`map_type` AS `map_type`,`m`.`battle_type` AS `battle_type`,`v`.`width` AS `map_sizeX`,`v`.`height` AS `map_sizeY`,`v`.`version` AS `version`,`v`.`filename` AS `filename`,`v`.`hidden` AS `hidden`,`m`.`id` AS `mapuid` from (`map` `m` join `map_version` `v` on((`m`.`id` = `v`.`map_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `table_mod`
--

/*!50001 DROP VIEW IF EXISTS `table_mod`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER */
/*!50001 VIEW `table_mod` AS select `v`.`id` AS `id`,`v`.`uid` AS `uid`,`m`.`display_name` AS `name`,`v`.`version` AS `version`,`m`.`author` AS `author`,(case `v`.`type` when 'UI' then 1 when 'SIM' then 0 end) AS `ui`,`v`.`create_time` AS `date`,coalesce(`s`.`downloads`,0) AS `downloads`,coalesce(`s`.`likes`,0) AS `likes`,coalesce(`s`.`times_played`,0) AS `played`,`v`.`description` AS `description`,`s`.`likers` AS `likers`,`v`.`filename` AS `filename`,`v`.`icon` AS `icon`,`v`.`ranked` AS `ranked` from ((`mod` `m` join `mod_version` `v` on((`m`.`id` = `v`.`mod_id`))) left join `mod_stats` `s` on((`m`.`id` = `s`.`mod_id`))) where (`v`.`hidden` = 0) */;
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

-- Dump completed on 2017-05-11 22:59:29
