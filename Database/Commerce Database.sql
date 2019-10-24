/*drop tables to prevent duplicate tables*/
/*DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Accounts;​
DROP TABLE IF EXISTS Customers;​
DROP TABLE IF EXISTS Employees;​
DROP TABLE IF EXISTS Departments;​
DROP TABLE IF EXISTS Branches;​
DROP TABLE IF EXISTS States;​
DROP TABLE IF EXISTS  Account_Types;*/

/*BEGIN TABLE CREATION*/

CREATE TABLE IF NOT EXISTS Customers
 (Customer_ID integer unsigned not null auto_increment,​
  CustStreet varchar(30),​
  CustCity varchar(20),​
  State_ID varchar(2),​
  CustZip_code varchar(10),​
  CustFirst_Name varchar(20) not null,​
  CustLast_Name varchar(20) not null,​
  CustBirth_Date Date not null,
  
  CustEmail varchar(30),
  CustPhone varchar(15) not null,​
  CustUserName varchar(20) not null,​
  CustPassword varchar(20) not null,
  ​
  constraint pk_customers primary key (Customer_id),​
  constraint fk_customers_states foreign key(State_id) references States(State_ID)​
  ON DELETE RESTRICT​
 );
 
 CREATE TABLE IF NOT EXISTS Account_Types
 (Account_Type_ID varchar(3) not null ,​
   Account_Type_Name varchar(60) not null,​
  constraint pk_account_types primary key (Account_Type_ID)​
 );
 
 create table IF NOT EXISTS Accounts
 (Account_ID integer unsigned not null auto_increment,​
  Customer_ID integer unsigned,​
  AcctOpen_Date date not null,​
  AcctClose_Date date,​
  AcctStatus enum('ACTIVE','CLOSED','FROZEN'),​
  Branch_ID smallint unsigned,​
  Employee_ID smallint unsigned,​
  Account_Type_ID varchar(3),​
  constraint fk_accounts_customers foreign key (Customer_ID)​
    references Customers (Customer_ID) ON DELETE RESTRICT,​
  constraint fk_accounts_branches foreign key (Branch_ID)​
    references Branches (Branch_ID) ON DELETE RESTRICT,​
  constraint fk_accounts_employees foreign key (Employee_ID)​
    references Employees (Employee_ID) ON DELETE RESTRICT,​
  constraint fk_accounts_account_types foreign key (Account_Type_ID)​
    references Account_Types (Account_Type_ID) ON DELETE RESTRICT,​
  constraint pk_accounts primary key (Account_ID)​
 );
 
 create table IF NOT EXISTS Transactions
 (Transaction_id integer unsigned not null auto_increment,​
  TrnsDate datetime not null default now(),​
  Account_ID integer unsigned not null,​
  TrnsType enum('DBT','CDT'),​
  TrnsAmount double(10,2) not null,​
  Employee_ID smallint unsigned,​
  constraint fk_transactions_accounts foreign key (Account_ID)​
    references Accounts (Account_ID) ON DELETE CASCADE,​
  constraint fk_transactions_employees foreign key (Employee_ID)​
    references Employees (Employee_ID) ON DELETE RESTRICT,​
  constraint pk_transactions primary key (Transaction_ID)​
 );
 
 CREATE TABLE IF NOT EXISTS States
 (State_ID varchar(2) not null,​
  StateName varchar(20) not null,​
  constraint pk_states primary key (State_ID)​
 );
 
 CREATE TABLE IF NOT EXISTS Alerts
(Alert_ID smallint unsigned not null auto_increment,
AlertName varchar(20) not null,
constraint pk_alert primary key(Alert_ID)
);

CREATE TABLE IF NOT EXISTS Branches
 (Branch_ID smallint unsigned not null auto_increment,​
  BranchName varchar(20) not null,​
  BranchStreet varchar(30),​
  BranchCity varchar(20),​
  State_ID varchar(2),​
  BranchZip_Code varchar(12),​
constraint fk_branches_states foreign key (State_ID) references States(State_ID) ON DELETE RESTRICT,​
  constraint pk_branches primary key (Branch_ID)​
 );

CREATE TABLE IF NOT EXISTS Departments
 (Department_ID smallint unsigned not null auto_increment,​
  DeptName varchar(20) not null,​
  constraint pk_department primary key (Department_ID)​
 );
 
 create table IF NOT EXISTS Employees
 (Employee_id smallint unsigned not null auto_increment,​
  EmpFirst_Name varchar(20) not null,​
  EmpLast_Name varchar(20) not null,​
  EmpStart_date date not null,​
  EmpEnd_date date,​
  EmpSupervisor_ID smallint unsigned,​
  Department_ID smallint unsigned,​
  Branch_ID smallint unsigned,​
  constraint fk_employee_supervisor ​
    foreign key (EmpSupervisor_ID) references Employees (Employee_ID),​
  constraint fk_employees_departments​
    foreign key (Department_ID) references Departments (Department_ID)​
ON DELETE RESTRICT​
,​
  constraint fk_employees_branches​
    foreign key (Branch_ID) references Branches (Branch_ID)​
ON DELETE RESTRICT​
,​
  constraint pk_employees primary key (Employee_ID)​
 );

/*END TABLE CREATION*/

/*BEGIN DATA POPULATION*/

/*CUSTOMER DATA*/

/*ACCOUNT TYPE DATA*/

/*ACCOUNT DATA*/

/*TRANSACTION DATA*/

/*STATE DATA*/

/*ALERT  DATA*/