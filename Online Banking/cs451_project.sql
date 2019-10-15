CREATE DATABASE  IF NOT EXISTS
USE `cs451r_fs2019_group6`;

--
-- Table structure for table `account_types`
--

DROP TABLE IF EXISTS `account_types`;
CREATE TABLE `account_types` (
  `Account_Type_ID` varchar(3) NOT NULL,
  `Account_Type_Name` varchar(60) NOT NULL,
  PRIMARY KEY (`Account_Type_ID`)
);

INSERT INTO `account_types` VALUES ('CD','certificate of deposit'),('CHK','checking account'),('SAV','savings account');

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `Account_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AcctOpen_Date` date NOT NULL,
  `AcctClose_Date` date DEFAULT NULL,
  `AcctStatus` enum('ACTIVE','CLOSED','FROZEN') DEFAULT NULL,
  `Branch_ID` smallint(5) unsigned DEFAULT NULL,
  `Employee_ID` smallint(5) unsigned DEFAULT NULL,
  `Account_Type_ID` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`Account_ID`),
  KEY `fk_accounts_branches` (`Branch_ID`),
  KEY `fk_accounts_employees` (`Employee_ID`),
  KEY `fk_accounts_account_types` (`Account_Type_ID`),
  CONSTRAINT `fk_accounts_account_types` FOREIGN KEY (`Account_Type_ID`) REFERENCES `account_types` (`Account_Type_ID`),
  CONSTRAINT `fk_accounts_branches` FOREIGN KEY (`Branch_ID`) REFERENCES `branches` (`Branch_ID`),
  CONSTRAINT `fk_accounts_employees` FOREIGN KEY (`Employee_ID`) REFERENCES `employees` (`Employee_id`)
);

INSERT INTO `accounts` VALUES (5,'2015-12-05',NULL,'ACTIVE',NULL,NULL,'CHK'),(6,'2015-12-05',NULL,'ACTIVE',NULL,NULL,'SAV');

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts` (
  `TransDate` char(10) DEFAULT NULL,
  `AlertReason` varchar(50) DEFAULT NULL
);

INSERT INTO `alerts` VALUES ('2019-05-07','Location is not Missouri or Kansas'),('2019-05-07','Amount is Over $1000');

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
CREATE TABLE `branches` (
  `Branch_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `BranchName` varchar(20) NOT NULL,
  `BranchStreet` varchar(30) DEFAULT NULL,
  `BranchCity` varchar(20) DEFAULT NULL,
  `State_ID` varchar(2) DEFAULT NULL,
  `BranchZip_Code` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`Branch_ID`),
  KEY `fk_branches_states` (`State_ID`),
  CONSTRAINT `fk_branches_states` FOREIGN KEY (`State_ID`) REFERENCES `states` (`State_ID`)
);

--
-- Table structure for table `customer_accounts`
--

DROP TABLE IF EXISTS `customer_accounts`;
CREATE TABLE `customer_accounts` (
  `CustomerID` int(11) NOT NULL,
  `AccountID` int(11) NOT NULL,
  KEY `CustomerID_idx` (`CustomerID`)
);

INSERT INTO `customer_accounts` VALUES (2,5),(2,6);

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `Customer_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustStreet` varchar(30) DEFAULT NULL,
  `CustCity` varchar(20) DEFAULT NULL,
  `State_ID` varchar(2) DEFAULT NULL,
  `CustZip_code` varchar(10) DEFAULT NULL,
  `CustFirst_Name` varchar(20) NOT NULL,
  `CustLast_Name` varchar(20) NOT NULL,
  `CustBirth_Date` date NOT NULL,
  `CustEmail` varchar(30) DEFAULT NULL,
  `CustPhone` varchar(15) NOT NULL,
  `CustUserName` varchar(20) NOT NULL,
  `CustPassword` varchar(20) NOT NULL,
  PRIMARY KEY (`Customer_ID`),
  KEY `fk_customers_states` (`State_ID`),
  CONSTRAINT `fk_customers_states` FOREIGN KEY (`State_ID`) REFERENCES `states` (`State_ID`)
);

