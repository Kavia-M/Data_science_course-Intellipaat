USE Case_Study2;

-- SET Operators:

-- Writing a Table valued function
-- Since lisiting job is common task in SET operators section
-- NOTE: Currently no employee is working in Accounting Department

CREATE FUNCTION FN_JOBS_IN_DEPARTMENT
(
	@DEPARTMENT_NAME VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		J.Job_ID AS JOB_ID,
		J.Designation AS DESIGNATION
	FROM EMPLOYEE E
	JOIN DEPARTMENT D
	ON E.DEPARTMENT_ID = D.Department_Id
	JOIN JOB J
	ON E.JOB_ID = J.Job_ID
	WHERE D.[Name] = @DEPARTMENT_NAME
);

-- 1. List out the distinct jobs in sales and accounting departments.
-- Union without duplicates
SELECT 
	J.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON E.JOB_ID = J.Job_ID
WHERE D.[Name] = 'Sales'
UNION
SELECT 
	J.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON E.JOB_ID = J.Job_ID
WHERE D.[Name] = 'Accounting';

-- Using The TVF
SELECT * FROM dbo.FN_JOBS_IN_DEPARTMENT('Sales')
UNION
SELECT * FROM dbo.FN_JOBS_IN_DEPARTMENT('Accounting');

-- Lising only Designation
SELECT DESIGNATION FROM dbo.FN_JOBS_IN_DEPARTMENT('Sales')
UNION
SELECT DESIGNATION FROM dbo.FN_JOBS_IN_DEPARTMENT('Accounting');


-- 2. List out all the jobs in sales and accounting departments.
-- Use Union all to list all jobs including duplicates
SELECT 
	J.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON E.JOB_ID = J.Job_ID
WHERE D.[Name] = 'Sales'
UNION ALL
SELECT 
	J.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON E.JOB_ID = J.Job_ID
WHERE D.[Name] = 'Accounting';

-- Using The TVF
SELECT * FROM dbo.FN_JOBS_IN_DEPARTMENT('Sales')
UNION ALL
SELECT * FROM dbo.FN_JOBS_IN_DEPARTMENT('Accounting');

-- Lising only Designation
SELECT DESIGNATION FROM dbo.FN_JOBS_IN_DEPARTMENT('Sales')
UNION ALL
SELECT DESIGNATION FROM dbo.FN_JOBS_IN_DEPARTMENT('Accounting');


-- 3. List out the common jobs in research and accounting
-- departments in ascending order.

-- Intersect is used to list common jobs
-- Ascending order of job_id
SELECT 
	J.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON E.JOB_ID = J.Job_ID
WHERE D.[Name] = 'Research'
INTERSECT
SELECT 
	J.*
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN JOB J
ON E.JOB_ID = J.Job_ID
WHERE D.[Name] = 'Accounting'
ORDER BY J.Job_ID;

-- Using The TVF and ascending order of designation
SELECT * FROM dbo.FN_JOBS_IN_DEPARTMENT('Research')
INTERSECT
SELECT * FROM dbo.FN_JOBS_IN_DEPARTMENT('Accounting')
ORDER BY DESIGNATION ASC;

-- Lising only Designation
SELECT DESIGNATION FROM dbo.FN_JOBS_IN_DEPARTMENT('Research')
INTERSECT
SELECT DESIGNATION FROM dbo.FN_JOBS_IN_DEPARTMENT('Accounting')
ORDER BY DESIGNATION;


--Subqueries:

-- 1. Display the employees list who got the maximum salary

SELECT * 
FROM EMPLOYEE 
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

-- Display only names and Id
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME 
FROM EMPLOYEE 
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);


-- 2. Display the employees who are working in the sales department,
SELECT * 
FROM EMPLOYEE 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE [Name] = 'Sales');

-- Display only names and Id
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME 
FROM EMPLOYEE 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE [Name] = 'Sales');


--  3. Display the employees who are working as 'Clerk'
SELECT * 
FROM EMPLOYEE 
WHERE JOB_ID = (SELECT Job_ID FROM JOB WHERE Designation = 'Clerk');

-- Display only names and Id
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME 
FROM EMPLOYEE 
WHERE JOB_ID = (SELECT Job_ID FROM JOB WHERE Designation = 'Clerk');


-- 4. Display the list of employees who are living in "New York".

--Without subqueries also this is achievable, 
-- But this not what is asked in this session
-- Using inner join to avoid null to employee details in result
SELECT * 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPARTMENT_ID = D.Department_Id
JOIN [LOCATION] L
ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

