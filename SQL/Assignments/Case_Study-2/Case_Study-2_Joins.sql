USE Case_Study2;

-- Joins:
-- 1. List out employees with their department names.

-- Select all colunms in Employee as well as department name
SELECT 
	E.*, 
	D.[Name] AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id;

-- List only IDs and Names
SELECT 
	E.EMPLOYEE_ID,
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	E.DEPARTMENT_ID,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id;

-- select only names
SELECT 
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id;


-- 2. Display employees with their designations.

-- Select all colunms in Employee as well as designations
SELECT 
	E.*,
	J.Designation AS Designation
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_ID = J.Job_ID;

-- List only IDs, Names and Designation
SELECT 
	E.EMPLOYEE_ID,
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	E.JOB_ID,
	J.Designation AS Designation
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_ID = J.Job_ID;

-- select only names and Designation
SELECT 
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	J.Designation AS Designation
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_ID = J.Job_ID;


-- 3. Display the employees with their department names and regional groups.
-- NOTE: There is no column named regional group in any of the given tables
-- Considering CITY in Location table as Regional Group

-- Select all employee details
SELECT 
	E.*,
	D.[Name] AS Department_Name,
	D.Location_Id,
	L.City AS Regional_Group 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID;

-- List only IDs and Names
SELECT 
	E.EMPLOYEE_ID,
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	E.DEPARTMENT_ID,
	D.[Name] AS Department_Name,
	D.Location_Id,
	L.City AS Regional_Group 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID;

-- List only names
SELECT 
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	D.[Name] AS Department_Name,
	L.City AS Regional_Group 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID;

-- Additional Implementation

-- Using group by since in question it is mentioned as REGIONAL GROUPS
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name,
	L.City AS Regional_Group 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
GROUP BY L.City, D.[Name];

-- Using right join to display zero count also
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name,
	L.City AS Regional_Group 
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
RIGHT JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
GROUP BY L.City, D.[Name];

-- Each employee ID is unique here,
-- so below query with group by employee id makes no sense
SELECT 
	E.EMPLOYEE_ID,
	D.[Name] AS Department_Name,
	L.City AS Regional_Group 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
GROUP BY L.City, D.[Name], E.EMPLOYEE_ID;


-- 4. How many employees are working in different departments? Display with
-- department names.

-- RIGHT JOIN is necessary to inclue Accounting dept which has no employees
-- count(*) counts rows making 1 for Accounting which is not correct
-- count(employee_id) counts non null and is primary key of employee table
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.Department_Id,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Department_Id, D.[Name];

-- selecting only count and department name
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Department_Id, D.[Name];

-- Each DEPARTMENT NAME uniquely maps to a DEPARTMENT_ID in this dataset, 
-- even though it is not explicitly defined as UNIQUE in the schema.
-- So we can safely ignore department ID in group by as of now
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.[Name];

-- Using Left join if we use Department table as left table
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E
ON D.Department_Id = E.DEPARTMENT_ID
GROUP BY D.[Name];


-- 5. How many employees are working in the sales department?

-- though we know sales dept has employees working in it,
-- it is not guaranteed.
-- so, we should use RIGHT JOIN only
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.[Name]
HAVING D.[Name] = 'Sales';

-- Using Where and using employee id in count
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.[Name] = 'Sales'
GROUP BY D.[Name];

-- Displayiong only count
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.[Name]
HAVING D.[Name] = 'Sales';


--  6. Which is the department having greater than or equal to 5
-- employees? Display the department names in ascending
-- order.

-- NOTE: There is no departments with >= 5 employees as of now

SELECT 
	D.Department_Id,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Department_Id, D.[Name]
HAVING Count(E.EMPLOYEE_ID) >= 5
ORDER BY Department_Name;

-- Selecting only Department name and using Employee Id in count
SELECT 
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Department_Id, D.[Name]
HAVING Count(E.EMPLOYEE_ID) >= 5
ORDER BY Department_Name;

