CREATE DATABASE Case_Study2;

USE Case_Study2;

-- Create table and import statements from the text document given
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

-- These following lines seems repetitive, so commenting out them

-- CREATE TABLE JOB
-- (JOB_ID INT PRIMARY KEY,
-- DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT');


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID));

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30);

-- Checking with the tables given in the Assignment question paper
-- Note, I have inserted rows using the text document provided
-- In this text document, additional Manager_ID row is there
-- Some mismatch of data like EMPLOYEE_ID few values and 1984-02-20 in Hire Date also there
-- But I followed the text document

--Using [] for Location since it is also a keyword
SELECT * FROM [LOCATION];
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM EMPLOYEE;


-- Questions
-- Simple Queries:

-- 1. List all the employee details.
SELECT * FROM EMPLOYEE;

-- 2. List all the department details.
SELECT * FROM DEPARTMENT;

-- 3. List all job details.
SELECT * FROM JOB;

-- 4. List all the locations.
SELECT * FROM [LOCATION];

-- 5. List out the FirstName, LastName, Salary, Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMM FROM EMPLOYEE;


-- 6. List out the EmployeeID, LastName, Department ID for all employees and
-- alias
-- EmployeeID as "ID of the Employee", LastName as "Nameof the
-- Employee", Department ID as "Dep_id".
SELECT 
	EMPLOYEE_ID AS ID_of_the_Employee,
	LAST_NAME AS Name_of_the_Employee,
	DEPARTMENT_ID AS Dep_id
FROM EMPLOYEE;


-- 7. List out the annual salary of the employees with their names only.

-- Salary with all of their names
SELECT 
	LAST_NAME,
	FIRST_NAME,
	MIDDLE_NAME,
	SALARY
FROM EMPLOYEE;

-- Another order of columns
SELECT 
	SALARY,	
	LAST_NAME,
	FIRST_NAME,
	MIDDLE_NAME
FROM EMPLOYEE;

-- Salary with only last name
SELECT LAST_NAME, SALARY FROM EMPLOYEE;

-- Salary with only First name
SELECT FIRST_NAME, SALARY FROM EMPLOYEE;


--  WHERE Condition:

-- 1. List the details about "Smith"
SELECT * FROM EMPLOYEE WHERE LAST_NAME = 'Smith';


-- 2. List out the employees who are working in department 20
-- To select all details
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 20;

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE DEPARTMENT_ID = 20;

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE DEPARTMENT_ID = 20;


-- 3. List out the employees who are earning salaries between 3000 and 4500.
-- NOTE: Nobody is there in this salary limit as of now

-- To select all details
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500;

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500;

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500;


-- 4. List out the employees who are working in department 10 or 20.
-- To select all details
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 20;

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 20;

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 20;


-- 5. Find out the employees who are not working in department 10 or 30.
-- To select all details
SELECT * FROM EMPLOYEE WHERE NOT (DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 30);

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE NOT (DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 30);

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE NOT (DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 30);


-- 6. List out the employees whose name starts with 'S'.
-- Assuming that name here refers to Last Name
-- To select all details
SELECT * FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%';

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%';

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%';


-- 7. List out the employees whose name starts with 'S' and ends with 'H'.
-- Assuming that name here refers to Last Name
-- To select all details
SELECT * FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%' AND LAST_NAME LIKE '%H';

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%' AND LAST_NAME LIKE '%H';

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE LAST_NAME LIKE 'S%' AND LAST_NAME LIKE '%H';


-- 8. List out the employees whose name length is 4 and start with 'S'.
-- Assuming that name here refers to Last Name

-- NOTE: as of now only SMITH starts with S and its length is 5.
-- So, as of now no employee last name satisfies the condition

-- To select all details
SELECT * FROM EMPLOYEE WHERE LEN(LAST_NAME) = 4 AND LAST_NAME LIKE 'S%';

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE LEN(LAST_NAME) = 4 AND LAST_NAME LIKE 'S%';

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE LEN(LAST_NAME) = 4 AND LAST_NAME LIKE 'S%';


-- 9. List out employees who are working in department 10 and draw salaries more
-- than 3500.
-- NOTE: no one has salary more than 3500 as of now

-- To select all details
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 AND SALARY > 3500;

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 AND SALARY > 3500;

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 AND SALARY > 3500;