-- Using 3 layered nested subquery
-- though city is uniquely mapped to 1 location id in our table,
-- unique constraint is not explicitly given in city column
-- so using IN instead of =
SELECT * 
FROM EMPLOYEE 
WHERE DEPARTMENT_ID IN (
	SELECT DEPARTMENT_ID
	FROM DEPARTMENT
	WHERE Location_Id IN (
		SELECT Location_Id
		FROM [LOCATION]
		WHERE City = 'New York'
	)
);

-- By using = for location id 
-- since our data has only one location_id for a city
-- though not mentioned as UNIQUE constraint explicitly,
-- our data has city mapping to only one location_id
SELECT * 
FROM EMPLOYEE 
WHERE DEPARTMENT_ID IN (
	SELECT DEPARTMENT_ID
	FROM DEPARTMENT
	WHERE Location_Id IN (
		SELECT Location_Id
		FROM [LOCATION]
		WHERE City = 'New York'
	)
);


-- Display only names and Id and using join only in subquery
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME 
FROM EMPLOYEE 
WHERE DEPARTMENT_ID IN (
	SELECT D.Department_Id
	FROM DEPARTMENT D
	JOIN [LOCATION] L
	ON D.Location_Id = L.Location_ID
	WHERE L.City = 'New York'
);


-- 5. Find out the number of employees working in the sales department

-- Instead of using Primary Key in count, count(*) is used since it is fast
-- Even though, name in department is uniquely mapped to exactly one id,
-- still no unique constraint is emplicity given,
-- so we are using IN instead of =
SELECT COUNT(*) AS Number_of_employees
FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (
	SELECT DEPARTMENT_ID 
	FROM DEPARTMENT
	WHERE [Name] = 'Sales'
);

-- Data specific - since in our data, each name of department uniquely maps to one id
-- we can use =
-- also we can try using Primary key of employee table in count
SELECT COUNT(EMPLOYEE_ID) AS Number_of_employees
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (
	SELECT DEPARTMENT_ID 
	FROM DEPARTMENT
	WHERE [Name] = 'Sales'
);


-- 6. Update the salaries of employees who are working as clerks on the basisof
-- 10%
-- NOTE: DML commands auto commit so no need o use transaction
-- Knowing that each designation maps to unique JOB_ID
UPDATE EMPLOYEE
SET SALARY = (SALARY + (SALARY * 0.10))
WHERE JOB_ID = (
	SELECT Job_ID FROM JOB WHERE Designation = 'Clerk'
);

-- Checking
SELECT * FROM EMPLOYEE;

-- Checking with another kind of query using transaction and rollback
-- Here we use IN because designation does not have explicit UNIQUE constraint
-- Considering the chances that Clerk could have been mapped to more than one JOB_ID also
BEGIN TRANSACTION Update_Clerk_Salary
UPDATE EMPLOYEE
SET SALARY = (SALARY + (SALARY * 0.10))
WHERE JOB_ID IN (
	SELECT Job_ID FROM JOB WHERE Designation = 'Clerk'
);

-- Checking
SELECT * FROM EMPLOYEE;

-- Rollback this transaction (with name) since we already updated in above statement
ROLLBACK TRANSACTION Update_Clerk_Salary;
-- Checking after rollback
SELECT * FROM EMPLOYEE;


-- 7. Delete the employees who are working in the accounting department.
-- Last Question we tried without BEGIN transaction
-- Now we shall try using begin transaction and commit
-- Without transaction name

-- NOTE: as of now nobody is working in accounting department
BEGIN TRANSACTION
DELETE
FROM EMPLOYEE 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE [Name] = 'Accounting');

COMMIT;


-- 8. Display the second highest salary drawing employee details.
SELECT *
FROM EMPLOYEE E1
WHERE SALARY = (
	SELECT MAX(SALARY)
	FROM EMPLOYEE E2
	WHERE NOT SALARY = (
		SELECT MAX(SALARY) 
		FROM EMPLOYEE E3
	)
);

-- Since this is non correlated subquery we need not use table alias
-- and using <> for more readability
SELECT *
FROM EMPLOYEE
WHERE SALARY = (
	SELECT MAX(SALARY)
	FROM EMPLOYEE
	WHERE SALARY <> (
		SELECT MAX(SALARY) 
		FROM EMPLOYEE
	)
);