-- Given the explanation in Question 4,
-- safely ignoring department id in group by
SELECT 
	D.[Name] AS Department_Name
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.[Name]
HAVING Count(E.EMPLOYEE_ID) >= 5
ORDER BY Department_Name;

-- For this condition, >=5 means,
-- 0 count cannot satisfy this condition at any case
-- so we can use inner join in this case
-- and use count(*) since NULL for employeeID not possible in inner join
SELECT 
	D.Department_Id,
	D.[Name] AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Department_Id, D.[Name]
HAVING Count(*) >= 5
ORDER BY Department_Name;

-- Selecting only Department name and using Employee Id in count
SELECT 
	D.[Name] AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Department_Id, D.[Name]
HAVING Count(E.EMPLOYEE_ID) >= 5
ORDER BY Department_Name;

-- Given the explanation in Question 4,
-- safely ignoring department id in group by 
-- and using ASC (additionally though not needed) in order by
SELECT 
	D.[Name] AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.[Name]
HAVING Count(*) >= 5
ORDER BY Department_Name ASC;


--  7. How many jobs are there in the organization? Display with designations.
-- NOTE - To see all the available jobs in organization, join is not needed
SELECT * FROM JOB;
SELECT COUNT(*) AS Total_number_of_Jobs FROM JOB;
SELECT COUNT(DISTINCT Designation) AS Number_of_Designations FROM JOB;
SELECT DISTINCT Designation FROM JOB;

-- Answer, to see all jobs actively employed currently
-- We need to count employees as per designation
SELECT
	COUNT(E.EMPLOYEE_ID) AS Number_of_employees,
	J.Job_ID,
	J.Designation
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_ID = J.Job_ID
GROUP BY J.Job_ID, J.Designation;

-- Each designation uniquely maps to a JOB_ID in this dataset, 
-- even though it is not explicitly defined as UNIQUE in the schema.
-- So we can safely ignore JOB_ID in group by as of now
-- And also Inner Join joins matched rows only, so we can use count(*)
SELECT 
	Count(*) AS Number_of_Employees,
	J.Designation
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_ID = J.Job_ID
GROUP BY J.Designation;


-- Answer, RIGHT JOIN to see all jobs actively employed currently
-- with 0 for no employees in that role
-- We need to count employees as per designation
SELECT
	COUNT(E.EMPLOYEE_ID) AS Number_of_employees,
	J.Job_ID,
	J.Designation
FROM EMPLOYEE E
RIGHT JOIN JOB J
ON E.JOB_ID = J.Job_ID
GROUP BY J.Job_ID, J.Designation;

-- Each designation uniquely maps to a JOB_ID in this dataset, 
-- even though it is not explicitly defined as UNIQUE in the schema.
-- So we can safely ignore JOB_ID in group by as of now
-- And also Inner Join joins matched rows only, so we can use count(*)
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	J.Designation
FROM EMPLOYEE E
RIGHT JOIN JOB J
ON E.JOB_ID = J.Job_ID
GROUP BY J.Designation
ORDER BY J.Designation;

