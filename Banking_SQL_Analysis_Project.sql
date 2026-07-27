-- ============================================================================
-- BANKING DATABASE ANALYSIS PROJECT
-- ============================================================================
-- Author: Lerato Lehoko
--
-- Description:
-- This project demonstrates SQL database design and business analysis using
-- a simulated banking database. The project includes database creation,
-- relational table design, sample banking data, and SQL queries that answer
-- real-world business questions.
--
-- Skills Demonstrated:
-- • Database Design
-- • Primary & Foreign Keys
-- • INNER JOIN
-- • Aggregate Functions
-- • GROUP BY & HAVING
-- • CASE Statements
-- • Common Table Expressions (CTEs)
-- • Window Functions
-- • ROW_NUMBER() & RANK()
-- • Running Totals
-- • Business Reporting
-- ============================================================================



-- ============================================================================
-- SECTION 1 : CREATE DATABASE
-- ============================================================================

CREATE DATABASE BankingDB;

USE BankingDB;



-- ============================================================================
-- SECTION 2 : CREATE TABLES
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Customers Table
-- ---------------------------------------------------------------------------

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    City VARCHAR(50),
    Province VARCHAR(50),
    JoinDate DATE
);



-- ---------------------------------------------------------------------------
-- Branches Table
-- ---------------------------------------------------------------------------

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    City VARCHAR(50),
    Province VARCHAR(50)
);



-- ---------------------------------------------------------------------------
-- Employees Table
-- ---------------------------------------------------------------------------

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    HireDate DATE,
    BranchID INT,
    FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID)
);



-- ---------------------------------------------------------------------------
-- Accounts Table
-- ---------------------------------------------------------------------------

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    BranchID INT,
    AccountType VARCHAR(30),
    Balance DECIMAL(12,2),
    OpenDate DATE,
    Status VARCHAR(20),

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID)
);



-- ---------------------------------------------------------------------------
-- Transactions Table
-- ---------------------------------------------------------------------------

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(30),
    Amount DECIMAL(12,2),
    TransactionDate DATE,

    FOREIGN KEY (AccountID)
        REFERENCES Accounts(AccountID)
);



-- ---------------------------------------------------------------------------
-- Loans Table
-- ---------------------------------------------------------------------------

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanType VARCHAR(30),
    LoanAmount DECIMAL(12,2),
    InterestRate DECIMAL(5,2),
    LoanStatus VARCHAR(20),

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- ============================================================================
-- SECTION 3 : INSERT SAMPLE DATA
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Insert Customers
-- ---------------------------------------------------------------------------

INSERT INTO Customers
(CustomerID, FirstName, LastName, Gender, DateOfBirth, City, Province, JoinDate)
VALUES
(101,'Lerato','Mokoena','Female','1998-03-14','Johannesburg','Gauteng','2022-01-15'),
(102,'Thabo','Ndlovu','Male','1995-07-20','Pretoria','Gauteng','2021-08-22'),
(103,'Ayanda','Khumalo','Female','1999-11-10','Durban','KwaZulu-Natal','2023-02-18'),
(104,'Sipho','Dlamini','Male','1993-04-25','Bloemfontein','Free State','2020-09-11'),
(105,'Naledi','Molefe','Female','1997-06-18','Polokwane','Limpopo','2021-05-03'),
(106,'Brian','Smith','Male','1992-01-30','Cape Town','Western Cape','2022-10-14'),
(107,'Sarah','Johnson','Female','1996-09-12','Port Elizabeth','Eastern Cape','2023-03-08'),
(108,'Michael','Brown','Male','1994-12-05','Nelspruit','Mpumalanga','2020-12-20'),
(109,'Zanele','Zulu','Female','1998-08-17','Kimberley','Northern Cape','2021-07-01'),
(110,'David','Williams','Male','1991-02-11','Mahikeng','North West','2022-04-27');



-- ---------------------------------------------------------------------------
-- Insert Branches
-- ---------------------------------------------------------------------------

INSERT INTO Branches
(BranchID, BranchName, City, Province)
VALUES
(1,'Sandton Branch','Johannesburg','Gauteng'),
(2,'Pretoria CBD Branch','Pretoria','Gauteng'),
(3,'Durban Central Branch','Durban','KwaZulu-Natal'),
(4,'Cape Town Branch','Cape Town','Western Cape'),
(5,'Bloemfontein Branch','Bloemfontein','Free State');