-- Another safe method
SELECT *
FROM EMPLOYEE
WHERE SALARY = (
	SELECT MAX(SALARY)
	FROM EMPLOYEE
	WHERE SALARY < (
		SELECT MAX(SALARY) 
		FROM EMPLOYEE
	)
);

-- Using the method taught in class
SELECT * 
FROM EMPLOYEE 
WHERE SALARY = (
	SELECT MIN(SALARY)
	FROM (
		SELECT TOP 2 * FROM EMPLOYEE ORDER BY SALARY DESC
	) AS T2
);


-- The above won't work if maximum value has duplicates
-- To get the details of all employees who get exactly the 2nd highest
-- it returns rows with that salary

-- NOTE: if 2nd maximum not available, all the rows have maximum means,
-- in that case it will give MAXIMUM salary results (EXCEPTIONAL CASE)
-- Meaning only one distinct salary is there means, 
SELECT * 
FROM EMPLOYEE 
WHERE SALARY = (
	SELECT MIN(SALARY)
	FROM (
		SELECT DISTINCT TOP 2 SALARY FROM EMPLOYEE ORDER BY SALARY DESC
	) AS Employees_With_Top_2_salaries
);

-- NOTE: using ROW number would not give correct result if maximum salary occurs more than once
-- So, DENSE_RANK() should be used
-- Here is 2nd maximum salary is not available it won't return any rows
SELECT *
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY SALARY DESC) AS rank_number
    FROM EMPLOYEE
) AS Employee_with_salary_rank
WHERE rank_number = 2;


-- 9. Display the nth highest salary drawing employee details.

-- Using TOP
-- I have created a stored procedure since N is a variable here
-- ( ) for @N is needed near TOP, that is TOP (@N)
-- NOTE : If N is greater than total number of distinct rows,
-- then it returns rows with LEAST AVAILABLE SALARY 
CREATE PROC USP_Nth_Highest_Salaried_Employee_Using_Top
@N INT
AS
(
	SELECT * 
	FROM EMPLOYEE 
	WHERE SALARY = (
	SELECT MIN(SALARY)
	FROM (
		SELECT DISTINCT TOP (@N) SALARY FROM EMPLOYEE ORDER BY SALARY DESC
	) AS Employees_With_Top_N_salaries
	)
);

-- checking, in our table 6 distinct salaries available as of now
EXEC USP_Nth_Highest_Salaried_Employee_Using_Top 5;
USP_Nth_Highest_Salaried_Employee_Using_Top 4;
EXEC USP_Nth_Highest_Salaried_Employee_Using_Top @N = 6;
-- but if we pass N greater than 6,
-- it returns 6th maximum salary which is the LEAST AVAILABLE SALARY
EXEC USP_Nth_Highest_Salaried_Employee_Using_Top 7;
EXEC USP_Nth_Highest_Salaried_Employee_Using_Top @N = 8;


-- using dense rank 
-- NOTE: here if N is greater than total number of distinct rows,
-- it won't return any rows
CREATE PROCEDURE USP_Nth_Highest_Salaried_Employee_Using_Dense_Rank
@N INT
AS
(
	SELECT *
	FROM (
		SELECT *, DENSE_RANK() OVER (ORDER BY SALARY DESC) AS rank_number
		FROM EMPLOYEE
	) AS Employee_with_salary_rank
	WHERE rank_number = @N
);

-- checking
select * from EMPLOYEE order by salary desc;
EXEC USP_Nth_Highest_Salaried_Employee_Using_Dense_Rank 5;
-- if N is greater than 6, then no rows returned
EXEC USP_Nth_Highest_Salaried_Employee_Using_Dense_Rank 8;


--  10. List out the employees who earn more than every employee in department 30.
-- It simply means to select employees who earn more than the maximum salary in department 30
-- So, obviously it would be from other departments only
-- Currently there is no such employee, because the overall maximum salary falls in department 30

-- Simple and effective statement
SELECT * 
FROM EMPLOYEE
WHERE SALARY > (
	SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = 30
);

-- Select Id and Names only
SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME 
FROM EMPLOYEE
WHERE SALARY > (
	SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = 30
);

-- Check against each of the salary in department 30
-- > ALL compares to every element in SET 
-- only if all elements satisfy, it returns true
SELECT * 
FROM EMPLOYEE
WHERE SALARY > ALL (
	SELECT SALARY FROM EMPLOYEE WHERE DEPARTMENT_ID = 30
);

