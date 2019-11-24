DROP DATABASE IF EXISTS `cs451_project`;
CREATE DATABASE cs451_project;
USE cs451_project;

-------------------------------------------------------------------------------------------------------
-- Add Tables
-------------------------------------------------------------------------------------------------------

CREATE TABLE `account` (
  ID int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  Balance decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (ID)
) AUTO_INCREMENT=12341002;

CREATE TABLE alert (
  ID int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  Reason varchar(45) NOT NULL,
  Removed tinyint(3) unsigned NOT NULL DEFAULT '0',
  AccountID int(11) NOT NULL,
  CustomerID int(11) NOT NULL,
  TransactionID int(11) NOT NULL,
  PRIMARY KEY (ID)
) AUTO_INCREMENT=26;

CREATE TABLE archivedreport (
  ID int(11) NOT NULL AUTO_INCREMENT,
  `Start` date NOT NULL,
  `End` date NOT NULL,
  OutState int(10) unsigned DEFAULT '0',
  `Range` int(10) unsigned DEFAULT '0',
  Category int(10) unsigned DEFAULT '0',
  ExcessTran int(10) unsigned DEFAULT '0',
  ExcessDepo int(10) unsigned DEFAULT '0',
  ExcessWith int(10) unsigned DEFAULT '0',
  HighBal int(10) unsigned DEFAULT '0',
  LowBal int(10) unsigned DEFAULT '0',
  AccountID int(11) NOT NULL,
  CustomerID int(11) NOT NULL,
  PRIMARY KEY (ID)
) AUTO_INCREMENT=5;

CREATE TABLE customer (
  ID int(11) NOT NULL AUTO_INCREMENT,
  Username varchar(45) NOT NULL,
  FirstName blob NOT NULL,
  LastName blob NOT NULL,
  `Password` binary(20) NOT NULL,
  State blob NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE KEY Username (Username,`Password`)
) AUTO_INCREMENT=2;

CREATE TABLE customeraccount (
  CustomerID int(11) NOT NULL,
  AccountID int(11) NOT NULL,
  PRIMARY KEY (CustomerID,AccountID)
);

CREATE TABLE report (
  ID int(11) NOT NULL AUTO_INCREMENT,
  OutState int(10) unsigned DEFAULT '0',
  `Range` int(10) unsigned DEFAULT '0',
  Category int(10) unsigned DEFAULT '0',
  ExcessTran int(10) unsigned DEFAULT '0',
  ExcessDepo int(10) unsigned DEFAULT '0',
  ExcessWith int(10) unsigned DEFAULT '0',
  HighBal int(10) unsigned DEFAULT '0',
  LowBal int(10) unsigned DEFAULT '0',
  CustomerID int(11) NOT NULL,
  AccountID int(11) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE KEY Unique_CustomerID_AccountID (CustomerID,AccountID)
) AUTO_INCREMENT=26;

CREATE TABLE rule (
  ID int(11) NOT NULL AUTO_INCREMENT,
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
  CustomerID int(11) NOT NULL,
  AccountID int(11) NOT NULL,
  PRIMARY KEY (ID),
  UNIQUE KEY Unique_CustomerID_AccountID (CustomerID,AccountID)
) AUTO_INCREMENT=3;