-- ---------------------------------------------------------------------------
-- Insert Employees
-- ---------------------------------------------------------------------------

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Position, HireDate, BranchID)
VALUES
(201,'John','Meyer','Branch Manager','2018-01-15',1),
(202,'Grace','Nkosi','Financial Advisor','2020-06-12',1),
(203,'Peter','Naidoo','Branch Manager','2017-03-18',2),
(204,'Nomsa','Zulu','Customer Consultant','2021-08-21',2),
(205,'Lindiwe','Mabaso','Branch Manager','2019-05-10',3),
(206,'Kevin','Jacobs','Customer Consultant','2022-02-15',3),
(207,'Amanda','Peters','Branch Manager','2018-11-30',4),
(208,'Chris','Daniels','Financial Advisor','2020-09-04',4),
(209,'Sibusiso','Mokoena','Branch Manager','2019-01-19',5),
(210,'Precious','Molefe','Customer Consultant','2021-04-27',5);



-- ---------------------------------------------------------------------------
-- Insert Accounts
-- ---------------------------------------------------------------------------

INSERT INTO Accounts
(AccountID, CustomerID, BranchID, AccountType, Balance, OpenDate, Status)
VALUES
(301,101,1,'Savings',25000,'2022-01-15','Active'),
(302,101,1,'Cheque',18000,'2022-02-10','Active'),

(303,102,2,'Savings',42000,'2021-08-22','Active'),

(304,103,3,'Savings',31500,'2023-02-18','Active'),
(305,103,3,'Cheque',12000,'2023-03-02','Active'),

(306,104,5,'Savings',15500,'2020-09-11','Closed'),

(307,105,2,'Savings',51000,'2021-05-03','Active'),
(308,105,2,'Cheque',21000,'2021-05-15','Active'),

(309,106,4,'Savings',62000,'2022-10-14','Active'),

(310,107,4,'Savings',29000,'2023-03-08','Active'),

(311,108,1,'Savings',34000,'2020-12-20','Active'),

(312,109,5,'Savings',11000,'2021-07-01','Closed'),

(313,110,2,'Savings',47000,'2022-04-27','Active'),
(314,110,2,'Cheque',19500,'2022-05-12','Active');

-- ---------------------------------------------------------------------------
-- Insert Transactions
-- ---------------------------------------------------------------------------

INSERT INTO Transactions
(TransactionID, AccountID, TransactionType, Amount, TransactionDate)
VALUES

-- Account 301 (Savings - Lerato)
(401,301,'Deposit',5000,'2024-01-10'),
(402,301,'Withdrawal',1200,'2024-01-15'),
(403,301,'Deposit',3500,'2024-02-05'),

-- Account 302 (Cheque - Lerato)
(404,302,'Deposit',2000,'2024-02-18'),
(405,302,'Withdrawal',800,'2024-03-01'),
(406,302,'Deposit',4200,'2024-03-15'),

-- Account 303 (Thabo)
(407,303,'Deposit',10000,'2024-01-12'),
(408,303,'Withdrawal',2500,'2024-02-08'),
(409,303,'Deposit',5000,'2024-04-11'),

-- Account 304 (Ayanda)
(410,304,'Deposit',7000,'2024-01-20'),
(411,304,'Withdrawal',1500,'2024-02-14'),
(412,304,'Deposit',3000,'2024-04-06'),

-- Account 305 (Ayanda)
(413,305,'Deposit',2500,'2024-03-08'),
(414,305,'Withdrawal',1000,'2024-03-20'),
(415,305,'Deposit',4500,'2024-05-03'),

-- Account 306 (Sipho)
(416,306,'Deposit',4500,'2024-01-05'),
(417,306,'Withdrawal',2200,'2024-02-10'),
(418,306,'Deposit',1800,'2024-05-20'),

-- Account 307 (Naledi)
(419,307,'Deposit',12000,'2024-01-18'),
(420,307,'Withdrawal',3000,'2024-02-28'),
(421,307,'Deposit',5500,'2024-04-15'),

-- Account 308 (Naledi)
(422,308,'Deposit',2500,'2024-03-05'),
(423,308,'Withdrawal',900,'2024-04-09'),
(424,308,'Deposit',3800,'2024-05-08'),

