create database EMPLOYEE_DB;
use EMPLOYEE_DB;

CREATE TABLE Employees
(
  EmployeeID int NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  ManagerID int NULL
);

INSERT INTO Employees VALUES (1, 'Ken', 'Thompson', NULL)
INSERT INTO Employees VALUES (2, 'Terri', 'Ryan', 1)
INSERT INTO Employees VALUES (3, 'Robert', 'Durello', 1)
INSERT INTO Employees VALUES (4, 'Rob', 'Bailey', 2)
INSERT INTO Employees VALUES (5, 'Kent', 'Erickson', 2)
INSERT INTO Employees VALUES (6, 'Bill', 'Goldberg', 3)
INSERT INTO Employees VALUES (7, 'Ryan', 'Miller', 3)
INSERT INTO Employees VALUES (8, 'Dane', 'Mark', 5)
INSERT INTO Employees VALUES (9, 'Charles', 'Matthew', 6)
INSERT INTO Employees VALUES (10, 'Michael', 'Jhonson', 6) 

select CONCAT('Join', ' ', 'Smith');

select CONCAT(FirstName, ' ', LastName) from Employees;


-- self join to print emp name along with their manager name
----------------------------------------------------------

select * from Employees a left outer join Employees b
on a.ManagerID = b.EmployeeID;

select a.EmployeeID, concat(a.FirstName,' ',a.LastName) as Emp_Name, 
coalesce(a.ManagerID,0) as Manager_ID,
IIF(a.ManagerID is null, 'CEO', concat(b.FirstName,' ',b.LastName)) as Manager_Name
from
Employees a left outer join Employees b
on
 a.ManagerID = b.EmployeeID ;


 create table employees2 (
   employee_id int not null primary key,
   emp_aadhar char(12),
   emp_pan char(10),
   firstname varchar(50) not null,
   lastname varchar(50) not null,
   gender char(1),
   constraint employees_ck1 unique (emp_aadhar),
   constraint employees_ck2 unique (emp_pan)
);



exec sp_help employees2;

delete from employees2;

insert into employees2 values(101, '123456789012', 'ABCDE1234Z', 'Arun', 'Sharma', 'M');

insert into employees2 values(102, '123456789013', null, 'John', 'Smith', 'M');

insert into employees2 values(103, '123456789014', 'ABCDE1234Y', 'Mary', 'Jones', 'F');

insert into employees2 values(104, null, 'ABCDE1234X', 'Mary', 'Jones', 'F');

-- insert into employees2 values(105, null, null, 'Mary', 'Jones', 'F');
-- error since null cannot be repeated


select * from employees2;