-- Correlated sub queries using NOT EXISTS
-- it checks NOT EXISTS of dept 30 and E1.salary <= E2.salary
-- means if there is no <= means obviously it is > ALL of dept 30 salaries
SELECT *
FROM EMPLOYEE E1
WHERE NOT EXISTS (
	SELECT 1
	FROM EMPLOYEE E2
	WHERE E2.DEPARTMENT_ID = 30 AND E1.SALARY <= E2.SALARY
);

-- Actually the subquery no need alias
-- And here we select Salary in subquery
-- Actually selecting any column or columns or even constants would work
-- And selecting only names in outer query
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME
FROM EMPLOYEE E1
WHERE NOT EXISTS (
	SELECT SALARY
	FROM EMPLOYEE
	WHERE DEPARTMENT_ID = 30 AND E1.SALARY <= SALARY
);


-- 11. List out the employees who earn more than the lowest salary in
-- department. Find out whose department has no employees

-- First part of the question
-- List out the employees who earn more than the lowest salary in
-- department.

-- Simple and effective
-- select employees who earn more than minimum salary in their department
SELECT * 
FROM EMPLOYEE E1
WHERE SALARY > (
	SELECT MIN(SALARY) FROM EMPLOYEE E2 WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);

-- select ID and names
SELECT E1.EMPLOYEE_ID, E1.LAST_NAME, E1.FIRST_NAME, E1.MIDDLE_NAME 
FROM EMPLOYEE E1
WHERE SALARY > (
	SELECT MIN(SALARY) FROM EMPLOYEE E2 WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);

-- select if there is any employee in their department earning less than them
-- so that they are not earning the least salary in department
-- that is earning more than the lowest salary in their respestive department
SELECT * 
FROM EMPLOYEE E1
WHERE SALARY > ANY (
	SELECT SALARY FROM EMPLOYEE E2 WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);

-- Using exists to check if there is anyone in the department earning less than them
SELECT *
FROM EMPLOYEE E1
WHERE EXISTS (
	SELECT 1
	FROM EMPLOYEE  E2
	WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID AND E2.SALARY < E1.SALARY
);

-- selecting salary in subquery
SELECT *
FROM EMPLOYEE E1
WHERE EXISTS (
	SELECT SALARY
	FROM EMPLOYEE  E2
	WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID AND E2.SALARY < E1.SALARY
);
-- Selecting only names
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME
FROM EMPLOYEE E1
WHERE EXISTS (
	SELECT SALARY
	FROM EMPLOYEE  E2
	WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID AND E2.SALARY < E1.SALARY
);


-- Second part of the question
-- Find out whose department has no employees

-- Without alias name for tables
SELECT * FROM DEPARTMENT
WHERE (SELECT COUNT(*) FROM EMPLOYEE WHERE Department_Id = DEPARTMENT.Department_Id) = 0;


-- 12. Find out which department has no employees.

-- Selecting only department Id and name
-- using table alias
SELECT 
	Department_Id, 
	[Name] 
FROM DEPARTMENT D
WHERE (
	SELECT 
		COUNT(*) 
	FROM EMPLOYEE E 
	WHERE E.Department_Id = D.Department_Id
) = 0;

-- Using NOT exists
-- Selecting only Department name
SELECT 
	[Name] 
FROM DEPARTMENT D
WHERE NOT EXISTS (
	SELECT 
		1 
	FROM EMPLOYEE E 
	WHERE E.Department_Id = D.Department_Id
);

-- Selecting all columns in subquery
-- selecting department ID and name in outer query
SELECT 
	Department_Id, 
	[Name] 
FROM DEPARTMENT D
WHERE NOT EXISTS (
	SELECT 
		* 
	FROM EMPLOYEE E 
	WHERE E.Department_Id = D.Department_Id
);


--13. Find out the employees who earn greater than the average salary for
-- their department.
SELECT *
FROM EMPLOYEE E1
WHERE E1.Salary > (
	SELECT AVG(E2.Salary)
    FROM EMPLOYEE E2
	WHERE  E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);

-- selecting only ID and Names
SELECT E1.EMPLOYEE_ID, E1.LAST_NAME, E1.FIRST_NAME, E1.MIDDLE_NAME
FROM EMPLOYEE E1
WHERE E1.Salary > (
	SELECT AVG(E2.Salary)
    FROM EMPLOYEE E2
	WHERE  E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);

-- selecting only Names
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME
FROM EMPLOYEE E1
WHERE E1.Salary > (
	SELECT AVG(E2.Salary)
    FROM EMPLOYEE E2
	WHERE  E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);