USE Case_Study2;

--  GROUP BY and HAVING Clause:

-- 1. How many employees are in different departments in the organization?
SELECT COUNT(*) AS Number_of_employees, DEPARTMENT_ID FROM EMPLOYEE GROUP BY DEPARTMENT_ID;


-- 2. List out the department wise maximum salary, minimum salary and
-- average salary of the employees.
SELECT 
	MAX(SALARY) AS Max_Salary, 
	MIN(SALARY) AS Min_Salary,
	AVG(SALARY) AS Avg_Salary,
	DEPARTMENT_ID 
FROM EMPLOYEE 
GROUP BY DEPARTMENT_ID;


-- 3. List out the job wise maximum salary, minimum salary and average
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


-- 5. List out the number of employees for each month and year in
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


-- 6. List out the Department ID having at least four employees.
SELECT 
	COUNT(*) AS Number_of_Employees,
	DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;

-- Primary key can also be used in count but it will be slower than count(*)
SELECT 
	COUNT(EMPLOYEE_ID) AS Number_of_Employees,
	DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) >= 4;

-- Final Answer - to list out only the Department ID
SELECT 
	DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;


-- 7. How many employees joined in the month of January?
-- NOTE : as of now no one joined in January

SELECT 
	COUNT(*) AS Number_of_Employees,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'January';

-- Answer - to display the count only
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'January';

-- Alternative implementation - using where
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
WHERE DATENAME(MONTH, HIRE_DATE) = 'January'
GROUP BY DATENAME(MONTH, HIRE_DATE);

-- The above queries gives no nows.
-- To get 0 as answer we can try
-- Without group by
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
WHERE DATENAME(MONTH, HIRE_DATE) = 'January';

-- Using Case statement
SELECT 
  COUNT(CASE WHEN MONTH(HIRE_DATE) = 1 THEN 1 END) AS JANUARY_EMPLOYEES
FROM EMPLOYEE;

-- Additional implementation, also using Year to group by
-- The following will display the number of employees joined in January in each year
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATEPART(YEAR, HIRE_DATE) as Joining_year
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'January';


-- 8. How many employees joined in the month of January or September
-- NOTE : as of now no one joined in January or September
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'January' OR DATENAME(MONTH, HIRE_DATE) = 'September';

-- Answer - to display the count only
-- Using Month Number
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE)
HAVING DATEPART(MONTH, HIRE_DATE) = 1 OR DATEPART(MONTH, HIRE_DATE) = 9; 

-- Using Month Name 
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'January' OR DATENAME(MONTH, HIRE_DATE) = 'September';

-- Alternative implementation - using where
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
WHERE DATENAME(MONTH, HIRE_DATE) = 'January' OR DATENAME(MONTH, HIRE_DATE) = 'September'
GROUP BY DATENAME(MONTH, HIRE_DATE);

-- The above queries gives no nows.
-- To get 0 as answer we can try
-- Without group by
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
WHERE DATENAME(MONTH, HIRE_DATE) = 'January' OR DATENAME(MONTH, HIRE_DATE) = 'September';

-- Using Case statement
SELECT 
	COUNT(
		CASE 
			WHEN MONTH(HIRE_DATE) = 1 THEN 1 
			WHEN MONTH(HIRE_DATE) = 9 THEN 1 
		END
	) AS JANUARY_EMPLOYEES
FROM EMPLOYEE;


-- Additional implementation, also using Year to group by
-- The following will display the number of employees joined in January or September in each year
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE), DATENAME(MONTH, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'January' OR DATENAME(MONTH, HIRE_DATE) = 'September';


-- 9. How many employees joined in 1985?
-- NOTE : In the table in Question paper, Allen's Hire date given as 20-Feb-85
-- But in the insert statement it is given as 20-FEB-84
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(YEAR, HIRE_DATE) = 1985;

-- Answer - to display the count only
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(YEAR, HIRE_DATE) = 1985;

-- Alternative implementation - using where
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985
GROUP BY DATEPART(YEAR, HIRE_DATE);
 

-- 10. How many employees joined each month in 1985?
 SELECT 
	COUNT(*) AS Number_of_Employees,
	DATEPART(MONTH, HIRE_DATE) AS Joining_Month,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(YEAR, HIRE_DATE) = 1985;

-- Answer - to display the count month wise without year displayed
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATEPART(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(YEAR, HIRE_DATE) = 1985;

-- For more readability, Using Month Name
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(YEAR, HIRE_DATE) = 1985;

-- Order by Month number but display month name
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE), DATENAME(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(YEAR, HIRE_DATE) = 1985
ORDER BY DATEPART(MONTH, HIRE_DATE);


-- 11. How many employees joined in March 1985?
-- NOTE: No one joined in March 1985 as of now

-- Using Month number
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATEPART(MONTH, HIRE_DATE) AS Joining_Month,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(MONTH, HIRE_DATE) = 3 AND DATEPART(YEAR, HIRE_DATE) = 1985;

-- Using Month Name
SELECT 
	COUNT(*) AS Number_of_Employees,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'March' AND DATEPART(YEAR, HIRE_DATE) = 1985;

-- Answer - Display the count only
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY DATENAME(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'March' AND DATEPART(YEAR, HIRE_DATE) = 1985;

-- The above queries gives no nows.
-- To get 0 as answer we can try
-- Without group by
SELECT 
	COUNT(*) AS Number_of_Employees
FROM EMPLOYEE
WHERE DATENAME(MONTH, HIRE_DATE) = 'March' AND DATEPART(YEAR, HIRE_DATE) = 1985;

-- Using Case statement
SELECT 
	COUNT(
		CASE 
			WHEN MONTH(HIRE_DATE) = 3 THEN 1 
		END
	) AS JANUARY_EMPLOYEES
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985;


-- 12. Which is the Department ID having greater than or equal to 3 employees
-- joining in April 1985?

-- NOTE: As of now, there is no department with >= 3 employees joining April 1985

SELECT 
	COUNT(*) AS Number_of_Employees,
	DEPARTMENT_ID,
	DATEPART(MONTH, HIRE_DATE) AS Joining_Month,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID, DATEPART(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATEPART(MONTH, HIRE_DATE) = 4 AND DATEPART(YEAR, HIRE_DATE) = 1985 AND COUNT(*) >= 3;

-- Using Month Name
SELECT 
	COUNT(*) AS Number_of_Employees,
	DEPARTMENT_ID,
	DATENAME(MONTH, HIRE_DATE) AS Joining_Month,
	DATEPART(YEAR, HIRE_DATE) AS Joining_Year
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID, DATENAME(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'April' AND DATEPART(YEAR, HIRE_DATE) = 1985 AND COUNT(*) >= 3;

-- Answer - Display the DEPARTMENT ID
SELECT 
	DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID, DATENAME(MONTH, HIRE_DATE), DATEPART(YEAR, HIRE_DATE)
HAVING DATENAME(MONTH, HIRE_DATE) = 'April' AND DATEPART(YEAR, HIRE_DATE) = 1985 AND COUNT(*) >= 3;