INSERT INTO `customers` VALUES (2,'11 Rise St','Kansas City','MO','64123','John','Smith','1970-06-22','john.smith@gmail.com','816-123-4567','jsmith','a1');

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `Department_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `DeptName` varchar(20) NOT NULL,
  PRIMARY KEY (`Department_ID`)
);

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `Employee_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `EmpFirst_Name` varchar(20) NOT NULL,
  `EmpLast_Name` varchar(20) NOT NULL,
  `EmpStart_date` date NOT NULL,
  `EmpEnd_date` date DEFAULT NULL,
  `Department_ID` smallint(5) unsigned DEFAULT NULL,
  `Branch_ID` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`Employee_id`),
  KEY `fk_employees_departments` (`Department_ID`),
  KEY `fk_employees_branches` (`Branch_ID`),
  CONSTRAINT `fk_employees_branches` FOREIGN KEY (`Branch_ID`) REFERENCES `branches` (`Branch_ID`),
  CONSTRAINT `fk_employees_departments` FOREIGN KEY (`Department_ID`) REFERENCES `departments` (`Department_ID`)
);

--
-- Table structure for table `previousreports`
--

DROP TABLE IF EXISTS `previousreports`;
CREATE TABLE `previousreports` (
  `StartDate` char(10) DEFAULT NULL,
  `EndDate` char(10) DEFAULT NULL,
  `AlertsInTimePeriod` int(10) DEFAULT NULL
);

INSERT INTO `previousreports` VALUES ('2019-04-01','2019-04-30',24),('2019-03-01','2019-03-30',15),('2019-02-01','2019-02-30',32),('2019-01-01','2019-01-30',8);

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `Alert` varchar(50) DEFAULT NULL,
  `TimesRecently` int(10) DEFAULT NULL
);

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
);

INSERT INTO `rules` VALUES (1,2,5,1,0,'','',0,'',0,0000000000000000000000,0,0,1,0000000000000000001000,0,0000000000000000000000,0,0000000000000000000000),(3,2,6,0,0,'','',1,'Starbucks',0,0000000000000000000000,0,0,0,0000000000000000000000,0,0000000000000000000000,0,0000000000000000000000);

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `State_ID` varchar(2) NOT NULL,
  `StateName` varchar(20) NOT NULL,
  PRIMARY KEY (`State_ID`)
);

