CREATE DATABASE  IF NOT EXISTS `cs451_project`
USE `cs451_project`;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts` (
  `TransDate` char(10) DEFAULT NULL,
  `AlertReason` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `alerts` VALUES ('2019-05-07','Location is not Missouri or Kansas'),('2019-05-07','Amount is Over $1000');

--
-- Table structure for table `customer_accounts`
--

DROP TABLE IF EXISTS `customer_accounts`;
CREATE TABLE `customer_accounts` (
  `CustomerID` int(11) NOT NULL,
  `AccountID` int(11) NOT NULL,
  KEY `CustomerID_idx` (`CustomerID`),
  CONSTRAINT `CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `customer_accounts` VALUES (12345678,211111110),(12345678,211111112);

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `UserName` varchar(45) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  KEY `CustomerID` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `customers` VALUES (12345678,'John','Smith','12345','JSmith');

--
-- Table structure for table `previousreports`
--

DROP TABLE IF EXISTS `previousreports`;
CREATE TABLE `previousreports` (
  `StartDate` char(10) DEFAULT NULL,
  `EndDate` char(10) DEFAULT NULL,
  `AlertsInTimePeriod` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `previousreports` VALUES ('2019-04-01','2019-04-30',24),('2019-03-01','2019-03-30',15),('2019-02-01','2019-02-30',32),('2019-01-01','2019-01-30',8);

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `Alert` varchar(50) DEFAULT NULL,
  `TimesRecently` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `reports` VALUES ('Location != (Missouri or Kansas)',1),('Amount >= $1000',1);

--
-- Table structure for table `rules`
--

DROP TABLE IF EXISTS `rules`;
CREATE TABLE `rules` (
  `RuleID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerId` int(11) NOT NULL,
  `AccountID` int(11) NOT NULL,
  `OutStateTrans` tinyint(1) unsigned zerofill DEFAULT NULL,
  `RangeTrans` tinyint(1) unsigned zerofill DEFAULT NULL,
  `StartTrans` varchar(10) DEFAULT NULL,
  `EndTrans` varchar(10) DEFAULT NULL,
  `CatTrans` tinyint(1) unsigned zerofill DEFAULT NULL,
  `Catagory` varchar(45) DEFAULT NULL,
  `GreatTrans` tinyint(1) unsigned zerofill DEFAULT NULL,
  `GreatTransAmt` double unsigned zerofill DEFAULT NULL,
  `GreatDepo` tinyint(1) unsigned zerofill DEFAULT NULL,
  `GreatDepoAmt` double DEFAULT NULL,
  `GreatWithdraw` tinyint(1) unsigned zerofill DEFAULT NULL,
  `GreatWithdrawAmt` double unsigned zerofill DEFAULT NULL,
  `GreatBal` tinyint(1) unsigned zerofill DEFAULT NULL,
  `GreatBalAmt` double unsigned zerofill DEFAULT NULL,
  `LessBal` tinyint(1) unsigned zerofill DEFAULT NULL,
  `LessBalAmt` double unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`RuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `rules` VALUES (1,12345678,211111110,1,0,'','',0,'',0,0000000000000000000000,0,0,1,0000000000000000001000,0,0000000000000000000000,0,0000000000000000000000),(3,12345678,211111112,0,0,'','',1,'Starbucks',0,0000000000000000000000,0,0,0,0000000000000000000000,0,0000000000000000000000,0,0000000000000000000000);

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `TransId` int(10) NOT NULL,
  `TransDate` char(10) DEFAULT NULL,
  `TransDesc` varchar(30) DEFAULT NULL,
  `Location` varchar(30) DEFAULT NULL,
  `Amount` double(10,2) DEFAULT NULL,
  `Balance` double(10,2) DEFAULT NULL,
  `AccountID` varchar(45) NOT NULL,
  PRIMARY KEY (`TransId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `transactions` VALUES (1,'2019-05-01','Starbucks','Missouri',-2.00,5000.00,'211111110'),(2,'2019-05-01','Chipotle','Missouri',-7.00,4993.00,'211111110'),(3,'2019-05-04','Payroll','Missouri',400.00,5393.00,'211111110'),(4,'2019-05-07','Withdrawal','California',-1200.00,4193.00,'211111110'),(5,'2019-05-09','Gas','Kansas',-30.00,4163.00,'211111110');