-- Using Roll up for total number of roles (employees) actively employed
SELECT 
	J.Designation,
	Count(E.EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEE E
RIGHT JOIN JOB J
ON E.JOB_ID = J.Job_ID
GROUP BY ROLLUP (J.Designation);


-- 8. How many employees are working in "New York"?

-- NOTE - Only Department 10 that is Accounting department's location is new york
-- No one is in Accounting department as of now
-- So no one is in working in New York

-- To include New york in answer with 0 count,
-- we should use RIGHT JOIN
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	L.City
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
RIGHT JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
GROUP BY L.City
HAVING L.City = 'New York';

-- using WHERE
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees,
	L.City
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
RIGHT JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York'
GROUP BY L.City;

-- displaying only count
SELECT 
	Count(E.EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
RIGHT JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
GROUP BY L.City
HAVING L.City = 'New York';


-- 9. Display the employee details with salary grades. Use conditional statement to
-- create a grade column.

-- We shall use 2 types of conditional statements
-- IIF And Case
-- Considering A for more than or equal to 2000 salary and B for less than 2000
SELECT *, IIF(SALARY >= 2000, 'A', 'B') AS Salary_Grade FROM EMPLOYEE;

-- case statement - 2 different grade schemes are demonstraded
-- Scheme 1. <1000 as C, 1000 - 2000 as B, >2000 as A (which is else condition)
SELECT 
	*,
	CASE
		WHEN SALARY < 1000 THEN 'C'
		WHEN SALARY BETWEEN 1000 AND 2000 THEN 'B'
		ELSE 'A'
	END AS Salary_Grade
FROM EMPLOYEE;

-- using CTE
WITH Employee_With_Salary_Grade as (
	SELECT *,
		CASE
			WHEN SALARY < 1000 THEN 'C'
			WHEN SALARY BETWEEN 1000 AND 2000 THEN 'B'
			ELSE 'A'
		END AS Salary_Grade
	FROM EMPLOYEE
)
SELECT * from Employee_With_Salary_Grade;

-- (as to fit with Question number 11)
-- Scheme 2. <2000 as C, 2000 - 5000 as B, >5000 as A (which is else condition)
-- Using so that it can be reused in other question
-- NOTE : in this scheme , no employee would be in grade A as of now
CREATE VIEW VW_EMPLOYEE_SALARY_GRADE
AS
(
	SELECT *,
		CASE
			WHEN SALARY < 2000 THEN 'C'
			WHEN SALARY BETWEEN 2000 AND 5000 THEN 'B'
			ELSE 'A'
		END AS Salary_Grade
	FROM EMPLOYEE	
);

-- Answer
SELECT * FROM VW_EMPLOYEE_SALARY_GRADE;

-- Additional implementation
-- If you want to create the salary grade permenently in the Employee table
-- As of now, we do it in a transaction and rollback

BEGIN TRANSACTION
ALTER TABLE Employee
ADD Salary_Grade AS (
	CASE
		WHEN SALARY < 2000 THEN 'C'
		WHEN SALARY BETWEEN 2000 AND 5000 THEN 'B'
		ELSE 'A'
	END
);

-- checking
EXEC SP_HELP Employee;
select * from employee;

-- To keep it permanent in Employee table,
-- Uncomment the below line (COMMIT;) and run. Don't run (ROLLBACK;)
-- COMMIT;

ROLLBACK;

-- checking after rollback
EXEC SP_HELP Employee;
select * from employee;


--  10. List out the number of employees grade wise. Use conditional statement to
-- create a grade column

-- Using CTE 
-- (Using Scheme 1 for grading)
-- <1000 as C, 1000 - 2000 as B, >2000 as A (which is else condition)
WITH Employee_With_Salary_Grade as (
	SELECT *,
		CASE
			WHEN SALARY < 1000 THEN 'C'
			WHEN SALARY BETWEEN 1000 AND 2000 THEN 'B'
			ELSE 'A'
	END AS Salary_Grade
	FROM EMPLOYEE
)
SELECT COUNT(*) AS Number_of_Employees, Salary_Grade 
from Employee_With_Salary_Grade 
group by Salary_Grade
order by Salary_Grade;

-- Using the view we already created
-- (Using Scheme 2 for grading)
-- <2000 as C, 2000 - 5000 as B, >5000 as A (which is else condition)
-- NOTE : in this scheme , no employee would be in grade A as of now
SELECT COUNT(*) AS Number_of_Employees, Salary_Grade
FROM VW_EMPLOYEE_SALARY_GRADE
GROUP BY Salary_Grade
ORDER BY Salary_Grade;

-- Alternative implementation
-- using count of primary key of employee table
-- and order by count
SELECT COUNT(EMPLOYEE_ID) AS Number_of_Employees, Salary_Grade 
FROM VW_EMPLOYEE_SALARY_GRADE
GROUP BY Salary_Grade
ORDER BY Number_of_Employees;


-- 11. Display the employee salary grades and the number ofemployees
-- between 2000 to 5000 range of salary.
-- This question Uses only Scheme 2 for grading
-- <2000 as C, 2000 - 5000 as B, >5000 as A (which is else condition)
-- This is nothing but Question number 10 with a filter for grade B (2000 to 5000 salary)
WITH Employee_With_Salary_Grade as (
	SELECT *,
		CASE
			WHEN SALARY < 2000 THEN 'C'
			WHEN SALARY BETWEEN 2000 AND 5000 THEN 'B'
			ELSE 'A'
	END AS Salary_Grade
	FROM EMPLOYEE
)
SELECT COUNT(*) AS Number_of_Employees, Salary_Grade 
FROM Employee_With_Salary_Grade 
GROUP BY Salary_Grade 
HAVING Salary_Grade = 'B'
ORDER BY Salary_Grade;

-- Using View that we already created
SELECT COUNT(*) AS Number_of_Employees, Salary_Grade 
FROM VW_EMPLOYEE_SALARY_GRADE
GROUP BY Salary_Grade
HAVING Salary_Grade = 'B'
ORDER BY Salary_Grade;

-- using where to filter based on grades
SELECT COUNT(*) AS Number_of_Employees, Salary_Grade 
FROM VW_EMPLOYEE_SALARY_GRADE
WHERE Salary_Grade = 'B'
GROUP BY Salary_Grade
ORDER BY Salary_Grade;

-- Using Primary Key of employee table for count
-- And also directly filtering using the salary column
SELECT COUNT(EMPLOYEE_ID) AS Number_of_Employees, Salary_Grade 
FROM VW_EMPLOYEE_SALARY_GRADE
WHERE SALARY BETWEEN 2000 AND 5000
GROUP BY Salary_Grade
ORDER BY Salary_Grade;


-- Additional implementation
-- (Using Scheme 1 for grading)
-- <1000 as C, 1000 - 2000 as B, >2000 as A (which is else condition)
-- And filtering in where condition using salary column
-- here all the three falling in grade A of grading scheme 1 is counted
WITH Employee_With_Salary_Grade as (
	SELECT *,
		CASE
			WHEN SALARY < 1000 THEN 'C'
			WHEN SALARY BETWEEN 1000 AND 2000 THEN 'B'
			ELSE 'A'
	END AS Salary_Grade
	FROM EMPLOYEE
)
SELECT COUNT(*) AS Number_of_Employees, Salary_Grade 
from Employee_With_Salary_Grade 
WHERE SALARY BETWEEN 2000 AND 5000
group by Salary_Grade
order by Salary_Grade;


-- 12. Display all employees in sales or operation departments.
-- Since we are going to display employees and not counting here
-- inner join would work

-- JOIN is by default INNER JOIN
SELECT 
	E.*,
	D.[Name]
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.[Name] = 'Sales' OR D.[Name] = 'Operations';

-- Displaying names and IDs only and using IN
-- also using inner join with INNER keyword though not needed
SELECT 
	E.EMPLOYEE_ID,
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	D.Department_Id,
	D.[Name]
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.[Name] IN ('Sales', 'Operations');

-- Displaying only Names
SELECT 
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME,
	D.[Name]
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.[Name] = 'Sales' OR D.[Name] = 'Operations';

-- Displaying only Name and Id of emplpyees and usign IN
SELECT 
	E.EMPLOYEE_ID,
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.[Name] IN ('Sales', 'Operations');

-- Displaying only names of employees
SELECT 
	E.LAST_NAME,
	E.FIRST_NAME,
	E.MIDDLE_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.[Name] = 'Sales' OR D.[Name] = 'Operations';