INSERT INTO `states` VALUES ('CA','California'),('KS','Kansas'),('MO','Missouri'),('NY','New York');

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `Transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Account_ID` int(10) unsigned NOT NULL,
  `TrnsDate` varchar(10) NOT NULL,
  `TrnsType` enum('DR','CR') DEFAULT NULL,
  `TrnsAmount` decimal(10,2) NOT NULL,
  `TrnsName` varchar(50) NOT NULL,
  `Employee_ID` smallint(5) unsigned DEFAULT NULL,
  `TrnsLocation` varchar(2) DEFAULT NULL,
  `TrnsBalance` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Transaction_id`),
  KEY `fk_transactions_accounts` (`Account_ID`),
  KEY `fk_transactions_employees` (`Employee_ID`),
  CONSTRAINT `fk_transactions_accounts` FOREIGN KEY (`Account_ID`) REFERENCES `accounts` (`Account_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_transactions_employees` FOREIGN KEY (`Employee_ID`) REFERENCES `employees` (`Employee_id`)
);

INSERT INTO `transactions` VALUES (1,5,'05/01/19','CR',0.00,'',NULL,NULL,5000.00),(2,5,'05/02/19','DR',2.00,'Starbucks',NULL,NULL,4998.00),(3,5,'05/04/19','CR',800.00,'Payroll',NULL,NULL,5798.00),(4,5,'05/07/19','DR',8.00,'Chipotle',NULL,NULL,5790.00),(5,5,'05/09/19','DR',10.00,'ATM',NULL,NULL,5780.00),(6,5,'05/10/19','DR',32.00,'Hoolihans',NULL,NULL,5748.00),(7,5,'05/10/19','DR',100.00,'KCPL',NULL,NULL,5648.00),(8,5,'05/10/19','DR',190.00,'Google Fiber',NULL,NULL,5458.00),(9,5,'05/15/19','DR',9.99,'Netflix',NULL,NULL,5448.01),(10,5,'05/15/19','DR',350.00,'Rent',NULL,NULL,5098.01),(11,5,'05/19/19','DR',2.00,'Starbucks',NULL,NULL,5096.01),(12,5,'05/19/19','CR',750.00,'Payroll',NULL,NULL,5846.01),(13,5,'05/19/19','DR',620.00,'Commerce Bank Credit Card payment',NULL,NULL,5226.01),(14,5,'05/19/19','DR',150.00,'McFaddens',NULL,NULL,5076.01),(15,5,'05/22/19','DR',100.00,'Price Chopper',NULL,NULL,4976.01),(16,5,'05/23/19','CR',50.00,'Check from friend',NULL,NULL,5026.01),(17,5,'06/02/19','CR',800.00,'Payroll',NULL,NULL,5826.01),(18,5,'06/02/19','DR',9.00,'Hyvee',NULL,NULL,5817.01),(19,5,'06/06/19','DR',14.00,'McFaddens',NULL,NULL,5803.01),(20,5,'06/13/19','DR',32.00,'Target',NULL,NULL,5771.01),(21,5,'06/13/19','DR',100.00,'KCPL',NULL,NULL,5671.01),(22,5,'06/19/19','CR',750.00,'Payroll',NULL,NULL,6421.01),(23,5,'06/19/19','DR',190.00,'Google Fiber',NULL,NULL,6231.01),(24,5,'06/19/19','DR',9.99,'Netflix',NULL,NULL,6221.02),(25,5,'06/19/19','DR',350.00,'Rent',NULL,NULL,5871.02),(26,5,'06/22/19','DR',6.50,'Neo\'s',NULL,NULL,5864.52),(27,5,'06/22/19','DR',230.00,'Commerce Bank Credit Card payment',NULL,NULL,5634.52),(28,5,'06/22/19','DR',100.00,'Best Buy',NULL,NULL,5534.52),(29,5,'06/22/19','DR',300.00,'Pottery Barn',NULL,NULL,5234.52),(30,5,'06/26/19','DR',23.00,'The Loft',NULL,NULL,5211.52),(31,5,'06/26/19','DR',45.00,'Dave and Busters',NULL,NULL,5166.52),(32,5,'06/26/19','DR',35.00,'Bowling',NULL,NULL,5131.52),(33,5,'06/30/19','CR',800.00,'Payroll',NULL,NULL,5931.52),(34,5,'06/31/19','DR',210.00,'McFaddens',NULL,NULL,5721.52),(35,5,'06/31/19','DR',18.00,'Taco Bell',NULL,NULL,5703.52),(36,5,'06/31/19','DR',45.00,'QuikTrip',NULL,NULL,5658.52),(37,5,'07/02/19','DR',130.00,'KCPL',NULL,NULL,5528.52),(38,5,'07/02/19','DR',185.00,'Google Fiber',NULL,NULL,5343.52),(39,5,'07/04/19','DR',7.99,'Netflix',NULL,NULL,5335.53),(40,5,'07/04/19','DR',56.00,'Price Chopper',NULL,NULL,5279.53),(41,5,'07/06/19','DR',43.00,'Price Chopper',NULL,NULL,5236.53),(42,5,'07/07/19','DR',98.00,'Target',NULL,NULL,5138.53),(43,5,'07/09/19','DR',13.00,'Jose Peppers',NULL,NULL,5125.53),(44,5,'07/10/19','DR',9.00,'Starbucks',NULL,NULL,5116.53),(45,5,'07/12/19','DR',350.00,'Rent',NULL,NULL,4766.53),(46,5,'07/12/19','DR',3.50,'Redbox',NULL,NULL,4763.03),(47,5,'07/12/19','DR',301.00,'Bank of America Credit Card payment',NULL,NULL,4462.03),(48,5,'07/13/19','CR',730.00,'Payroll',NULL,NULL,5192.03),(49,5,'07/14/19','DR',232.68,'Target',NULL,NULL,4959.35),(50,5,'07/14/19','DR',18.50,'Best Buy',NULL,NULL,4940.85),(51,5,'07/16/19','DR',120.00,'Nationwide',NULL,NULL,4820.85),(52,5,'07/19/19','DR',50.00,'KC Police - Speeding Ticket',NULL,NULL,4770.85),(53,5,'07/19/19','DR',50.00,'Uber',NULL,NULL,4720.85),(54,5,'07/19/19','DR',9.20,'Manny\'s',NULL,NULL,4711.65),(55,5,'07/19/19','DR',24.75,'Toys R Us',NULL,NULL,4686.90),(56,5,'07/19/19','DR',3.50,'Scooters',NULL,NULL,4683.40),(57,5,'07/20/19','DR',36.00,'QuikTrip',NULL,NULL,4647.40),(58,5,'07/20/19','DR',32.00,'Price Chopper',NULL,NULL,4615.40),(59,5,'07/21/19','DR',48.12,'Home Depot',NULL,NULL,4567.28),(60,5,'07/22/19','DR',4.20,'Burger King',NULL,NULL,4563.08),(61,5,'07/22/19','DR',45.00,'Jiffy Lube',NULL,NULL,4518.08),(62,5,'07/22/19','DR',25.00,'Doctor visit',NULL,NULL,4493.08),(63,5,'07/23/19','DR',36.00,'CVS',NULL,NULL,4457.08),(64,5,'07/23/19','DR',29.00,'Price Chopper',NULL,NULL,4428.08),(65,5,'07/23/19','DR',200.00,'Transfer to Savings',NULL,NULL,4228.08),(66,5,'07/23/19','CR',150.00,'Christmas Check from Grandma',NULL,NULL,4378.08),(67,5,'07/23/19','DR',250.00,'Student loans',NULL,NULL,4128.08),(68,5,'07/23/19','DR',75.00,'Ford Service',NULL,NULL,4053.08),(69,5,'07/27/19','DR',36.00,'Hallmark',NULL,NULL,4017.08),(70,5,'07/27/19','DR',22.00,'CVS',NULL,NULL,3995.08),(71,5,'07/27/19','CR',810.00,'Payroll',NULL,NULL,4805.08),(72,5,'07/30/19','DR',180.00,'Pottery Barn',NULL,NULL,4625.08),(73,5,'07/30/19','DR',46.00,'Cheesecake Factory',NULL,NULL,4579.08),(74,5,'07/30/19','DR',8.00,'Starbucks',NULL,NULL,4571.08);

UPDATE transactions SET TrnsName = "Initial" WHERE Transaction_id = 1;

UPDATE transactions SET TrnsLocation = "MO" WHERE Account_ID = 5;

UPDATE transactions SET TrnsLocation = "NE" WHERE Transaction_id = 41; # out of state
UPDATE transactions SET TrnsLocation = "NE" WHERE Transaction_id = 42; # out of state

DROP TABLE IF EXISTS `alerts`;

CREATE TABLE `alerts` (
  `Transaction_id` int(10) unsigned NOT NULL,
  `Account_ID` int(10) unsigned NOT NULL,
  `TrnsDate` varchar(10) NOT NULL,
  `AlertReason` varchar(30) NOT NULL
  );
  
INSERT INTO `alerts` VALUES (42, 5, '07/07/19', 'Out of State');
INSERT INTO `alerts` VALUES (41, 5, '07/06/19', 'Out of State');
INSERT INTO `alerts` VALUES (13, 5, '05/19/19', 'Withdrawal Over Amount');

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
	`Rules` varchar(30) NOT NULL,
    `TimesRecent` int(10) NOT NULL
  );
  
INSERT INTO `reports` VALUES ('Out of State', 0);
INSERT INTO `reports` VALUES ('Withdrawal Over Amount', 0);

DROP TABLE IF EXISTS `previousreports`;

CREATE TABLE `previousreports` (
	`StartDate` varchar(10) NOT NULL,
    `EndDate` varchar(10) NOT NULL,
    `AlertsInTimePeriod` int(10) NOT NULL
  );
  
INSERT INTO `previousreports` VALUES ('07/01/19', '07/31/19', 2);
INSERT INTO `previousreports` VALUES ('06/01/19', '06/30/19', 0);
INSERT INTO `previousreports` VALUES ('05/01/19', '05/31/19', 1);
  
