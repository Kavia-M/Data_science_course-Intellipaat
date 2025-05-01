-- creating a dedicated Database for Mandatory Assignment 1 
create database Mandatory_Assignment1;

-- Using the newly created Database
use Mandatory_Assignment1;

-- Table creation and records insertion using the script provided in the drive link in assignment
--------------------------  Salesman Table ----------------------------
--  Salesman table creation
 CREATE TABLE Salesman (
 SalesmanId INT,
 Name VARCHAR(255),
 Commission DECIMAL(10, 2),
 City VARCHAR(255),
 Age INT
 );

-- Salesman table record insertion
 INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
 VALUES
 (101, 'Joe', 50, 'California', 17),
 (102, 'Simon', 75, 'Texas', 25),
 (103, 'Jessie', 105, 'Florida', 35),
 (104, 'Danny', 100, 'Texas', 22),
 (105, 'Lia', 65, 'New Jersey', 30);

-------------------------------- Customer Table --------------------
-- Customer table creation
 CREATE TABLE Customer (
 SalesmanId INT,
 CustomerId INT,
 CustomerName VARCHAR(255),
 PurchaseAmount INT,
 );

-- Customer table record insertion
 INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
 VALUES
 (101, 2345, 'Andrew', 550),
 (103, 1575, 'Lucky', 4500),
 (104, 2345, 'Andrew', 4000),
 (107, 3747, 'Remona', 2700),
 (110, 4004, 'Julia', 4545);

------------------------- Orders Table ---------------------------------
-- Orders table Creation
 CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount
 money);

-- Orders table record insertion
 INSERT INTO Orders Values
 (5001,2345,101,'2021-07-01',550),
 (5003,1234,105,'2022-02-15',1500);


 -- checking
 select * from Salesman;
 select * from Customer;
 select * from Orders;


 -- 1. Insert a new record in your Orders table.

 -- inserting rows into Orders table with suitable values for all columns
 INSERT INTO Orders VALUES
 (5004, 1575, 103, '2024-03-20', 1450);


-- 2. Add Primary key constraint for SalesmanId column in Salesman table. Add default 
-- constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId 
-- column in Customer table. Add not null constraint in Customer_name column for the 
-- Customer table. 


-- making column not null before primary key cinstraint to be added because primary key can be on non nullable column only
ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;

-- adding primary key with constraint name
ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman
PRIMARY KEY (SalesmanId);

-- adding default constraint with constraint name
ALTER TABLE Salesman
ADD CONSTRAINT City_Default
DEFAULT 'New York' FOR City;

-- addding cusotmer foreign key with constraint name
-- since customer table already has a salesmanID that is not in salesman table, to avoid conflict NOCHECK is added
-- this will check for rows that will be inserted after the constraint added not before that
ALTER TABLE Customer
WITH NOCHECK
ADD CONSTRAINT FK_SalesmanId
FOREIGN KEY (SalesmanId)
REFERENCES Salesman(SalesmanId);

-- adding not null constraint to customerName
-- not null constraint cannot have constraint name like we did for primary key, default and foreign key
ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

-- checking whether our changes are reflected
EXEC sp_help salesman;
EXEC sp_help customer;
select * from INFORMATION_SCHEMA.COLUMNS;


-- 3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase 
-- amount value greater than 500.

-- this query currenty returns no rows since no customer name ends with N
select CustomerName from Customer where CustomerName like '%n';

-- this query returns PurchaseAmount from all rows since all of those are greate than 500
select PurchaseAmount from Customer where PurchaseAmount > 500;


-- 4. Using SET operators, retrieve the first result with unique SalesmanId values from two 
-- tables, and the other result containing SalesmanId with duplicates from two tables. 

-- results tried for different table since salesmanId is in all the 3 tables
-- given that 2 tables in question, 2 tables are taken for a result

-- result 1 - UNION is used to get distinct 
select SalesmanId from Salesman
union
select SalesmanId from Customer;

select SalesmanId from Salesman
union 
select SalesmanId from Orders;

select SalesmanId from Customer
union 
select SalesmanId from Orders;

-- result 2 - UNION ALL includes duplicates also
select SalesmanId from Salesman
union all
select SalesmanId from Customer;

select SalesmanId from Salesman
union all
select SalesmanId from Orders;

select SalesmanId from Customer
union all
select SalesmanId from Orders


-- 5. Display the below columns which has the matching data. 
-- Orderdate, Salesman Name, Customer Name, Commission, and City which has the 
-- range of Purchase Amount between 500 to 1500.

-- salesmanId is present in both customer table and orders table
-- to join salesman table if the salesman id from orders table is used
select o.Orderdate, s.Name as SalesmanName, c.CustomerName, s.Commission as SalesmanCommission, s.City as SalesmanCity
from Orders o join Customer c
on o.CustomerId = c.CustomerId
join Salesman s 
on o.SalesmanId = s.SalesmanId
where c.PurchaseAmount between 500 and 1500;

---- salesmanId is present in both customer table and orders table
-- to join salesman table if the salesman id from customer table is used
select o.Orderdate, s.Name as SalesmanName, c.CustomerName, s.Commission as SalesmanCommission, s.City as SalesmanCity
from Orders o join Customer c
on o.CustomerId = c.CustomerId
join Salesman s 
on c.SalesmanId = s.SalesmanId
where c.PurchaseAmount between 500 and 1500;


-- 6. Using right join fetch all the results from Salesman and Orders table. 

-- to seelct all rows from orders table
select * 
from Salesman s right join Orders o
on s.SalesmanId = o.SalesmanId;

-- to select all rows from salesman table
select * 
from Orders o right join Salesman s
on o.SalesmanId = s.SalesmanId; 
