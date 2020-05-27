-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: St 27.Máj 2020, 17:21
-- Verzia serveru: 10.4.11-MariaDB
-- Verzia PHP: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `essentialmode`
--

DELIMITER $$
--
-- Procedúry
--
CREATE DEFINER=`root`@`%` PROCEDURE `ADD_COLUMN_IN_NOT_EXISTS` (IN `dbName` TINYTEXT, IN `tableName` TINYTEXT, IN `fieldName` TINYTEXT, IN `fieldDef` TEXT)  BEGIN
  IF NOT EXISTS (
    SELECT * FROM information_schema.COLUMNS
    WHERE `column_name`  = fieldName
    AND   `table_name`   = tableName
    AND   `table_schema` = dbName
  )
  THEN
    SET @ddl=CONCAT('ALTER TABLE ', dbName, '.', tableName, ' ADD COLUMN ', fieldName, ' ', fieldDef);
    PREPARE stmt from @ddl;
    EXECUTE stmt;
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('caution', 'caution', 0),
('property_black_money', 'Argent Sale Propriété', 0),
('society_ambulance', 'EMS', 1),
('society_cardealer', 'Concessionnaire', 1),
('society_mafia', 'Mafia', 1),
('society_mecano', 'Mechanic', 1),
('society_police', 'Police', 1),
('society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'society_ambulance', 0, NULL),
(2, 'society_cardealer', 0, NULL),
(3, 'society_mafia', 0, NULL),
(4, 'society_mecano', 0, NULL),
(5, 'society_police', 999999999, NULL),
(6, 'society_taxi', 0, NULL),
(8, 'caution', 0, 'steam:11000011488633d'),
(9, 'caution', 0, 'steam:110000119bffa22'),
(10, 'caution', 0, 'steam:110000137dfca7f'),
(11, 'caution', 0, 'steam:11000011c573ef6'),
(12, 'caution', 0, 'steam:110000115cf38b3'),
(13, 'property_black_money', 0, 'steam:11000011488633d'),
(14, 'property_black_money', 0, 'steam:110000119bffa22');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('property', 'Propriété', 0),
('society_ambulance', 'EMS', 1),
('society_cardealer', 'Concesionnaire', 1),
('society_mafia', 'Mafia', 1),
('society_mecano', 'Mechanic', 1),
('society_police', 'Police', 1),
('society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `arrests_list`
--

CREATE TABLE `arrests_list` (
  `id` int(11) NOT NULL,
  `json_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `sender` varchar(40) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `bolos_list`
--

CREATE TABLE `bolos_list` (
  `id` int(11) NOT NULL,
  `json_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `bwh_bans`
--

CREATE TABLE `bwh_bans` (
  `id` int(11) NOT NULL,
  `receiver` text NOT NULL,
  `sender` varchar(60) NOT NULL,
  `length` datetime DEFAULT NULL,
  `reason` text NOT NULL,
  `unbanned` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `bwh_identifiers`
--

CREATE TABLE `bwh_identifiers` (
  `steam` varchar(60) NOT NULL,
  `license` varchar(60) NOT NULL,
  `ip` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `xbl` varchar(60) DEFAULT NULL,
  `live` varchar(60) DEFAULT NULL,
  `discord` varchar(60) DEFAULT NULL,
  `fivem` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `bwh_identifiers`
--

INSERT INTO `bwh_identifiers` (`steam`, `license`, `ip`, `name`, `xbl`, `live`, `discord`, `fivem`) VALUES
('steam:11000011488633d', 'license:b2e61faa40b22864be1664bb23ab2086c49a9046', 'ip:178.255.168.94', 'Honza_X', 'xbl:2535419641290304', 'live:1055518553934770', 'discord:240522805731393537', NULL),
('steam:110000115cf38b3', 'license:0e9eee3fbe6feff93578a99b4f8cd1ada73299c0', 'ip:95.102.26.235', 'AreSS', 'xbl:2535413298409699', 'live:985153869205081', 'discord:563856575354109972', NULL),
('steam:110000119bffa22', 'license:dbeb3e7e31fe668b6c63bcea96cc4c09519fcd4d', 'ip:81.92.252.25', 'Benik', 'xbl:2535420719927773', 'live:1055518904490302', 'discord:605107764565639182', NULL),
('steam:11000011c573ef6', 'license:05042533bb520f48a5c07416d6a850a8efefda04', 'ip:88.212.43.50', 'Vipkor_234', 'xbl:2535463747248514', 'live:985153859077689', 'discord:520312622764261381', NULL),
('steam:110000137dfca7f', 'license:538326f948f350bae4caa6f54b6a48f0b0eddebc', 'ip:185.193.86.254', 'Kubber_CZ', 'xbl:2535427323982289', 'live:985157446988255', 'discord:340033662995267586', NULL),
('steam:11000013df78852', 'license:f8cb9fcec19d5dfeec67d3e9cdc2d72edc5c1ca8', 'ip:185.112.167.43', 'tartlpxd', NULL, NULL, 'discord:704308815616671766', NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `bwh_warnings`
--

CREATE TABLE `bwh_warnings` (
  `id` int(11) NOT NULL,
  `receiver` text NOT NULL,
  `sender` varchar(60) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `calls`
--

CREATE TABLE `calls` (
  `callid` mediumint(9) NOT NULL,
  `type` mediumtext NOT NULL,
  `location` mediumtext NOT NULL,
  `description` mediumtext NOT NULL,
  `police_grade` mediumtext NOT NULL,
  `rmu_grade` mediumtext NOT NULL,
  `channel` mediumtext NOT NULL,
  `caller` mediumint(9) NOT NULL,
  `status` mediumint(9) NOT NULL,
  `dateline` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `cardealer_vehicles`
--

CREATE TABLE `cardealer_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `characters`
--

CREATE TABLE `characters` (
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'f',
  `height` varchar(128) NOT NULL,
  `lastdigits` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `characters`
--

INSERT INTO `characters` (`identifier`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `lastdigits`) VALUES
('steam:110000119bffa22', 'Josephi', 'Krakowski', '1998/11/27', 'm', '180', NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `character_current`
--

CREATE TABLE `character_current` (
  `cid` varchar(255) NOT NULL,
  `model` longtext NOT NULL DEFAULT '',
  `drawables` longtext NOT NULL DEFAULT '',
  `props` longtext NOT NULL DEFAULT '',
  `drawtextures` longtext NOT NULL DEFAULT '',
  `proptextures` longtext NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `character_face`
--

CREATE TABLE `character_face` (
  `identifier` varchar(255) NOT NULL,
  `hairColor` varchar(255) NOT NULL DEFAULT '',
  `headBlend` varchar(255) NOT NULL DEFAULT '',
  `headStructure` varchar(255) NOT NULL DEFAULT '',
  `headOverlay` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `civilians`
--

CREATE TABLE `civilians` (
  `civid` bigint(20) NOT NULL,
  `name` mediumtext NOT NULL,
  `dob` mediumtext NOT NULL,
  `address` mediumtext NOT NULL,
  `markers` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `civilian_notes`
--

CREATE TABLE `civilian_notes` (
  `noteid` bigint(20) NOT NULL,
  `civid` int(11) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `note` mediumtext NOT NULL,
  `dateline` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `communityservice`
--

CREATE TABLE `communityservice` (
  `identifier` varchar(100) NOT NULL,
  `actions_remaining` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `companies`
--

CREATE TABLE `companies` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `investRate` float DEFAULT NULL,
  `rate` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT 'stale'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Sťahujem dáta pre tabuľku `companies`
--

INSERT INTO `companies` (`name`, `label`, `investRate`, `rate`) VALUES
('24/7', 'TNYFVN', -2.57, 'down'),
('Ammu-Nation', 'AMNA', 1.56, 'up'),
('Augury Insurance', 'AUGIN', 0.87, 'up'),
('Downtown Cab Co.', 'DCC', 2.22, 'up'),
('ECola', 'ECLA', 2.07, 'down'),
('Fleeca', 'FLCA', 0.54, 'down'),
('Globe Oil', 'GLBO', -2.96, 'up'),
('GoPostal', 'GPSTL', -1.09, 'up'),
('Lifeinvader', 'LIVDR', 2.76, 'up'),
('Los Santos Air', 'LSA', -2.86, 'up'),
('Los Santos Customs', 'LSC', -1.67, 'up'),
('Los Santos Transit', 'LST', 0.41, 'down'),
('Maze Bank', 'MBANK', -3.64, 'down'),
('Post OP', 'PSTP', -0.43, 'down'),
('RON', 'RON', -1.22, 'down'),
('Up-n-Atom Burger', 'UNAB', 3.52, 'up'),
('Weazel', 'NEWS', 0.53, 'up');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('property', 'Propriété', 0),
('society_ambulance', 'EMS', 1),
('society_mafia', 'Mafia', 1),
('society_police', 'Police', 1),
('user_ears', 'Ears', 0),
('user_glasses', 'Glasses', 0),
('user_helmet', 'Helmet', 0),
('user_mask', 'Mask', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'society_ambulance', NULL, '{}'),
(2, 'society_mafia', NULL, '{}'),
(3, 'society_police', NULL, '{}'),
(4, 'user_mask', 'steam:11000011488633d', '{}'),
(5, 'user_ears', 'steam:11000011488633d', '{}'),
(6, 'property', 'steam:11000011488633d', '{\"dressing\":[{\"label\":\"sdsds\",\"skin\":{\"sun_2\":0,\"pants_1\":0,\"makeup_2\":0,\"helmet_1\":-1,\"tshirt_1\":4,\"lipstick_3\":0,\"chest_1\":0,\"bags_2\":0,\"chain_1\":0,\"beard_1\":0,\"chest_2\":0,\"sex\":0,\"arms_2\":0,\"blush_1\":0,\"hair_color_2\":0,\"torso_2\":0,\"hair_1\":21,\"makeup_3\":0,\"eyebrows_2\":0,\"chain_2\":0,\"hair_2\":0,\"lipstick_1\":0,\"moles_2\":0,\"moles_1\":0,\"hair_color_1\":0,\"bproof_1\":0,\"complexion_1\":0,\"bodyb_2\":0,\"pants_2\":0,\"chest_3\":0,\"blush_2\":0,\"blush_3\":0,\"mask_1\":0,\"bracelets_1\":-1,\"mask_2\":0,\"ears_2\":0,\"shoes_2\":0,\"arms\":0,\"glasses_2\":0,\"eyebrows_1\":0,\"bproof_2\":0,\"skin\":0,\"eyebrows_3\":0,\"eyebrows_4\":0,\"sun_1\":0,\"watches_2\":0,\"beard_3\":0,\"bracelets_2\":0,\"beard_2\":0,\"makeup_4\":0,\"bodyb_1\":0,\"blemishes_1\":0,\"ears_1\":-1,\"makeup_1\":0,\"age_1\":0,\"shoes_1\":0,\"lipstick_4\":0,\"decals_2\":0,\"torso_1\":5,\"glasses_1\":0,\"eye_color\":0,\"tshirt_2\":0,\"decals_1\":0,\"bags_1\":0,\"complexion_2\":0,\"blemishes_2\":0,\"watches_1\":-1,\"lipstick_2\":0,\"beard_4\":0,\"face\":0,\"age_2\":0,\"helmet_2\":0}}]}'),
(7, 'user_glasses', 'steam:11000011488633d', '{}'),
(8, 'user_helmet', 'steam:11000011488633d', '{}'),
(9, 'property', 'steam:110000119bffa22', '{}'),
(10, 'user_mask', 'steam:110000119bffa22', '{}'),
(11, 'user_helmet', 'steam:110000119bffa22', '{}'),
(12, 'user_ears', 'steam:110000119bffa22', '{}'),
(13, 'user_glasses', 'steam:110000119bffa22', '{}'),
(14, 'property', 'steam:110000137dfca7f', '{}'),
(15, 'user_helmet', 'steam:110000137dfca7f', '{}'),
(16, 'user_glasses', 'steam:110000137dfca7f', '{}'),
(17, 'user_ears', 'steam:110000137dfca7f', '{}'),
(18, 'user_mask', 'steam:110000137dfca7f', '{}'),
(19, 'user_glasses', 'steam:11000011c573ef6', '{}'),
(20, 'property', 'steam:11000011c573ef6', '{}'),
(21, 'user_ears', 'steam:11000011c573ef6', '{}'),
(22, 'user_helmet', 'steam:11000011c573ef6', '{}'),
(23, 'user_mask', 'steam:11000011c573ef6', '{}'),
(24, 'property', 'steam:110000115cf38b3', '{}'),
(25, 'user_ears', 'steam:110000115cf38b3', '{}'),
(26, 'user_glasses', 'steam:110000115cf38b3', '{}'),
(27, 'user_helmet', 'steam:110000115cf38b3', '{}'),
(28, 'user_mask', 'steam:110000115cf38b3', '{}');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `disc_inventory`
--

CREATE TABLE `disc_inventory` (
  `id` int(11) NOT NULL,
  `owner` text NOT NULL,
  `type` text DEFAULT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `disc_inventory_itemdata`
--

CREATE TABLE `disc_inventory_itemdata` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `description` text DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `closeonuse` tinyint(1) NOT NULL DEFAULT 0,
  `max` int(11) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `fine_types`
--

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
(1, 'Misuse of a horn', 30, 0),
(2, 'Illegally Crossing a continuous Line', 40, 0),
(3, 'Driving on the wrong side of the road', 250, 0),
(4, 'Illegal U-Turn', 250, 0),
(5, 'Illegally Driving Off-road', 170, 0),
(6, 'Refusing a Lawful Command', 30, 0),
(7, 'Illegally Stopping a Vehicle', 150, 0),
(8, 'Illegal Parking', 70, 0),
(9, 'Failing to Yield to the right', 70, 0),
(10, 'Failure to comply with Vehicle Information', 90, 0),
(11, 'Failing to stop at a Stop Sign ', 105, 0),
(12, 'Failing to stop at a Red Light', 130, 0),
(13, 'Illegal Passing', 100, 0),
(14, 'Driving an illegal Vehicle', 100, 0),
(15, 'Driving without a License', 1500, 0),
(16, 'Hit and Run', 800, 0),
(17, 'Exceeding Speeds Over < 5 mph', 90, 0),
(18, 'Exceeding Speeds Over 5-15 mph', 120, 0),
(19, 'Exceeding Speeds Over 15-30 mph', 180, 0),
(20, 'Exceeding Speeds Over > 30 mph', 300, 0),
(21, 'Impeding traffic flow', 110, 1),
(22, 'Public Intoxication', 90, 1),
(23, 'Disorderly conduct', 90, 1),
(24, 'Obstruction of Justice', 130, 1),
(25, 'Insults towards Civilans', 75, 1),
(26, 'Disrespecting of an LEO', 110, 1),
(27, 'Verbal Threat towards a Civilan', 90, 1),
(28, 'Verbal Threat towards an LEO', 150, 1),
(29, 'Providing False Information', 250, 1),
(30, 'Attempt of Corruption', 1500, 1),
(31, 'Brandishing a weapon in city Limits', 120, 2),
(32, 'Brandishing a Lethal Weapon in city Limits', 300, 2),
(33, 'No Firearms License', 600, 2),
(34, 'Possession of an Illegal Weapon', 700, 2),
(35, 'Possession of Burglary Tools', 300, 2),
(36, 'Grand Theft Auto', 1800, 2),
(37, 'Intent to Sell/Distrube of an illegal Substance', 1500, 2),
(38, 'Frabrication of an Illegal Substance', 1500, 2),
(39, 'Possession of an Illegal Substance ', 650, 2),
(40, 'Kidnapping of a Civilan', 1500, 2),
(41, 'Kidnapping of an LEO', 2000, 2),
(42, 'Robbery', 650, 2),
(43, 'Armed Robbery of a Store', 650, 2),
(44, 'Armed Robbery of a Bank', 1500, 2),
(45, 'Assault on a Civilian', 2000, 3),
(46, 'Assault of an LEO', 2500, 3),
(47, 'Attempt of Murder of a Civilian', 3000, 3),
(48, 'Attempt of Murder of an LEO', 5000, 3),
(49, 'Murder of a Civilian', 10000, 3),
(50, 'Murder of an LEO', 30000, 3),
(51, 'Involuntary manslaughter', 1800, 3),
(52, 'Fraud', 2000, 2);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `fine_types_mafia`
--

CREATE TABLE `fine_types_mafia` (
  `id` int(11) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `fine_types_mafia`
--

INSERT INTO `fine_types_mafia` (`id`, `label`, `amount`, `category`) VALUES
(1, 'Raket', 3000, 0),
(2, 'Raket', 5000, 0),
(3, 'Raket', 10000, 1),
(4, 'Raket', 20000, 1),
(5, 'Raket', 50000, 2),
(6, 'Raket', 150000, 3),
(7, 'Raket', 350000, 3);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `glovebox_inventory`
--

CREATE TABLE `glovebox_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `glovebox_inventory`
--

INSERT INTO `glovebox_inventory` (`id`, `plate`, `data`, `owned`) VALUES
(1, '83ZIT836', '{}', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `insto_accounts`
--

CREATE TABLE `insto_accounts` (
  `id` int(11) NOT NULL,
  `forename` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `surname` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `insto_instas`
--

CREATE TABLE `insto_instas` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filters` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `insto_likes`
--

CREATE TABLE `insto_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `inapId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `invest`
--

CREATE TABLE `invest` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `amount` float NOT NULL,
  `rate` float NOT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `sold` datetime DEFAULT NULL,
  `soldAmount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Sťahujem dáta pre tabuľku `invest`
--

INSERT INTO `invest` (`id`, `identifier`, `amount`, `rate`, `job`, `active`, `created`, `sold`, `soldAmount`) VALUES
(7, 'steam:110000119bffa22', 5.60519e-45, 4.31, 'LIVDR', 1, '2020-05-21 10:56:41', NULL, NULL),
(8, 'steam:110000137dfca7f', 0.00000000369226, 0.45, 'MBANK', 0, '2020-05-21 10:57:49', '2020-05-24 07:23:12', 0.00000000370888);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  `weight` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `items`
--

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`, `weight`) VALUES
('advancedlockpick', 'Multi-pick', 5, 0, 1, 0),
('airbag', 'Airbag', 6, 0, 1, 0),
('alive_chicken', 'Living chicken', 20, 0, 1, 0),
('armor', 'Armor', 2, 0, 1, 0),
('armor2', 'Dense Armor', 2, 0, 1, 0),
('bandage', 'Bandage', 15, 0, 1, 0),
('bandage2', 'Small Bandage', 15, 0, 1, 0),
('battery', 'Car Battery', 5, 0, 1, 0),
('beer', 'Beer', 7, 0, 1, 0),
('blowpipe', 'Blowtorch', 10, 0, 1, 0),
('bread', 'Bread', 15, 0, 1, 0),
('cannabinoid', 'Chemicals', 10, 0, 1, 0),
('cannabis', 'Weed Plant', 10, 0, 1, 0),
('carokit', 'Body Kit', 10, 0, 1, 0),
('carotool', 'Tools', 10, 0, 1, 0),
('cburger', 'Cheese Burger', 3, 0, 1, 0),
('clip', 'Weapon Clip', 5, 0, 1, 0),
('clothe', 'Clothes', 40, 0, 1, 0),
('coffees', 'Hot Coffee', 4, 0, 1, 0),
('coke', 'Koks', -1, 0, 1, 0),
('coke_pooch', 'Portion Koks', -1, 0, 1, 0),
('cola', 'Can of Cola', 4, 0, 1, 0),
('copper', 'Copper', 55, 0, 1, 0),
('crack', 'Crack', 10, 0, 1, 0),
('cutted_wood', 'Cut wood', 30, 0, 1, 0),
('dcburger', 'Double Cheese Burger', 2, 0, 1, 0),
('diamond', 'Diamond', 35, 0, 1, 0),
('essence', 'Gas', 50, 0, 1, 0),
('fabric', 'Fabric', 80, 0, 1, 0),
('fish', 'Fish', 100, 0, 1, 0),
('fishbait', 'Fish Bait', 8, 0, 1, 0),
('fishingrod', 'Fishing rod', 3, 0, 1, 0),
('fixkit', 'Repair Kit', 10, 0, 1, 0),
('fixtool', 'Repair Tools', 10, 0, 1, 0),
('fountain', 'Fountain Firework', 5, 0, 1, 0),
('fries', 'Small Fries', 4, 0, 1, 0),
('fries2', 'Large Fries', 5, 0, 1, 0),
('gazbottle', 'Gas Bottle', 10, 0, 1, 0),
('gold', 'Gold', 45, 0, 1, 0),
('gold_o', 'Scrap gold', 25, 0, 1, 0),
('gold_t', 'Gold', 5, 0, 1, 0),
('highradio', 'Aftermarket Radio', 6, 0, 1, 0),
('highrim', 'Nice Rim', 2, 0, 1, 0),
('hotdog', 'Hotdog', 5, 0, 1, 0),
('iron', 'Iron', 55, 0, 1, 0),
('jewels', 'Jewels', 150, 0, 1, 0),
('licenseplate', 'License plate', 1, 0, 1, 0),
('lowradio', 'Stock Radio', 8, 0, 1, 0),
('marijuana', 'Bag of Weed', 20, 0, 1, 0),
('medikit', 'Medikit', 15, 0, 1, 0),
('meth', 'Meth', -1, 0, 1, 0),
('meth_pooch', 'Portion Meth', -1, 0, 1, 0),
('mleko', 'Milk', 50, 0, 1, 0),
('opium', 'Opium', -1, 0, 1, 0),
('opium_pooch', 'opium_pooch', -1, 0, 1, 0),
('oxygen_mask', 'Oxygen Mask', 2, 0, 1, 0),
('packaged_chicken', 'Chicken fillet', 100, 0, 1, 0),
('packaged_plank', 'Packaged wood', 100, 0, 1, 0),
('petrol', 'Oil', 24, 0, 1, 0),
('petrol_raffin', 'Processed oil', 24, 0, 1, 0),
('radio', 'Radio', 2, 0, 1, 0),
('shotburst', 'Shotburst Firework', 5, 0, 1, 0),
('sim', 'Sim', -1, 0, 1, 0),
('slaughtered_chicken', 'Slaughtered chicken', 25, 0, 1, 0),
('spice', 'Spice', 20, 0, 1, 0),
('sprite', 'Bottle of 7UP', 4, 0, 1, 0),
('starburst', 'Starburst Firework', 5, 0, 1, 0),
('stockrim', 'Stock Rim', 3, 0, 1, 0),
('stone', 'Stone', 10, 0, 1, 0),
('taco', 'Taco', 5, 0, 1, 0),
('taco2', 'Deluxe Taco', 5, 0, 1, 0),
('taco3', 'Steves Special Taco', 5, 0, 1, 0),
('trailburst', 'Trailburst Firework', 5, 0, 1, 0),
('tuning_laptop', 'Tuner Laptop', 2, 0, 1, 0),
('turbo', 'Turbo', 5, 0, 1, 0),
('turtlebait', 'Turtle Bait', 8, 0, 1, 0),
('vodka', 'Vodka', 7, 0, 1, 0),
('washed_stone', 'Washed stone', 10, 0, 1, 0),
('water', 'Water', 15, 0, 1, 0),
('Waters', 'water', -1, 0, 1, 0),
('weed', 'Grass', -1, 0, 1, 0),
('weed_pooch', 'Portion Grass', -1, 0, 1, 0),
('wood', 'Wood', 25, 0, 1, 0),
('wool', 'Wool', 40, 0, 1, 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ambulance', 'EMS', 1),
('cardealer', 'Concessionnaire', 0),
('fisherman', 'Fisherman', 0),
('fueler', 'Fueler', 0),
('krowa', 'Farmer', 0),
('lumberjack', 'Lumberjack', 0),
('mafia', 'Mafia', 1),
('mecano', 'Mechanic', 1),
('miner', 'Miner', 0),
('offambulance', 'Off-Duty', 0),
('offmecano', 'Off-Duty', 0),
('offpolice', 'Off-Duty', 0),
('pawn', 'Pawn', 1),
('police', 'Police', 1),
('reporter', 'Reporter', 0),
('slaughterer', 'Butcher', 0),
('tailor', 'Tailor', 0),
('taxi', 'Taxi', 0),
('unemployed', 'Unemployed', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Unemployed', 5, '{}', '{}'),
(2, 'ambulance', 0, 'ambulance', 'Jr. EMT', 20, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(3, 'ambulance', 1, 'doctor', 'EMT', 40, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(4, 'ambulance', 2, 'chief_doctor', 'Sr. EMT', 60, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(5, 'ambulance', 3, 'boss', 'EMT Supervisor', 80, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(6, 'offpolice', 0, 'recruit', 'Recrue', 5, '{}', '{}'),
(7, 'offpolice', 1, 'officer', 'Officier', 5, '{}', '{}'),
(8, 'offpolice', 2, 'sergeant', 'Sergent', 5, '{}', '{}'),
(9, 'offpolice', 3, 'lieutenant', 'Lieutenant', 6, '{}', '{}'),
(10, 'offpolice', 4, 'boss', 'Commandant', 10, '{}', '{}'),
(11, 'offambulance', 0, 'ambulance', 'Ambulance', 5, '{}', '{}'),
(12, 'offambulance', 1, 'doctor', 'Doctor', 5, '{}', '{}'),
(13, 'offambulance', 2, 'chief_doctor', 'Chief Doctor', 6, '{}', '{}'),
(14, 'offambulance', 3, 'boss', 'Boss', 10, '{}', '{}'),
(15, 'offmecano', 0, 'recrue', 'Technician', 5, '{}', '{}'),
(16, 'offmecano', 1, 'novice', 'Technician', 5, '{}', '{}'),
(17, 'offmecano', 2, 'experimente', 'Technician', 5, '{}', '{}'),
(18, 'offmecano', 3, 'chief', 'Chef déquipe', 6, '{}', '{}'),
(19, 'offmecano', 4, 'boss', 'Patron', 10, '{}', '{}'),
(20, 'lumberjack', 0, 'employee', 'Employee', 35, '{}', '{}'),
(21, 'fisherman', 0, 'employee', 'Employee', 10, '{}', '{}'),
(22, 'fueler', 0, 'employee', 'Employee', 25, '{}', '{}'),
(23, 'reporter', 0, 'employee', 'Employee', 10, '{}', '{}'),
(24, 'tailor', 0, 'employee', 'Employee', 25, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
(25, 'miner', 0, 'employee', 'Employee', 20, '{\"tshirt_2\":1,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":1,\"pants_1\":75,\"shoes_1\":51,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":7,\"torso_1\":71,\"tshirt_1\":59,\"arms\":2,\"bags_2\":0,\"helmet_1\":0}', '{}'),
(26, 'slaughterer', 0, 'employee', 'Employee', 20, '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
(27, 'krowa', 0, 'employee', 'Farmer', 5, '', ''),
(28, 'mafia', 0, 'soldato', 'Ptite-Frappe', 20, '{}', '{}'),
(29, 'mafia', 1, 'capo', 'Capo', 40, '{}', '{}'),
(30, 'mafia', 2, 'consigliere', 'Consigliere', 60, '{}', '{}'),
(31, 'mafia', 3, 'boss', 'Don', 80, '{}', '{}'),
(32, 'mecano', 0, 'recrue', 'Recruit', 20, '{}', '{}'),
(33, 'mecano', 1, 'novice', 'Novice', 40, '{}', '{}'),
(34, 'mecano', 2, 'experimente', 'Experienced', 60, '{}', '{}'),
(35, 'mecano', 3, 'chief', 'Leader', 80, '{}', '{}'),
(36, 'mecano', 4, 'boss', 'Boss', 100, '{}', '{}'),
(37, 'pawn', 0, 'employee', 'Boss', 100, '', ''),
(38, 'police', 0, 'recruit', 'Recruit', 20, '{}', '{}'),
(39, 'police', 1, 'officer', 'Officer', 40, '{}', '{}'),
(40, 'police', 2, 'sergeant', 'Sergeant', 60, '{}', '{}'),
(41, 'police', 3, 'lieutenant', 'Lieutenant', 85, '{}', '{}'),
(42, 'police', 4, 'boss', 'Chief', 100, '{}', '{}'),
(43, 'taxi', 0, 'recrue', 'Speedy Recruit', 12, '{}', '{}'),
(44, 'taxi', 1, 'novice', 'Speedy Novice', 24, '{}', '{}'),
(45, 'taxi', 2, 'experimente', 'Speedy Experimental', 36, '{}', '{}'),
(46, 'taxi', 3, 'uber', 'Speedy Driver', 48, '{}', '{}'),
(47, 'taxi', 4, 'boss', 'Boss', 100, '{}', '{}'),
(56, 'cardealer', 0, 'recruit', 'Recrue', 10, '{}', '{}'),
(57, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
(58, 'cardealer', 2, 'experienced', 'Experimente', 40, '{}', '{}'),
(59, 'cardealer', 3, 'boss', 'Patron', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('aircraft', 'Aircraft License'),
('boating', 'Boating License'),
('coke_processing', 'Coke Processing License'),
('dmv', 'Driving Permit'),
('drive', 'Drivers License'),
('drive_bike', 'Motorcycle License'),
('drive_truck', 'Commercial Drivers License'),
('gold_processing', 'Gold Processing License'),
('spice_processing', 'Spice Processing License'),
('weapon', 'Weapon License'),
('weapon_assault', 'Assault Rifle License'),
('weapon_handgun', 'Handgun License'),
('weapon_lmg', 'LMG License'),
('weapon_melee', 'Melee License'),
('weapon_shotgun', 'Shotgun License'),
('weapon_smg', 'SMG License'),
('weapon_sniper', 'Sniper Rifle License'),
('weed_processing', 'Weed Processing License');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `logs`
--

CREATE TABLE `logs` (
  `logid` bigint(20) NOT NULL,
  `user` mediumtext NOT NULL,
  `content` mediumtext NOT NULL,
  `category` mediumtext NOT NULL,
  `dateline` bigint(20) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT 1 COMMENT '1 = Visible, 0 = Hidden'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `lspd_mdc_judgments_suggestion`
--

CREATE TABLE `lspd_mdc_judgments_suggestion` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `length` int(10) NOT NULL,
  `fee` int(10) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `showName` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `lspd_mdc_judgments_suggestion_category`
--

CREATE TABLE `lspd_mdc_judgments_suggestion_category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `lspd_mdc_tag_suggestion`
--

CREATE TABLE `lspd_mdc_tag_suggestion` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Sťahujem dáta pre tabuľku `lspd_mdc_tag_suggestion`
--

INSERT INTO `lspd_mdc_tag_suggestion` (`id`, `name`, `description`, `type`) VALUES
(1, 'Poszukiwany', 'Obywatel jest aktualnie poszukiwany', 'CITIZEN'),
(2, 'Niebezpieczny', 'Obywatel jest niebezpieczny', 'CITIZEN'),
(3, 'Handlarz narokytków', 'Obywatel jest handlarzem narkotyków', 'CITIZEN'),
(4, 'Handlarz bronią', 'Obywatel jest handlarzem bronią', 'CITIZEN'),
(5, 'Grupa przestępcza', 'Obywatel jest powiązany z grupą przestępczą', 'CITIZEN'),
(6, 'Poszukiwany', 'Pojazd jest aktualnie poszukiwany', 'VEHICLE');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `lspd_mdc_user_notes`
--

CREATE TABLE `lspd_mdc_user_notes` (
  `id` int(11) NOT NULL,
  `userId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `addedBy` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `lspd_mdc_vehicle_notes`
--

CREATE TABLE `lspd_mdc_vehicle_notes` (
  `id` int(11) NOT NULL,
  `vehicleId` int(11) NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `addedBy` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `lspd_user_judgments`
--

CREATE TABLE `lspd_user_judgments` (
  `id` int(11) NOT NULL,
  `userId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `crimes` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `note` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  `addedBy` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `length` int(10) DEFAULT NULL,
  `fee` int(10) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `markers`
--

CREATE TABLE `markers` (
  `id` bigint(20) NOT NULL,
  `acronym` mediumtext NOT NULL,
  `name` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sťahujem dáta pre tabuľku `markers`
--

INSERT INTO `markers` (`id`, `acronym`, `name`) VALUES
(1, 'T1A', 'Assault'),
(2, 'T1AA', 'Assault with a Deadly Weapon'),
(3, 'T1B', 'Battery'),
(4, 'T1BA', 'Battery with Serious Bodily Harm'),
(5, 'T1C', 'False Imprisonment'),
(6, 'T1D', 'Kidnapping'),
(7, 'T1E', 'Attempted Murder'),
(8, 'T1FA', '1st Degree Murder'),
(9, 'T1FB', '2nd Degree Murder'),
(10, 'T1FC', '3rd Degree Murder'),
(11, 'T1GA', 'Voluntary Manslaughter'),
(12, 'T1GB', 'Involuntary Manslaughter'),
(13, 'T1GC', 'Vehicular Manslaughter'),
(14, 'T1H', 'Sexual Battery'),
(15, 'T1I', 'Toture'),
(16, 'T1J', 'Violating A Restraining Order'),
(17, 'T2A', 'Arson'),
(18, 'T2B', 'Trespassing'),
(19, 'T2C', 'Breaking and Entering'),
(20, 'T2D', 'Burglary'),
(21, 'T2E', 'Possession of criminal tools '),
(22, 'T2F', 'Vandalism'),
(23, 'T3A', 'Forgery'),
(24, 'T3B', 'Fraud'),
(25, 'T3C', 'Money Laundering'),
(26, 'T3DA', 'Petty Theft'),
(27, 'T3DB', 'Theft'),
(28, 'T3DC', 'Grand Theft'),
(29, 'T3DD', 'Grand Theft Auto'),
(30, 'T3DE', 'Grand Theft of Firearms'),
(31, 'T3E', 'Receiving Stolen Property'),
(32, 'T3F', 'Robbery'),
(33, 'T3G', 'Armed Robbery'),
(34, 'T3H', 'Extortion'),
(35, 'T3I', 'Counterfeiting'),
(36, 'T3J', 'Embezzlement'),
(37, 'T3K', 'Carjacking'),
(38, 'T4A', 'Bribery'),
(39, 'T4AA', 'Bribery of a Government Official'),
(40, 'T4AB', 'Accepting A Bribe'),
(41, 'T4B', 'Failure To Pay A Fine'),
(42, 'T4C', 'Resisting Arrest'),
(43, 'T4D', 'Escaping Custody'),
(44, 'T4E', 'Obstruction'),
(45, 'T4F', 'Misuse of a Government Helpline'),
(46, 'T4G', 'Human Trafficking'),
(47, 'T4H', 'Aiding and Abetting'),
(48, 'T4I', 'Accessory After The Fact'),
(49, 'T4J', 'Tampering With Evidence'),
(50, 'T4KA', 'Impersonation Of Another Person'),
(51, 'TK4B', 'Impersonation of a Government Official'),
(52, 'T4KC', 'Contempt of Court '),
(53, 'T4L', 'Corruption'),
(54, 'T4LA', 'Corruption of a Public Office'),
(55, 'T4LB', 'Corruption of Public Duty'),
(56, 'T5A', 'Indecent Exposure'),
(57, 'T5B', 'Disturbing the Peace'),
(58, 'T5C', 'Littering'),
(59, 'T5D', 'Unlawful Assembly'),
(60, 'T5E', 'Rioting'),
(61, 'T5EA', 'Participating in a Riot'),
(62, 'T5EB', 'Initiating a Riot'),
(63, 'T5F', 'Prostitution'),
(64, 'T5G', 'Pimping'),
(65, 'T6A', 'Public Intoxication'),
(66, 'T6B', 'Terrorism'),
(67, 'T6C', 'Possession of a controlled substance'),
(68, 'T6D', 'Possession of a controlled substance with intent'),
(69, 'T6E', 'Sale of a Controlled Substance'),
(70, 'T6FA', 'Manufacture of a Controlled Substance'),
(71, 'T6FB', 'Manufacturing of Alcohol without a license'),
(72, 'T6G', 'Sale of Alcohol to a minor'),
(73, 'T7A', 'Eluding / Evading a Peace Officer'),
(74, 'T7B', 'Reckless Elusion / Evasion?'),
(75, 'T7C', 'Hit and Run'),
(76, 'T7D', 'Hit and Run with Injury'),
(77, 'T7E', 'Failure to yield at a stop sign'),
(78, 'T7F', 'Reckless Driving'),
(79, 'T7G', 'Speeding'),
(80, 'T7H', 'Parking Violation'),
(81, 'T7I', 'Illegal Window Tint'),
(82, 'T7J', 'Driving without Valid License'),
(83, 'T7L', 'Failure to show I.D.'),
(84, 'T7M', 'Open Alcohol Container'),
(85, 'T7N', 'Driving Under the Influence'),
(86, 'T7O', 'Driving Under the Influence of Drugs'),
(87, 'T7P', 'Operation of a ATV on Streets/Highways'),
(88, 'T7Q', 'Operation of a Golf Cart on Streets/Highways'),
(89, 'T7R', 'Failure to Display plates'),
(90, 'T7S', 'Engaging in a Speed Contest'),
(91, 'T8A', 'Carrying a concealed weapon'),
(92, 'T8B', 'Possession of an Automatic Assault Rifle'),
(93, 'T8C', 'Felon in possession of a firearm'),
(94, 'T8D', 'High Dangerous Device'),
(95, 'T8E', 'Brandishing a weapon'),
(96, 'T8F', 'Brandishing a firearm'),
(97, 'T8G', 'Drive By Shooting'),
(98, 'T8H', 'General Prohibited weapons violation'),
(99, 'T8I', 'Weapons Discharge Violation'),
(100, 'T8IA', 'Weapons Discharge Violation (In Public)'),
(101, 'T8J', 'Unlawful sale of a firearm'),
(102, 'T8JA', 'Unlawful sale of a firearm to an unlicensed person'),
(103, 'CLEAN', 'CLEAN RECORD');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `mdt_reports`
--

CREATE TABLE `mdt_reports` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `mdt_sessions`
--

CREATE TABLE `mdt_sessions` (
  `id` mediumint(9) NOT NULL,
  `session_id` mediumtext NOT NULL,
  `user_id` mediumint(9) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `timestamp` mediumint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sťahujem dáta pre tabuľku `mdt_sessions`
--

INSERT INTO `mdt_sessions` (`id`, `session_id`, `user_id`, `ip`, `timestamp`) VALUES
(2, 'f5aos3n8mpf9830rosq59ctp8k', 1, '::1', 8388607),
(3, 'tb3l8sk7jeskm08nagbgggpms9', 1, '::1', 8388607),
(14, 'iovf81sg2lf0i10g118r91uld7', 1, '24.165.178.147', 8388607);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `mdt_users`
--

CREATE TABLE `mdt_users` (
  `userid` mediumint(9) NOT NULL,
  `first_name` text NOT NULL,
  `surname` mediumtext NOT NULL,
  `email` mediumtext NOT NULL,
  `steamid` longtext NOT NULL,
  `password` mediumtext NOT NULL,
  `collar` mediumtext NOT NULL,
  `groups` mediumtext NOT NULL,
  `joindate` bigint(20) NOT NULL,
  `theme` int(11) NOT NULL DEFAULT 1,
  `last_ip` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sťahujem dáta pre tabuľku `mdt_users`
--

INSERT INTO `mdt_users` (`userid`, `first_name`, `surname`, `email`, `steamid`, `password`, `collar`, `groups`, `joindate`, `theme`, `last_ip`) VALUES
(1, 'Change', 'Me', 'Changeme@gmail.com', '', '$2y$10$Hd6BbW4F4SNJv1wVq0o6xOHZpdPMoGYYpI.mtZVY3ntkfqveVre/i', '1234', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,', 1530222515, 2, '24.165.178.147');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `mdt_warrants`
--

CREATE TABLE `mdt_warrants` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `messages`
--

CREATE TABLE `messages` (
  `messageid` mediumint(9) NOT NULL,
  `recive` mediumtext NOT NULL,
  `post` mediumtext NOT NULL,
  `content` mediumtext NOT NULL,
  `dateline` bigint(20) NOT NULL,
  `visible` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `migrations`
--

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL,
  `module` varchar(64) DEFAULT NULL,
  `last` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `migrations`
--

INSERT INTO `migrations` (`id`, `module`, `last`) VALUES
(1, 'addonaccount', 0),
(2, 'addoninventory', 0),
(3, 'datastore', 0),
(4, 'accessories', 0),
(5, 'skin', 0),
(6, 'society', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `outfits`
--

CREATE TABLE `outfits` (
  `idSteam` varchar(255) NOT NULL,
  `dad` int(11) NOT NULL DEFAULT 0,
  `mum` int(11) NOT NULL DEFAULT 0,
  `dadmumpercent` int(11) NOT NULL DEFAULT 0,
  `skinton` int(11) NOT NULL DEFAULT 0,
  `eyecolor` int(11) NOT NULL DEFAULT 0,
  `acne` int(11) NOT NULL DEFAULT 0,
  `skinproblem` int(11) NOT NULL DEFAULT 0,
  `freckle` int(11) NOT NULL DEFAULT 0,
  `wrinkle` int(11) NOT NULL DEFAULT 0,
  `wrinkleopacity` int(11) NOT NULL DEFAULT 0,
  `eyebrow` int(11) NOT NULL DEFAULT 0,
  `eyebrowopacity` int(11) NOT NULL DEFAULT 0,
  `beard` int(11) NOT NULL DEFAULT 0,
  `beardopacity` int(11) NOT NULL DEFAULT 0,
  `beardcolor` int(11) NOT NULL DEFAULT 0,
  `hair` int(11) NOT NULL DEFAULT 0,
  `hairtext` int(11) NOT NULL DEFAULT 0,
  `torso` int(11) NOT NULL DEFAULT 0,
  `torsotext` int(11) NOT NULL DEFAULT 0,
  `leg` int(11) NOT NULL DEFAULT 0,
  `legtext` int(11) NOT NULL DEFAULT 0,
  `shoes` int(11) NOT NULL DEFAULT 0,
  `shoestext` int(11) NOT NULL DEFAULT 0,
  `accessory` int(11) NOT NULL DEFAULT 0,
  `accessorytext` int(11) NOT NULL DEFAULT 0,
  `undershirt` int(11) NOT NULL DEFAULT 0,
  `undershirttext` int(11) NOT NULL DEFAULT 0,
  `torso2` int(11) NOT NULL DEFAULT 0,
  `torso2text` int(11) NOT NULL DEFAULT 0,
  `prop_hat` int(11) NOT NULL DEFAULT 0,
  `prop_hat_text` int(11) NOT NULL DEFAULT 0,
  `prop_glasses` int(11) NOT NULL DEFAULT 0,
  `prop_glasses_text` int(11) NOT NULL DEFAULT 0,
  `prop_earrings` int(11) NOT NULL DEFAULT 0,
  `prop_earrings_text` int(11) NOT NULL DEFAULT 0,
  `prop_watches` int(11) NOT NULL DEFAULT 0,
  `prop_watches_text` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `owned_shops`
--

CREATE TABLE `owned_shops` (
  `identifier` varchar(250) DEFAULT NULL,
  `ShopNumber` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `ShopValue` int(11) DEFAULT NULL,
  `LastRobbery` int(11) DEFAULT 0,
  `ShopName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sťahujem dáta pre tabuľku `owned_shops`
--

INSERT INTO `owned_shops` (`identifier`, `ShopNumber`, `money`, `ShopValue`, `LastRobbery`, `ShopName`) VALUES
('110000119bffa22', 1, 0, 280000, 1549643682, '0'),
('110000119bffa22', 2, 0, 220000, 1549643682, '0'),
('110000119bffa22', 3, 0, 235000, 1549643682, '0'),
('steam:11000011488633d', 5, 0, 135000, 1549643682, 'GG PI?O'),
('steam:11000011488633d', 6, 0, 235000, 1549643682, 'Kokotko'),
('0', 7, 0, 160000, 1549643682, '0'),
('0', 8, 0, 275000, 1549643682, '0'),
('0', 9, 0, 265000, 1549643682, '0'),
('0', 10, 0, 300000, 1549643682, '0'),
('0', 12, 0, 145000, 1549643682, '0'),
('0', 13, 0, 145000, 1549643682, '0'),
('0', 14, 0, 280000, 1549643682, '0'),
('0', 15, 0, 300000, 1549643682, '0'),
('0', 16, 0, 435000, 1549643682, '0'),
('0', 18, 0, 235000, 1549643682, '0'),
('0', 11, 0, 225000, 1549643682, '0'),
('0', 19, 0, 150000, 1549643682, '0'),
('0', 20, 0, 165000, 1549643682, '0'),
('0', 17, 0, 150000, 1549643682, '0'),
('0', 1, 0, 280000, 1549643682, '0'),
('0', 2, 0, 220000, 1549643682, '0'),
('0', 3, 0, 235000, 1549643682, '0'),
('0', 4, 0, 285000, 1549643682, '0'),
('0', 5, 0, 135000, 1549643682, '0'),
('steam:11000011488633d', 6, 0, 235000, 1549643682, 'Kokotko'),
('0', 7, 0, 160000, 1549643682, '0'),
('0', 8, 0, 275000, 1549643682, '0'),
('0', 9, 0, 265000, 1549643682, '0'),
('0', 10, 0, 300000, 1549643682, '0'),
('0', 12, 0, 145000, 1549643682, '0'),
('0', 13, 0, 145000, 1549643682, '0'),
('0', 14, 0, 280000, 1549643682, '0'),
('0', 15, 0, 300000, 1549643682, '0'),
('0', 16, 0, 435000, 1549643682, '0'),
('0', 18, 0, 235000, 1549643682, '0'),
('0', 11, 0, 225000, 1549643682, '0'),
('0', 19, 0, 150000, 1549643682, '0'),
('0', 20, 0, 165000, 1549643682, '0'),
('0', 17, 0, 150000, 1549643682, '0');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(40) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `owned_vehicles`
--

INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `type`, `job`, `stored`) VALUES
('steam:110000119bffa22', '', '{\"plateIndex\":0,\"modSideSkirt\":-1,\"modAPlate\":-1,\"modOrnaments\":-1,\"modRoof\":-1,\"modBackWheels\":-1,\"modShifterLeavers\":-1,\"dirtLevel\":8.0,\"modTrunk\":-1,\"modFender\":-1,\"modDoorSpeaker\":-1,\"modEngineBlock\":-1,\"modTank\":-1,\"modPlateHolder\":-1,\"modLivery\":-1,\"model\":-344943009,\"modWindows\":-1,\"modSeats\":-1,\"neonEnabled\":[false,false,false,false],\"neonColor\":[255,0,255],\"modAirFilter\":-1,\"modArmor\":-1,\"modSteeringWheel\":-1,\"pearlescentColor\":111,\"modArchCover\":-1,\"wheelColor\":156,\"plate\":\"48EPO780\",\"modEngine\":-1,\"modFrame\":-1,\"modSuspension\":-1,\"modStruts\":-1,\"health\":1000,\"modDial\":-1,\"modSmokeEnabled\":false,\"tyreSmokeColor\":[255,255,255],\"modRearBumper\":-1,\"modSpoilers\":-1,\"windowTint\":-1,\"modAerials\":-1,\"modDashboard\":-1,\"modExhaust\":-1,\"modTrimA\":-1,\"modTransmission\":-1,\"modGrille\":-1,\"modFrontWheels\":-1,\"extras\":{\"12\":true,\"10\":false},\"modFrontBumper\":-1,\"color2\":0,\"modSpeakers\":-1,\"color1\":6,\"modHood\":-1,\"modTrimB\":-1,\"modHorns\":-1,\"modHydrolic\":-1,\"wheels\":0,\"modVanityPlate\":-1,\"modBrakes\":-1,\"modTurbo\":false,\"modXenon\":false,\"modRightFender\":-1}', 'car', NULL, 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `phone_calls`
--

INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
(123, '548-9058', '625-2539', 1, '2020-05-22 19:42:22', 0),
(124, '548-9058', '625-2539', 1, '2020-05-22 19:50:08', 0),
(125, '548-9058', '625-2539', 1, '2020-05-22 20:10:19', 0),
(126, '625-2539', '548-9058', 0, '2020-05-22 20:10:19', 0),
(127, '513-1139', '548-9058', 0, '2020-05-23 18:58:19', 1),
(128, '548-9058', '513-1139', 1, '2020-05-23 18:58:19', 1);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_ch_reddit`
--

CREATE TABLE `phone_ch_reddit` (
  `id` int(11) NOT NULL,
  `redgkit` varchar(20) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_reddit`
--

CREATE TABLE `phone_reddit` (
  `id` int(11) NOT NULL,
  `redgkit` varchar(20) DEFAULT NULL,
  `reditsage` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_shops`
--

CREATE TABLE `phone_shops` (
  `id` int(11) NOT NULL,
  `store` varchar(255) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sťahujem dáta pre tabuľku `phone_shops`
--

INSERT INTO `phone_shops` (`id`, `store`, `item`, `price`, `label`) VALUES
(18, 'https://img.pngio.com/sim-card-png-clipart-sim-cards-png-1483_1162.png', 'sim', 50, 'SIM CARD');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `playerstattoos`
--

CREATE TABLE `playerstattoos` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `tattoos` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `playerstattoos`
--

INSERT INTO `playerstattoos` (`id`, `identifier`, `tattoos`) VALUES
(1, 'steam:11000011488633d', '[]'),
(2, 'steam:110000119bffa22', 'null'),
(3, 'steam:110000137dfca7f', '[]'),
(4, 'steam:11000011c573ef6', 'null'),
(5, 'steam:110000115cf38b3', '[]');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `pois`
--

CREATE TABLE `pois` (
  `id` bigint(20) NOT NULL,
  `civ_id` bigint(20) NOT NULL,
  `image` mediumtext NOT NULL,
  `reason` mediumtext NOT NULL,
  `notes` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{\"y\":564.89,\"z\":182.959,\"x\":119.384}', '{\"x\":117.347,\"y\":559.506,\"z\":183.304}', '{\"y\":557.032,\"z\":183.301,\"x\":118.037}', '{\"y\":567.798,\"z\":182.131,\"x\":119.249}', '[]', NULL, 1, 1, 0, '{\"x\":118.748,\"y\":566.573,\"z\":175.697}', 1500000),
(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{\"x\":372.796,\"y\":428.327,\"z\":144.685}', '{\"x\":373.548,\"y\":422.982,\"z\":144.907},', '{\"y\":420.075,\"z\":145.904,\"x\":372.161}', '{\"x\":372.454,\"y\":432.886,\"z\":143.443}', '[]', NULL, 1, 1, 0, '{\"x\":377.349,\"y\":429.422,\"z\":137.3}', 1500000),
(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}', '{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}', '{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}', '{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}', '[]', NULL, 1, 1, 0, '{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}', 1700000),
(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{\"y\":440.8,\"z\":146.702,\"x\":346.964}', '{\"y\":437.456,\"z\":148.394,\"x\":341.683}', '{\"y\":435.626,\"z\":148.394,\"x\":339.595}', '{\"x\":350.535,\"y\":443.329,\"z\":145.764}', '[]', NULL, 1, 1, 0, '{\"x\":337.726,\"y\":436.985,\"z\":140.77}', 1500000),
(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{\"y\":502.696,\"z\":136.421,\"x\":-176.003}', '{\"y\":497.817,\"z\":136.653,\"x\":-174.349}', '{\"y\":495.069,\"z\":136.666,\"x\":-173.331}', '{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}', '[]', NULL, 1, 1, 0, '{\"x\":-174.725,\"y\":493.095,\"z\":129.043}', 1500000),
(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{\"y\":596.58,\"z\":142.641,\"x\":-686.554}', '{\"y\":591.988,\"z\":144.392,\"x\":-681.728}', '{\"y\":590.608,\"z\":144.392,\"x\":-680.124}', '{\"y\":599.019,\"z\":142.059,\"x\":-689.492}', '[]', NULL, 1, 1, 0, '{\"x\":-680.46,\"y\":588.6,\"z\":136.769}', 1500000),
(7, 'LowEndApartment', 'Appartement de base', '{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}', '{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}', '{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}', '{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}', '[]', NULL, 1, 1, 0, '{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}', 562500),
(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}', '{\"x\":-1289.917,\"y\":449.541,\"z\":96.902}', '{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}', '{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}', '[]', NULL, 1, 1, 0, '{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}', 1500000),
(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{\"x\":-853.346,\"y\":696.678,\"z\":147.782}', '{\"y\":690.875,\"z\":151.86,\"x\":-859.961}', '{\"y\":688.361,\"z\":151.857,\"x\":-859.395}', '{\"y\":701.628,\"z\":147.773,\"x\":-855.007}', '[]', NULL, 1, 1, 0, '{\"x\":-858.543,\"y\":697.514,\"z\":144.253}', 1500000),
(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{\"y\":620.494,\"z\":141.588,\"x\":-752.82}', '{\"y\":618.62,\"z\":143.153,\"x\":-759.317}', '{\"y\":617.629,\"z\":143.153,\"x\":-760.789}', '{\"y\":621.281,\"z\":141.254,\"x\":-750.919}', '[]', NULL, 1, 1, 0, '{\"x\":-762.504,\"y\":618.992,\"z\":135.53}', 1500000),
(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{\"y\":37.025,\"z\":42.58,\"x\":-618.299}', '{\"y\":58.898,\"z\":97.2,\"x\":-603.301}', '{\"y\":58.941,\"z\":97.2,\"x\":-608.741}', '{\"y\":30.603,\"z\":42.524,\"x\":-620.017}', '[]', NULL, 1, 1, 0, '{\"x\":-622.173,\"y\":54.585,\"z\":96.599}', 1700000),
(12, 'MiltonDrive', 'Milton Drive', '{\"x\":-775.17,\"y\":312.01,\"z\":84.658}', NULL, NULL, '{\"x\":-775.346,\"y\":306.776,\"z\":84.7}', '[]', NULL, 0, 0, 1, NULL, 0),
(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_01_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.661,\"y\":327.672,\"z\":210.396}', 1300000),
(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_01_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.735,\"y\":326.757,\"z\":186.313}', 1300000),
(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_01_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.386,\"y\":330.782,\"z\":195.08}', 1300000),
(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_02_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.615,\"y\":327.878,\"z\":210.396}', 1300000),
(17, 'Mody2Apartment', 'Appartement Mode 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_02_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.297,\"y\":327.092,\"z\":186.313}', 1300000),
(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_02_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.303,\"y\":330.932,\"z\":195.085}', 1300000),
(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_03_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.885,\"y\":327.641,\"z\":210.396}', 1300000),
(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_03_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.607,\"y\":327.344,\"z\":186.313}', 1300000),
(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_03_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.525,\"y\":330.851,\"z\":195.085}', 1300000),
(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_04_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.527,\"y\":327.89,\"z\":210.396}', 1300000),
(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_04_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.642,\"y\":326.497,\"z\":186.313}', 1300000),
(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_04_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.503,\"y\":331.318,\"z\":195.085}', 1300000),
(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_05_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.289,\"y\":328.086,\"z\":210.396}', 1300000),
(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_05_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.692,\"y\":326.762,\"z\":186.313}', 1300000),
(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_05_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.094,\"y\":330.976,\"z\":195.085}', 1300000),
(28, 'Seductive1Apartment', 'Appartement Séduisant 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_06_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.263,\"y\":328.104,\"z\":210.396}', 1300000),
(29, 'Seductive2Apartment', 'Appartement Séduisant 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_06_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.655,\"y\":326.611,\"z\":186.313}', 1300000),
(30, 'Seductive3Apartment', 'Appartement Séduisant 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_06_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.3,\"y\":331.414,\"z\":195.085}', 1300000),
(31, 'Regal1Apartment', 'Appartement Régal 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_07_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.956,\"y\":328.257,\"z\":210.396}', 1300000),
(32, 'Regal2Apartment', 'Appartement Régal 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_07_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.545,\"y\":326.659,\"z\":186.313}', 1300000),
(33, 'Regal3Apartment', 'Appartement Régal 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_07_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.087,\"y\":331.429,\"z\":195.123}', 1300000),
(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{\"x\":-784.194,\"y\":323.636,\"z\":210.997}', '{\"x\":-779.751,\"y\":323.385,\"z\":210.997}', NULL, '[\"apa_v_mp_h_08_a\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-766.187,\"y\":328.47,\"z\":210.396}', 1300000),
(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}', '{\"x\":-781.808,\"y\":315.866,\"z\":186.913}', NULL, '[\"apa_v_mp_h_08_c\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-795.658,\"y\":326.563,\"z\":186.313}', 1300000),
(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{\"x\":-774.012,\"y\":342.042,\"z\":195.686}', '{\"x\":-779.057,\"y\":342.063,\"z\":195.686}', NULL, '[\"apa_v_mp_h_08_b\"]', 'MiltonDrive', 0, 1, 0, '{\"x\":-765.287,\"y\":331.084,\"z\":195.086}', 1300000),
(37, 'IntegrityWay', '4 Integrity Way', '{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}', NULL, NULL, '{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}', '[]', NULL, 0, 0, 1, NULL, 0),
(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}', '{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}', 1700000),
(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}', '{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}', 1700000),
(40, 'DellPerroHeights', 'Dell Perro Heights', '{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}', NULL, NULL, '{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}', '[]', NULL, 0, 0, 1, NULL, 0),
(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{\"x\":-1452.125,\"y\":-540.591,\"z\":73.044}', '{\"x\":-1455.435,\"y\":-535.79,\"z\":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1467.058,\"y\":-527.571,\"z\":72.443}', 1700000),
(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{\"x\":-1451.562,\"y\":-523.535,\"z\":55.928}', '{\"x\":-1456.02,\"y\":-519.209,\"z\":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{\"x\":-1457.026,\"y\":-530.219,\"z\":55.937}', 1700000),
(43, 'MazeBankBuilding', 'Maze Bank Building', '{\"x\":-79.18,\"y\":-795.92,\"z\":43.35}', NULL, NULL, '{\"x\":-72.50,\"y\":-786.92,\"z\":43.40}', '[]', NULL, 0, 0, 1, NULL, 0),
(44, 'OldSpiceWarm', 'Old Spice Warm', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(45, 'OldSpiceClassical', 'Old Spice Classical', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(46, 'OldSpiceVintage', 'Old Spice Vintage', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_01c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(47, 'ExecutiveRich', 'Executive Rich', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(48, 'ExecutiveCool', 'Executive Cool', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(49, 'ExecutiveContrast', 'Executive Contrast', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_02a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(50, 'PowerBrokerIce', 'Power Broker Ice', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03a\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(51, 'PowerBrokerConservative', 'Power Broker Conservative', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03b\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(52, 'PowerBrokerPolished', 'Power Broker Polished', NULL, '{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}', '{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}', NULL, '[\"ex_dt1_11_office_03c\"]', 'MazeBankBuilding', 0, 1, 0, '{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}', 5000000),
(53, 'LomBank', 'Lom Bank', '{\"x\":-1581.36,\"y\":-558.23,\"z\":34.07}', NULL, NULL, '{\"x\":-1583.60,\"y\":-555.12,\"z\":34.07}', '[]', NULL, 0, 0, 1, NULL, 0),
(54, 'LBOldSpiceWarm', 'LB Old Spice Warm', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(55, 'LBOldSpiceClassical', 'LB Old Spice Classical', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(56, 'LBOldSpiceVintage', 'LB Old Spice Vintage', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_01c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(57, 'LBExecutiveRich', 'LB Executive Rich', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(58, 'LBExecutiveCool', 'LB Executive Cool', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(59, 'LBExecutiveContrast', 'LB Executive Contrast', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_02a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(60, 'LBPowerBrokerIce', 'LB Power Broker Ice', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03a\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(61, 'LBPowerBrokerConservative', 'LB Power Broker Conservative', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03b\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(62, 'LBPowerBrokerPolished', 'LB Power Broker Polished', NULL, '{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}', '{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}', NULL, '[\"ex_sm_13_office_03c\"]', 'LomBank', 0, 1, 0, '{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}', 3500000),
(63, 'MazeBankWest', 'Maze Bank West', '{\"x\":-1379.58,\"y\":-499.63,\"z\":32.22}', NULL, NULL, '{\"x\":-1378.95,\"y\":-502.82,\"z\":32.22}', '[]', NULL, 0, 0, 1, NULL, 0),
(64, 'MBWOldSpiceWarm', 'MBW Old Spice Warm', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(65, 'MBWOldSpiceClassical', 'MBW Old Spice Classical', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(66, 'MBWOldSpiceVintage', 'MBW Old Spice Vintage', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_01c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(67, 'MBWExecutiveRich', 'MBW Executive Rich', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(68, 'MBWExecutiveCool', 'MBW Executive Cool', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(69, 'MBWExecutive Contrast', 'MBW Executive Contrast', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_02a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(70, 'MBWPowerBrokerIce', 'MBW Power Broker Ice', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03a\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(71, 'MBWPowerBrokerConvservative', 'MBW Power Broker Convservative', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03b\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(72, 'MBWPowerBrokerPolished', 'MBW Power Broker Polished', NULL, '{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}', '{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}', NULL, '[\"ex_sm_15_office_03c\"]', 'MazeBankWest', 0, 1, 0, '{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}', 2700000),
(100, 'MedEndApartment1', 'Medium Apartment 1', '{\"y\":3107.56,\"z\":41.49,\"x\":240.6}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":3100.77,\"z\":41.49,\"x\":240.21}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(101, 'MedEndApartment2', 'Medium Apartment 2', '{\"y\":3169.1,\"z\":41.81,\"x\":246.7}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":3163.97,\"z\":41.82,\"x\":245.83}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(102, 'MedEndApartment3', 'Medium Apartment 3', '{\"y\":2667.22,\"z\":39.06,\"x\":980.38}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":2668.77,\"z\":39.06,\"x\":986.38}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(103, 'MedEndApartment4', 'Medium Apartment 4', '{\"y\":3031.08,\"z\":42.89,\"x\":195.85}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":3031.39,\"z\":42.27,\"x\":200.68}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(104, 'MedEndApartment5', 'Medium Apartment 5', '{\"y\":4642.17,\"z\":42.88,\"x\":1724.43}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":4637.34,\"z\":42.31,\"x\":1724.27}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(105, 'MedEndApartment6', 'Medium Apartment 6', '{\"y\":4739.73,\"z\":40.99,\"x\":1664.98}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":4740.93,\"z\":41.08,\"x\":1670.92}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(106, 'MedEndApartment7', 'Medium Apartment 7', '{\"y\":6577.19,\"z\":31.74,\"x\":12.57}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":6572.61,\"z\":31.72,\"x\":16.93}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(107, 'MedEndApartment8', 'Medium Apartment 8', '{\"y\":6190.84,\"z\":30.73,\"x\":-374.31}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":6186.58,\"z\":30.52,\"x\":-372.65}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(108, 'MedEndApartment9', 'Medium Apartment 9', '{\"y\":6597.56,\"z\":30.86,\"x\":-27.06}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":6601.55,\"z\":30.44,\"x\":-30.55}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000),
(109, 'MedEndApartment10', 'Medium Apartment 10', '{\"y\":6340.1,\"z\":28.84,\"x\":-367.33}', '{\"y\":-1012.27,\"z\":-100.2,\"x\":346.49}', '{\"y\":-1000.09,\"z\":-100.2,\"x\":347.06}', '{\"y\":6336.97,\"z\":28.84,\"x\":-371.3}', '[]', NULL, 1, 1, 0, '{\"x\":345.3,\"y\":-995.24,\"z\":-100.2}', 500000);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `qalle_brottsregister`
--

CREATE TABLE `qalle_brottsregister` (
  `id` int(255) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofcrime` varchar(255) NOT NULL,
  `crime` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `remarks`
--

CREATE TABLE `remarks` (
  `remarkid` mediumint(9) NOT NULL,
  `unit` mediumtext NOT NULL,
  `content` mediumtext NOT NULL,
  `dateline` bigint(20) NOT NULL,
  `callid` mediumint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `rented_vehicles`
--

CREATE TABLE `rented_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `reports`
--

CREATE TABLE `reports` (
  `id` bigint(20) NOT NULL,
  `user` bigint(20) NOT NULL,
  `incident` mediumtext NOT NULL,
  `cad` mediumtext NOT NULL,
  `located` mediumtext NOT NULL,
  `otherUnits` mediumtext NOT NULL,
  `arrested` mediumtext NOT NULL,
  `person` mediumtext NOT NULL,
  `arrestedFor` mediumtext NOT NULL,
  `foundItems` mediumtext NOT NULL,
  `whatHappened` longtext NOT NULL,
  `dateline` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `shipments`
--

CREATE TABLE `shipments` (
  `id` int(11) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `count` varchar(50) DEFAULT NULL,
  `time` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `shops`
--

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES
(1, 'TwentyFourSeven', 'bread', 30),
(2, 'TwentyFourSeven', 'water', 15),
(3, 'RobsLiquor', 'bread', 30),
(4, 'RobsLiquor', 'water', 15),
(5, 'LTDgasoline', 'bread', 30),
(6, 'LTDgasoline', 'water', 15);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `sim`
--

CREATE TABLE `sim` (
  `identifier` varchar(50) NOT NULL,
  `phone_number` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `trunk_inventory`
--

CREATE TABLE `trunk_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `twitter_accounts`
--

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `twitter_likes`
--

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `twitter_tweets`
--

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `units`
--

CREATE TABLE `units` (
  `unitid` mediumint(9) NOT NULL,
  `unit` mediumtext NOT NULL,
  `callid` mediumint(9) NOT NULL,
  `status` mediumtext NOT NULL,
  `collar` mediumtext NOT NULL,
  `steamid` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `usergroups`
--

CREATE TABLE `usergroups` (
  `id` mediumint(9) NOT NULL,
  `name` mediumtext NOT NULL,
  `perms` mediumint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sťahujem dáta pre tabuľku `usergroups`
--

INSERT INTO `usergroups` (`id`, `name`, `perms`) VALUES
(1, 'Registered User', 1),
(2, 'Community Member', 17),
(3, 'Trooper', 211),
(4, 'Corporal', 209),
(5, 'Sergeant', 241),
(6, 'Lieutenant', 8959),
(7, 'Captain', 25343),
(8, 'Chief', 27647),
(9, 'Moderator', 60159),
(10, 'Field Training Officer', 255),
(11, 'Dispatcher', 59647),
(12, 'Director', 64255),
(13, 'Administrator', 64511),
(14, 'Website Administrator', 16383);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `users`
--

CREATE TABLE `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(36) COLLATE utf8mb4_bin DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `is_dead` tinyint(1) DEFAULT 0,
  `jail` int(11) NOT NULL DEFAULT 0,
  `status` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `lastdigits` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `model` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `drawables` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `props` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `drawtextures` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `proptextures` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `hairColor` longtext COLLATE utf8mb4_bin DEFAULT '[]',
  `headBlend` longtext COLLATE utf8mb4_bin DEFAULT '[]',
  `headOverlay` longtext COLLATE utf8mb4_bin DEFAULT '[]',
  `headStructure` longtext COLLATE utf8mb4_bin DEFAULT '[]',
  `last_property` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `accounts` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `inventory` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `is_male` int(11) DEFAULT 1,
  `dob` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `last_name` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `first_name` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `accessories` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Sťahujem dáta pre tabuľku `users`
--

INSERT INTO `users` (`identifier`, `license`, `money`, `name`, `skin`, `job`, `job_grade`, `loadout`, `position`, `bank`, `permission_level`, `group`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `is_dead`, `jail`, `status`, `phone_number`, `lastdigits`, `model`, `drawables`, `props`, `drawtextures`, `proptextures`, `hairColor`, `headBlend`, `headOverlay`, `headStructure`, `last_property`, `accounts`, `inventory`, `is_male`, `dob`, `last_name`, `first_name`, `accessories`) VALUES
('b2e61faa40b22864be1664bb23ab2086c49a9046', NULL, NULL, '', NULL, 'unemployed', 0, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', '[]', '[]', '[]', NULL, '{\"black_money\":0,\"bank\":50000,\"money\":0}', NULL, 1, NULL, NULL, NULL, NULL),
('dbeb3e7e31fe668b6c63bcea96cc4c09519fcd4d', NULL, NULL, '', NULL, 'unemployed', 0, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', '[]', '[]', '[]', NULL, '{\"black_money\":0,\"bank\":50000,\"money\":0}', NULL, 1, NULL, NULL, NULL, NULL),
('steam:11000011488633d', 'license:b2e61faa40b22864be1664bb23ab2086c49a9046', 887406795, 'Honza_X', '{\"makeup_2\":0,\"arms_2\":0,\"decals_2\":0,\"age_2\":0,\"watches_1\":-1,\"hair_2\":0,\"blush_2\":0,\"bags_1\":0,\"pants_1\":0,\"lipstick_1\":0,\"sun_2\":0,\"hair_color_2\":0,\"watches_2\":0,\"sun_1\":0,\"bodyb_2\":0,\"beard_3\":0,\"chest_1\":0,\"chest_3\":0,\"complexion_1\":0,\"makeup_3\":0,\"beard_4\":0,\"eyebrows_3\":0,\"bproof_2\":0,\"hair_color_1\":0,\"sex\":0,\"moles_2\":0,\"skin\":2,\"lipstick_4\":0,\"eye_color\":0,\"shoes_2\":0,\"helmet_1\":-1,\"eyebrows_2\":0,\"torso_2\":0,\"glasses_1\":0,\"chain_2\":0,\"chain_1\":0,\"shoes_1\":0,\"glasses_2\":0,\"tshirt_1\":0,\"face\":0,\"mask_2\":0,\"blemishes_1\":0,\"pants_2\":0,\"makeup_4\":0,\"torso_1\":0,\"blush_3\":0,\"makeup_1\":0,\"helmet_2\":0,\"bracelets_1\":-1,\"bodyb_1\":0,\"age_1\":0,\"mask_1\":0,\"lipstick_2\":0,\"moles_1\":0,\"ears_1\":-1,\"decals_1\":0,\"beard_2\":0,\"blush_1\":0,\"bags_2\":0,\"ears_2\":0,\"beard_1\":0,\"arms\":0,\"eyebrows_1\":0,\"bproof_1\":0,\"complexion_2\":0,\"hair_1\":19,\"chest_2\":0,\"lipstick_3\":0,\"bracelets_2\":0,\"eyebrows_4\":0,\"blemishes_2\":0,\"tshirt_2\":0}', 'mecano', 4, '[]', '{\"y\":-970.2,\"x\":294.4,\"z\":55.3}', 10900, 0, 'user', 'Honza', 'Brody', '05/09/1990', 'm', '200', 0, 0, '[{\"percent\":20.33,\"name\":\"hunger\",\"val\":203300},{\"percent\":27.7475,\"name\":\"thirst\",\"val\":277475}]', '731-8810', '4444', NULL, NULL, NULL, NULL, NULL, '[]', '[]', '[]', '[]', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
('steam:110000115cf38b3', 'license:0e9eee3fbe6feff93578a99b4f8cd1ada73299c0', 10000, 'AreSS', NULL, 'unemployed', 0, '[]', '{\"y\":-972.3,\"x\":-250.4,\"z\":31.2}', 10000, 0, 'user', '', '', '', '', '', 0, 0, '[{\"val\":977100,\"name\":\"hunger\",\"percent\":97.71},{\"val\":982825,\"name\":\"thirst\",\"percent\":98.2825}]', '552-2882', NULL, NULL, NULL, NULL, NULL, NULL, '[]', '[]', '[]', '[]', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
('steam:110000119bffa22', 'license:dbeb3e7e31fe668b6c63bcea96cc4c09519fcd4d', 154038, 'Benik', '{\"lipstick_4\":0,\"pants_1\":0,\"bags_1\":0,\"arms\":0,\"eyebrows_3\":0,\"moles_1\":0,\"blush_3\":0,\"mask_2\":0,\"face\":0,\"lipstick_2\":0,\"blush_2\":0,\"chest_1\":0,\"eye_color\":0,\"tshirt_2\":0,\"sex\":0,\"blemishes_2\":0,\"lipstick_1\":0,\"skin\":0,\"lipstick_3\":0,\"ears_2\":0,\"blush_1\":0,\"bproof_2\":0,\"torso_1\":0,\"complexion_1\":0,\"bracelets_2\":0,\"eyebrows_1\":0,\"hair_1\":0,\"makeup_2\":0,\"eyebrows_4\":0,\"bproof_1\":0,\"beard_3\":0,\"ears_1\":-1,\"age_1\":0,\"hair_color_1\":0,\"watches_1\":-1,\"helmet_1\":-1,\"makeup_1\":0,\"makeup_3\":0,\"bodyb_1\":0,\"hair_2\":0,\"arms_2\":0,\"beard_4\":0,\"mask_1\":0,\"decals_1\":0,\"chest_3\":0,\"beard_1\":0,\"glasses_1\":0,\"bags_2\":0,\"shoes_2\":0,\"chest_2\":0,\"helmet_2\":0,\"complexion_2\":0,\"chain_2\":0,\"tshirt_1\":0,\"beard_2\":0,\"moles_2\":0,\"decals_2\":0,\"torso_2\":0,\"watches_2\":0,\"shoes_1\":0,\"hair_color_2\":0,\"chain_1\":0,\"sun_2\":0,\"pants_2\":0,\"bracelets_1\":-1,\"blemishes_1\":0,\"sun_1\":0,\"eyebrows_2\":0,\"glasses_2\":0,\"bodyb_2\":0,\"makeup_4\":0,\"age_2\":0}', 'police', 4, '[{\"components\":[],\"name\":\"WEAPON_KNIFE\",\"label\":\"Knife\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_NIGHTSTICK\",\"label\":\"Nightstick\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_HAMMER\",\"label\":\"Hammer\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_BAT\",\"label\":\"Bat\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_GOLFCLUB\",\"label\":\"Golf club\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_CROWBAR\",\"label\":\"Crow bar\",\"ammo\":0},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_PISTOL\",\"label\":\"Pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_COMBATPISTOL\",\"label\":\"Combat pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_APPISTOL\",\"label\":\"AP pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_PISTOL50\",\"label\":\"Pistol .50\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_REVOLVER\",\"label\":\"Heavy revolver\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_SNSPISTOL\",\"label\":\"Sns pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_HEAVYPISTOL\",\"label\":\"Heavy pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_VINTAGEPISTOL\",\"label\":\"Vintage pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_MICROSMG\",\"label\":\"Micro SMG\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_SMG\",\"label\":\"SMG\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_ASSAULTSMG\",\"label\":\"Assault SMG\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_MINISMG\",\"label\":\"Mini smg\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_MACHINEPISTOL\",\"label\":\"Machine pistol\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_COMBATPDW\",\"label\":\"Combat pdw\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_PUMPSHOTGUN\",\"label\":\"Pump shotgun\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_SAWNOFFSHOTGUN\",\"label\":\"Sawed off shotgun\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_ASSAULTSHOTGUN\",\"label\":\"Assault shotgun\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_BULLPUPSHOTGUN\",\"label\":\"Bullpup shotgun\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_HEAVYSHOTGUN\",\"label\":\"Heavy shotgun\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_ASSAULTRIFLE\",\"label\":\"Assault rifle\",\"ammo\":9985},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_CARBINERIFLE\",\"label\":\"Carbine rifle\",\"ammo\":9985},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_ADVANCEDRIFLE\",\"label\":\"Advanced rifle\",\"ammo\":9985},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_SPECIALCARBINE\",\"label\":\"Special carbine\",\"ammo\":9985},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_BULLPUPRIFLE\",\"label\":\"Bullpup rifle\",\"ammo\":9985},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_COMPACTRIFLE\",\"label\":\"Compact rifle\",\"ammo\":9985},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_MG\",\"label\":\"MG\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_COMBATMG\",\"label\":\"Combat MG\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_GUSENBERG\",\"label\":\"Gusenberg sweeper\",\"ammo\":9999},{\"components\":[\"scope\"],\"name\":\"WEAPON_SNIPERRIFLE\",\"label\":\"Sniper rifle\",\"ammo\":9999},{\"components\":[\"scope_advanced\"],\"name\":\"WEAPON_HEAVYSNIPER\",\"label\":\"Heavy sniper\",\"ammo\":9999},{\"components\":[\"clip_default\",\"scope\"],\"name\":\"WEAPON_MARKSMANRIFLE\",\"label\":\"Marksman rifle\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_GRENADELAUNCHER\",\"label\":\"Grenade launcher\",\"ammo\":17},{\"components\":[],\"name\":\"WEAPON_RPG\",\"label\":\"Rocket launcher\",\"ammo\":20},{\"components\":[],\"name\":\"WEAPON_MINIGUN\",\"label\":\"Minigun\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_GRENADE\",\"label\":\"Grenade\",\"ammo\":25},{\"components\":[],\"name\":\"WEAPON_STICKYBOMB\",\"label\":\"Sticky bomb\",\"ammo\":25},{\"components\":[],\"name\":\"WEAPON_SMOKEGRENADE\",\"label\":\"Smoke grenade\",\"ammo\":25},{\"components\":[],\"name\":\"WEAPON_BZGAS\",\"label\":\"Bz gas\",\"ammo\":25},{\"components\":[],\"name\":\"WEAPON_MOLOTOV\",\"label\":\"Molotov cocktail\",\"ammo\":25},{\"components\":[],\"name\":\"WEAPON_FIREEXTINGUISHER\",\"label\":\"Fire extinguisher\",\"ammo\":2000},{\"components\":[],\"name\":\"WEAPON_PETROLCAN\",\"label\":\"Jerrycan\",\"ammo\":4500},{\"components\":[],\"name\":\"WEAPON_BALL\",\"label\":\"Ball\",\"ammo\":1},{\"components\":[],\"name\":\"WEAPON_BOTTLE\",\"label\":\"Bottle\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_DAGGER\",\"label\":\"Dagger\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_FIREWORK\",\"label\":\"Firework\",\"ammo\":20},{\"components\":[],\"name\":\"WEAPON_MUSKET\",\"label\":\"Musket\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_STUNGUN\",\"label\":\"Taser\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_HOMINGLAUNCHER\",\"label\":\"Homing launcher\",\"ammo\":10},{\"components\":[],\"name\":\"WEAPON_PROXMINE\",\"label\":\"Proximity mine\",\"ammo\":5},{\"components\":[],\"name\":\"WEAPON_SNOWBALL\",\"label\":\"Snow ball\",\"ammo\":10},{\"components\":[],\"name\":\"WEAPON_FLAREGUN\",\"label\":\"Flaregun\",\"ammo\":20},{\"components\":[],\"name\":\"WEAPON_MARKSMANPISTOL\",\"label\":\"Marksman pistol\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_KNUCKLE\",\"label\":\"Knuckledusters\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_HATCHET\",\"label\":\"Hatchet\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_RAILGUN\",\"label\":\"Railgun\",\"ammo\":20},{\"components\":[],\"name\":\"WEAPON_MACHETE\",\"label\":\"Machete\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_SWITCHBLADE\",\"label\":\"Switchblade\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_DBSHOTGUN\",\"label\":\"Double barrel shotgun\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_AUTOSHOTGUN\",\"label\":\"Auto shotgun\",\"ammo\":9999},{\"components\":[],\"name\":\"WEAPON_BATTLEAXE\",\"label\":\"Battle axe\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_COMPACTLAUNCHER\",\"label\":\"Compact launcher\",\"ammo\":17},{\"components\":[],\"name\":\"WEAPON_PIPEBOMB\",\"label\":\"Pipe bomb\",\"ammo\":10},{\"components\":[],\"name\":\"WEAPON_POOLCUE\",\"label\":\"Pool cue\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_WRENCH\",\"label\":\"Pipe wrench\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_FLASHLIGHT\",\"label\":\"Flashlight\",\"ammo\":0},{\"components\":[],\"name\":\"WEAPON_FLARE\",\"label\":\"Flare gun\",\"ammo\":25},{\"components\":[],\"name\":\"WEAPON_DOUBLEACTION\",\"label\":\"Double-Action Revolver\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_PISTOL_MK2\",\"label\":\"Pistol MK2\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_SMG_MK2\",\"label\":\"SMG MK2\",\"ammo\":9999},{\"components\":[\"clip_default\"],\"name\":\"WEAPON_ASSAULTRIFLE_MK2\",\"label\":\"Assault rifle MK2\",\"ammo\":9985}]', '{\"y\":-831.9,\"x\":-991.1,\"z\":14.2}', 10040, 0, 'user', 'Josep', 'PP', '1999/11/27', NULL, '185', 1, 0, '[{\"val\":25800,\"name\":\"hunger\",\"percent\":2.58},{\"val\":144350,\"name\":\"thirst\",\"percent\":14.435}]', '508-3927', NULL, NULL, NULL, NULL, NULL, NULL, '[]', '[]', '[]', '[]', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
('steam:11000011c573ef6', 'license:05042533bb520f48a5c07416d6a850a8efefda04', 36514, 'Vipkor_234', '{\"headOverlay\":[{\"overlayOpacity\":1.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Blemishes\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":1,\"overlayValue\":255,\"secondColour\":0,\"name\":\"FacialHair\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":1,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Eyebrows\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Ageing\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":2,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Makeup\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":2,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Blush\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Complexion\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"SunDamage\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":2,\"overlayValue\":255,\"secondColour\":0,\"name\":\"Lipstick\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"MolesFreckles\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":1,\"overlayValue\":255,\"secondColour\":0,\"name\":\"ChestHair\",\"firstColour\":0},{\"overlayOpacity\":0.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"BodyBlemishes\",\"firstColour\":0},{\"overlayOpacity\":1.0,\"colourType\":0,\"overlayValue\":255,\"secondColour\":0,\"name\":\"AddBodyBlemishes\",\"firstColour\":0}],\"headBlend\":{\"skinThird\":0,\"shapeMix\":1.0,\"shapeSecond\":0,\"skinFirst\":0,\"shapeFirst\":0,\"hasParent\":false,\"thirdMix\":1.0,\"shapeThird\":0,\"skinMix\":1.0,\"skinSecond\":0},\"headStructure\":[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],\"model\":1885233650,\"drawables\":{\"1\":[\"masks\",0],\"2\":[\"hair\",14],\"3\":[\"torsos\",26],\"4\":[\"legs\",33],\"5\":[\"bags\",0],\"6\":[\"shoes\",75],\"7\":[\"neck\",0],\"8\":[\"undershirts\",15],\"9\":[\"vest\",0],\"10\":[\"decals\",0],\"11\":[\"jackets\",50],\"0\":[\"face\",0]},\"drawtextures\":[[\"face\",0],[\"masks\",0],[\"hair\",0],[\"torsos\",0],[\"legs\",0],[\"bags\",0],[\"shoes\",0],[\"neck\",0],[\"undershirts\",0],[\"vest\",0],[\"decals\",0],[\"jackets\",0]],\"hairColor\":[0,0],\"props\":{\"1\":[\"glasses\",-1],\"2\":[\"earrings\",-1],\"3\":[\"mouth\",-1],\"4\":[\"lhand\",-1],\"5\":[\"rhand\",-1],\"6\":[\"watches\",2],\"7\":[\"braclets\",-1],\"0\":[\"hats\",50]},\"proptextures\":[[\"hats\",0],[\"glasses\",-1],[\"earrings\",-1],[\"mouth\",-1],[\"lhand\",-1],[\"rhand\",-1],[\"watches\",0],[\"braclets\",-1]]}', 'unemployed', 0, '[]', '{\"z\":26.2,\"y\":-1138.1,\"x\":-39.2}', 60080, 0, 'user', 'Karel', 'Varlat', '14.8.1996', 'm', '192', 0, 0, '[{\"name\":\"hunger\",\"percent\":71.58,\"val\":715800},{\"name\":\"thirst\",\"percent\":46.185,\"val\":461850}]', '309-3433', NULL, '1885233650', '{\"1\":[\"masks\",0],\"2\":[\"hair\",14],\"3\":[\"torsos\",26],\"4\":[\"legs\",33],\"5\":[\"bags\",0],\"6\":[\"shoes\",75],\"7\":[\"neck\",0],\"8\":[\"undershirts\",15],\"9\":[\"vest\",0],\"10\":[\"decals\",0],\"11\":[\"jackets\",50],\"0\":[\"face\",0]}', '{\"1\":[\"glasses\",-1],\"2\":[\"earrings\",-1],\"3\":[\"mouth\",-1],\"4\":[\"lhand\",-1],\"5\":[\"rhand\",-1],\"6\":[\"watches\",2],\"7\":[\"braclets\",-1],\"0\":[\"hats\",50]}', '[[\"face\",0],[\"masks\",0],[\"hair\",0],[\"torsos\",0],[\"legs\",0],[\"bags\",0],[\"shoes\",0],[\"neck\",0],[\"undershirts\",0],[\"vest\",0],[\"decals\",0],[\"jackets\",0]]', '[[\"hats\",0],[\"glasses\",-1],[\"earrings\",-1],[\"mouth\",-1],[\"lhand\",-1],[\"rhand\",-1],[\"watches\",0],[\"braclets\",-1]]', '[0,0]', '{\"hasParent\":false,\"skinThird\":0,\"shapeFirst\":0,\"skinFirst\":0,\"shapeThird\":0,\"skinMix\":1.0,\"shapeSecond\":0,\"skinSecond\":0,\"thirdMix\":1.0,\"shapeMix\":1.0}', '[{\"overlayOpacity\":1.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"Blemishes\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":1,\"secondColour\":0,\"firstColour\":0,\"name\":\"FacialHair\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":1,\"secondColour\":0,\"firstColour\":0,\"name\":\"Eyebrows\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"Ageing\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":2,\"secondColour\":0,\"firstColour\":0,\"name\":\"Makeup\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":2,\"secondColour\":0,\"firstColour\":0,\"name\":\"Blush\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"Complexion\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"SunDamage\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":2,\"secondColour\":0,\"firstColour\":0,\"name\":\"Lipstick\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"MolesFreckles\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":1,\"secondColour\":0,\"firstColour\":0,\"name\":\"ChestHair\",\"overlayValue\":255},{\"overlayOpacity\":0.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"BodyBlemishes\",\"overlayValue\":255},{\"overlayOpacity\":1.0,\"colourType\":0,\"secondColour\":0,\"firstColour\":0,\"name\":\"AddBodyBlemishes\",\"overlayValue\":255}]', '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
('steam:110000137dfca7f', 'license:538326f948f350bae4caa6f54b6a48f0b0eddebc', 0, 'Kubber_CZ', '{\"makeup_2\":0,\"arms_2\":0,\"decals_2\":0,\"bracelets_1\":-1,\"watches_1\":-1,\"mask_1\":0,\"blush_2\":0,\"bags_1\":0,\"pants_1\":0,\"lipstick_1\":0,\"sun_2\":0,\"hair_color_2\":0,\"watches_2\":0,\"sun_1\":0,\"bodyb_2\":0,\"beard_3\":0,\"chest_1\":0,\"beard_1\":0,\"complexion_1\":0,\"hair_1\":0,\"beard_4\":0,\"eyebrows_3\":0,\"bproof_1\":0,\"hair_color_1\":0,\"sex\":1,\"moles_2\":0,\"skin\":0,\"lipstick_4\":0,\"eye_color\":0,\"shoes_2\":0,\"helmet_1\":-1,\"eyebrows_2\":0,\"torso_2\":0,\"glasses_1\":0,\"chain_2\":0,\"chain_1\":0,\"shoes_1\":0,\"glasses_2\":0,\"lipstick_2\":0,\"face\":0,\"blush_1\":0,\"decals_1\":0,\"bodyb_1\":0,\"makeup_4\":0,\"arms\":0,\"blush_3\":0,\"helmet_2\":0,\"lipstick_3\":0,\"pants_2\":0,\"bags_2\":0,\"ears_2\":0,\"moles_1\":0,\"bproof_2\":0,\"blemishes_1\":0,\"ears_1\":-1,\"age_2\":0,\"makeup_1\":0,\"age_1\":0,\"makeup_3\":0,\"mask_2\":0,\"beard_2\":0,\"chest_3\":0,\"eyebrows_1\":0,\"tshirt_1\":0,\"complexion_2\":0,\"hair_2\":0,\"chest_2\":0,\"torso_1\":0,\"bracelets_2\":0,\"eyebrows_4\":0,\"blemishes_2\":0,\"tshirt_2\":0}', 'unemployed', 0, '[{\"ammo\":9634,\"name\":\"WEAPON_ASSAULTRIFLE\",\"components\":[\"clip_default\"],\"label\":\"Assault rifle\"}]', '{\"x\":-115.2,\"y\":-1128.0,\"z\":25.6}', 10, 0, 'user', 'Jakub', 'Protiva', '06/18/1995', 'm', '200', 0, 0, '[{\"name\":\"hunger\",\"val\":398300,\"percent\":39.83},{\"name\":\"thirst\",\"val\":423725,\"percent\":42.3725}]', '695-1031', NULL, NULL, NULL, NULL, NULL, NULL, '[]', '[]', '[]', '[]', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_accounts`
--

CREATE TABLE `user_accounts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(22) NOT NULL,
  `name` varchar(50) NOT NULL,
  `money` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `user_accounts`
--

INSERT INTO `user_accounts` (`id`, `identifier`, `name`, `money`) VALUES
(1, 'steam:11000011488633d', 'black_money', 0),
(2, 'steam:110000119bffa22', 'black_money', 0),
(3, 'steam:110000137dfca7f', 'black_money', 0),
(4, 'steam:11000011c573ef6', 'black_money', 0),
(5, 'steam:110000115cf38b3', 'black_money', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_convictions`
--

CREATE TABLE `user_convictions` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_inventory`
--

CREATE TABLE `user_inventory` (
  `id` int(11) NOT NULL,
  `identifier` varchar(22) NOT NULL,
  `item` varchar(50) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `user_inventory`
--

INSERT INTO `user_inventory` (`id`, `identifier`, `item`, `count`) VALUES
(1, 'steam:11000011488633d', 'stone', 0),
(2, 'steam:11000011488633d', 'wood', 0),
(3, 'steam:11000011488633d', 'petrol', 0),
(4, 'steam:11000011488633d', 'licenseplate', 1),
(5, 'steam:11000011488633d', 'gazbottle', 0),
(6, 'steam:11000011488633d', 'packaged_chicken', 0),
(7, 'steam:11000011488633d', 'cburger', 0),
(8, 'steam:11000011488633d', 'gold_t', 0),
(9, 'steam:11000011488633d', 'wool', 0),
(10, 'steam:11000011488633d', 'carotool', 0),
(11, 'steam:11000011488633d', 'clip', 0),
(12, 'steam:11000011488633d', 'jewels', 0),
(13, 'steam:11000011488633d', 'highradio', 0),
(14, 'steam:11000011488633d', 'battery', 1),
(15, 'steam:11000011488633d', 'mleko', 0),
(16, 'steam:11000011488633d', 'crack', 0),
(17, 'steam:11000011488633d', 'radio', 0),
(18, 'steam:11000011488633d', 'lowradio', 0),
(19, 'steam:11000011488633d', 'fountain', 0),
(20, 'steam:11000011488633d', 'cannabis', 0),
(21, 'steam:11000011488633d', 'airbag', 0),
(22, 'steam:11000011488633d', 'medikit', 0),
(23, 'steam:11000011488633d', 'turbo', 0),
(24, 'steam:11000011488633d', 'armor', 0),
(25, 'steam:11000011488633d', 'cutted_wood', 0),
(26, 'steam:11000011488633d', 'bread', 0),
(27, 'steam:11000011488633d', 'highrim', 1),
(28, 'steam:11000011488633d', 'spice', 0),
(29, 'steam:11000011488633d', 'bandage', 0),
(30, 'steam:11000011488633d', 'bandage2', 0),
(31, 'steam:11000011488633d', 'packaged_plank', 0),
(32, 'steam:11000011488633d', 'fishingrod', 0),
(33, 'steam:11000011488633d', 'coke', 0),
(34, 'steam:11000011488633d', 'cannabinoid', 0),
(35, 'steam:11000011488633d', 'essence', 0),
(36, 'steam:11000011488633d', 'diamond', 0),
(37, 'steam:11000011488633d', 'beer', 0),
(38, 'steam:11000011488633d', 'fishbait', 0),
(39, 'steam:11000011488633d', 'hotdog', 0),
(40, 'steam:11000011488633d', 'slaughtered_chicken', 0),
(41, 'steam:11000011488633d', 'trailburst', 0),
(42, 'steam:11000011488633d', 'washed_stone', 0),
(43, 'steam:11000011488633d', 'fish', 0),
(44, 'steam:11000011488633d', 'vodka', 0),
(45, 'steam:11000011488633d', 'fries', 0),
(46, 'steam:11000011488633d', 'taco', 0),
(47, 'steam:11000011488633d', 'tuning_laptop', 4),
(48, 'steam:11000011488633d', 'water', 0),
(49, 'steam:11000011488633d', 'gold', 0),
(50, 'steam:11000011488633d', 'taco3', 0),
(51, 'steam:11000011488633d', 'dcburger', 0),
(52, 'steam:11000011488633d', 'marijuana', 0),
(53, 'steam:11000011488633d', 'advancedlockpick', 0),
(54, 'steam:11000011488633d', 'taco2', 0),
(55, 'steam:11000011488633d', 'clothe', 0),
(56, 'steam:11000011488633d', 'petrol_raffin', 0),
(57, 'steam:11000011488633d', 'cola', 0),
(58, 'steam:11000011488633d', 'carokit', 0),
(59, 'steam:11000011488633d', 'oxygen_mask', 0),
(60, 'steam:11000011488633d', 'sprite', 0),
(61, 'steam:11000011488633d', 'turtlebait', 1),
(62, 'steam:11000011488633d', 'fixtool', 0),
(63, 'steam:11000011488633d', 'stockrim', 1),
(64, 'steam:11000011488633d', 'fixkit', 0),
(65, 'steam:11000011488633d', 'starburst', 0),
(66, 'steam:11000011488633d', 'armor2', 0),
(67, 'steam:11000011488633d', 'iron', 0),
(68, 'steam:11000011488633d', 'gold_o', 0),
(69, 'steam:11000011488633d', 'copper', 0),
(70, 'steam:11000011488633d', 'alive_chicken', 0),
(71, 'steam:11000011488633d', 'blowpipe', 0),
(72, 'steam:11000011488633d', 'fries2', 0),
(73, 'steam:11000011488633d', 'fabric', 0),
(74, 'steam:11000011488633d', 'coffees', 0),
(75, 'steam:11000011488633d', 'shotburst', 0),
(76, 'steam:110000119bffa22', 'fishingrod', 0),
(77, 'steam:110000119bffa22', 'alive_chicken', 0),
(78, 'steam:110000119bffa22', 'hotdog', 0),
(79, 'steam:110000119bffa22', 'armor', 0),
(80, 'steam:110000119bffa22', 'lowradio', 0),
(81, 'steam:110000119bffa22', 'marijuana', 0),
(82, 'steam:110000119bffa22', 'carokit', 0),
(83, 'steam:110000119bffa22', 'mleko', 0),
(84, 'steam:110000119bffa22', 'armor2', 0),
(85, 'steam:110000119bffa22', 'shotburst', 0),
(86, 'steam:110000119bffa22', 'highrim', 0),
(87, 'steam:110000119bffa22', 'gold', 0),
(88, 'steam:110000119bffa22', 'tuning_laptop', 3),
(89, 'steam:110000119bffa22', 'clothe', 0),
(90, 'steam:110000119bffa22', 'stone', 0),
(91, 'steam:110000119bffa22', 'taco2', 0),
(92, 'steam:110000119bffa22', 'slaughtered_chicken', 0),
(93, 'steam:110000119bffa22', 'diamond', 0),
(94, 'steam:110000119bffa22', 'clip', 0),
(95, 'steam:110000119bffa22', 'cola', 0),
(96, 'steam:110000119bffa22', 'gold_t', 0),
(97, 'steam:110000119bffa22', 'vodka', 0),
(98, 'steam:110000119bffa22', 'airbag', 0),
(99, 'steam:110000119bffa22', 'starburst', 0),
(100, 'steam:110000119bffa22', 'cannabinoid', 0),
(101, 'steam:110000119bffa22', 'cutted_wood', 0),
(102, 'steam:110000119bffa22', 'coffees', 0),
(103, 'steam:110000119bffa22', 'wood', 0),
(104, 'steam:110000119bffa22', 'wool', 0),
(105, 'steam:110000119bffa22', 'spice', 0),
(106, 'steam:110000119bffa22', 'dcburger', 0),
(107, 'steam:110000119bffa22', 'fishbait', 0),
(108, 'steam:110000119bffa22', 'bread', 0),
(109, 'steam:110000119bffa22', 'cburger', 0),
(110, 'steam:110000119bffa22', 'fountain', 0),
(111, 'steam:110000119bffa22', 'fries2', 0),
(112, 'steam:110000119bffa22', 'highradio', 0),
(113, 'steam:110000119bffa22', 'cannabis', 0),
(114, 'steam:110000119bffa22', 'petrol', 0),
(115, 'steam:110000119bffa22', 'oxygen_mask', 0),
(116, 'steam:110000119bffa22', 'sprite', 0),
(117, 'steam:110000119bffa22', 'gold_o', 0),
(118, 'steam:110000119bffa22', 'packaged_chicken', 0),
(119, 'steam:110000119bffa22', 'jewels', 0),
(120, 'steam:110000119bffa22', 'copper', 0),
(121, 'steam:110000119bffa22', 'water', 0),
(122, 'steam:110000119bffa22', 'carotool', 0),
(123, 'steam:110000119bffa22', 'bandage2', 0),
(124, 'steam:110000119bffa22', 'iron', 0),
(125, 'steam:110000119bffa22', 'taco3', 0),
(126, 'steam:110000119bffa22', 'turtlebait', 0),
(127, 'steam:110000119bffa22', 'petrol_raffin', 0),
(128, 'steam:110000119bffa22', 'turbo', 0),
(129, 'steam:110000119bffa22', 'medikit', 0),
(130, 'steam:110000119bffa22', 'trailburst', 0),
(131, 'steam:110000119bffa22', 'washed_stone', 0),
(132, 'steam:110000119bffa22', 'fabric', 0),
(133, 'steam:110000119bffa22', 'battery', 0),
(134, 'steam:110000119bffa22', 'bandage', 0),
(135, 'steam:110000119bffa22', 'stockrim', 0),
(136, 'steam:110000119bffa22', 'crack', 0),
(137, 'steam:110000119bffa22', 'coke', 0),
(138, 'steam:110000119bffa22', 'fries', 0),
(139, 'steam:110000119bffa22', 'beer', 0),
(140, 'steam:110000119bffa22', 'advancedlockpick', 0),
(141, 'steam:110000119bffa22', 'essence', 0),
(142, 'steam:110000119bffa22', 'fixkit', 0),
(143, 'steam:110000119bffa22', 'gazbottle', 0),
(144, 'steam:110000119bffa22', 'blowpipe', 0),
(145, 'steam:110000119bffa22', 'radio', 0),
(146, 'steam:110000119bffa22', 'fixtool', 0),
(147, 'steam:110000119bffa22', 'licenseplate', 0),
(148, 'steam:110000119bffa22', 'fish', 0),
(149, 'steam:110000119bffa22', 'taco', 0),
(150, 'steam:110000119bffa22', 'packaged_plank', 0),
(151, 'steam:110000137dfca7f', 'highradio', 0),
(152, 'steam:110000137dfca7f', 'hotdog', 0),
(153, 'steam:110000137dfca7f', 'wool', 0),
(154, 'steam:110000137dfca7f', 'radio', 0),
(155, 'steam:110000137dfca7f', 'stone', 0),
(156, 'steam:110000137dfca7f', 'fixtool', 0),
(157, 'steam:110000137dfca7f', 'slaughtered_chicken', 0),
(158, 'steam:110000137dfca7f', 'alive_chicken', 0),
(159, 'steam:110000137dfca7f', 'cannabis', 0),
(160, 'steam:110000137dfca7f', 'taco2', 0),
(161, 'steam:110000137dfca7f', 'dcburger', 0),
(162, 'steam:110000137dfca7f', 'cola', 0),
(163, 'steam:110000137dfca7f', 'essence', 0),
(164, 'steam:110000137dfca7f', 'bread', 0),
(165, 'steam:110000137dfca7f', 'battery', 0),
(166, 'steam:110000137dfca7f', 'mleko', 0),
(167, 'steam:110000137dfca7f', 'armor2', 0),
(168, 'steam:110000137dfca7f', 'fishingrod', 0),
(169, 'steam:110000137dfca7f', 'clip', 0),
(170, 'steam:110000137dfca7f', 'advancedlockpick', 0),
(171, 'steam:110000137dfca7f', 'carokit', 0),
(172, 'steam:110000137dfca7f', 'petrol_raffin', 0),
(173, 'steam:110000137dfca7f', 'fishbait', 0),
(174, 'steam:110000137dfca7f', 'bandage2', 0),
(175, 'steam:110000137dfca7f', 'gold_t', 0),
(176, 'steam:110000137dfca7f', 'diamond', 0),
(177, 'steam:110000137dfca7f', 'oxygen_mask', 0),
(178, 'steam:110000137dfca7f', 'fountain', 0),
(179, 'steam:110000137dfca7f', 'vodka', 0),
(180, 'steam:110000137dfca7f', 'shotburst', 0),
(181, 'steam:110000137dfca7f', 'coffees', 0),
(182, 'steam:110000137dfca7f', 'cburger', 0),
(183, 'steam:110000137dfca7f', 'turtlebait', 0),
(184, 'steam:110000137dfca7f', 'cannabinoid', 0),
(185, 'steam:110000137dfca7f', 'highrim', 0),
(186, 'steam:110000137dfca7f', 'fries', 0),
(187, 'steam:110000137dfca7f', 'lowradio', 0),
(188, 'steam:110000137dfca7f', 'medikit', 0),
(189, 'steam:110000137dfca7f', 'clothe', 0),
(190, 'steam:110000137dfca7f', 'armor', 0),
(191, 'steam:110000137dfca7f', 'packaged_plank', 0),
(192, 'steam:110000137dfca7f', 'gold', 0),
(193, 'steam:110000137dfca7f', 'crack', 0),
(194, 'steam:110000137dfca7f', 'taco', 0),
(195, 'steam:110000137dfca7f', 'tuning_laptop', 0),
(196, 'steam:110000137dfca7f', 'bandage', 0),
(197, 'steam:110000137dfca7f', 'wood', 0),
(198, 'steam:110000137dfca7f', 'cutted_wood', 0),
(199, 'steam:110000137dfca7f', 'water', 0),
(200, 'steam:110000137dfca7f', 'carotool', 0),
(201, 'steam:110000137dfca7f', 'packaged_chicken', 0),
(202, 'steam:110000137dfca7f', 'turbo', 0),
(203, 'steam:110000137dfca7f', 'gold_o', 0),
(204, 'steam:110000137dfca7f', 'stockrim', 0),
(205, 'steam:110000137dfca7f', 'iron', 0),
(206, 'steam:110000137dfca7f', 'taco3', 0),
(207, 'steam:110000137dfca7f', 'starburst', 0),
(208, 'steam:110000137dfca7f', 'licenseplate', 0),
(209, 'steam:110000137dfca7f', 'fries2', 0),
(210, 'steam:110000137dfca7f', 'trailburst', 0),
(211, 'steam:110000137dfca7f', 'fish', 0),
(212, 'steam:110000137dfca7f', 'beer', 0),
(213, 'steam:110000137dfca7f', 'marijuana', 0),
(214, 'steam:110000137dfca7f', 'copper', 0),
(215, 'steam:110000137dfca7f', 'jewels', 0),
(216, 'steam:110000137dfca7f', 'gazbottle', 0),
(217, 'steam:110000137dfca7f', 'airbag', 0),
(218, 'steam:110000137dfca7f', 'sprite', 0),
(219, 'steam:110000137dfca7f', 'washed_stone', 0),
(220, 'steam:110000137dfca7f', 'petrol', 0),
(221, 'steam:110000137dfca7f', 'spice', 0),
(222, 'steam:110000137dfca7f', 'fixkit', 0),
(223, 'steam:110000137dfca7f', 'fabric', 0),
(224, 'steam:110000137dfca7f', 'coke', 0),
(225, 'steam:110000137dfca7f', 'blowpipe', 0),
(226, 'steam:11000011c573ef6', 'oxygen_mask', 0),
(227, 'steam:11000011c573ef6', 'packaged_plank', 0),
(228, 'steam:11000011c573ef6', 'wool', 0),
(229, 'steam:11000011c573ef6', 'washed_stone', 0),
(230, 'steam:11000011c573ef6', 'vodka', 0),
(231, 'steam:11000011c573ef6', 'slaughtered_chicken', 0),
(232, 'steam:11000011c573ef6', 'bread', 0),
(233, 'steam:11000011c573ef6', 'mleko', 0),
(234, 'steam:11000011c573ef6', 'cburger', 0),
(235, 'steam:11000011c573ef6', 'spice', 0),
(236, 'steam:11000011c573ef6', 'carokit', 0),
(237, 'steam:11000011c573ef6', 'hotdog', 0),
(238, 'steam:11000011c573ef6', 'turbo', 0),
(239, 'steam:11000011c573ef6', 'highradio', 0),
(240, 'steam:11000011c573ef6', 'cannabis', 0),
(241, 'steam:11000011c573ef6', 'fixkit', 0),
(242, 'steam:11000011c573ef6', 'shotburst', 0),
(243, 'steam:11000011c573ef6', 'fountain', 0),
(244, 'steam:11000011c573ef6', 'bandage', 0),
(245, 'steam:11000011c573ef6', 'crack', 0),
(246, 'steam:11000011c573ef6', 'gold', 0),
(247, 'steam:11000011c573ef6', 'gazbottle', 0),
(248, 'steam:11000011c573ef6', 'petrol', 0),
(249, 'steam:11000011c573ef6', 'gold_o', 0),
(250, 'steam:11000011c573ef6', 'coke', 0),
(251, 'steam:11000011c573ef6', 'copper', 0),
(252, 'steam:11000011c573ef6', 'clothe', 0),
(253, 'steam:11000011c573ef6', 'fries', 0),
(254, 'steam:11000011c573ef6', 'gold_t', 0),
(255, 'steam:11000011c573ef6', 'advancedlockpick', 0),
(256, 'steam:11000011c573ef6', 'cannabinoid', 0),
(257, 'steam:11000011c573ef6', 'sprite', 0),
(258, 'steam:11000011c573ef6', 'stone', 0),
(259, 'steam:11000011c573ef6', 'wood', 0),
(260, 'steam:11000011c573ef6', 'medikit', 0),
(261, 'steam:11000011c573ef6', 'fish', 0),
(262, 'steam:11000011c573ef6', 'diamond', 0),
(263, 'steam:11000011c573ef6', 'fries2', 0),
(264, 'steam:11000011c573ef6', 'bandage2', 0),
(265, 'steam:11000011c573ef6', 'taco2', 0),
(266, 'steam:11000011c573ef6', 'fishbait', 11),
(267, 'steam:11000011c573ef6', 'fixtool', 0),
(268, 'steam:11000011c573ef6', 'cola', 0),
(269, 'steam:11000011c573ef6', 'taco', 0),
(270, 'steam:11000011c573ef6', 'jewels', 0),
(271, 'steam:11000011c573ef6', 'cutted_wood', 0),
(272, 'steam:11000011c573ef6', 'water', 0),
(273, 'steam:11000011c573ef6', 'radio', 0),
(274, 'steam:11000011c573ef6', 'packaged_chicken', 0),
(275, 'steam:11000011c573ef6', 'blowpipe', 0),
(276, 'steam:11000011c573ef6', 'turtlebait', 16),
(277, 'steam:11000011c573ef6', 'armor2', 2),
(278, 'steam:11000011c573ef6', 'taco3', 0),
(279, 'steam:11000011c573ef6', 'tuning_laptop', 0),
(280, 'steam:11000011c573ef6', 'petrol_raffin', 0),
(281, 'steam:11000011c573ef6', 'trailburst', 0),
(282, 'steam:11000011c573ef6', 'essence', 0),
(283, 'steam:11000011c573ef6', 'fabric', 0),
(284, 'steam:11000011c573ef6', 'fishingrod', 3),
(285, 'steam:11000011c573ef6', 'stockrim', 0),
(286, 'steam:11000011c573ef6', 'lowradio', 0),
(287, 'steam:11000011c573ef6', 'battery', 0),
(288, 'steam:11000011c573ef6', 'armor', 0),
(289, 'steam:11000011c573ef6', 'licenseplate', 0),
(290, 'steam:11000011c573ef6', 'highrim', 0),
(291, 'steam:11000011c573ef6', 'beer', 0),
(292, 'steam:11000011c573ef6', 'starburst', 0),
(293, 'steam:11000011c573ef6', 'airbag', 0),
(294, 'steam:11000011c573ef6', 'coffees', 0),
(295, 'steam:11000011c573ef6', 'alive_chicken', 0),
(296, 'steam:11000011c573ef6', 'dcburger', 0),
(297, 'steam:11000011c573ef6', 'marijuana', 0),
(298, 'steam:11000011c573ef6', 'iron', 0),
(299, 'steam:11000011c573ef6', 'carotool', 0),
(300, 'steam:11000011c573ef6', 'clip', 0),
(301, 'steam:110000119bffa22', 'opium', 0),
(302, 'steam:110000119bffa22', 'opium_pooch', 0),
(303, 'steam:110000119bffa22', 'meth_pooch', 0),
(304, 'steam:110000119bffa22', 'coke_pooch', 0),
(305, 'steam:110000119bffa22', 'weed_pooch', 0),
(306, 'steam:110000119bffa22', 'weed', 0),
(307, 'steam:110000119bffa22', 'meth', 0),
(308, 'steam:11000011488633d', 'meth_pooch', 0),
(309, 'steam:11000011488633d', 'opium_pooch', 0),
(310, 'steam:11000011488633d', 'weed', 1),
(311, 'steam:11000011488633d', 'coke_pooch', 0),
(312, 'steam:11000011488633d', 'opium', 0),
(313, 'steam:11000011488633d', 'weed_pooch', 0),
(314, 'steam:11000011488633d', 'meth', 0),
(315, 'steam:11000011488633d', 'sim', 0),
(316, 'steam:110000119bffa22', 'sim', 0),
(317, 'steam:11000011c573ef6', 'weed_pooch', 0),
(318, 'steam:11000011c573ef6', 'opium', 0),
(319, 'steam:11000011c573ef6', 'weed', 0),
(320, 'steam:11000011c573ef6', 'meth_pooch', 0),
(321, 'steam:11000011c573ef6', 'meth', 0),
(322, 'steam:11000011c573ef6', 'opium_pooch', 0),
(323, 'steam:11000011c573ef6', 'sim', 0),
(324, 'steam:11000011c573ef6', 'coke_pooch', 0),
(325, 'steam:110000137dfca7f', 'meth_pooch', 0),
(326, 'steam:110000137dfca7f', 'weed', 0),
(327, 'steam:110000137dfca7f', 'weed_pooch', 0),
(328, 'steam:110000137dfca7f', 'opium', 0),
(329, 'steam:110000137dfca7f', 'sim', 0),
(330, 'steam:110000137dfca7f', 'coke_pooch', 0),
(331, 'steam:110000137dfca7f', 'opium_pooch', 0),
(332, 'steam:110000137dfca7f', 'meth', 0),
(333, 'steam:110000115cf38b3', 'iron', 0),
(334, 'steam:110000115cf38b3', 'clip', 0),
(335, 'steam:110000115cf38b3', 'opium', 0),
(336, 'steam:110000115cf38b3', 'fixkit', 0),
(337, 'steam:110000115cf38b3', 'cutted_wood', 0),
(338, 'steam:110000115cf38b3', 'radio', 0),
(339, 'steam:110000115cf38b3', 'taco', 0),
(340, 'steam:110000115cf38b3', 'packaged_plank', 0),
(341, 'steam:110000115cf38b3', 'cola', 0),
(342, 'steam:110000115cf38b3', 'stone', 0),
(343, 'steam:110000115cf38b3', 'armor', 0),
(344, 'steam:110000115cf38b3', 'turbo', 0),
(345, 'steam:110000115cf38b3', 'fishbait', 0),
(346, 'steam:110000115cf38b3', 'coke', 0),
(347, 'steam:110000115cf38b3', 'weed', 0),
(348, 'steam:110000115cf38b3', 'coke_pooch', 0),
(349, 'steam:110000115cf38b3', 'carokit', 0),
(350, 'steam:110000115cf38b3', 'sprite', 0),
(351, 'steam:110000115cf38b3', 'fries', 0),
(352, 'steam:110000115cf38b3', 'wool', 0),
(353, 'steam:110000115cf38b3', 'fish', 0),
(354, 'steam:110000115cf38b3', 'clothe', 0),
(355, 'steam:110000115cf38b3', 'beer', 0),
(356, 'steam:110000115cf38b3', 'highrim', 0),
(357, 'steam:110000115cf38b3', 'gold_t', 0),
(358, 'steam:110000115cf38b3', 'gold_o', 0),
(359, 'steam:110000115cf38b3', 'crack', 0),
(360, 'steam:110000115cf38b3', 'petrol_raffin', 0),
(361, 'steam:110000115cf38b3', 'taco3', 0),
(362, 'steam:110000115cf38b3', 'bread', 0),
(363, 'steam:110000115cf38b3', 'carotool', 0),
(364, 'steam:110000115cf38b3', 'washed_stone', 0),
(365, 'steam:110000115cf38b3', 'shotburst', 0),
(366, 'steam:110000115cf38b3', 'lowradio', 0),
(367, 'steam:110000115cf38b3', 'meth', 0),
(368, 'steam:110000115cf38b3', 'coffees', 0),
(369, 'steam:110000115cf38b3', 'jewels', 0),
(370, 'steam:110000115cf38b3', 'meth_pooch', 0),
(371, 'steam:110000115cf38b3', 'alive_chicken', 0),
(372, 'steam:110000115cf38b3', 'bandage2', 0),
(373, 'steam:110000115cf38b3', 'packaged_chicken', 0),
(374, 'steam:110000115cf38b3', 'copper', 0),
(375, 'steam:110000115cf38b3', 'weed_pooch', 0),
(376, 'steam:110000115cf38b3', 'fountain', 0),
(377, 'steam:110000115cf38b3', 'wood', 0),
(378, 'steam:110000115cf38b3', 'vodka', 0),
(379, 'steam:110000115cf38b3', 'gazbottle', 0),
(380, 'steam:110000115cf38b3', 'turtlebait', 0),
(381, 'steam:110000115cf38b3', 'petrol', 0),
(382, 'steam:110000115cf38b3', 'water', 0),
(383, 'steam:110000115cf38b3', 'tuning_laptop', 0),
(384, 'steam:110000115cf38b3', 'trailburst', 0),
(385, 'steam:110000115cf38b3', 'taco2', 0),
(386, 'steam:110000115cf38b3', 'oxygen_mask', 0),
(387, 'steam:110000115cf38b3', 'stockrim', 0),
(388, 'steam:110000115cf38b3', 'hotdog', 0),
(389, 'steam:110000115cf38b3', 'starburst', 0),
(390, 'steam:110000115cf38b3', 'battery', 0),
(391, 'steam:110000115cf38b3', 'spice', 0),
(392, 'steam:110000115cf38b3', 'cannabinoid', 0),
(393, 'steam:110000115cf38b3', 'fishingrod', 0),
(394, 'steam:110000115cf38b3', 'fabric', 0),
(395, 'steam:110000115cf38b3', 'armor2', 0),
(396, 'steam:110000115cf38b3', 'sim', 0),
(397, 'steam:110000115cf38b3', 'cannabis', 0),
(398, 'steam:110000115cf38b3', 'licenseplate', 0),
(399, 'steam:110000115cf38b3', 'essence', 0),
(400, 'steam:110000115cf38b3', 'advancedlockpick', 0),
(401, 'steam:110000115cf38b3', 'diamond', 0),
(402, 'steam:110000115cf38b3', 'dcburger', 0),
(403, 'steam:110000115cf38b3', 'cburger', 0),
(404, 'steam:110000115cf38b3', 'mleko', 0),
(405, 'steam:110000115cf38b3', 'opium_pooch', 0),
(406, 'steam:110000115cf38b3', 'blowpipe', 0),
(407, 'steam:110000115cf38b3', 'airbag', 0),
(408, 'steam:110000115cf38b3', 'slaughtered_chicken', 0),
(409, 'steam:110000115cf38b3', 'medikit', 0),
(410, 'steam:110000115cf38b3', 'fixtool', 0),
(411, 'steam:110000115cf38b3', 'highradio', 0),
(412, 'steam:110000115cf38b3', 'marijuana', 0),
(413, 'steam:110000115cf38b3', 'gold', 0),
(414, 'steam:110000115cf38b3', 'bandage', 0),
(415, 'steam:110000115cf38b3', 'fries2', 0),
(416, 'steam:11000011488633d', 'Waters', 0),
(417, 'steam:110000119bffa22', 'Waters', 0),
(418, 'steam:110000137dfca7f', 'Waters', 0),
(419, 'steam:11000011c573ef6', 'Waters', 0);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `user_licenses`
--

INSERT INTO `user_licenses` (`id`, `type`, `owner`) VALUES
(1, 'dmv', 'steam:110000137dfca7f'),
(2, 'dmv', 'steam:110000119bffa22'),
(3, 'drive', 'steam:110000119bffa22'),
(4, 'dmv', 'steam:11000011488633d'),
(5, 'drive', 'steam:11000011488633d');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_mdt`
--

CREATE TABLE `user_mdt` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_perms`
--

CREATE TABLE `user_perms` (
  `perm` bigint(20) NOT NULL,
  `name` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Sťahujem dáta pre tabuľku `user_perms`
--

INSERT INTO `user_perms` (`perm`, `name`) VALUES
(1, 'Is A Registered Member[Do not uncheck this or will break usergroups!]'),
(2, 'Can Access Call Overview Page'),
(4, 'Can Access Assign Calls Page [Must have \"Can Access Call Overview Page\" Enabled]'),
(8, 'Can Access Dismiss Calls Page [Must have \"Can Access Call Overview Page\" Enabled]'),
(16, 'Can Access Civilian Area'),
(32, 'Can Access BOLO Area'),
(64, 'Can Access Reports Area'),
(128, 'Can Access CAD Area'),
(256, 'Can Access Admin Area'),
(512, 'Is a Command Member'),
(2048, 'Can End Shifts'),
(4096, 'Can Ban mdt_users'),
(8192, 'Can View Reports'),
(16384, 'Can view Form Responses'),
(32768, 'Can create & Delete events');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_properties`
--

CREATE TABLE `user_properties` (
  `userId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vehicles`
--

INSERT INTO `vehicles` (`id`, `name`, `model`, `price`, `category`) VALUES
(1, 'Blade', 'blade', 15000, 'muscle'),
(2, 'Buccaneer', 'buccaneer', 18000, 'muscle'),
(3, 'Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
(4, 'Chino', 'chino', 15000, 'muscle'),
(5, 'Chino Luxe', 'chino2', 19000, 'muscle'),
(6, 'Coquette BlackFin', 'coquette3', 55000, 'muscle'),
(7, 'Dominator', 'dominator', 35000, 'muscle'),
(8, 'Dukes', 'dukes', 28000, 'muscle'),
(9, 'Gauntlet', 'gauntlet', 30000, 'muscle'),
(10, 'Hotknife', 'hotknife', 125000, 'muscle'),
(11, 'Faction', 'faction', 20000, 'muscle'),
(12, 'Faction Rider', 'faction2', 30000, 'muscle'),
(13, 'Faction XL', 'faction3', 40000, 'muscle'),
(14, 'Nightshade', 'nightshade', 65000, 'muscle'),
(15, 'Phoenix', 'phoenix', 12500, 'muscle'),
(16, 'Picador', 'picador', 18000, 'muscle'),
(17, 'Sabre Turbo', 'sabregt', 20000, 'muscle'),
(18, 'Sabre GT', 'sabregt2', 25000, 'muscle'),
(19, 'Slam Van', 'slamvan3', 11500, 'muscle'),
(20, 'Tampa', 'tampa', 16000, 'muscle'),
(21, 'Virgo', 'virgo', 14000, 'muscle'),
(22, 'Vigero', 'vigero', 12500, 'muscle'),
(23, 'Voodoo', 'voodoo', 7200, 'muscle'),
(24, 'Blista', 'blista', 8000, 'compacts'),
(25, 'Brioso R/A', 'brioso', 18000, 'compacts'),
(26, 'Issi', 'issi2', 10000, 'compacts'),
(27, 'Panto', 'panto', 10000, 'compacts'),
(28, 'Prairie', 'prairie', 12000, 'compacts'),
(29, 'Bison', 'bison', 45000, 'vans'),
(30, 'Bobcat XL', 'bobcatxl', 32000, 'vans'),
(31, 'Burrito', 'burrito3', 19000, 'vans'),
(32, 'Burrito', 'gburrito2', 29000, 'vans'),
(33, 'Camper', 'camper', 42000, 'vans'),
(34, 'Gang Burrito', 'gburrito', 45000, 'vans'),
(35, 'Journey', 'journey', 6500, 'vans'),
(36, 'Minivan', 'minivan', 13000, 'vans'),
(37, 'Moonbeam', 'moonbeam', 18000, 'vans'),
(38, 'Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
(39, 'Paradise', 'paradise', 19000, 'vans'),
(40, 'Rumpo', 'rumpo', 15000, 'vans'),
(41, 'Rumpo Trail', 'rumpo3', 19500, 'vans'),
(42, 'Surfer', 'surfer', 12000, 'vans'),
(43, 'Youga', 'youga', 10800, 'vans'),
(44, 'Youga Luxuary', 'youga2', 14500, 'vans'),
(45, 'Asea', 'asea', 5500, 'sedans'),
(46, 'Cognoscenti', 'cognoscenti', 55000, 'sedans'),
(47, 'Emperor', 'emperor', 8500, 'sedans'),
(48, 'Fugitive', 'fugitive', 12000, 'sedans'),
(49, 'Glendale', 'glendale', 6500, 'sedans'),
(50, 'Intruder', 'intruder', 7500, 'sedans'),
(51, 'Premier', 'premier', 8000, 'sedans'),
(52, 'Primo Custom', 'primo2', 14000, 'sedans'),
(53, 'Regina', 'regina', 5000, 'sedans'),
(54, 'Schafter', 'schafter2', 25000, 'sedans'),
(55, 'Stretch', 'stretch', 90000, 'sedans'),
(56, 'Super Diamond', 'superd', 130000, 'sedans'),
(57, 'Tailgater', 'tailgater', 30000, 'sedans'),
(58, 'Warrener', 'warrener', 4000, 'sedans'),
(59, 'Washington', 'washington', 9000, 'sedans'),
(60, 'Baller', 'baller2', 40000, 'suvs'),
(61, 'Baller Sport', 'baller3', 60000, 'suvs'),
(62, 'Cavalcade', 'cavalcade2', 55000, 'suvs'),
(63, 'Contender', 'contender', 70000, 'suvs'),
(64, 'Dubsta', 'dubsta', 45000, 'suvs'),
(65, 'Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
(66, 'Fhantom', 'fq2', 17000, 'suvs'),
(67, 'Grabger', 'granger', 50000, 'suvs'),
(68, 'Gresley', 'gresley', 47500, 'suvs'),
(69, 'Huntley S', 'huntley', 40000, 'suvs'),
(70, 'Landstalker', 'landstalker', 35000, 'suvs'),
(71, 'Mesa', 'mesa', 16000, 'suvs'),
(72, 'Mesa Trail', 'mesa3', 40000, 'suvs'),
(73, 'Patriot', 'patriot', 55000, 'suvs'),
(74, 'Radius', 'radi', 29000, 'suvs'),
(75, 'Rocoto', 'rocoto', 45000, 'suvs'),
(76, 'Seminole', 'seminole', 25000, 'suvs'),
(77, 'XLS', 'xls', 32000, 'suvs'),
(78, 'Btype', 'btype', 62000, 'sportsclassics'),
(79, 'Btype Luxe', 'btype3', 85000, 'sportsclassics'),
(80, 'Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
(81, 'Casco', 'casco', 30000, 'sportsclassics'),
(82, 'Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
(83, 'Manana', 'manana', 12800, 'sportsclassics'),
(84, 'Monroe', 'monroe', 55000, 'sportsclassics'),
(85, 'Pigalle', 'pigalle', 20000, 'sportsclassics'),
(86, 'Stinger', 'stinger', 80000, 'sportsclassics'),
(87, 'Stinger GT', 'stingergt', 75000, 'sportsclassics'),
(88, 'Stirling GT', 'feltzer3', 65000, 'sportsclassics'),
(89, 'Z-Type', 'ztype', 220000, 'sportsclassics'),
(90, 'Bifta', 'bifta', 12000, 'offroad'),
(91, 'Bf Injection', 'bfinjection', 16000, 'offroad'),
(92, 'Blazer', 'blazer', 6500, 'offroad'),
(93, 'Blazer Sport', 'blazer4', 8500, 'offroad'),
(94, 'Brawler', 'brawler', 45000, 'offroad'),
(95, 'Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
(96, 'Dune Buggy', 'dune', 8000, 'offroad'),
(97, 'Guardian', 'guardian', 45000, 'offroad'),
(98, 'Rebel', 'rebel2', 35000, 'offroad'),
(99, 'Sandking', 'sandking', 55000, 'offroad'),
(100, 'The Liberator', 'monster', 210000, 'offroad'),
(101, 'Trophy Truck', 'trophytruck', 60000, 'offroad'),
(102, 'Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
(103, 'Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes'),
(104, 'Exemplar', 'exemplar', 32000, 'coupes'),
(105, 'F620', 'f620', 40000, 'coupes'),
(106, 'Felon', 'felon', 42000, 'coupes'),
(107, 'Felon GT', 'felon2', 55000, 'coupes'),
(108, 'Jackal', 'jackal', 38000, 'coupes'),
(109, 'Oracle XS', 'oracle2', 35000, 'coupes'),
(110, 'Sentinel', 'sentinel', 32000, 'coupes'),
(111, 'Sentinel XS', 'sentinel2', 40000, 'coupes'),
(112, 'Windsor', 'windsor', 95000, 'coupes'),
(113, 'Windsor Drop', 'windsor2', 125000, 'coupes'),
(114, 'Zion', 'zion', 36000, 'coupes'),
(115, 'Zion Cabrio', 'zion2', 45000, 'coupes'),
(116, '9F', 'ninef', 65000, 'sports'),
(117, '9F Cabrio', 'ninef2', 80000, 'sports'),
(118, 'Alpha', 'alpha', 60000, 'sports'),
(119, 'Banshee', 'banshee', 70000, 'sports'),
(120, 'Bestia GTS', 'bestiagts', 55000, 'sports'),
(121, 'Buffalo', 'buffalo', 12000, 'sports'),
(122, 'Buffalo S', 'buffalo2', 20000, 'sports'),
(123, 'Carbonizzare', 'carbonizzare', 75000, 'sports'),
(124, 'Comet', 'comet2', 65000, 'sports'),
(125, 'Coquette', 'coquette', 65000, 'sports'),
(126, 'Drift Tampa', 'tampa2', 80000, 'sports'),
(127, 'Elegy', 'elegy2', 38500, 'sports'),
(128, 'Feltzer', 'feltzer2', 55000, 'sports'),
(129, 'Furore GT', 'furoregt', 45000, 'sports'),
(130, 'Fusilade', 'fusilade', 40000, 'sports'),
(131, 'Jester', 'jester', 65000, 'sports'),
(132, 'Jester(Racecar)', 'jester2', 135000, 'sports'),
(133, 'Khamelion', 'khamelion', 38000, 'sports'),
(134, 'Kuruma', 'kuruma', 30000, 'sports'),
(135, 'Lynx', 'lynx', 40000, 'sports'),
(136, 'Mamba', 'mamba', 70000, 'sports'),
(137, 'Massacro', 'massacro', 65000, 'sports'),
(138, 'Massacro(Racecar)', 'massacro2', 130000, 'sports'),
(139, 'Omnis', 'omnis', 35000, 'sports'),
(140, 'Penumbra', 'penumbra', 28000, 'sports'),
(141, 'Rapid GT', 'rapidgt', 35000, 'sports'),
(142, 'Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
(143, 'Schafter V12', 'schafter3', 50000, 'sports'),
(144, 'Seven 70', 'seven70', 39500, 'sports'),
(145, 'Sultan', 'sultan', 15000, 'sports'),
(146, 'Surano', 'surano', 50000, 'sports'),
(147, 'Tropos', 'tropos', 40000, 'sports'),
(148, 'Verlierer', 'verlierer2', 70000, 'sports'),
(149, 'Adder', 'adder', 900000, 'super'),
(150, 'Banshee 900R', 'banshee2', 255000, 'super'),
(151, 'Bullet', 'bullet', 90000, 'super'),
(152, 'Cheetah', 'cheetah', 375000, 'super'),
(153, 'Entity XF', 'entityxf', 425000, 'super'),
(154, 'ETR1', 'sheava', 220000, 'super'),
(155, 'FMJ', 'fmj', 185000, 'super'),
(156, 'Infernus', 'infernus', 180000, 'super'),
(157, 'Osiris', 'osiris', 160000, 'super'),
(158, 'Pfister', 'pfister811', 85000, 'super'),
(159, 'RE-7B', 'le7b', 325000, 'super'),
(160, 'Reaper', 'reaper', 150000, 'super'),
(161, 'Sultan RS', 'sultanrs', 65000, 'super'),
(162, 'T20', 't20', 300000, 'super'),
(163, 'Turismo R', 'turismor', 350000, 'super'),
(164, 'Tyrus', 'tyrus', 600000, 'super'),
(165, 'Vacca', 'vacca', 120000, 'super'),
(166, 'Voltic', 'voltic', 90000, 'super'),
(167, 'X80 Proto', 'prototipo', 2500000, 'super'),
(168, 'Zentorno', 'zentorno', 1500000, 'super'),
(169, 'Akuma', 'AKUMA', 7500, 'motorcycles'),
(170, 'Avarus', 'avarus', 18000, 'motorcycles'),
(171, 'Bagger', 'bagger', 13500, 'motorcycles'),
(172, 'Bati 801', 'bati', 12000, 'motorcycles'),
(173, 'Bati 801RR', 'bati2', 19000, 'motorcycles'),
(174, 'BF400', 'bf400', 6500, 'motorcycles'),
(175, 'BMX (velo)', 'bmx', 160, 'motorcycles'),
(176, 'Carbon RS', 'carbonrs', 18000, 'motorcycles'),
(177, 'Chimera', 'chimera', 38000, 'motorcycles'),
(178, 'Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
(179, 'Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
(180, 'Daemon', 'daemon', 11500, 'motorcycles'),
(181, 'Daemon High', 'daemon2', 13500, 'motorcycles'),
(182, 'Defiler', 'defiler', 9800, 'motorcycles'),
(183, 'Double T', 'double', 28000, 'motorcycles'),
(184, 'Enduro', 'enduro', 5500, 'motorcycles'),
(185, 'Esskey', 'esskey', 4200, 'motorcycles'),
(186, 'Faggio', 'faggio', 1900, 'motorcycles'),
(187, 'Vespa', 'faggio2', 2800, 'motorcycles'),
(188, 'Fixter (velo)', 'fixter', 225, 'motorcycles'),
(189, 'Gargoyle', 'gargoyle', 16500, 'motorcycles'),
(190, 'Hakuchou', 'hakuchou', 31000, 'motorcycles'),
(191, 'Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles'),
(192, 'Hexer', 'hexer', 12000, 'motorcycles'),
(193, 'Innovation', 'innovation', 23500, 'motorcycles'),
(194, 'Manchez', 'manchez', 5300, 'motorcycles'),
(195, 'Nemesis', 'nemesis', 5800, 'motorcycles'),
(196, 'Nightblade', 'nightblade', 35000, 'motorcycles'),
(197, 'PCJ-600', 'pcj', 6200, 'motorcycles'),
(198, 'Ruffian', 'ruffian', 6800, 'motorcycles'),
(199, 'Sanchez', 'sanchez', 5300, 'motorcycles'),
(200, 'Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
(201, 'Sanctus', 'sanctus', 25000, 'motorcycles'),
(202, 'Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
(203, 'Sovereign', 'sovereign', 22000, 'motorcycles'),
(204, 'Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
(205, 'Thrust', 'thrust', 24000, 'motorcycles'),
(206, 'Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
(207, 'Vader', 'vader', 7200, 'motorcycles'),
(208, 'Vortex', 'vortex', 9800, 'motorcycles'),
(209, 'Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
(210, 'Zombie', 'zombiea', 9500, 'motorcycles'),
(211, 'Zombie Luxuary', 'zombieb', 12000, 'motorcycles');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vehicles_for_sale`
--

CREATE TABLE `vehicles_for_sale` (
  `id` int(11) NOT NULL,
  `seller` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicleProps` longtext NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`id`, `name`, `label`) VALUES
(1, 'compacts', 'Compacts'),
(2, 'coupes', 'Coupés'),
(3, 'sedans', 'Sedans'),
(4, 'sports', 'Sports'),
(5, 'sportsclassics', 'Sports Classics'),
(6, 'super', 'Super'),
(7, 'muscle', 'Muscle'),
(8, 'offroad', 'Off Road'),
(9, 'suvs', 'SUVs'),
(10, 'vans', 'Vans'),
(11, 'sedans', 'Sedans'),
(12, 'motorcycles', 'Motos');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vehicle_properties`
--

CREATE TABLE `vehicle_properties` (
  `vehicleId` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vehicle_sold`
--

CREATE TABLE `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vois`
--

CREATE TABLE `vois` (
  `id` bigint(20) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL,
  `image` mediumtext NOT NULL,
  `reason` mediumtext NOT NULL,
  `notes` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_aircrafts`
--

CREATE TABLE `vs_aircrafts` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_aircrafts`
--

INSERT INTO `vs_aircrafts` (`name`, `model`, `price`, `category`) VALUES
('Alpha Z1', 'alphaz1', 1121000, 'plane'),
('Besra', 'besra', 1000000, 'plane'),
('Buzzard', 'buzzard2', 500000, 'heli'),
('Cuban 800', 'cuban800', 240000, 'plane'),
('Dodo', 'dodo', 500000, 'plane'),
('Duster', 'duster', 175000, 'plane'),
('Frogger', 'frogger', 800000, 'heli'),
('Havok', 'havok', 250000, 'heli'),
('Howard NX25', 'howard', 975000, 'plane'),
('Luxor', 'luxor', 1500000, 'plane'),
('Luxor Deluxe ', 'luxor2', 1750000, 'plane'),
('Mammatus', 'mammatus', 300000, 'plane'),
('Maverick', 'maverick', 750000, 'heli'),
('Ultra Light', 'microlight', 50000, 'plane'),
('Nimbus', 'nimbus', 900000, 'plane'),
('Rogue', 'rogue', 1000000, 'plane'),
('Sea Breeze', 'seabreeze', 850000, 'plane'),
('Sea Sparrow', 'seasparrow', 815000, 'heli'),
('Shamal', 'shamal', 1150000, 'plane'),
('Mallard', 'stunt', 250000, 'plane'),
('SuperVolito', 'supervolito', 1000000, 'heli'),
('SuperVolito Carbon', 'supervolito2', 1250000, 'heli'),
('Swift', 'swift', 1000000, 'heli'),
('Swift Deluxe', 'swift2', 1250000, 'heli'),
('Velum', 'velum2', 450000, 'plane'),
('Vestra', 'vestra', 950000, 'plane'),
('Volatus', 'volatus', 1250000, 'heli');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_aircraft_categories`
--

CREATE TABLE `vs_aircraft_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_aircraft_categories`
--

INSERT INTO `vs_aircraft_categories` (`name`, `label`) VALUES
('heli', 'Helicopters'),
('plane', 'Planes');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_ambulance`
--

CREATE TABLE `vs_ambulance` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_ambulance`
--

INSERT INTO `vs_ambulance` (`id`, `name`, `model`, `price`, `category`) VALUES
(1, 'Ambulance', 'ambulance', 500, 'ambulance'),
(2, 'Fire Truck', 'firetruk', 750, 'ambulance'),
(3, 'Ambulance', 'ambulance', 500, 'doctor'),
(4, 'Fire Truck', 'firetruk', 750, 'doctor'),
(5, 'Ambulance', 'ambulance', 500, 'chief_doctor'),
(6, 'Fire Truck', 'firetruk', 750, 'chief_doctor'),
(7, 'Ambulance', 'ambulance', 500, 'boss'),
(8, 'Fire Truck', 'firetruk', 750, 'boss'),
(9, 'Maverick', 'polmav', 1000, 'boss');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_ambulance_categories`
--

CREATE TABLE `vs_ambulance_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_ambulance_categories`
--

INSERT INTO `vs_ambulance_categories` (`name`, `label`) VALUES
('ambulance', 'Jr. EMT'),
('boss', 'EMT Supervisor'),
('chief_doctor', 'Sr. EMT'),
('doctor', 'EMT');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_boats`
--

CREATE TABLE `vs_boats` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_boats`
--

INSERT INTO `vs_boats` (`name`, `model`, `price`, `category`) VALUES
('Dinghy 4Seat', 'dinghy', 25000, 'boat'),
('Dinghy 2Seat', 'dinghy2', 20000, 'boat'),
('Dinghy Yacht', 'dinghy4', 25000, 'boat'),
('Jetmax', 'jetmax', 30000, 'boat'),
('Marquis', 'marquis', 45000, 'boat'),
('Seashark', 'seashark', 10000, 'boat'),
('Seashark Yacht', 'seashark3', 10000, 'boat'),
('Speeder', 'speeder', 40000, 'boat'),
('Squalo', 'squalo', 32000, 'boat'),
('Submarine', 'submersible', 29000, 'subs'),
('Kraken', 'submersible2', 31000, 'subs'),
('Suntrap', 'suntrap', 34000, 'boat'),
('Toro', 'toro', 38000, 'boat'),
('Toro Yacht', 'toro2', 38000, 'boat'),
('Tropic', 'tropic', 27000, 'boat'),
('Tropic Yacht', 'tropic2', 27000, 'boat');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_boat_categories`
--

CREATE TABLE `vs_boat_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_boat_categories`
--

INSERT INTO `vs_boat_categories` (`name`, `label`) VALUES
('boat', 'Boats'),
('subs', 'Submersibles');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_cars`
--

CREATE TABLE `vs_cars` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_cars`
--

INSERT INTO `vs_cars` (`name`, `model`, `price`, `category`) VALUES
('Adder', 'adder', 900000, 'super'),
('Akuma', 'AKUMA', 7500, 'motorcycles'),
('Alpha', 'alpha', 60000, 'sports'),
('Ardent', 'ardent', 1150000, 'sportsclassics'),
('Asea', 'asea', 5500, 'sedans'),
('Autarch', 'autarch', 1955000, 'super'),
('Avarus', 'avarus', 18000, 'motorcycles'),
('Bagger', 'bagger', 13500, 'motorcycles'),
('Baller', 'baller2', 40000, 'suvs'),
('Baller Sport', 'baller3', 60000, 'suvs'),
('Banshee', 'banshee', 70000, 'sports'),
('Banshee 900R', 'banshee2', 255000, 'super'),
('Bati 801', 'bati', 12000, 'motorcycles'),
('Bati 801RR', 'bati2', 19000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 55000, 'sports'),
('BF400', 'bf400', 6500, 'motorcycles'),
('Bf Injection', 'bfinjection', 16000, 'offroad'),
('Bifta', 'bifta', 12000, 'offroad'),
('Bison', 'bison', 45000, 'vans'),
('Blade', 'blade', 15000, 'muscle'),
('Blazer', 'blazer', 6500, 'offroad'),
('Blazer Sport', 'blazer4', 8500, 'offroad'),
('blazer5', 'blazer5', 1755600, 'offroad'),
('Blista', 'blista', 8000, 'compacts'),
('BMX (velo)', 'bmx', 160, 'motorcycles'),
('Bobcat XL', 'bobcatxl', 32000, 'vans'),
('Brawler', 'brawler', 45000, 'offroad'),
('Brioso R/A', 'brioso', 18000, 'compacts'),
('Btype', 'btype', 62000, 'sportsclassics'),
('Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
('Btype Luxe', 'btype3', 85000, 'sportsclassics'),
('Buccaneer', 'buccaneer', 18000, 'muscle'),
('Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
('Buffalo', 'buffalo', 12000, 'sports'),
('Buffalo S', 'buffalo2', 20000, 'sports'),
('Bullet', 'bullet', 90000, 'super'),
('Burrito', 'burrito3', 19000, 'vans'),
('Camper', 'camper', 42000, 'vans'),
('Carbonizzare', 'carbonizzare', 75000, 'sports'),
('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
('Casco', 'casco', 30000, 'sportsclassics'),
('Cavalcade', 'cavalcade2', 55000, 'suvs'),
('Cheetah', 'cheetah', 375000, 'super'),
('Chimera', 'chimera', 38000, 'motorcycles'),
('Chino', 'chino', 15000, 'muscle'),
('Chino Luxe', 'chino2', 19000, 'muscle'),
('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
('Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes'),
('Cognoscenti', 'cognoscenti', 55000, 'sedans'),
('Comet', 'comet2', 65000, 'sports'),
('Comet 5', 'comet5', 1145000, 'sports'),
('Contender', 'contender', 70000, 'suvs'),
('Coquette', 'coquette', 65000, 'sports'),
('Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
('Coquette BlackFin', 'coquette3', 55000, 'muscle'),
('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
('Cyclone', 'cyclone', 1890000, 'super'),
('Daemon', 'daemon', 11500, 'motorcycles'),
('Daemon High', 'daemon2', 13500, 'motorcycles'),
('Defiler', 'defiler', 9800, 'motorcycles'),
('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
('Dominator', 'dominator', 35000, 'muscle'),
('Double T', 'double', 28000, 'motorcycles'),
('Dubsta', 'dubsta', 45000, 'suvs'),
('Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
('Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
('Dukes', 'dukes', 28000, 'muscle'),
('Dune Buggy', 'dune', 8000, 'offroad'),
('Elegy', 'elegy2', 38500, 'sports'),
('Emperor', 'emperor', 8500, 'sedans'),
('Enduro', 'enduro', 5500, 'motorcycles'),
('Entity XF', 'entityxf', 425000, 'super'),
('Esskey', 'esskey', 4200, 'motorcycles'),
('Exemplar', 'exemplar', 32000, 'coupes'),
('F620', 'f620', 40000, 'coupes'),
('Faction', 'faction', 20000, 'muscle'),
('Faction Rider', 'faction2', 30000, 'muscle'),
('Faction XL', 'faction3', 40000, 'muscle'),
('Faggio', 'faggio', 1900, 'motorcycles'),
('Vespa', 'faggio2', 2800, 'motorcycles'),
('Felon', 'felon', 42000, 'coupes'),
('Felon GT', 'felon2', 55000, 'coupes'),
('Feltzer', 'feltzer2', 55000, 'sports'),
('Stirling GT', 'feltzer3', 65000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 225, 'motorcycles'),
('FMJ', 'fmj', 185000, 'super'),
('Fhantom', 'fq2', 17000, 'suvs'),
('Fugitive', 'fugitive', 12000, 'sedans'),
('Furore GT', 'furoregt', 45000, 'sports'),
('Fusilade', 'fusilade', 40000, 'sports'),
('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
('Gauntlet', 'gauntlet', 30000, 'muscle'),
('Gang Burrito', 'gburrito', 45000, 'vans'),
('Burrito', 'gburrito2', 29000, 'vans'),
('Glendale', 'glendale', 6500, 'sedans'),
('Grabger', 'granger', 50000, 'suvs'),
('Gresley', 'gresley', 47500, 'suvs'),
('GT 500', 'gt500', 785000, 'sportsclassics'),
('Guardian', 'guardian', 45000, 'offroad'),
('Hakuchou', 'hakuchou', 31000, 'motorcycles'),
('Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles'),
('Hermes', 'hermes', 535000, 'muscle'),
('Hexer', 'hexer', 12000, 'motorcycles'),
('Hotknife', 'hotknife', 125000, 'muscle'),
('Huntley S', 'huntley', 40000, 'suvs'),
('Hustler', 'hustler', 625000, 'muscle'),
('Infernus', 'infernus', 180000, 'super'),
('Innovation', 'innovation', 23500, 'motorcycles'),
('Intruder', 'intruder', 7500, 'sedans'),
('Issi', 'issi2', 10000, 'compacts'),
('Jackal', 'jackal', 38000, 'coupes'),
('Jester', 'jester', 65000, 'sports'),
('Jester(Racecar)', 'jester2', 135000, 'sports'),
('Journey', 'journey', 6500, 'vans'),
('Kamacho', 'kamacho', 345000, 'offroad'),
('Khamelion', 'khamelion', 38000, 'sports'),
('Kuruma', 'kuruma', 30000, 'sports'),
('Landstalker', 'landstalker', 35000, 'suvs'),
('RE-7B', 'le7b', 325000, 'super'),
('Lynx', 'lynx', 40000, 'sports'),
('Mamba', 'mamba', 70000, 'sports'),
('Manana', 'manana', 12800, 'sportsclassics'),
('Manchez', 'manchez', 5300, 'motorcycles'),
('Massacro', 'massacro', 65000, 'sports'),
('Massacro(Racecar)', 'massacro2', 130000, 'sports'),
('Mesa', 'mesa', 16000, 'suvs'),
('Mesa Trail', 'mesa3', 40000, 'suvs'),
('Minivan', 'minivan', 13000, 'vans'),
('Monroe', 'monroe', 55000, 'sportsclassics'),
('The Liberator', 'monster', 210000, 'offroad'),
('Moonbeam', 'moonbeam', 18000, 'vans'),
('Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
('Nemesis', 'nemesis', 5800, 'motorcycles'),
('Neon', 'neon', 1500000, 'sports'),
('Nightblade', 'nightblade', 35000, 'motorcycles'),
('Nightshade', 'nightshade', 65000, 'muscle'),
('9F', 'ninef', 65000, 'sports'),
('9F Cabrio', 'ninef2', 80000, 'sports'),
('Omnis', 'omnis', 35000, 'sports'),
('Oppressor', 'oppressor', 3524500, 'super'),
('Oracle XS', 'oracle2', 35000, 'coupes'),
('Osiris', 'osiris', 160000, 'super'),
('Panto', 'panto', 10000, 'compacts'),
('Paradise', 'paradise', 19000, 'vans'),
('Pariah', 'pariah', 1420000, 'sports'),
('Patriot', 'patriot', 55000, 'suvs'),
('PCJ-600', 'pcj', 6200, 'motorcycles'),
('Penumbra', 'penumbra', 28000, 'sports'),
('Pfister', 'pfister811', 85000, 'super'),
('Phoenix', 'phoenix', 12500, 'muscle'),
('Picador', 'picador', 18000, 'muscle'),
('Pigalle', 'pigalle', 20000, 'sportsclassics'),
('Prairie', 'prairie', 12000, 'compacts'),
('Premier', 'premier', 8000, 'sedans'),
('Primo Custom', 'primo2', 14000, 'sedans'),
('X80 Proto', 'prototipo', 2500000, 'super'),
('Radius', 'radi', 29000, 'suvs'),
('Raiden', 'raiden', 1375000, 'sports'),
('Rapid GT', 'rapidgt', 35000, 'sports'),
('Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
('Reaper', 'reaper', 150000, 'super'),
('Rebel', 'rebel2', 35000, 'offroad'),
('Regina', 'regina', 5000, 'sedans'),
('Retinue', 'retinue', 615000, 'sportsclassics'),
('Revolter', 'revolter', 1610000, 'sports'),
('Riata', 'riata', 380000, 'offroad'),
('Rocoto', 'rocoto', 45000, 'suvs'),
('Ruffian', 'ruffian', 6800, 'motorcycles'),
('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
('Rumpo', 'rumpo', 15000, 'vans'),
('Rumpo Trail', 'rumpo3', 19500, 'vans'),
('Sabre Turbo', 'sabregt', 20000, 'muscle'),
('Sabre GT', 'sabregt2', 25000, 'muscle'),
('Sanchez', 'sanchez', 5300, 'motorcycles'),
('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
('Sanctus', 'sanctus', 25000, 'motorcycles'),
('Sandking', 'sandking', 55000, 'offroad'),
('Savestra', 'savestra', 990000, 'sportsclassics'),
('SC 1', 'sc1', 1603000, 'super'),
('Schafter', 'schafter2', 25000, 'sedans'),
('Schafter V12', 'schafter3', 50000, 'sports'),
('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
('Seminole', 'seminole', 25000, 'suvs'),
('Sentinel', 'sentinel', 32000, 'coupes'),
('Sentinel XS', 'sentinel2', 40000, 'coupes'),
('Sentinel3', 'sentinel3', 650000, 'sports'),
('Seven 70', 'seven70', 39500, 'sports'),
('ETR1', 'sheava', 220000, 'super'),
('Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
('Slam Van', 'slamvan3', 11500, 'muscle'),
('Sovereign', 'sovereign', 22000, 'motorcycles'),
('Stinger', 'stinger', 80000, 'sportsclassics'),
('Stinger GT', 'stingergt', 75000, 'sportsclassics'),
('Streiter', 'streiter', 500000, 'sports'),
('Stretch', 'stretch', 90000, 'sedans'),
('Stromberg', 'stromberg', 3185350, 'sports'),
('Sultan', 'sultan', 15000, 'sports'),
('Sultan RS', 'sultanrs', 65000, 'super'),
('Super Diamond', 'superd', 130000, 'sedans'),
('Surano', 'surano', 50000, 'sports'),
('Surfer', 'surfer', 12000, 'vans'),
('T20', 't20', 300000, 'super'),
('Tailgater', 'tailgater', 30000, 'sedans'),
('Tampa', 'tampa', 16000, 'muscle'),
('Drift Tampa', 'tampa2', 80000, 'sports'),
('Thrust', 'thrust', 24000, 'motorcycles'),
('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
('Trophy Truck', 'trophytruck', 60000, 'offroad'),
('Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
('Tropos', 'tropos', 40000, 'sports'),
('Turismo R', 'turismor', 350000, 'super'),
('Tyrus', 'tyrus', 600000, 'super'),
('Vacca', 'vacca', 120000, 'super'),
('Vader', 'vader', 7200, 'motorcycles'),
('Verlierer', 'verlierer2', 70000, 'sports'),
('Vigero', 'vigero', 12500, 'muscle'),
('Virgo', 'virgo', 14000, 'muscle'),
('Viseris', 'viseris', 875000, 'sportsclassics'),
('Visione', 'visione', 2250000, 'super'),
('Voltic', 'voltic', 90000, 'super'),
('Voltic 2', 'voltic2', 3830400, 'super'),
('Voodoo', 'voodoo', 7200, 'muscle'),
('Vortex', 'vortex', 9800, 'motorcycles'),
('Warrener', 'warrener', 4000, 'sedans'),
('Washington', 'washington', 9000, 'sedans'),
('Windsor', 'windsor', 95000, 'coupes'),
('Windsor Drop', 'windsor2', 125000, 'coupes'),
('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
('XLS', 'xls', 32000, 'suvs'),
('Yosemite', 'yosemite', 485000, 'muscle'),
('Youga', 'youga', 10800, 'vans'),
('Youga Luxuary', 'youga2', 14500, 'vans'),
('Z190', 'z190', 900000, 'sportsclassics'),
('Zentorno', 'zentorno', 1500000, 'super'),
('Zion', 'zion', 36000, 'coupes'),
('Zion Cabrio', 'zion2', 45000, 'coupes'),
('Zombie', 'zombiea', 9500, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
('Z-Type', 'ztype', 220000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_car_categories`
--

CREATE TABLE `vs_car_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_car_categories`
--

INSERT INTO `vs_car_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupes'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_police`
--

CREATE TABLE `vs_police` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_police`
--

INSERT INTO `vs_police` (`id`, `name`, `model`, `price`, `category`) VALUES
(1, 'Police Cruiser', 'police', 500, 'recruit'),
(2, 'Police Cruiser', 'police2', 750, 'recruit'),
(3, 'Police Cruiser', 'police', 500, 'officer'),
(4, 'Police Cruiser', 'police2', 750, 'officer'),
(5, 'Police Cruiser', 'police', 500, 'sergeant'),
(6, 'Police Cruiser', 'police2', 750, 'sergeant'),
(7, 'Police Cruiser', 'police', 500, 'lieutenant'),
(8, 'Police Cruiser', 'police2', 750, 'lieutenant'),
(9, 'Police Cruiser', 'police', 500, 'boss'),
(10, 'Police Cruiser', 'police2', 750, 'boss'),
(11, 'Maverick', 'polmav', 1000, 'boss');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_police_categories`
--

CREATE TABLE `vs_police_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_police_categories`
--

INSERT INTO `vs_police_categories` (`name`, `label`) VALUES
('boss', 'Chief'),
('lieutenant', 'Lieutenant'),
('officer', 'Officer'),
('recruit', 'Recruit'),
('sergeant', 'Sergeant');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_trucks`
--

CREATE TABLE `vs_trucks` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_trucks`
--

INSERT INTO `vs_trucks` (`name`, `model`, `price`, `category`) VALUES
('Airport Bus', 'airbus', 50000, 'trans'),
('Benson', 'benson', 55000, 'box'),
('Biff', 'biff', 30000, 'other'),
('Boxville 1', 'boxville', 45000, 'box'),
('Boxville 2', 'boxville2', 45000, 'box'),
('Boxville 3', 'boxville3', 45000, 'box'),
('Boxville 4', 'boxville4', 45000, 'box'),
('Dozer', 'bulldozer', 20000, 'other'),
('Bus', 'bus', 50000, 'trans'),
('Dashound', 'coach', 50000, 'trans'),
('Hauler', 'hauler', 100000, 'haul'),
('Mixer 1', 'mixer', 30000, 'other'),
('Mixer 2', 'mixer2', 30000, 'other'),
('Mule 1', 'mule', 40000, 'box'),
('Mule 2', 'mule2', 40000, 'box'),
('Mule 3', 'mule3', 40000, 'box'),
('Packer', 'packer', 100000, 'haul'),
('Festival Bus', 'pbus2', 125000, 'trans'),
('Phantom', 'phantom', 105000, 'haul'),
('Phantom Custom', 'phantom3', 110000, 'haul'),
('Pounder', 'pounder', 55000, 'box'),
('Rental Bus', 'rentalbus', 35000, 'trans'),
('Rubble', 'rubble', 30000, 'other'),
('Scrap Truck', 'scrap', 10000, 'other'),
('Tipper 1', 'tiptruck', 30000, 'other'),
('Tipper 2', 'tiptruck2', 30000, 'other'),
('Tour Bus', 'tourbus', 35000, 'trans'),
('Field Master', 'tractor2', 15000, 'other');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_truck_categories`
--

CREATE TABLE `vs_truck_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_truck_categories`
--

INSERT INTO `vs_truck_categories` (`name`, `label`) VALUES
('box', 'Boxed Trucks'),
('haul', 'Haulers'),
('other', 'Other Trucks'),
('trans', 'Transport Trucks');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_vips`
--

CREATE TABLE `vs_vips` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_vips`
--

INSERT INTO `vs_vips` (`name`, `model`, `price`, `category`) VALUES
('Shotaro', 'shotaro', 30000, 'motorcycles');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `vs_vip_categories`
--

CREATE TABLE `vs_vip_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `vs_vip_categories`
--

INSERT INTO `vs_vip_categories` (`name`, `label`) VALUES
('motorcycles', 'Motos');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `warrants_list`
--

CREATE TABLE `warrants_list` (
  `id` int(11) NOT NULL,
  `json_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `warrants_list`
--

INSERT INTO `warrants_list` (`id`, `json_data`) VALUES
(1, '{\"Officer\":\"steam:110000119bffa22\",\"Suspect\":\"Josephi Krakowdki\",\"Description\":\"je to kokot\",\"OfficerC\":\"50000\", \"Date\":\"Sun May 24 09:17:30 2020\"}');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `weaponshops`
--

CREATE TABLE `weaponshops` (
  `id` int(11) NOT NULL,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `weaponshops`
--

INSERT INTO `weaponshops` (`id`, `zone`, `item`, `price`, `category`) VALUES
(1, 'GunShop', 'GADGET_PARACHUTE', 800, 'melee'),
(2, 'GunShop', 'WEAPON_FLASHLIGHT', 25, 'melee'),
(3, 'GunShop', 'WEAPON_MACHETE', 20, 'melee'),
(4, 'GunShop', 'WEAPON_BAT', 20, 'melee'),
(5, 'GunShop', 'WEAPON_NIGHTSTICK', 15, 'melee'),
(6, 'GunShop', 'WEAPON_KNIFE', 30, 'melee'),
(7, 'GunShop', 'WEAPON_HAMMER', 5, 'melee'),
(8, 'GunShop', 'WEAPON_GOLFCLUB', 40, 'melee'),
(9, 'GunShop', 'WEAPON_CROWBAR', 15, 'melee'),
(10, 'GunShop', 'WEAPON_DAGGER', 15, 'melee'),
(11, 'GunShop', 'WEAPON_KNUCKLE', 25, 'melee'),
(12, 'GunShop', 'WEAPON_HATCHET', 20, 'melee'),
(13, 'GunShop', 'WEAPON_SWITCHBLADE', 25, 'melee'),
(14, 'GunShop', 'WEAPON_POOLCUE', 10, 'melee'),
(15, 'GunShop', 'WEAPON_WRENCH', 40, 'melee'),
(16, 'GunShop', 'WEAPON_BOTTLE', 10, 'melee'),
(17, 'GunShop', 'WEAPON_BATTLEAXE', 125, 'melee'),
(18, 'GunShop', 'WEAPON_FIREEXTINGUISHER', 100, 'melee'),
(19, 'GunShop', 'WEAPON_BALL', 25, 'melee'),
(20, 'GunShop', 'WEAPON_SNOWBALL', 25, 'melee'),
(21, 'GunShop', 'WEAPON_BZGAS', 250, 'melee'),
(22, 'BlackShop', 'WEAPON_BZGAS', 500, 'melee'),
(23, 'GunShop', 'WEAPON_SMOKEGRENADE', 250, 'melee'),
(24, 'BlackShop', 'WEAPON_SMOKEGRENADE', 500, 'melee'),
(25, 'BlackShop', 'WEAPON_MOLOTOV', 150, 'melee'),
(26, 'GunShop', 'WEAPON_FLARE', 100, 'melee'),
(27, 'GunShop', 'WEAPON_FLAREGUN', 500, 'handgun'),
(28, 'GunShop', 'WEAPON_STUNGUN', 500, 'handgun'),
(29, 'GunShop', 'WEAPON_SNSPISTOL', 150, 'handgun'),
(30, 'BlackShop', 'WEAPON_SNSPISTOL', 450, 'handgun'),
(31, 'GunShop', 'WEAPON_VINTAGEPISTOL', 300, 'handgun'),
(32, 'BlackShop', 'WEAPON_VINTAGEPISTOL', 900, 'handgun'),
(33, 'GunShop', 'WEAPON_PISTOL', 350, 'handgun'),
(34, 'BlackShop', 'WEAPON_PISTOL', 1050, 'handgun'),
(35, 'GunShop', 'WEAPON_COMBATPISTOL', 400, 'handgun'),
(36, 'GunShop', 'WEAPON_PISTOL50', 1500, 'handgun'),
(37, 'GunShop', 'WEAPON_HEAVYPISTOL', 550, 'handgun'),
(38, 'GunShop', 'WEAPON_REVOLVER', 1300, 'handgun'),
(39, 'GunShop', 'WEAPON_APPISTOL', 2700, 'handgun'),
(40, 'GunShop', 'WEAPON_MICROSMG', 900, 'smg'),
(41, 'BlackShop', 'WEAPON_MICROSMG', 2700, 'smg'),
(42, 'GunShop', 'WEAPON_MINISMG', 800, 'smg'),
(43, 'BlackShop', 'WEAPON_MINISMG', 2400, 'smg'),
(44, 'GunShop', 'WEAPON_SMG', 1600, 'smg'),
(45, 'BlackShop', 'WEAPON_SMG', 4800, 'smg'),
(46, 'GunShop', 'WEAPON_MACHINEPISTOL', 1300, 'smg'),
(47, 'GunShop', 'WEAPON_ASSAULTSMG', 1400, 'smg'),
(48, 'GunShop', 'WEAPON_COMBATPDW', 1500, 'smg'),
(49, 'GunShop', 'WEAPON_PUMPSHOTGUN', 350, 'shotgun'),
(50, 'BlackShop', 'WEAPON_PUMPSHOTGUN', 1050, 'shotgun'),
(51, 'GunShop', 'WEAPON_SAWNOFFSHOTGUN', 500, 'shotgun'),
(52, 'BlackShop', 'WEAPON_SAWNOFFSHOTGUN', 1500, 'shotgun'),
(53, 'GunShop', 'WEAPON_DBSHOTGUN', 450, 'shotgun'),
(54, 'BlackShop', 'WEAPON_DBSHOTGUN', 1350, 'shotgun'),
(55, 'GunShop', 'WEAPON_HEAVYSHOTGUN', 1000, 'shotgun'),
(56, 'GunShop', 'WEAPON_ASSAULTSHOTGUN', 1100, 'shotgun'),
(57, 'GunShop', 'WEAPON_MUSKET', 225, 'assault'),
(58, 'GunShop', 'WEAPON_ASSAULTRIFLE', 1200, 'assault'),
(59, 'BlackShop', 'WEAPON_ASSAULTRIFLE', 3600, 'assault'),
(60, 'GunShop', 'WEAPON_CARBINERIFLE', 2400, 'assault'),
(61, 'BlackShop', 'WEAPON_CARBINERIFLE', 7200, 'assault'),
(62, 'GunShop', 'WEAPON_BULLPUPRIFLE', 1200, 'assault'),
(63, 'GunShop', 'WEAPON_SPECIALCARBINE', 5200, 'assault'),
(64, 'GunShop', 'WEAPON_COMPACTRIFLE', 750, 'assault'),
(65, 'GunShop', 'WEAPON_ADVANCEDRIFLE', 2000, 'assault'),
(66, 'GunShop', 'WEAPON_GUSENBERG', 4280, 'lmg'),
(67, 'GunShop', 'WEAPON_MG', 8250, 'lmg'),
(68, 'GunShop', 'WEAPON_COMBATMG', 13950, 'lmg'),
(69, 'GunShop', 'WEAPON_SNIPERRIFLE', 2000, 'sniper'),
(70, 'GunShop', 'WEAPON_MARKSMANRIFLE', 3800, 'sniper'),
(71, 'GunShop', 'WEAPON_HEAVYSNIPER', 9900, 'sniper');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `weashops`
--

CREATE TABLE `weashops` (
  `id` int(11) NOT NULL,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `weashops`
--

INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
(1, 'GunShop', 'WEAPON_PISTOL', 300),
(2, 'BlackWeashop', 'WEAPON_PISTOL', 500),
(3, 'GunShop', 'WEAPON_FLASHLIGHT', 60),
(4, 'BlackWeashop', 'WEAPON_FLASHLIGHT', 70),
(5, 'GunShop', 'WEAPON_MACHETE', 90),
(6, 'BlackWeashop', 'WEAPON_MACHETE', 110),
(7, 'GunShop', 'WEAPON_NIGHTSTICK', 150),
(8, 'BlackWeashop', 'WEAPON_NIGHTSTICK', 150),
(9, 'GunShop', 'WEAPON_BAT', 100),
(10, 'BlackWeashop', 'WEAPON_BAT', 100),
(11, 'GunShop', 'WEAPON_STUNGUN', 50),
(12, 'BlackWeashop', 'WEAPON_STUNGUN', 50),
(13, 'GunShop', 'WEAPON_MICROSMG', 1400),
(14, 'BlackWeashop', 'WEAPON_MICROSMG', 1700),
(15, 'GunShop', 'WEAPON_PUMPSHOTGUN', 3400),
(16, 'BlackWeashop', 'WEAPON_PUMPSHOTGUN', 3500),
(17, 'GunShop', 'WEAPON_ASSAULTRIFLE', 10000),
(18, 'BlackWeashop', 'WEAPON_ASSAULTRIFLE', 11000),
(19, 'GunShop', 'WEAPON_SPECIALCARBINE', 15000),
(20, 'BlackWeashop', 'WEAPON_SPECIALCARBINE', 16500),
(21, 'GunShop', 'WEAPON_SNIPERRIFLE', 22000),
(22, 'BlackWeashop', 'WEAPON_SNIPERRIFLE', 24000),
(23, 'GunShop', 'WEAPON_FIREWORK', 18000),
(24, 'BlackWeashop', 'WEAPON_FIREWORK', 20000),
(25, 'GunShop', 'WEAPON_GRENADE', 500),
(26, 'BlackWeashop', 'WEAPON_GRENADE', 650),
(27, 'GunShop', 'WEAPON_BZGAS', 200),
(28, 'BlackWeashop', 'WEAPON_BZGAS', 350),
(29, 'GunShop', 'WEAPON_FIREEXTINGUISHER', 100),
(30, 'BlackWeashop', 'WEAPON_FIREEXTINGUISHER', 100),
(31, 'GunShop', 'WEAPON_BALL', 50),
(32, 'BlackWeashop', 'WEAPON_BALL', 50),
(33, 'GunShop', 'WEAPON_SMOKEGRENADE', 100),
(34, 'BlackWeashop', 'WEAPON_SMOKEGRENADE', 100),
(35, 'BlackWeashop', 'WEAPON_APPISTOL', 1100),
(36, 'BlackWeashop', 'WEAPON_CARBINERIFLE', 12000),
(37, 'BlackWeashop', 'WEAPON_HEAVYSNIPER', 30000),
(38, 'BlackWeashop', 'WEAPON_MINIGUN', 45000),
(39, 'BlackWeashop', 'WEAPON_RAILGUN', 50000),
(40, 'BlackWeashop', 'WEAPON_STICKYBOMB', 500);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `yellow_tweets`
--

CREATE TABLE `yellow_tweets` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Indexy pre tabuľku `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Indexy pre tabuľku `arrests_list`
--
ALTER TABLE `arrests_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `bolos_list`
--
ALTER TABLE `bolos_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `bwh_bans`
--
ALTER TABLE `bwh_bans`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `bwh_identifiers`
--
ALTER TABLE `bwh_identifiers`
  ADD PRIMARY KEY (`steam`);

--
-- Indexy pre tabuľku `bwh_warnings`
--
ALTER TABLE `bwh_warnings`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `calls`
--
ALTER TABLE `calls`
  ADD PRIMARY KEY (`callid`);

--
-- Indexy pre tabuľku `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `civilians`
--
ALTER TABLE `civilians`
  ADD PRIMARY KEY (`civid`);

--
-- Indexy pre tabuľku `civilian_notes`
--
ALTER TABLE `civilian_notes`
  ADD PRIMARY KEY (`noteid`);

--
-- Indexy pre tabuľku `communityservice`
--
ALTER TABLE `communityservice`
  ADD PRIMARY KEY (`identifier`);

--
-- Indexy pre tabuľku `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Indexy pre tabuľku `disc_inventory`
--
ALTER TABLE `disc_inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `disc_inventory_itemdata`
--
ALTER TABLE `disc_inventory_itemdata`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexy pre tabuľku `fine_types`
--
ALTER TABLE `fine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `fine_types_mafia`
--
ALTER TABLE `fine_types_mafia`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `glovebox_inventory`
--
ALTER TABLE `glovebox_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Indexy pre tabuľku `insto_accounts`
--
ALTER TABLE `insto_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexy pre tabuľku `insto_instas`
--
ALTER TABLE `insto_instas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_insto_instas_insto_accounts` (`authorId`);

--
-- Indexy pre tabuľku `insto_likes`
--
ALTER TABLE `insto_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_insto_likes_insto_accounts` (`authorId`),
  ADD KEY `FK_insto_likes_insto_instas` (`inapId`);

--
-- Indexy pre tabuľku `invest`
--
ALTER TABLE `invest`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Indexy pre tabuľku `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`logid`);

--
-- Indexy pre tabuľku `lspd_mdc_judgments_suggestion`
--
ALTER TABLE `lspd_mdc_judgments_suggestion`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `lspd_mdc_judgments_suggestion_category`
--
ALTER TABLE `lspd_mdc_judgments_suggestion_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `lspd_mdc_tag_suggestion`
--
ALTER TABLE `lspd_mdc_tag_suggestion`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `lspd_mdc_user_notes`
--
ALTER TABLE `lspd_mdc_user_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `lspd_mdc_vehicle_notes`
--
ALTER TABLE `lspd_mdc_vehicle_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `lspd_user_judgments`
--
ALTER TABLE `lspd_user_judgments`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `markers`
--
ALTER TABLE `markers`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `mdt_reports`
--
ALTER TABLE `mdt_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `mdt_sessions`
--
ALTER TABLE `mdt_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `mdt_users`
--
ALTER TABLE `mdt_users`
  ADD PRIMARY KEY (`userid`);

--
-- Indexy pre tabuľku `mdt_warrants`
--
ALTER TABLE `mdt_warrants`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`messageid`);

--
-- Indexy pre tabuľku `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Indexy pre tabuľku `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `phone_ch_reddit`
--
ALTER TABLE `phone_ch_reddit`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `phone_reddit`
--
ALTER TABLE `phone_reddit`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `phone_shops`
--
ALTER TABLE `phone_shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `playerstattoos`
--
ALTER TABLE `playerstattoos`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `pois`
--
ALTER TABLE `pois`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `qalle_brottsregister`
--
ALTER TABLE `qalle_brottsregister`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `remarks`
--
ALTER TABLE `remarks`
  ADD PRIMARY KEY (`remarkid`);

--
-- Indexy pre tabuľku `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `society_moneywash`
--
ALTER TABLE `society_moneywash`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Indexy pre tabuľku `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexy pre tabuľku `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  ADD KEY `FK_twitter_likes_twitter_tweets` (`tweetId`);

--
-- Indexy pre tabuľku `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_tweets_twitter_accounts` (`authorId`);

--
-- Indexy pre tabuľku `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unitid`);

--
-- Indexy pre tabuľku `usergroups`
--
ALTER TABLE `usergroups`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Indexy pre tabuľku `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `user_convictions`
--
ALTER TABLE `user_convictions`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `user_mdt`
--
ALTER TABLE `user_mdt`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vehicles_for_sale`
--
ALTER TABLE `vehicles_for_sale`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vehicle_sold`
--
ALTER TABLE `vehicle_sold`
  ADD PRIMARY KEY (`plate`);

--
-- Indexy pre tabuľku `vois`
--
ALTER TABLE `vois`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vs_aircrafts`
--
ALTER TABLE `vs_aircrafts`
  ADD PRIMARY KEY (`model`);

--
-- Indexy pre tabuľku `vs_aircraft_categories`
--
ALTER TABLE `vs_aircraft_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `vs_ambulance`
--
ALTER TABLE `vs_ambulance`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vs_ambulance_categories`
--
ALTER TABLE `vs_ambulance_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `vs_boats`
--
ALTER TABLE `vs_boats`
  ADD PRIMARY KEY (`model`);

--
-- Indexy pre tabuľku `vs_boat_categories`
--
ALTER TABLE `vs_boat_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `vs_cars`
--
ALTER TABLE `vs_cars`
  ADD PRIMARY KEY (`model`);

--
-- Indexy pre tabuľku `vs_car_categories`
--
ALTER TABLE `vs_car_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `vs_police`
--
ALTER TABLE `vs_police`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `vs_police_categories`
--
ALTER TABLE `vs_police_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `vs_trucks`
--
ALTER TABLE `vs_trucks`
  ADD PRIMARY KEY (`model`);

--
-- Indexy pre tabuľku `vs_truck_categories`
--
ALTER TABLE `vs_truck_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `vs_vips`
--
ALTER TABLE `vs_vips`
  ADD PRIMARY KEY (`model`);

--
-- Indexy pre tabuľku `vs_vip_categories`
--
ALTER TABLE `vs_vip_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexy pre tabuľku `warrants_list`
--
ALTER TABLE `warrants_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `weaponshops`
--
ALTER TABLE `weaponshops`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `weashops`
--
ALTER TABLE `weashops`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `yellow_tweets`
--
ALTER TABLE `yellow_tweets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pre tabuľku `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `arrests_list`
--
ALTER TABLE `arrests_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `bolos_list`
--
ALTER TABLE `bolos_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `bwh_bans`
--
ALTER TABLE `bwh_bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `bwh_warnings`
--
ALTER TABLE `bwh_warnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `calls`
--
ALTER TABLE `calls`
  MODIFY `callid` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pre tabuľku `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `civilians`
--
ALTER TABLE `civilians`
  MODIFY `civid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pre tabuľku `civilian_notes`
--
ALTER TABLE `civilian_notes`
  MODIFY `noteid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pre tabuľku `disc_inventory`
--
ALTER TABLE `disc_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pre tabuľku `disc_inventory_itemdata`
--
ALTER TABLE `disc_inventory_itemdata`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `fine_types`
--
ALTER TABLE `fine_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pre tabuľku `fine_types_mafia`
--
ALTER TABLE `fine_types_mafia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pre tabuľku `glovebox_inventory`
--
ALTER TABLE `glovebox_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pre tabuľku `insto_accounts`
--
ALTER TABLE `insto_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT pre tabuľku `insto_instas`
--
ALTER TABLE `insto_instas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

--
-- AUTO_INCREMENT pre tabuľku `insto_likes`
--
ALTER TABLE `insto_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT pre tabuľku `invest`
--
ALTER TABLE `invest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pre tabuľku `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pre tabuľku `logs`
--
ALTER TABLE `logs`
  MODIFY `logid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=315;

--
-- AUTO_INCREMENT pre tabuľku `lspd_mdc_judgments_suggestion`
--
ALTER TABLE `lspd_mdc_judgments_suggestion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `lspd_mdc_judgments_suggestion_category`
--
ALTER TABLE `lspd_mdc_judgments_suggestion_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `lspd_mdc_tag_suggestion`
--
ALTER TABLE `lspd_mdc_tag_suggestion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pre tabuľku `lspd_mdc_user_notes`
--
ALTER TABLE `lspd_mdc_user_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pre tabuľku `lspd_mdc_vehicle_notes`
--
ALTER TABLE `lspd_mdc_vehicle_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `lspd_user_judgments`
--
ALTER TABLE `lspd_user_judgments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pre tabuľku `markers`
--
ALTER TABLE `markers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT pre tabuľku `mdt_reports`
--
ALTER TABLE `mdt_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `mdt_sessions`
--
ALTER TABLE `mdt_sessions`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pre tabuľku `mdt_users`
--
ALTER TABLE `mdt_users`
  MODIFY `userid` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pre tabuľku `mdt_warrants`
--
ALTER TABLE `mdt_warrants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `messages`
--
ALTER TABLE `messages`
  MODIFY `messageid` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pre tabuľku `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pre tabuľku `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pre tabuľku `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT pre tabuľku `phone_ch_reddit`
--
ALTER TABLE `phone_ch_reddit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT pre tabuľku `phone_reddit`
--
ALTER TABLE `phone_reddit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `phone_shops`
--
ALTER TABLE `phone_shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pre tabuľku `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pre tabuľku `playerstattoos`
--
ALTER TABLE `playerstattoos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pre tabuľku `pois`
--
ALTER TABLE `pois`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pre tabuľku `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT pre tabuľku `qalle_brottsregister`
--
ALTER TABLE `qalle_brottsregister`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pre tabuľku `remarks`
--
ALTER TABLE `remarks`
  MODIFY `remarkid` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pre tabuľku `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pre tabuľku `society_moneywash`
--
ALTER TABLE `society_moneywash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pre tabuľku `twitter_likes`
--
ALTER TABLE `twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT pre tabuľku `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT pre tabuľku `units`
--
ALTER TABLE `units`
  MODIFY `unitid` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pre tabuľku `usergroups`
--
ALTER TABLE `usergroups`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pre tabuľku `user_accounts`
--
ALTER TABLE `user_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pre tabuľku `user_convictions`
--
ALTER TABLE `user_convictions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `user_inventory`
--
ALTER TABLE `user_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=420;

--
-- AUTO_INCREMENT pre tabuľku `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pre tabuľku `user_mdt`
--
ALTER TABLE `user_mdt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT pre tabuľku `vehicles_for_sale`
--
ALTER TABLE `vehicles_for_sale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pre tabuľku `vois`
--
ALTER TABLE `vois`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pre tabuľku `vs_ambulance`
--
ALTER TABLE `vs_ambulance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pre tabuľku `vs_police`
--
ALTER TABLE `vs_police`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pre tabuľku `warrants_list`
--
ALTER TABLE `warrants_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pre tabuľku `weaponshops`
--
ALTER TABLE `weaponshops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT pre tabuľku `weashops`
--
ALTER TABLE `weashops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pre tabuľku `yellow_tweets`
--
ALTER TABLE `yellow_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=830;

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `insto_instas`
--
ALTER TABLE `insto_instas`
  ADD CONSTRAINT `FK_insto_instas_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `insto_accounts` (`id`);

--
-- Obmedzenie pre tabuľku `insto_likes`
--
ALTER TABLE `insto_likes`
  ADD CONSTRAINT `FK_insto_likes_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `insto_accounts` (`id`),
  ADD CONSTRAINT `FK_insto_likes_insto_instas` FOREIGN KEY (`inapId`) REFERENCES `insto_instas` (`id`) ON DELETE CASCADE;

--
-- Obmedzenie pre tabuľku `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Obmedzenie pre tabuľku `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