-- Account 309 (Brian)
(425,309,'Deposit',15000,'2024-01-11'),
(426,309,'Withdrawal',5000,'2024-03-02'),
(427,309,'Deposit',8000,'2024-05-18'),

-- Account 310 (Sarah)
(428,310,'Deposit',6000,'2024-02-06'),
(429,310,'Withdrawal',1200,'2024-03-19'),
(430,310,'Deposit',4500,'2024-05-28'),

-- Account 311 (Michael)
(431,311,'Deposit',9000,'2024-01-25'),
(432,311,'Withdrawal',2000,'2024-02-16'),
(433,311,'Deposit',3500,'2024-04-22'),

-- Account 312 (Zanele)
(434,312,'Deposit',2000,'2024-01-28'),
(435,312,'Withdrawal',500,'2024-02-20'),
(436,312,'Deposit',2500,'2024-05-10'),

-- Account 313 (David)
(437,313,'Deposit',11000,'2024-01-30'),
(438,313,'Withdrawal',2500,'2024-03-14'),
(439,313,'Deposit',6000,'2024-04-30'),

-- Account 314 (David)
(440,314,'Deposit',3000,'2024-02-25'),
(441,314,'Withdrawal',700,'2024-04-10'),
(442,314,'Deposit',2800,'2024-05-25');

-- ---------------------------------------------------------------------------
-- Insert Loans
-- ---------------------------------------------------------------------------

INSERT INTO Loans
(LoanID, CustomerID, LoanType, LoanAmount, InterestRate, LoanStatus)
VALUES
(501,101,'Home Loan',850000,8.75,'Approved'),
(502,102,'Car Loan',320000,9.20,'Approved'),
(503,103,'Personal Loan',85000,12.50,'Pending'),
(504,104,'Home Loan',650000,8.90,'Approved'),
(505,105,'Business Loan',450000,10.50,'Approved'),
(506,106,'Car Loan',280000,9.00,'Pending'),
(507,107,'Personal Loan',120000,13.00,'Rejected'),
(508,108,'Education Loan',95000,7.50,'Approved'),
(509,109,'Business Loan',600000,10.80,'Approved'),
(510,110,'Home Loan',980000,8.60,'Pending');

-- ============================================================================
-- SECTION 4 : BUSINESS ANALYSIS
-- ============================================================================



-- ============================================================================
-- Business Question 1
-- Top 10 Customers by Total Account Balance
-- ============================================================================

-- This query calculates the total balance across all accounts for each customer
-- and returns the top 10 customers with the highest balances.

SELECT
    c.CustomerID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    SUM(a.Balance) AS TotalBalance
FROM Customers c
INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalBalance DESC
LIMIT 10;

-- ============================================================================
-- Business Question 2
-- Branch with the Highest Total Account Balance
-- ============================================================================

-- This query identifies the branch that holds the highest total customer balance.

SELECT
    b.BranchName,
    SUM(a.Balance) AS TotalBalance
FROM Branches b
INNER JOIN Accounts a
ON b.BranchID = a.BranchID
GROUP BY b.BranchName
ORDER BY TotalBalance DESC
LIMIT 1;

-- ============================================================================
-- Business Question 3
-- Customers with More Than One Account
-- ============================================================================

-- This query identifies customers who own more than one bank account.

SELECT
    c.CustomerID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    COUNT(a.AccountID) AS NumberOfAccounts
FROM Customers c
INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING COUNT(a.AccountID) > 1;

-- ============================================================================
-- Business Question 4
-- Rank Customers by Total Account Balance
-- ============================================================================

-- This query ranks customers according to their total account balances.

WITH CustomerBalances AS (

SELECT
    c.CustomerID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    SUM(a.Balance) AS TotalBalance

FROM Customers c

INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

)

SELECT
    CustomerName,
    TotalBalance,
    RANK() OVER(ORDER BY TotalBalance DESC) AS CustomerRank
FROM CustomerBalances;

-- ============================================================================
-- Business Question 5
-- Assign a Unique Rank to Customers by Total Balance
-- ============================================================================

-- This query assigns a unique ranking to every customer based on
-- total account balance.

WITH CustomerBalances AS (

SELECT
    c.CustomerID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    SUM(a.Balance) AS TotalBalance

FROM Customers c

INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

)

SELECT
    CustomerName,
    TotalBalance,
    ROW_NUMBER() OVER(ORDER BY TotalBalance DESC) AS CustomerRank
