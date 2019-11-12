Use cs451_project;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS account_types;
DROP TABLE IF EXISTS alerts;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS branches;
DROP TABLE IF EXISTS customer_accounts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS previousreports;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS rules;
DROP TABLE IF EXISTS states;
DROP PROCEDURE IF EXISTS transAlert;
DROP TRIGGER IF EXISTS transactions_AFTER_INSERT;


CREATE TABLE `account` (
  ID INT NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  Balance decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (ID)
) AUTO_INCREMENT=12341002;


CREATE TABLE alert (
  ID INT NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  Reason varchar(45) NOT NULL,
  Removed tinyint(3) unsigned NOT NULL DEFAULT '0',
  AccountID INT NOT NULL,
  CustomerID INT NOT NULL,
  TransactionID INT NOT NULL,
  PRIMARY KEY (ID)
) AUTO_INCREMENT=5;

CREATE TABLE archivedreport (
  ID INT NOT NULL AUTO_INCREMENT,
  `Start` date NOT NULL,
  `End` date NOT NULL,
  OutState INT unsigned DEFAULT '0',
  `Range` INT unsigned DEFAULT '0',
  Category INT unsigned DEFAULT '0',
  ExcessTran INT unsigned DEFAULT '0',
  ExcessDepo INT unsigned DEFAULT '0',
  ExcessWith INT unsigned DEFAULT '0',
  HighBal INT unsigned DEFAULT '0',
  LowBal INT unsigned DEFAULT '0',
  AccountID INT NOT NULL,
  CustomerID INT NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE customer (
  ID INT NOT NULL AUTO_INCREMENT,
  Username varchar(45) NOT NULL,
  FirstName varchar(45) NOT NULL,
  LastName varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  State char(2) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE KEY Username (Username,`Password`)
) AUTO_INCREMENT=2;

CREATE TABLE customeraccount (
  CustomerID INT NOT NULL,
  AccountID INT NOT NULL,
  PRIMARY KEY (CustomerID, AccountID)
);

CREATE TABLE report (
  OutState INT unsigned DEFAULT '0',
  `Range` INT unsigned DEFAULT '0',
  Category INT unsigned DEFAULT '0',
  ExcessTran INT unsigned DEFAULT '0',
  ExcessDepo INT unsigned DEFAULT '0',
  ExcessWith INT unsigned DEFAULT '0',
  HighBal INT unsigned DEFAULT '0',
  LowBal INT unsigned DEFAULT '0',
  CustomerID INT NOT NULL,
  AccountID INT NOT NULL,
  PRIMARY KEY (CustomerID,AccountID)
);

CREATE TABLE rule (
  OutStateChk tinyint(1) NOT NULL,
  RangeChk tinyint(1) NOT NULL,
  `Start` date DEFAULT NULL,
  `End` date DEFAULT NULL,
  CatChk tinyint(1) NOT NULL,
  Category varchar(45) DEFAULT NULL,
  GTranChk tinyint(1) NOT NULL,
  GTranAmt decimal(10,2) DEFAULT NULL,
  GDepoChk tinyint(1) NOT NULL,
  GDepoAmt decimal(10,2) DEFAULT NULL,
  GWithChk tinyint(1) NOT NULL,
  GWithAmt decimal(10,2) DEFAULT NULL,
  GBalChk tinyint(1) NOT NULL,
  GBalAmt decimal(10,2) DEFAULT NULL,
  LBalChk tinyint(1) NOT NULL,
  LBalAmt decimal(10,2) DEFAULT NULL,
  CustomerID INT NOT NULL,
  AccountID INT NOT NULL,
  PRIMARY KEY (CustomerID,AccountID)
);

CREATE TABLE `transaction` (
  ID INT NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Type` char(2) NOT NULL,
  Amount decimal(10,2) NOT NULL,
  `Desc` varchar(45) NOT NULL,
  Location char(2) NOT NULL,
  Balance decimal(10,2) NOT NULL,
  AccountID INT NOT NULL,
  PRIMARY KEY (ID)
);

-------------------------------------------------------------------------------------------------------
-- Add Foreign keys and indexes
-------------------------------------------------------------------------------------------------------

ALTER TABLE alert 
  ADD KEY Alert_AccoutID_FK (AccountID),
  ADD KEY Alert_TransactionID_FK (TransactionID),
  ADD KEY Alert_CustomerID_FK (CustomerID),
  ADD CONSTRAINT Alert_AccoutID_FK FOREIGN KEY (AccountID) REFERENCES account (ID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT Alert_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES customer (ID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT Alert_TransactionID_FK FOREIGN KEY (TransactionID) REFERENCES transaction (ID) ON DELETE CASCADE ON UPDATE CASCADE;
  
ALTER TABLE archivedreport
  ADD KEY ArchivedReport_AccountID_FK (AccountID),
  ADD KEY ArchivedReport_CustomerID_FK (CustomerID),
  ADD CONSTRAINT ArchivedReport_AccountID_FK FOREIGN KEY (AccountID) REFERENCES account (ID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT ArchivedReport_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES customer (ID) ON DELETE CASCADE ON UPDATE CASCADE;
  
ALTER TABLE customeraccount
  ADD KEY CustomerAccount_AccountID_FK (AccountID),
  ADD KEY CustomerAccount_CustomerID_FK (CustomerID),
  ADD CONSTRAINT CustomerAccount_AccountID_FK FOREIGN KEY (AccountID) REFERENCES account (ID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT CustomerAccount_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES customer (ID) ON DELETE CASCADE ON UPDATE CASCADE;
  
ALTER TABLE report
  ADD KEY Report_AccountID_FK (AccountID),
  ADD KEY Report_CustomerID_FK (CustomerID),
  ADD CONSTRAINT Report_AccountID_FK FOREIGN KEY (AccountID) REFERENCES account (ID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT Report_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES customer (ID) ON DELETE CASCADE ON UPDATE CASCADE;
  
ALTER TABLE rule
  ADD KEY Rule_AccountID_FK (AccountID),
  ADD KEY Rule_CustomerID_FK (CustomerID),
  ADD CONSTRAINT Rule_AccountID_FK FOREIGN KEY (AccountID) REFERENCES account (ID) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT Rule_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES customer (ID) ON DELETE CASCADE ON UPDATE CASCADE;
  
ALTER TABLE `transaction`
  ADD KEY Transaction_AccountID_FK (AccountID),
  ADD CONSTRAINT Transaction_AccountID_FK FOREIGN KEY (AccountID) REFERENCES account (ID) ON DELETE CASCADE ON UPDATE CASCADE;

-------------------------------------------------------------------------------------------------------
-- Insert data
-------------------------------------------------------------------------------------------------------

INSERT INTO account VALUES (12341000,'SAV',0.00);
INSERT INTO account VALUES (12341001,'CHK',4002.00);

INSERT INTO customer VALUES (1,'jsmith','John','Smith','a1','MO');

INSERT INTO customeraccount VALUES (1,12341000);
INSERT INTO customeraccount VALUES (1,12341001);

INSERT INTO rule VALUES (0,0,NULL,NULL,0,NULL,0,0.00,0,0.00,1,100.00,0,0.00,1,2000.00,1,12341000);
INSERT INTO rule VALUES (0,0,NULL,NULL,1,'Starbucks',0,0.00,0,0.00,0,0.00,0,0.00,0,0.00,1,12341001);

INSERT INTO transaction VALUES (1,'2019-05-01','CR',5000.00,'Initial','MO',5000.00,12341001);
INSERT INTO transaction VALUES (2,'2019-05-02','DR',2.00,'Starbucks','MO',4998.00,12341001);
INSERT INTO transaction VALUES (3,'2019-05-04','CR',800.00,'Payroll','MO',5798.00,12341001);
INSERT INTO transaction VALUES (4,'2019-05-07','DR',8.00,'Chipotle','MO',5790.00,12341001);
INSERT INTO transaction VALUES (5,'2019-05-09','DR',10.00,'ATM','MO',5780.00,12341001);
INSERT INTO transaction VALUES (6,'2019-05-10','DR',32.00,'Hoolihans','MO',5748.00,12341001);
INSERT INTO transaction VALUES (7,'2019-05-10','DR',100.00,'KCPL','MO',5648.00,12341001);
INSERT INTO transaction VALUES (8,'2019-05-10','DR',190.00,'Google Fiber','MO',5458.00,12341001);
INSERT INTO transaction VALUES (9,'2019-05-15','DR',9.99,'Netflix','MO',5448.00,12341001);
INSERT INTO transaction VALUES (10,'2019-05-15','DR',350.00,'Rent','MO',5098.00,12341001);
INSERT INTO transaction VALUES (11,'2019-05-19','DR',2.00,'Starbucks','MO',5096.00,12341001);
INSERT INTO transaction VALUES (12,'2019-05-19','CR',750.00,'Payroll','MO',5846.00,12341001);
INSERT INTO transaction VALUES (13,'2019-05-19','DR',620.00,'Commerce Bank Credit Card payment','MO',5226.00,12341001);
INSERT INTO transaction VALUES (14,'2019-05-19','DR',150.00,'McFaddens','MO',5076.00,12341001);
INSERT INTO transaction VALUES (15,'2019-05-22','DR',100.00,'Price Chopper','MO',4976.00,12341001);
INSERT INTO transaction VALUES (16,'2019-05-23','CR',50.00,'Check from friend','MO',5026.00,12341001);
INSERT INTO transaction VALUES (17,'2019-06-02','CR',800.00,'Payroll','MO',5826.00,12341001);
INSERT INTO transaction VALUES (18,'2019-06-02','DR',9.00,'Hyvee','MO',5817.00,12341001);
INSERT INTO transaction VALUES (19,'2019-06-06','DR',14.00,'McFaddens','MO',5803.00,12341001);
INSERT INTO transaction VALUES (20,'2019-06-13','DR',32.00,'Target','MO',5771.00,12341001);
INSERT INTO transaction VALUES (21,'2019-06-13','DR',100.00,'KCPL','MO',5671.00,12341001);
INSERT INTO transaction VALUES (22,'2019-06-19','CR',750.00,'Payroll','MO',6421.00,12341001);
INSERT INTO transaction VALUES (23,'2019-06-19','DR',190.00,'Google Fiber','MO',6231.00,12341001);
INSERT INTO transaction VALUES (24,'2019-06-19','DR',9.99,'Netflix','MO',6221.00,12341001);
INSERT INTO transaction VALUES (25,'2019-06-19','DR',350.00,'Rent','MO',5871.00,12341001);
INSERT INTO transaction VALUES (26,'2019-06-22','DR',6.50,'Neo\'s','MO',5865.00,12341001);
INSERT INTO transaction VALUES (27,'2019-06-22','DR',230.00,'Commerce Bank Credit Card payment','MO',5635.00,12341001);
INSERT INTO transaction VALUES (28,'2019-06-22','DR',100.00,'Best Buy','MO',5535.00,12341001);
INSERT INTO transaction VALUES (29,'2019-06-22','DR',300.00,'Pottery Barn','MO',5235.00,12341001);
INSERT INTO transaction VALUES (30,'2019-06-26','DR',23.00,'The Loft','MO',5212.00,12341001);
INSERT INTO transaction VALUES (31,'2019-06-26','DR',45.00,'Dave and Busters','MO',5167.00,12341001);
INSERT INTO transaction VALUES (32,'2019-06-26','DR',35.00,'Bowling','MO',5132.00,12341001);
INSERT INTO transaction VALUES (33,'2019-06-30','CR',800.00,'Payroll','MO',5932.00,12341001);
INSERT INTO transaction VALUES (34,'2019-07-01','DR',210.00,'McFaddens','MO',5722.00,12341001);
INSERT INTO transaction VALUES (35,'2019-07-01','DR',18.00,'Taco Bell','MO',5704.00,12341001);
INSERT INTO transaction VALUES (36,'2019-07-01','DR',45.00,'QuikTrip','MO',5659.00,12341001);
INSERT INTO transaction VALUES (37,'2019-07-02','DR',130.00,'KCPL','MO',5529.00,12341001);
INSERT INTO transaction VALUES (38,'2019-07-02','DR',185.00,'Google Fiber','MO',5344.00,12341001);
INSERT INTO transaction VALUES (39,'2019-07-04','DR',7.99,'Netflix','MO',5336.00,12341001);
INSERT INTO transaction VALUES (40,'2019-07-04','DR',56.00,'Price Chopper','MO',5280.00,12341001);
INSERT INTO transaction VALUES (41,'2019-07-06','DR',43.00,'Price Chopper','NE',5237.00,12341001);
INSERT INTO transaction VALUES (42,'2019-07-07','DR',98.00,'Target','NE',5139.00,12341001);
INSERT INTO transaction VALUES (43,'2019-07-09','DR',13.00,'Jose Peppers','MO',5126.00,12341001);
INSERT INTO transaction VALUES (44,'2019-07-10','DR',9.00,'Starbucks','MO',5117.00,12341001);
INSERT INTO transaction VALUES (45,'2019-07-12','DR',350.00,'Rent','MO',4767.00,12341001);
INSERT INTO transaction VALUES (46,'2019-07-12','DR',3.50,'Redbox','MO',4764.00,12341001);
INSERT INTO transaction VALUES (47,'2019-07-12','DR',301.00,'Bank of America Credit Card payment','MO',4463.00,12341001);
INSERT INTO transaction VALUES (48,'2019-07-13','CR',730.00,'Payroll','MO',5193.00,12341001);
INSERT INTO transaction VALUES (49,'2019-07-14','DR',232.68,'Target','MO',4960.00,12341001);
INSERT INTO transaction VALUES (50,'2019-07-14','DR',18.50,'Best Buy','MO',4942.00,12341001);
INSERT INTO transaction VALUES (51,'2019-07-16','DR',120.00,'Nationwide','MO',4822.00,12341001);
INSERT INTO transaction VALUES (52,'2019-07-19','DR',50.00,'KC Police - Speeding Ticket','MO',4772.00,12341001);
INSERT INTO transaction VALUES (53,'2019-07-19','DR',50.00,'Uber','MO',4722.00,12341001);
INSERT INTO transaction VALUES (54,'2019-07-19','DR',9.20,'Manny\'s','MO',4713.00,12341001);
INSERT INTO transaction VALUES (55,'2019-07-19','DR',24.75,'Toys R Us','MO',4688.00,12341001);
INSERT INTO transaction VALUES (56,'2019-07-19','DR',3.50,'Scooters','MO',4685.00,12341001);
INSERT INTO transaction VALUES (57,'2019-07-20','DR',36.00,'QuikTrip','MO',4649.00,12341001);
INSERT INTO transaction VALUES (58,'2019-07-20','DR',32.00,'Price Chopper','MO',4617.00,12341001);
INSERT INTO transaction VALUES (59,'2019-07-21','DR',48.12,'Home Depot','MO',4569.00,12341001);
INSERT INTO transaction VALUES (60,'2019-07-22','DR',4.20,'Burger King','MO',4565.00,12341001);
INSERT INTO transaction VALUES (61,'2019-07-22','DR',45.00,'Jiffy Lube','MO',4520.00,12341001);
INSERT INTO transaction VALUES (62,'2019-07-22','DR',25.00,'Doctor visit','MO',4495.00,12341001);
INSERT INTO transaction VALUES (63,'2019-07-23','DR',36.00,'CVS','MO',4459.00,12341001);
INSERT INTO transaction VALUES (64,'2019-07-23','DR',29.00,'Price Chopper','MO',4430.00,12341001);
INSERT INTO transaction VALUES (65,'2019-07-23','DR',200.00,'Transfer to Savings','MO',4230.00,12341001);
INSERT INTO transaction VALUES (66,'2019-07-23','CR',150.00,'Christmas Check from Grandma','MO',4380.00,12341001);
INSERT INTO transaction VALUES (67,'2019-07-23','DR',250.00,'Student loans','MO',4130.00,12341001);
INSERT INTO transaction VALUES (68,'2019-07-23','DR',75.00,'Ford Service','MO',4055.00,12341001);
INSERT INTO transaction VALUES (69,'2019-07-27','DR',36.00,'Hallmark','MO',4019.00,12341001);
INSERT INTO transaction VALUES (70,'2019-07-27','DR',22.00,'CVS','MO',3997.00,12341001);
INSERT INTO transaction VALUES (71,'2019-07-27','CR',810.00,'Payroll','MO',4807.00,12341001);
INSERT INTO transaction VALUES (72,'2019-07-30','DR',180.00,'Pottery Barn','MO',4627.00,12341001);
INSERT INTO transaction VALUES (73,'2019-07-30','DR',46.00,'Cheesecake Factory','MO',4581.00,12341001);
INSERT INTO transaction VALUES (74,'2019-07-30','DR',8.00,'Starbucks','MO',4573.00,12341001);
INSERT INTO transaction VALUES (75,'2019-10-13','DR',571.08,'Gym','NY',4002.00,12341001);

INSERT INTO alert VALUES (1,'2019-05-02','Flagged catagory',0,12341001,1,2);
INSERT INTO alert VALUES (2,'2019-05-19','Flagged catagory',0,12341001,1,11);
INSERT INTO alert VALUES (3,'2019-07-10','Flagged catagory',0,12341001,1,44);
INSERT INTO alert VALUES (4,'2019-07-30','Flagged catagory',0,12341001,1,74);

INSERT INTO report VALUES (0,0,4,0,0,0,0,0,1,12341001);

INSERT INTO archivedreport VALUES (1, '2019-05-02', '2019-07-30', 0, 0, 4, 0, 0, 0, 0, 0, 12341001, 1);

-------------------------------------------------------------------------------------------------------
-- Add Stored Procedures
-------------------------------------------------------------------------------------------------------

DELIMITER $$ 
CREATE PROCEDURE addTransaction(date varchar(10), Type char(2), 
	Amount decimal(10,2), name varchar(50), Location varchar(2), AccountID INT)
BEGIN    
	DECLARE Balance INT DEFAULT 0;
    
    IF CONVERT(Type USING utf8mb4) = 'CR' THEN
        SELECT Account.Balance + Amount INTO Balance FROM Account WHERE Account.ID = AccountID;
	ELSEIF CONVERT(Type USING utf8mb4) = 'DR' THEN
		SELECT Account.Balance - Amount INTO Balance FROM Account WHERE Account.ID = AccountID;
    END IF;
    
    Insert into transaction(Date, Type, Amount, Transaction.Desc, Location, Balance, AccountID) 
		values (STR_TO_DATE(date, '%m/%d/%y'), Type, Amount, name, Location, Balance, AccountID);
	UPDATE Account SET Account.Balance = Balance WHERE Account.ID = AccountID;
END;

CREATE PROCEDURE deleteRules(IN customerID INT, IN accountID INT)
BEGIN
	DELETE FROM rule WHERE rule.CustomerID = customerID AND rule.AccountID = accountID;
END;

CREATE PROCEDURE generateReport(IN OutState INT, IN date INT, IN Cat INT, 
	IN GTran INT, IN GDepo INT, IN GWith INT, IN GBal INT, IN LBal INT, IN customerID INT, 
    IN accountID INT)
BEGIN
	INSERT INTO report(OutState, report.Range, Category, ExcessTran, ExcessDepo, ExcessWith, 
		HighBal, LowBal, CustomerID, AccountID)
		VALUES (OutState, date, Cat, GTran, GDepo, GWith, GBal, LBal, customerID, accountID) 
        ON DUPLICATE KEY UPDATE
		OutState = OutState + OutState, report.Range = report.Range + date, Category = Category + Cat, 
		ExcessTran = ExcessTran + GTran, ExcessDepo = ExcessDepo + GDepo, ExcessWith = ExcessWith + GWith, 
		HighBal = HighBal + GBal, LowBal = LowBal + LBal;
END;

CREATE PROCEDURE getAccounts(IN customerID INT)
BEGIN
	SELECT AccountID FROM customeraccount
    WHERE customeraccount.CustomerID = customerID;
END;

CREATE PROCEDURE getAccount(IN accountID INT)
BEGIN
	SELECT Type, Balance FROM account
    WHERE account.ID = accountID;
END;

CREATE PROCEDURE getAlerts(IN customerID INT, IN accountID INT)
BEGIN
	SELECT Alert.ID, TransactionID, Alert.Date, Transaction.Desc, Transaction.Type, 
		Location, Amount, Balance, Reason, Removed FROM Alert
		INNER JOIN Transaction ON Transaction.ID = Alert.TransactionID
        WHERE Alert.CustomerID = customerID and Alert.AccountID = accountID
        ORDER BY TransactionID DESC;
END;

CREATE PROCEDURE getPrevReports(IN customerID INT, IN accountID INT)
BEGIN
	SELECT ID, Start, End, OutState, ArchivedReport.Range, Category, ExcessTran, 
		ExcessDepo, ExcessWith, HighBal, LowBal, (OutState + ArchivedReport.Range + 
        Category + ExcessTran + ExcessDepo + ExcessWith + HighBal + LowBal) AS 
        AlertsInTimePeriod FROM ArchivedReport WHERE ArchivedReport.CustomerID = customerID 
        AND ArchivedReport.accountID = accountID ORDER BY End DESC;
END;

CREATE PROCEDURE getReports(IN customerID INT, IN accountID INT)
BEGIN
	SELECT OutState, Report.Range, Category, ExcessTran, ExcessDepo, 
		ExcessWith, HighBal, LowBal, (OutState + Report.Range + Category + 
        ExcessTran + ExcessDepo + ExcessWith + HighBal + LowBal) AS 
        AlertsInTimePeriod FROM Report WHERE Report.CustomerID = customerID 
        AND Report.accountID = accountID;
END;

CREATE PROCEDURE getRules(IN customerID INT, IN accountID INT)
BEGIN
	SELECT OutStateChk, RangeChk, Start, End, CatChk, Category, GTranChk,
		GTranAmt, GDepoChk, GDepoAmt, GWithChk, GWithAmt, GBalChk, GBalAmt, 
        LBalChk, LBalAmt FROM Rule
		WHERE rule.CustomerID = customerID AND rule.AccountID = accountID;
END;

CREATE PROCEDURE getTransactions(IN accountID INT)
BEGIN
	SELECT ID, Date, Type, Amount, Transaction.Desc, Location, Balance 
    FROM Transaction WHERE Transaction.AccountID = accountID
    ORDER BY ID DESC;
END;

CREATE PROCEDURE setRules(IN OutStateChk tinyint(1), IN RangeChk tinyint(1), IN Start date,
	IN End date, IN CatChk tinyint(1), IN Category VARCHAR(45), IN GTranChk tinyint(1), 
    IN GTranAmt decimal(10,2), IN GDepoChk tinyint(1), IN GDepoAmt decimal(10,2), IN GWithChk tinyint(1), 
    IN GWithAmt decimal(10,2), IN GBalChk tinyint(1), IN GBalAmt decimal(10,2), IN LBalChk tinyint(1), 
    IN LBalAmt decimal(10,2), IN CustomerID INT, IN AccountID INT)
BEGIN
	DECLARE HASRULE INT DEFAULT 0;
    SELECT COUNT(*) INTO HASRULE FROM Rule
    WHERE rule.CustomerID = CustomerID AND rule.AccountID = AccountID;
    
	IF HASRULE = 0 THEN
		INSERT INTO rule(OutStateChk, RangeChk, Start, End, CatChk, Category, GTranChk, GTranAmt, GDepoChk,
			GDepoAmt, GWithChk, GWithAmt, GBalChk, GBalAmt, LBalChk, LBalAmt, CustomerID, AccountID) 
            VALUES (OutStateChk, RangeChk, Start, End, CatChk, Category, GTranChk, GTranAmt, GDepoChk,
			GDepoAmt, GWithChk, GWithAmt, GBalChk, GBalAmt, LBalChk, LBalAmt, CustomerID, AccountID);
    ELSE
		UPDATE rule SET 
        rule.OutStateChk = outstatechk,
        rule.RangeChk = RangeChk, 
        rule.Start = Start, 
        rule.End = End, 
        rule.CatChk = CatChk, 
        rule.Category = Category, 
        rule.GTranChk = GTranChk,
		rule.GTranAmt = GTranAmt, 
        rule.GDepoChk = GDepoChk, 
        rule.GDepoAmt = GDepoAmt, 
        rule.GWithChk = GWithChk, 
        rule.GWithAmt = GWithAmt, 
        rule.GBalChk = GBalChk, 
        rule.GBalAmt = GBalAmt, 
        rule.LBalChk = LBalChk, 
        rule.LBalAmt = LBalAmt
        WHERE rule.CustomerID = CustomerID AND rule.AccountID = AccountID;
    END IF;
END;

CREATE PROCEDURE transAlert(accountID INT, transID INT, 
	transLoc char(2), tdate date, tCat varchar(45), tAmt decimal(10,2), 
    tType char(2), tBal decimal(10,2))
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE Customer INT;
	DECLARE curCustomers CURSOR FOR SELECT CustomerID FROM customeraccount 
		WHERE customeraccount.AccountID = accountID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    OPEN curCustomers;
    getCustomers: LOOP
		FETCH curCustomers INTO Customer;
        IF finished = 1 THEN
			LEAVE getCustomers;
		END IF;
        
        SELECT OutStateChk, RangeChk, Start, End, CatChk, Category, GTranChk, GTranAmt,
			GDepoChk, GDepoAmt, GWithChk, GWithAmt, GBalChk, GBalAmt, LBalChk, LBalAmt
			INTO @OutState, @RangeChk, @StartDte, @EndDte, @CatChk, @Cat, @GrtTrnChk, @GrtTrnAmt, @GrtDepoChk,
				@GrtDepoAmt, @GrtDRChk, @GrtDRAmt, @GrtBalChk, @GrtBalAmt, @LsBalChk, @LsBalAmt
				FROM rule WHERE rule.CustomerID = Customer AND rule.AccountID = accountID;
                
        IF (@OutState AND (SELECT State FROM customer WHERE customer.ID = Customer) <> transLoc) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Out of state');
			CALL generateReport(1, 0, 0, 0, 0, 0, 0, 0, Customer, accountID);
                
		ELSEIF (@RangeChk AND (tdate BETWEEN @StartDte AND @EndDte)) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Flagged date range');
			CALL generateReport(0, 1, 0, 0, 0, 0, 0, 0, Customer, accountID);
                
		ELSEIF (@CatChk AND @Cat = tCat) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Flagged catagory');
			CALL generateReport(0, 0, 1, 0, 0, 0, 0, 0, Customer, accountID);
                
		ELSEIF (@GrtTrnChk AND tAmt > @GrtTrnAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Excessive Transaction');
			CALL generateReport(0, 0, 0, 1, 0, 0, 0, 0, Customer, accountID);
            
        ELSEIF (@GrtDepoChk AND tType = 'CR' AND tAmt > @GrtDepoAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Excessive Deposit');
			CALL generateReport(0, 0, 0, 0, 1, 0, 0, 0, Customer, accountID);
            
		ELSEIF (@GrtDRChk AND tType = 'DR' AND tAmt > @GrtDRAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Excessive Withdraw');
			CALL generateReport(0, 0, 0, 0, 0, 1, 0, 0, Customer, accountID);
            
		ELSEIF (@GrtBalChk AND tBal > @GrtBalAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'High Balance');
			CALL generateReport(0, 0, 0, 0, 0, 0, 1, 0, Customer, accountID);
            
		ELSEIF (@LsBalChk AND tBal < @LsBalAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, 'Low Balance');
			CALL generateReport(0, 0, 0, 0, 0, 0, 0, 1, Customer, accountID);
        END IF;
        
    END LOOP getCustomers;
    CLOSE curCustomers;
END;

CREATE PROCEDURE validateUser(IN username VARCHAR(45), IN password VARCHAR(45))
BEGIN
	Select ID, FirstName, LastName FROM Customer
    WHERE Customer.Username = username AND Customer.Password = password;
END;$$

-------------------------------------------------------------------------------------------------------
-- Add Triggers (To preserve state of data, insert data before adding triggers)
-------------------------------------------------------------------------------------------------------

DELIMITER $$ 
CREATE TRIGGER transaction_AFTER_INSERT AFTER INSERT ON `transaction` FOR EACH ROW BEGIN
	CALL transAlert(NEW.AccountID, NEW.ID, NEW.Location, NEW.Date, 
		NEW.Desc, NEW.Amount, NEW.Type, NEW.Balance);
END;$$