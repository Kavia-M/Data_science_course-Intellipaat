CREATE DATABASE apr22nd;

USE apr22nd;


create table customer
(
    customerid int,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(30),
    address varchar(50),
    city varchar(20),
    state varchar(20),
    zip char(6)
);
insert into customer values
(1,'abhishek','singh','as@gmail.com','MGRoad','Mumbai','Maharastra','430003'),
(2,'ishika','k','ik@outlook.com','VVPuram','Bang','Karnataka','456781'),
(3,'chirag','dhamija','cd@gmail.com','LKPuram','HYD','TS','56001'),
(4,'vivek','gupta','vk@gmail.com','Raj Nagar','Delhi','Delhi','234561'),
(5,'ganesh','ram','gr@gmail.com','Lalnagar','Sanjose','USA','987654');
create table orders
(
orderid int,
orderdate date,
amount int,
customerid int
);

insert into orders values
(101,'2024-01-01',500,1),
(102,'2024-05-02',1500,3),
(103,'2024-02-06',700,2),
(104,'2024-06-08',100,9),
(105,'2024-07-12',120,8);

select * from customer;
select * from orders;

-- 1. Use the inbuilt functions and find the minimum, maximum and average amount from the orders table
SELECT
	min(amount) as min_amunt,
	max(amount) as max_amount,
	avg(amount) as avg_amount
FROM orders;

-- trainer's answer
select
    MIN(amount) as minimum,
    MAX(amount) as maximum,
    AVG(amount) as average
from orders;

--2. Create a user-defined function which will multiply the given number with 10
CREATE FUNCTION FN_multiply_with_10
(
	@num INT
)
RETURNS INT
AS
BEGIN
	RETURN (@num * 10)
END;

SELECT dbo.FN_multiply_with_10(20) as Result;

/*3. Use the case statement to check if 100 is less than 200, greater than 200
or equal to 200 and print the corresponding value. */

SELECT
	CASE	
		WHEN 100 < 200 THEN 'Less than 200'
		WHEN 100 > 200 THEN 'Greater than 200'
		ELSE 'Equal to 200' 
	END AS result;

/*4. Using a case statement, find the status of the amount. Set the status of the
amount as high amount, low amount or medium amount based upon the condition. */

SELECT 
	*,
	CASE	
		WHEN amount > 700 THEN 'High amount' 
		WHEN amount < 500 THEN 'Low amount'
		ELSE 'Medium amount'
	END AS [status]
FROM orders;
		
-- answer from some another, wonder this is working
select *, amount=
case 
    when amount>700 then 'high'
    when amount<500 then 'low'
else 'medium'
end
from orders;

--5. Create a user-defined function, to fetch the amount greater than then given input.
CREATE FUNCTION FN_amount_greater
(
	@input_amount INT
)
RETURNS TABLE
AS 
RETURN
(
	SELECT amount FROM orders WHERE amount > @input_amount
);

SELECT * FROM dbo.FN_amount_greater(1000);
SELECT * FROM FN_amount_greater(1000);

-- 1. Arrange the ‘Orders’ dataset in decreasing order of amount
SELECT * FROM orders ORDER BY amount DESC;

-- 2. Create a table with the name ‘Employee_details1’ consisting of these-- columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. Create another table with-- the name ‘Employee_details2’ consisting of the same columns as the first table.CREATE TABLE Employee_details1(	Emp_id INT,	Emp_name VARCHAR(50),	Emp_salary INT);CREATE TABLE Employee_details2(	Emp_id INT,	Emp_name VARCHAR(50),	Emp_salary INT);insert into Employee_details1 values(1,'A',3000),(2,'B',2500),(3,'C',4000),(4,'D',3500),(5,'E',3000);insert into Employee_details2 values(1,'A',3000),(2,'B',2500),(3,'C',4000),(6,'F',3500),(7,'G',3000);SELECT * FROM Employee_details1;SELECT * FROM Employee_details2;-- 3. Apply the UNION operator on these two tablesSELECT * FROM Employee_details1UNIONSELECT * FROM Employee_details2;-- Additional implementationSELECT * FROM Employee_details1UNION ALLSELECT * FROM Employee_details2;--4. Apply the INTERSECT operator on these two tablesSELECT * FROM Employee_details1INTERSECTSELECT * FROM Employee_details2;-- 5. Apply the EXCEPT operator on these two tablesSELECT * FROM Employee_details1EXCEPTSELECT * FROM Employee_details2;SELECT * FROM Employee_details2EXCEPTSELECT * FROM Employee_details1;-- Assignment 6-- 1. Create a view named ‘customer_san_jose’ which comprises of only those customers who are from San JoseCREATE VIEW Customer_San_JoseASselect * from customer where city = 'Sanjose';-- select from viewselect * from Customer_San_Jose;/*2. Inside a transaction, update the first name of the customer to Francis where the last name is Jordan:a. Rollback the transactionb. Set the first name of customer to Alex, where the last name is Jordan*/-- 1st update since we have no last name as Jordan as of nowUpdate customerset lastname='Jordan'where customerid=1select * from customer;-- aBEGIN TRANSACTION Update_JordanUPDATE customerSET firstname = 'Francis'WHERE lastname = 'Jordan';-- checkingSELECT * FROM customer;-- RollbackROLLBACK TRANSACTION Update_Jordan;-- CheckingSELECT * FROM customer;-- bUPDATE customerSET firstname = 'Alex'WHERE lastname = 'Jordan';-- checkingSELECT * FROM customer;-- 3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message.BEGIN TRY	SELECT 100/0 AS ResultEND TRYBEGIN CATCH	SELECT ERROR_MESSAGE() AS Default_Error_messageEND CATCH;begin try    print 100/0end trybegin catch    print error_message()end catch;-- 4. Create a transaction to insert a new record to Orders table and save it.BEGIN TRANSACTIONINSERT INTO orders VALUES(106,'2024-08-12',135,4);-- checkingselect * from orders;-- commitCOMMIT;-- again checkingselect * from orders;