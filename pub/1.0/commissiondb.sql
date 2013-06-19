-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Värd: 127.0.0.1
-- Skapad: 13 jun 2013 kl 07:23
-- Serverversion: 5.5.27
-- PHP-version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databas: `commissiondb`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `CityID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`CityID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=103 ;

--
-- Dumpning av Data i tabell `city`
--

INSERT INTO `city` (`CityID`, `Name`) VALUES
(100, 'Toledo'),
(101, 'Orlando'),
(102, 'Buffalo');

-- --------------------------------------------------------

--
-- Tabellstruktur `gunpart`
--

CREATE TABLE IF NOT EXISTS `gunpart` (
  `GunPartID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`GunPartID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=403 ;

--
-- Dumpning av Data i tabell `gunpart`
--

INSERT INTO `gunpart` (`GunPartID`, `Description`) VALUES
(400, 'Lock'),
(401, 'Stock'),
(402, 'Barrell');

-- --------------------------------------------------------

--
-- Tabellstruktur `gunsmith`
--

CREATE TABLE IF NOT EXISTS `gunsmith` (
  `GunSmithID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  PRIMARY KEY (`GunSmithID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=204 ;

--
-- Dumpning av Data i tabell `gunsmith`
--

INSERT INTO `gunsmith` (`GunSmithID`, `Name`, `PasswordHash`) VALUES
(200, 'Thomas Ferguson', 'pass200'),
(201, 'John Doe', 'pass201'),
(202, 'Rick Ross', 'pass202'),
(203, 'Mike Condor', 'pass203');

-- --------------------------------------------------------

--
-- Tabellstruktur `production`
--

CREATE TABLE IF NOT EXISTS `production` (
  `GunSmithID` int(11) NOT NULL,
  `GunPartID` int(11) NOT NULL,
  `MonthlyLimit` int(10) unsigned NOT NULL,
  `Price` int(10) unsigned NOT NULL,
  PRIMARY KEY (`GunSmithID`,`GunPartID`),
  KEY `GunPartID` (`GunPartID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `production`
--

INSERT INTO `production` (`GunSmithID`, `GunPartID`, `MonthlyLimit`, `Price`) VALUES
(200, 400, 20, 45),
(200, 401, 20, 30),
(200, 402, 15, 25),
(201, 400, 20, 45),
(201, 401, 20, 30),
(201, 402, 15, 25),
(202, 400, 20, 45),
(202, 401, 20, 30),
(202, 402, 15, 25),
(203, 400, 20, 45),
(203, 401, 20, 30),
(203, 402, 15, 25);

-- --------------------------------------------------------

--
-- Tabellstruktur `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `SalesManID` int(11) NOT NULL,
  `GunPartID` int(11) NOT NULL,
  `GunSmithID` int(11) NOT NULL,
  `CityID` int(11) NOT NULL,
  `Quantity` int(10) unsigned NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`SalesManID`,`GunPartID`,`GunSmithID`,`CityID`,`Date`),
  KEY `GunPartID` (`GunPartID`),
  KEY `GunSmithID` (`GunSmithID`),
  KEY `CityID` (`CityID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellstruktur `salesman`
--

CREATE TABLE IF NOT EXISTS `salesman` (
  `SalesManID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  PRIMARY KEY (`SalesManID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=304 ;

--
-- Dumpning av Data i tabell `salesman`
--

INSERT INTO `salesman` (`SalesManID`, `Name`, `PasswordHash`) VALUES
(300, 'John Smith', 'pass300'),
(301, 'Ari Gold', 'pass301'),
(302, 'Mike Ronan', 'pass302'),
(303, 'Shane Mickelson', 'pass303');

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `production`
--
ALTER TABLE `production`
  ADD CONSTRAINT `production_ibfk_1` FOREIGN KEY (`GunSmithID`) REFERENCES `gunsmith` (`GunsmithID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `production_ibfk_2` FOREIGN KEY (`GunPartID`) REFERENCES `gunpart` (`GunPartID`) ON UPDATE CASCADE;

--
-- Restriktioner för tabell `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`SalesManID`) REFERENCES `salesman` (`SalesManID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`GunPartID`) REFERENCES `gunpart` (`GunPartID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`GunSmithID`) REFERENCES `gunsmith` (`GunsmithID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_4` FOREIGN KEY (`CityID`) REFERENCES `city` (`CityID`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