FROM CustomerBalances;

-- ============================================================================
-- Business Question 6
-- Running Total of All Transactions
-- ============================================================================

-- This query calculates the cumulative transaction amount over time.

SELECT
    TransactionDate,
    Amount,
    SUM(Amount) OVER(
        ORDER BY TransactionDate
    ) AS RunningTotal
FROM Transactions;

-- ============================================================================
-- Business Question 7
-- Running Total of Transactions per Customer
-- ============================================================================

-- This query calculates the running total of transaction amounts
-- for each customer separately.

SELECT
    c.CustomerID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    t.TransactionDate,
    t.Amount,

    SUM(t.Amount)
    OVER(
        PARTITION BY c.CustomerID
        ORDER BY t.TransactionDate
    ) AS RunningTotal

FROM Customers c

INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID

INNER JOIN Transactions t
ON a.AccountID = t.AccountID;

-- ============================================================================
-- Business Question 8
-- Customers Holding Multiple Account Types
-- ============================================================================

-- This query identifies customers who own more than one account type.

SELECT

    c.CustomerID,

    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,

    MAX(CASE
            WHEN a.AccountType='Savings'
            THEN '✔'
        END) AS Savings,

    MAX(CASE
            WHEN a.AccountType='Cheque'
            THEN '✔'
        END) AS Cheque,

    COUNT(DISTINCT a.AccountType) AS NumberOfAccountTypes

FROM Customers c

INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

HAVING COUNT(DISTINCT a.AccountType)>1;

-- ============================================================================
-- Business Question 9
-- Branch with the Highest Total Transaction Value
-- ============================================================================

-- This query returns the branch that processed the highest
-- total transaction amount.

SELECT

    b.BranchName,

    SUM(t.Amount) AS TotalTransactionAmount

FROM Branches b

INNER JOIN Accounts a
ON b.BranchID = a.BranchID

INNER JOIN Transactions t
ON a.AccountID = t.AccountID

GROUP BY
    b.BranchName

ORDER BY
    TotalTransactionAmount DESC

LIMIT 1;

-- ============================================================================
-- Business Question 10
-- Top 5 Customers by Total Transaction Value
-- ============================================================================

-- This query identifies the five customers with the highest
-- transaction amounts.

SELECT

    c.CustomerID,

    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,

    SUM(t.Amount) AS TotalTransactionAmount

FROM Customers c

INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID

INNER JOIN Transactions t
ON a.AccountID = t.AccountID

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

ORDER BY
    TotalTransactionAmount DESC

LIMIT 5;

-- ============================================================================
-- Business Question 11
-- Month with the Highest Transaction Value
-- ============================================================================

-- This query identifies the month with the highest
-- total transaction amount.

SELECT

    YEAR(TransactionDate) AS Year,

    MONTHNAME(TransactionDate) AS Month,

    SUM(Amount) AS TotalTransactionAmount

FROM Transactions

GROUP BY

    YEAR(TransactionDate),

    MONTHNAME(TransactionDate)

ORDER BY

    TotalTransactionAmount DESC

LIMIT 1;

-- ============================================================================
-- Business Question 12
-- Loan Distribution by Status
-- ============================================================================

-- This query counts the number of loans
-- for each loan status.

SELECT

    LoanStatus,

    COUNT(LoanID) AS NumberOfLoans

FROM Loans

GROUP BY LoanStatus;

-- ============================================================================
-- Business Question 13
-- Total Loan Amount by Loan Type
-- ============================================================================

-- This query calculates the total loan amount
-- for each loan type.

SELECT

    LoanType,

    SUM(LoanAmount) AS TotalLoanAmount

FROM Loans

GROUP BY LoanType;

-- ============================================================================
-- Business Question 14
-- Customer Distribution by Province
-- ============================================================================

-- This query counts the number of customers
-- in each province.

SELECT

    Province,

    COUNT(CustomerID) AS NumberOfCustomers

FROM Customers

GROUP BY Province

ORDER BY NumberOfCustomers DESC;

-- ============================================================================
-- Business Question 15
-- Account Distribution by Status
-- ============================================================================

-- This query counts the number of accounts
-- for each account status.

SELECT

    Status,

    COUNT(AccountID) AS NumberOfAccounts

FROM Accounts

GROUP BY Status;