CREATE TABLE `transaction` (
  ID int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Type` char(2) NOT NULL,
  Amount decimal(10,2) NOT NULL,
  `Desc` blob NOT NULL,
  Location blob NOT NULL,
  Balance decimal(10,2) NOT NULL,
  AccountID int(11) NOT NULL,
  PRIMARY KEY (ID)
) AUTO_INCREMENT=77;

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

INSERT INTO account VALUES (12341000,'SAV',3580.39);
INSERT INTO account VALUES (12341001,'CHK',5419.61);

INSERT INTO customer VALUES (1,'jsmith',0x5EA67BB8E779273924DCCBDD8CDD909E,0x8EC6A0897CC5E7690596D46B1C163070,0x8093D995F066734046DBF5F2224400418733D521,0x4DC01C921B67A3D3AFB3A4663E36E7A6);

INSERT INTO customeraccount VALUES (1,12341000);
INSERT INTO customeraccount VALUES (1,12341001);

INSERT INTO rule VALUES (1,1,1,'2019-07-10','2019-07-13',1,'Starbucks',1,1000.00,1,750.00,1,500.00,1,6000.00,1,4000.00,1,12341000);
INSERT INTO rule VALUES (2,1,1,'2019-06-25','2019-07-02',1,'Gym',1,900.00,1,750.00,1,250.00,1,6000.00,1,4000.00,1,12341001);

INSERT INTO transaction VALUES (1,'2019-05-01','CR',5000.00,0xC19E5CDFC50A0A2C3E83EA9DA395B0AF,0xCE318AC8F062B7FF73BD6C4551F659CF,5000.00,12341000);
INSERT INTO transaction VALUES (2,'2019-05-01','CR',5000.00,0xCCAD7D087088DA1558158EEDF8F09151,0xFDB91B2EA57B27224D86BDE9D21E6C25,5000.00,12341001);
INSERT INTO transaction VALUES (3,'2019-05-04','CR',800.00,0x9DB51F5206E2B3753B47AF948C523BF1,0xCE318AC8F062B7FF73BD6C4551F659CF,5800.00,12341000);
INSERT INTO transaction VALUES (4,'2019-05-09','DR',10.00,0x2A00CB733B6C705D1F5B0DFA96DF4AE7,0xCE318AC8F062B7FF73BD6C4551F659CF,5790.00,12341000);
INSERT INTO transaction VALUES (5,'2019-05-10','DR',100.00,0xB4BBAEF4BACBEA90B79A07F8EDF74407,0xCE318AC8F062B7FF73BD6C4551F659CF,5690.00,12341000);
INSERT INTO transaction VALUES (6,'2019-05-15','DR',9.99,0x7A254DA3E32F478D7A25847F83279E22,0xCE318AC8F062B7FF73BD6C4551F659CF,5680.01,12341000);
INSERT INTO transaction VALUES (7,'2019-05-19','DR',2.00,0xB805E4DD969377C4FB4C8D61F8D6777D,0xCE318AC8F062B7FF73BD6C4551F659CF,5678.01,12341000);
INSERT INTO transaction VALUES (8,'2019-05-19','DR',620.00,0x2B48BF7D049026E677BD5B741FBF06E4DEEBB0C461C286BCD9B6D430AED51A714A8B8F7149E6FB82B4BC6186E02AD3C4,0xCE318AC8F062B7FF73BD6C4551F659CF,5058.01,12341000);
INSERT INTO transaction VALUES (9,'2019-05-22','DR',100.00,0xB5C6735DAAAC26935FA6DC539C0BB262,0xCE318AC8F062B7FF73BD6C4551F659CF,4958.01,12341000);
INSERT INTO transaction VALUES (10,'2019-06-02','CR',800.00,0x9DB51F5206E2B3753B47AF948C523BF1,0xCE318AC8F062B7FF73BD6C4551F659CF,5758.01,12341000);
INSERT INTO transaction VALUES (11,'2019-06-06','DR',14.00,0x3F42A82A81A566971DEB6EBDFC9DA058,0xCE318AC8F062B7FF73BD6C4551F659CF,5744.01,12341000);
INSERT INTO transaction VALUES (12,'2019-06-13','DR',100.00,0xB4BBAEF4BACBEA90B79A07F8EDF74407,0xCE318AC8F062B7FF73BD6C4551F659CF,5644.01,12341000);
INSERT INTO transaction VALUES (13,'2019-06-19','DR',190.00,0x7EEE1D81B35D0A89BD3FE451032D7AF1,0xCE318AC8F062B7FF73BD6C4551F659CF,5454.01,12341000);
INSERT INTO transaction VALUES (14,'2019-06-19','DR',350.00,0x57EC1031806D8DA3DF52964386164172,0xCE318AC8F062B7FF73BD6C4551F659CF,5104.01,12341000);
INSERT INTO transaction VALUES (15,'2019-06-22','DR',230.00,0x2B48BF7D049026E677BD5B741FBF06E4DEEBB0C461C286BCD9B6D430AED51A714A8B8F7149E6FB82B4BC6186E02AD3C4,0xCE318AC8F062B7FF73BD6C4551F659CF,4874.01,12341000);
INSERT INTO transaction VALUES (16,'2019-06-22','DR',300.00,0x00F056784E3660BE92886058112DD4DA,0xCE318AC8F062B7FF73BD6C4551F659CF,4574.01,12341000);
INSERT INTO transaction VALUES (17,'2019-06-26','DR',45.00,0x031CADEC6E04C36D9C396FA02EF6BA676F12D1E3BCE2BEE36ABB79B0079C16BB,0xCE318AC8F062B7FF73BD6C4551F659CF,4529.01,12341000);
INSERT INTO transaction VALUES (18,'2019-06-30','CR',800.00,0x9DB51F5206E2B3753B47AF948C523BF1,0xCE318AC8F062B7FF73BD6C4551F659CF,5329.01,12341000);
INSERT INTO transaction VALUES (19,'2019-07-01','DR',18.00,0x8006CE3B70193536C37C548ADF34CB05,0xCE318AC8F062B7FF73BD6C4551F659CF,5311.01,12341000);
INSERT INTO transaction VALUES (20,'2019-07-02','DR',130.00,0xB4BBAEF4BACBEA90B79A07F8EDF74407,0xCE318AC8F062B7FF73BD6C4551F659CF,5181.01,12341000);
INSERT INTO transaction VALUES (21,'2019-07-04','DR',7.99,0x7A254DA3E32F478D7A25847F83279E22,0xCE318AC8F062B7FF73BD6C4551F659CF,5173.02,12341000);
INSERT INTO transaction VALUES (22,'2019-07-06','DR',43.00,0xB5C6735DAAAC26935FA6DC539C0BB262,0xF50A88CB4A08765C52C1FA1D8AB7C59C,5130.02,12341000);
INSERT INTO transaction VALUES (23,'2019-07-09','DR',13.00,0x4B221F1843C12D51170BA66F60BC90B5,0xCE318AC8F062B7FF73BD6C4551F659CF,5117.02,12341000);
INSERT INTO transaction VALUES (24,'2019-07-12','DR',350.00,0x57EC1031806D8DA3DF52964386164172,0xCE318AC8F062B7FF73BD6C4551F659CF,4767.02,12341000);
INSERT INTO transaction VALUES (25,'2019-07-12','DR',301.00,0x9C654EB37F0D53B5D5F7D43BAEAA3B4499285CCF4DF93C12B0AD05B285C132F88F156B26876575250B76AF5CB459D13A,0xCE318AC8F062B7FF73BD6C4551F659CF,4466.02,12341000);
INSERT INTO transaction VALUES (26,'2019-07-14','DR',232.68,0x68E428750625505FBF8B23A12D0D4CBD,0xCE318AC8F062B7FF73BD6C4551F659CF,4233.34,12341000);
INSERT INTO transaction VALUES (27,'2019-07-16','DR',120.00,0xB1821FC13EB73A14C6147E1CE0C05B67,0xCE318AC8F062B7FF73BD6C4551F659CF,4113.34,12341000);
INSERT INTO transaction VALUES (28,'2019-07-19','DR',50.00,0x9C76E3DA1317C5C4B24BFFE8F87A31C7,0xCE318AC8F062B7FF73BD6C4551F659CF,4063.34,12341000);
INSERT INTO transaction VALUES (29,'2019-07-19','DR',24.75,0x58EB19AABFCFADA95D9AD817BE6E597C,0xCE318AC8F062B7FF73BD6C4551F659CF,4038.59,12341000);
INSERT INTO transaction VALUES (30,'2019-07-20','DR',36.00,0xEF8B32EB41D798102119E4D297C95A98,0xCE318AC8F062B7FF73BD6C4551F659CF,4002.59,12341000);
INSERT INTO transaction VALUES (31,'2019-07-21','DR',48.12,0xC64AF66933B62774475B45273A8E53B0,0xCE318AC8F062B7FF73BD6C4551F659CF,3954.47,12341000);
INSERT INTO transaction VALUES (32,'2019-07-22','DR',45.00,0x78D83A3F34A3662D3337ACDC86BEF9C8,0xCE318AC8F062B7FF73BD6C4551F659CF,3909.47,12341000);
INSERT INTO transaction VALUES (33,'2019-07-23','DR',36.00,0x63FA01FBECCB7576FADAABC9A46E4B06,0xCE318AC8F062B7FF73BD6C4551F659CF,3873.47,12341000);
INSERT INTO transaction VALUES (34,'2019-07-23','DR',200.00,0x17E1391AFFBB76A83C29AEDDBB7C0B31C05261238C3EFBDAC06D7EAEE94EBF25,0xCE318AC8F062B7FF73BD6C4551F659CF,3673.47,12341000);
INSERT INTO transaction VALUES (35,'2019-07-23','DR',250.00,0x5E8AB183B368E430C5A93E11DA53B429,0xCE318AC8F062B7FF73BD6C4551F659CF,3423.47,12341000);
INSERT INTO transaction VALUES (36,'2019-07-27','DR',36.00,0x20A6075452E00FE7DB2FB9B48057F959,0xCE318AC8F062B7FF73BD6C4551F659CF,3387.47,12341000);
INSERT INTO transaction VALUES (37,'2019-07-27','CR',810.00,0x9DB51F5206E2B3753B47AF948C523BF1,0xCE318AC8F062B7FF73BD6C4551F659CF,4197.47,12341000);
INSERT INTO transaction VALUES (38,'2019-07-30','DR',46.00,0xE192F3636B22ECF5FD1D69AD36365E18A6F73B286C7936A474B18461B5A80D36,0xCE318AC8F062B7FF73BD6C4551F659CF,4151.47,12341000);
INSERT INTO transaction VALUES (39,'2019-10-13','DR',571.08,0x8EAD228DAFD336BB34EF6068E3105B24,0xE42ABE237AAA77BFD04BD5B300F77D1A,3580.39,12341000);
INSERT INTO transaction VALUES (40,'2019-05-02','DR',2.00,0xA9F349E51E76C68344102275F1F3AC99,0xFDB91B2EA57B27224D86BDE9D21E6C25,4998.00,12341001);
INSERT INTO transaction VALUES (41,'2019-05-07','DR',8.00,0x68F5AD02E9677A2CFEE1165D05665D52,0xFDB91B2EA57B27224D86BDE9D21E6C25,4990.00,12341001);
INSERT INTO transaction VALUES (42,'2019-05-10','DR',32.00,0x9EDA4A665D52DC042EBA7A8446460610,0xFDB91B2EA57B27224D86BDE9D21E6C25,4958.00,12341001);
INSERT INTO transaction VALUES (43,'2019-05-10','DR',190.00,0x0D5A045767266A6D7247D8141A6251B6,0xFDB91B2EA57B27224D86BDE9D21E6C25,4768.00,12341001);
INSERT INTO transaction VALUES (44,'2019-05-15','DR',350.00,0xAEA7977F0783CE0A97AD95613185E25D,0xFDB91B2EA57B27224D86BDE9D21E6C25,4418.00,12341001);
INSERT INTO transaction VALUES (45,'2019-05-19','CR',750.00,0x02857E677EAD5408C97BCBD4B9EC2CA4,0xFDB91B2EA57B27224D86BDE9D21E6C25,5168.00,12341001);
INSERT INTO transaction VALUES (46,'2019-05-19','DR',150.00,0xF92881F9250FABAB9C4D64CE3A666FD1,0xFDB91B2EA57B27224D86BDE9D21E6C25,5018.00,12341001);
INSERT INTO transaction VALUES (47,'2019-05-23','CR',50.00,0xCE63CBA460CD6057251174AFBB64C15E8D22AE39AE5029184A8C2F7E4E052C97,0xFDB91B2EA57B27224D86BDE9D21E6C25,5068.00,12341001);
INSERT INTO transaction VALUES (48,'2019-06-02','DR',9.00,0x7814033DF613943CBA59A5C7D3C9A7A9,0xFDB91B2EA57B27224D86BDE9D21E6C25,5059.00,12341001);
INSERT INTO transaction VALUES (49,'2019-06-13','DR',32.00,0x3CBD9A335631D3255EFCD93AF0B635BC,0xFDB91B2EA57B27224D86BDE9D21E6C25,5027.00,12341001);
INSERT INTO transaction VALUES (50,'2019-06-19','CR',750.00,0x02857E677EAD5408C97BCBD4B9EC2CA4,0xFDB91B2EA57B27224D86BDE9D21E6C25,5777.00,12341001);
INSERT INTO transaction VALUES (51,'2019-06-19','DR',9.99,0x4A0255FB61C51DDAF3FFE6C2E8317070,0xFDB91B2EA57B27224D86BDE9D21E6C25,5767.01,12341001);
INSERT INTO transaction VALUES (52,'2019-06-22','DR',6.50,0xEFFDC5339CD2454A399D5DFC8BB4E207,0xFDB91B2EA57B27224D86BDE9D21E6C25,5760.51,12341001);
INSERT INTO transaction VALUES (53,'2019-06-22','DR',100.00,0xD12330DF4D2356D4EF853C08D12DA8A3,0xFDB91B2EA57B27224D86BDE9D21E6C25,5660.51,12341001);
INSERT INTO transaction VALUES (54,'2019-06-26','DR',23.00,0xA1BC5B944C599C2296A7777453A3057C,0xFDB91B2EA57B27224D86BDE9D21E6C25,5637.51,12341001);
INSERT INTO transaction VALUES (55,'2019-06-26','DR',35.00,0xC7C6CEBDE4513E54BE8D5C58CFD01E4B,0xFDB91B2EA57B27224D86BDE9D21E6C25,5602.51,12341001);
INSERT INTO transaction VALUES (56,'2019-07-01','DR',210.00,0xF92881F9250FABAB9C4D64CE3A666FD1,0xFDB91B2EA57B27224D86BDE9D21E6C25,5392.51,12341001);
INSERT INTO transaction VALUES (57,'2019-07-01','DR',45.00,0x612F792EC6B17C3E481A39D3B9DBF22C,0xFDB91B2EA57B27224D86BDE9D21E6C25,5347.51,12341001);
INSERT INTO transaction VALUES (58,'2019-07-02','DR',185.00,0x0D5A045767266A6D7247D8141A6251B6,0xFDB91B2EA57B27224D86BDE9D21E6C25,5162.51,12341001);
INSERT INTO transaction VALUES (59,'2019-07-04','DR',56.00,0xE734D08152D5F2BC8DD3DD7CED5E4640,0xFDB91B2EA57B27224D86BDE9D21E6C25,5106.51,12341001);
INSERT INTO transaction VALUES (60,'2019-07-07','DR',98.00,0x3CBD9A335631D3255EFCD93AF0B635BC,0xAB05924F06085064F26CBA45D8A280CE,5008.51,12341001);
INSERT INTO transaction VALUES (61,'2019-07-10','DR',9.00,0xA9F349E51E76C68344102275F1F3AC99,0xFDB91B2EA57B27224D86BDE9D21E6C25,4999.51,12341001);
INSERT INTO transaction VALUES (62,'2019-07-12','DR',3.50,0xACFFDDFF18CC3CCBF26F49900B6EF0B2,0xFDB91B2EA57B27224D86BDE9D21E6C25,4996.01,12341001);
INSERT INTO transaction VALUES (63,'2019-07-13','CR',730.00,0x02857E677EAD5408C97BCBD4B9EC2CA4,0xFDB91B2EA57B27224D86BDE9D21E6C25,5726.01,12341001);
INSERT INTO transaction VALUES (64,'2019-07-14','DR',18.50,0xD12330DF4D2356D4EF853C08D12DA8A3,0xFDB91B2EA57B27224D86BDE9D21E6C25,5707.51,12341001);
INSERT INTO transaction VALUES (65,'2019-07-19','DR',50.00,0x8380A447D06F3E7205FD90A0CEA7394084B54973C79AA7C1E67AF21798B52376,0xFDB91B2EA57B27224D86BDE9D21E6C25,5657.51,12341001);
INSERT INTO transaction VALUES (66,'2019-07-19','DR',9.20,0xB665886BBB1AB8D6732CF990477EDA86,0xFDB91B2EA57B27224D86BDE9D21E6C25,5648.31,12341001);
INSERT INTO transaction VALUES (67,'2019-07-19','DR',3.50,0x1A1807DFE9B45E62557F0EFC468B32F9,0xFDB91B2EA57B27224D86BDE9D21E6C25,5644.81,12341001);
INSERT INTO transaction VALUES (68,'2019-07-20','DR',32.00,0xE734D08152D5F2BC8DD3DD7CED5E4640,0xFDB91B2EA57B27224D86BDE9D21E6C25,5612.81,12341001);
INSERT INTO transaction VALUES (69,'2019-07-22','DR',4.20,0xAF7B136737E20C131A822B1FECDE117B,0xFDB91B2EA57B27224D86BDE9D21E6C25,5608.61,12341001);
INSERT INTO transaction VALUES (70,'2019-07-22','DR',25.00,0x370E7A95249351F58BA5A5F2EECD5D94,0xFDB91B2EA57B27224D86BDE9D21E6C25,5583.61,12341001);
INSERT INTO transaction VALUES (71,'2019-07-23','DR',29.00,0xE734D08152D5F2BC8DD3DD7CED5E4640,0xFDB91B2EA57B27224D86BDE9D21E6C25,5554.61,12341001);
INSERT INTO transaction VALUES (72,'2019-07-23','CR',150.00,0xC34597F4E98D1D33F6B8E99B116FDD98AB6C410BF2DA2513DA57A5C51DA547C3,0xFDB91B2EA57B27224D86BDE9D21E6C25,5704.61,12341001);
INSERT INTO transaction VALUES (73,'2019-07-23','DR',75.00,0x3F77E4AFA5109F589EE4173C13327E9E,0xFDB91B2EA57B27224D86BDE9D21E6C25,5629.61,12341001);
INSERT INTO transaction VALUES (74,'2019-07-27','DR',22.00,0x0BE8317B8B05A5B39C936693DC950C4C,0xFDB91B2EA57B27224D86BDE9D21E6C25,5607.61,12341001);
INSERT INTO transaction VALUES (75,'2019-07-30','DR',180.00,0xE703423318D14C54DD3FFB73FBD454E4,0xFDB91B2EA57B27224D86BDE9D21E6C25,5427.61,12341001);
INSERT INTO transaction VALUES (76,'2019-07-30','DR',8.00,0xA9F349E51E76C68344102275F1F3AC99,0xFDB91B2EA57B27224D86BDE9D21E6C25,5419.61,12341001);

INSERT INTO alert VALUES (1,'2019-05-01','Transaction more than 1000.00',0,12341000,1,1);
INSERT INTO alert VALUES (2,'2019-05-01','Transaction more than 900.00',0,12341001,1,2);
INSERT INTO alert VALUES (3,'2019-05-04','Deposit more than 750.00',0,12341000,1,3);
INSERT INTO alert VALUES (4,'2019-05-19','Flagged as Starbucks',0,12341000,1,7);
INSERT INTO alert VALUES (5,'2019-05-19','Withdraw more than 500.00',0,12341000,1,8);
INSERT INTO alert VALUES (6,'2019-06-02','Deposit more than 750.00',0,12341000,1,10);
INSERT INTO alert VALUES (7,'2019-06-30','Deposit more than 750.00',0,12341000,1,18);
INSERT INTO alert VALUES (8,'2019-07-06','Out of state: NE',0,12341000,1,22);
INSERT INTO alert VALUES (9,'2019-07-12','Between 7/10/2019 and 7/13/2019',0,12341000,1,24);
INSERT INTO alert VALUES (10,'2019-07-12','Between 7/10/2019 and 7/13/2019',0,12341000,1,25);
INSERT INTO alert VALUES (11,'2019-07-21','Balance less than 4000.00',0,12341000,1,31);
INSERT INTO alert VALUES (12,'2019-07-22','Balance less than 4000.00',0,12341000,1,32);
INSERT INTO alert VALUES (13,'2019-07-23','Balance less than 4000.00',0,12341000,1,33);
INSERT INTO alert VALUES (14,'2019-07-23','Balance less than 4000.00',0,12341000,1,34);
INSERT INTO alert VALUES (15,'2019-07-23','Balance less than 4000.00',0,12341000,1,35);
INSERT INTO alert VALUES (16,'2019-07-27','Balance less than 4000.00',0,12341000,1,36);
INSERT INTO alert VALUES (17,'2019-07-27','Deposit more than 750.00',0,12341000,1,37);
INSERT INTO alert VALUES (18,'2019-10-13','Out of state: NY',0,12341000,1,39);
INSERT INTO alert VALUES (19,'2019-05-15','Withdraw more than 250.00',0,12341001,1,44);
INSERT INTO alert VALUES (20,'2019-06-26','Between 6/25/2019 and 7/2/2019',0,12341001,1,54);
INSERT INTO alert VALUES (21,'2019-06-26','Between 6/25/2019 and 7/2/2019',0,12341001,1,55);
INSERT INTO alert VALUES (22,'2019-07-01','Between 6/25/2019 and 7/2/2019',0,12341001,1,56);
INSERT INTO alert VALUES (23,'2019-07-01','Between 6/25/2019 and 7/2/2019',0,12341001,1,57);
INSERT INTO alert VALUES (24,'2019-07-02','Between 6/25/2019 and 7/2/2019',0,12341001,1,58);
INSERT INTO alert VALUES (25,'2019-07-07','Out of state: NE',0,12341001,1,60);

INSERT INTO report VALUES (1,2,2,0,0,1,0,0,6,1,12341000);
INSERT INTO report VALUES (2,2,3,0,0,0,0,0,0,1,12341001);

INSERT INTO archivedreport VALUES (1,'2019-05-01','2019-05-30',0,0,1,1,1,1,0,0,12341000,1);
INSERT INTO archivedreport VALUES (2,'2019-05-01','2019-05-30',0,0,0,1,0,1,0,0,12341001,1);
INSERT INTO archivedreport VALUES (3,'2019-05-31','2019-06-30',0,0,0,0,2,0,0,0,12341000,1);
INSERT INTO archivedreport VALUES (4,'2019-05-31','2019-06-30',0,2,0,0,0,0,0,0,12341001,1);

-------------------------------------------------------------------------------------------------------
-- Add Stored Procedures
-------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE addTransaction(date varchar(10), Type char(2), 
	Amount decimal(10,2), name varchar(50), Location varchar(2), AccountID INT)
BEGIN    
	DECLARE Balance decimal(10,2) DEFAULT 0;
    
    IF CONVERT(Type USING utf8mb4) = 'CR' THEN
        SELECT Account.Balance + Amount INTO Balance FROM Account WHERE Account.ID = AccountID;
	ELSEIF CONVERT(Type USING utf8mb4) = 'DR' THEN
		SELECT Account.Balance - Amount INTO Balance FROM Account WHERE Account.ID = AccountID;
    END IF;
    
    Insert into transaction(Date, Type, Amount, Transaction.Desc, Location, Balance, AccountID) 
		values (date, Type, Amount, AES_ENCRYPT(name, AccountID), AES_ENCRYPT(Location, AccountID), 
        Balance, AccountID);
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

CREATE PROCEDURE getAccount(IN accountID INT)
BEGIN
	SELECT Type, Balance FROM account
    WHERE account.ID = accountID;
END;

CREATE PROCEDURE getAccounts(IN customerID INT)
BEGIN
	SELECT AccountID FROM customeraccount
    WHERE customeraccount.CustomerID = customerID;
END;

CREATE PROCEDURE getAlerts(IN customerID INT, IN accountID INT)
BEGIN
	SELECT Alert.ID, TransactionID, DATE_FORMAT(Alert.Date, '%m/%e/%Y') AS Date, 
		CAST(AES_DECRYPT(Transaction.Desc, accountID) AS CHAR(45)) 
		AS Description, Transaction.Type, CAST(AES_DECRYPT(Location, accountID) AS CHAR(45)) AS Location, 
        Amount, Balance, Reason, Removed FROM Alert
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
	SELECT ID, DATE_FORMAT(Date, '%m/%e/%Y') AS Date, Type, Amount, CAST(AES_DECRYPT(Transaction.Desc, accountID) 
		AS CHAR(45)) AS Description, CAST(AES_DECRYPT(Location, accountID) AS CHAR(45)) 
        AS Location, Balance FROM Transaction WHERE Transaction.AccountID = accountID
		ORDER BY ID DESC;
END;

CREATE PROCEDURE removedAlert(IN AlertID INT)
BEGIN
	UPDATE Alert SET Removed = True WHERE ID = AlertID;
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
	transLoc Blob, tdate date, tCat Blob, tAmt decimal(10,2), 
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
                
        IF (@OutState AND (SELECT AES_DECRYPT(State, Password) FROM customer 
			WHERE customer.ID = Customer) <> AES_DECRYPT(transLoc, AccountID)) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Out of state: ', AES_DECRYPT(transLoc, AccountID)));
			CALL generateReport(1, 0, 0, 0, 0, 0, 0, 0, Customer, accountID);
                
		ELSEIF (@RangeChk AND (tdate BETWEEN @StartDte AND @EndDte)) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Between ', 
                DATE_FORMAT(@StartDte, '%m/%e/%Y'), ' and ', DATE_FORMAT(@EndDte, '%m/%e/%Y')));
			CALL generateReport(0, 1, 0, 0, 0, 0, 0, 0, Customer, accountID);
                
		ELSEIF (@CatChk AND @Cat = AES_DECRYPT(tCat, AccountID)) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Flagged as ', @Cat));
			CALL generateReport(0, 0, 1, 0, 0, 0, 0, 0, Customer, accountID);
                
		ELSEIF (@GrtTrnChk AND tAmt > @GrtTrnAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Transaction more than ', @GrtTrnAmt));
			CALL generateReport(0, 0, 0, 1, 0, 0, 0, 0, Customer, accountID);
            
        ELSEIF (@GrtDepoChk AND tType = 'CR' AND tAmt > @GrtDepoAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Deposit more than ', @GrtDepoAmt));
			CALL generateReport(0, 0, 0, 0, 1, 0, 0, 0, Customer, accountID);
            
		ELSEIF (@GrtDRChk AND tType = 'DR' AND tAmt > @GrtDRAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Withdraw more than ', @GrtDRAmt));
			CALL generateReport(0, 0, 0, 0, 0, 1, 0, 0, Customer, accountID);
            
		ELSEIF (@GrtBalChk AND tBal > @GrtBalAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Balance more than ', @GrtBalAmt));
			CALL generateReport(0, 0, 0, 0, 0, 0, 1, 0, Customer, accountID);
            
		ELSEIF (@LsBalChk AND tBal < @LsBalAmt) THEN
			INSERT INTO Alert(Date, TransactionID, AccountID, CustomerID, Reason) 
				VALUES (tdate, transID, accountID, Customer, CONCAT('Balance less than ', @LsBalAmt));
			CALL generateReport(0, 0, 0, 0, 0, 0, 0, 1, Customer, accountID);
        END IF;
        
    END LOOP getCustomers;
    CLOSE curCustomers;
END;

CREATE PROCEDURE validateUser(IN username VARCHAR(45), IN password VARCHAR(45))
BEGIN
	SELECT ID, CAST(AES_DECRYPT(FirstName, Customer.Password) AS CHAR(45)) AS FirstName, 
    CAST(AES_DECRYPT(LastName, Customer.Password) AS CHAR(45)) AS LastName FROM Customer
    WHERE Customer.Username = username AND Customer.Password = UNHEX(SHA1(CONCAT(password, ID)));
END; $$
DELIMITER ;

-------------------------------------------------------------------------------------------------------
-- Add Triggers (To preserve state of data, insert data before adding triggers)
-------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE TRIGGER transaction_AFTER_INSERT AFTER INSERT ON `transaction` FOR EACH ROW BEGIN
	CALL transAlert(NEW.AccountID, NEW.ID, NEW.Location, NEW.Date, 
		NEW.Desc, NEW.Amount, NEW.Type, NEW.Balance);
END;$$
DELIMITER ;

-------------------------------------------------------------------------------------------------------
-- Add Events
-------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE EVENT archiveReport ON SCHEDULE EVERY 1 MONTH STARTS '2019-12-30 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE Report INT;
	DECLARE curReports CURSOR FOR SELECT ID FROM report;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    OPEN curReports;
    getReports: LOOP
		FETCH curReports INTO Report;
        IF finished = 1 THEN
			LEAVE getReports;
		END IF;
        
        Select DATE_SUB(CURDATE(), INTERVAL 30 DAY), CURDATE(), OutState, Report.Range, Category, ExcessTrans, 
			ExcessDepo, ExcessWith, HighBal, LowBal, AccountID, CustomerID
			Into @Start, @End, @OutState, @Range, @Category, @ExcessTran, @ExcessDepo, 
            @ExcessWith, @HighBal, @LowBal, @AccountID, @CustomerID From Report Where ID = Report;
        
        Insert Into Report(Start, End, OutState, Report.Range, Category, ExcessTran, 
			ExcessDepo, ExcessWith, HighBal, LowBal, AccountID, CustomerID) 
			Values (@Start, @End, @OutState, @Range, @Category, @ExcessTran, @ExcessDepo, 
            @ExcessWith, @HighBal, @LowBal, @AccountID, @CustomerID);
        
        Delete From Report Where ID = Report;
        
        END LOOP getReports;
    CLOSE curReports;
END;$$
DELIMITER ;