-- 10. List out the employees who are not receiving commission.
-- To select all details
SELECT * FROM EMPLOYEE WHERE COMM IS NULL;

-- To list out the employees with their id and names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE COMM IS NULL;

-- To list out the employees with their names only
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME FROM EMPLOYEE WHERE COMM IS NULL;



-- ORDER BY Clause:
-- NOTE : default in order by is ascending order

-- 1. List out the Employee ID and Last Name in ascending order based onthe
-- Employee ID.
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEE ORDER BY EMPLOYEE_ID;


--  2. List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEE ORDER BY SALARY DESC;

-- Additional implementation - with all names and salary for reference
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC;


-- 3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM EMPLOYEE ORDER BY LAST_NAME;

--  4. List out the employee details according to their Last Name in ascending
-- order and then Department ID in descending order.
SELECT * FROM EMPLOYEE ORDER BY LAST_NAME, DEPARTMENT_ID DESC;

-- Additional implementation - explicit ASC
SELECT * FROM EMPLOYEE ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC;


--  GROUP BY and HAVING Clause:

-- 1. How many employees are in different departments in the organization?
SELECT COUNT(*), DEPARTMENT_ID FROM EMPLOYEE GROUP BY DEPARTMENT_ID;

-- 2. List out the department wise maximum salary, minimum salary and
-- average salary of the employees.
SELECT 
	MAX(SALARY) AS Max_Salary, 
	MIN(SALARY) AS Min_Salary,
	AVG(SALARY) AS Avg_Salary,
	DEPARTMENT_ID 
FROM EMPLOYEE 
GROUP BY DEPARTMENT_ID;

-- 3. List out the job wise maximum salary, minimum salary andaverage
-- salary of the employees.
SELECT 
	MAX(SALARY) AS Max_Salary, 
	MIN(SALARY) AS Min_Salary,
	AVG(SALARY) AS Avg_Salary,
	JOB_ID 
FROM EMPLOYEE 
GROUP BY JOB_ID;

-- 4. List out the number of employees who joined each month in ascending order.
-- NOTE : In the table in Question paper, Allen's Hire date given as 20-Feb-85
-- But in the insert statement it is given as 20-FEB-84

-- Using only month in group by to get the count by joining month only
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(MONTH, HIRE_DATE) AS Joining_month
FROM EMPLOYEE 
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY DATEPART(MONTH, HIRE_DATE);

-- Using month name also
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(MONTH, HIRE_DATE) AS Joining_month,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY DATEPART(MONTH, HIRE_DATE);

-- improving above query more readable with only month name displayed with count
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY DATEPART(MONTH, HIRE_DATE);

-- Alternative Implementation - Ascending order of count
-- here Datepart(month) not required since order by is not using it
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATENAME(MONTH, HIRE_DATE)
ORDER BY Number_of_employees_joined;


-- Additional Implementation - This is as same as Question 5 (next question)

-- Month should be combined with year to get the result
-- DatePart(Month) or DateName(Month) gives only month or month name
-- So year and month would only give the month wise count

SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATEPART(MONTH, HIRE_DATE) AS Joining_month
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE)
ORDER BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE);

-- Using Month Name
-- NOTE : Not using month name in order by since it would order by alphabetical order
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATEPART(MONTH, HIRE_DATE) AS Joining_month,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE);

-- improving readability - only count, year and month name displayed
-- still datepart(month) needed in group by to use it in order by
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE);

-- Alternative implementation - Ascending order of count
-- here Datepart(month) not required since order by is not using it
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY Number_of_employees_joined;


-- 5. List out the number of employees for each month and yearin
-- ascending order based on the year and month

-- NOTE : This is already implemented as addtional implemetation in previous question
-- But again writing here for more clarity
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATEPART(MONTH, HIRE_DATE) AS Joining_month
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE)
ORDER BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE);

-- Using Month Name
-- NOTE : Not using month name in order by since it would order by alphabetical order
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATEPART(MONTH, HIRE_DATE) AS Joining_month,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE);

-- improving readability - only count, year and month name displayed
-- still datepart(month) needed in group by to use it in order by
SELECT 
	COUNT(*) AS Number_of_employees_joined,
	DATEPART(YEAR, HIRE_DATE) AS Joining_year,
	DATENAME(MONTH, HIRE_DATE) AS Joining_month_name
FROM EMPLOYEE 
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
ORDER BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE);