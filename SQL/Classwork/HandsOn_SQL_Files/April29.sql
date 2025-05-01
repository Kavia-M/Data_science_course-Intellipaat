create database apr29th;
use apr29th;
CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50)
);
INSERT INTO Location (Location_ID, City) VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');
CREATE TABLE Department (
    Department_Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Location_Id INT,
    FOREIGN KEY (Location_Id) REFERENCES Location(Location_ID)
);
INSERT INTO Department (Department_Id, Name, Location_Id) VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);
CREATE TABLE Job (
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(50)
);
INSERT INTO Job (Job_ID, Designation) VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');
CREATE TABLE Employee (
    Employee_Id INT PRIMARY KEY,
    Last_Name VARCHAR(50),
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Job_Id INT,
    Hire_Date DATE,
    Salary DECIMAL(10, 2),
    Comm DECIMAL(10, 2),
    Department_Id INT,
    FOREIGN KEY (Job_Id) REFERENCES Job(Job_ID),
    FOREIGN KEY (Department_Id) REFERENCES Department(Department_Id)
);
INSERT INTO Employee (Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Comm, Department_Id) VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 30);

select * from Location;
select * from Department;
select * from Job;
select * from Employee;

                                -- Simple Queries --
--1. List all the employee details.
--2. List all the department details.
--3. List all job details.
--4. List all the locations.

-- List all the employee details.
select * from Employee;

-- List all the department details.
select * from Department;

-- List all job details.
select * from Job;

-- List all the locations.
select * from Location;

------------- 30th April -----------------------

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select First_Name, Last_Name, Salary, Comm from Employee;

--6. List out the Employee ID, Last Name, Department ID for all employees and
--alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select Employee_Id as 'ID of the Employee', Last_Name as 'Name of the Employee', Department_Id as 'Dep_id'
from Employee;

-- trainer's answer
select Employee_Id as ID_of_the_Employee, Last_Name as Name_of_the_Employee, Department_Id as Dep_id
from Employee;

-- suggestion to use  []
select Employee_Id as [ID of the Employee], Last_Name as [Name of the Employee], Department_Id as [Dep_id]
from Employee;


--7. List out the annual salary of the employees with their names only.
select Last_name, 12*Salary as annual_salary from Employee;

-- trainer's answer - select first and last names since they asked names
select First_Name,Last_Name,(Salary*12) as Annual_Salary from Employee;


--------------------------- trainer's answers ------------------------
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select First_Name,Last_Name,Salary,Comm from Employee;
--6. List out the Employee ID, Last Name, Department ID for all employees and
--alias Em-ployee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select Employee_Id as ID_of_the_Employee,Last_Name as name_of_employee ,Department_Id as dep_id from Employee;
--7. List out the annual salary of the employees with their names only.
select First_Name,Last_Name,(Salary*12) as Annual_Salary from Employee;
--------------------------------------------------------------------------

                                        -- Where condition --
--1. List the details about "Smith".
select * from Employee where Last_Name = 'Smith';

--2. List out the employees who are working in department 20.
select * from Employee where Department_Id = 20;

--3. List out the employees who are earning salary between 2000 and 3000.
select * from Employee where Salary between 2000 and 3000;

--4. List out the employees who are working in department 10 or 20.
select * from Employee where Department_Id in (10, 20);
-- or --
select * from Employee where Department_Id = 10 or Department_Id = 20;

--5.- Find out the employees who are not working in department 10 or 30.
select * from Employee where Department_Id not in (10, 30);
-- or --
select * from Employee where not (Department_Id = 10 or Department_Id = 30);
-- or --
select * from Employee where not Department_Id = 10 and not Department_Id = 30;

--6. List out the employees whose name starts with 'L
select * from Employee where First_Name like 'L%';

--7. List out the employees whose name starts with 'L' and ends with 'E'.
select * from Employee where First_Name like 'L%' and First_Name like '%E';
-- trainer's answer
select * from Employee where First_Name like 'L%E';

--8. List out the employees whose name length is 4 and start with 'J'.
select * from Employee where LEN(First_Name) = 4 and First_Name like 'J%';
-- trainer's answer
select * from Employee where First_Name like 'J___';

--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
select * from Employee where Department_Id = 30 and Salary > 2500;

--10. List out the employees who are not receiving commission.
select * from Employee where Comm is null;

-- Arijit De's answer
SELECT * FROM EMPLOYEE
WHERE COMM = 0 OR COMM IS NULL;


										-- Order by  ---

--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
select Employee_Id, Last_Name from Employee order by Employee_Id;
select Employee_Id, Last_Name from Employee order by Employee_Id ASC;

--2. List out the Employee ID and Name in descending order based on salary.
select Employee_Id, First_Name, Last_Name from Employee order by Salary DESC;

--3. List out the employee details according to their Last Name in ascending-order.
select * from Employee order by Last_Name;

--4. List out the employee details according to their Last Name in ascending order and 
--then Department ID in descending order.
select * from Employee order by Last_Name, Department_Id DESC;

-- trainer's suggestion ASC to be used for proper manner even though above will work
select * from Employee order by Last_Name ASC, Department_Id DESC;


										-- Group by and Having  ---

--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
select max(salary) as max_salary, min(salary) as min_salary, avg(salary) as avg_salary
from Employee
group by Department_Id;

-- trainer's answer
select Department_Id,MAX(Salary) as max_sal,min(Salary) as min_sal,AVG(Salary) as avg_sal from Employee
group by Department_Id;


--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
select Job_Id, MAX(Salary) as max_sal,min(Salary) as min_sal,AVG(Salary) as avg_sal from Employee
group by Job_Id;

--3. List out the number of employees who joined each month in ascending order.
select DATENAME(MONTH, Hire_Date) as joining_month, count(*) as number_of_employees
from Employee
group by DATENAME(MONTH, Hire_Date)
order by joining_month;

-- to group using each month in each year
select DATEPART(YEAR, Hire_Date) as joining_year, DATEPART(MONTH, Hire_Date) as joining_month, count(*) as number_of_employees
from Employee
group by DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
order by joining_year, joining_month;

-- trainer's answer 
-- No need to consider year as they did not ask about year
-- already it is in ascending order
-- if want we can use order by
select MONTH(Hire_Date),COUNT(*) as c_emp from Employee
group by MONTH(Hire_Date);


									------ May 1 ------

-- yesterday's last question, add order by - trainer added today
select MONTH(Hire_Date),COUNT(*) as c_emp from Employee
group by MONTH(Hire_Date)
order by MONTH(Hire_Date);

--4. List out the number of employees for each month and year in ascending order--based on the year and month.select DATEPART(YEAR, Hire_Date) as joining_year, DATEPART(MONTH, Hire_Date) as joining_month, count(*) as number_of_employees
from Employee
group by DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
order by joining_year, joining_month;-- Using Year and month methods-- The below works although different functions are used in select and group by-- YEAR and DATEPART(YEAR,   both extract same data that is year from hire_date.-- Hire_date also same coumn used-- so it works properlyselect Year(Hire_Date) as joining_year, Month(Hire_Date) as joining_month, count(*) as number_of_employees
from Employee
group by DATEPART(YEAR, Hire_Date), DATEPART(MONTH, Hire_Date)
order by joining_year, joining_month;-- Trainer's answerselect YEAR(Hire_Date) as year_hd,MONTH(Hire_Date) as month_hd,COUNT(*) as c_emp from Employeegroup by YEAR(Hire_Date),MONTH(Hire_Date)order by YEAR(Hire_Date),MONTH(Hire_Date);--5. List out the Department ID having at least four employees.select Department_Id, COUNT(*) as [numberof employees]from Employeegroup by Department_Idhaving count(*) >= 4;--6. How many employees joined in February month.select DATENAME(Month, Hire_Date) as [joining month], count(*) as [numberof employees]from Employeegroup by DATENAME(Month, Hire_Date)having DATENAME(Month, Hire_Date) = 'February';-- where also can be used for a group by columnselect DATENAME(Month, Hire_Date) as [joining month], count(*) as [numberof employees]from Employeewhere DATENAME(Month, Hire_Date) = 'February'group by DATENAME(Month, Hire_Date);-- Trainer's answerselect MONTH(Hire_Date),COUNT(*) as c_emp from Employee
where MONTH(Hire_Date) = 2
group by MONTH(Hire_Date);

-- Without Group by also we can achieve the result
-- but we can't select month in select statement
select COUNT(*) as c_emp from Employee
where MONTH(Hire_Date) = 2;
--7. How many employees joined in May or June month.select DATENAME(Month, Hire_Date) as [joining month], count(*) as [number of employees]from Employeewhere DATENAME(Month, Hire_Date) in ('May', 'June')group by DATENAME(Month, Hire_Date);-- to get total number which is 2select count(*) as total_count_may_or_june_joining from Employeewhere DATENAME(Month, Hire_Date) in ('May', 'June');--8. How many employees joined in 1985?select YEAR(Hire_Date),COUNT(*) as c_emp from Employee
WHERE YEAR(Hire_Date) = 1985
group by YEAR(Hire_Date);

-- trainer's answer no need group by 
select COUNT(*) as c_emp from Employee
WHERE YEAR(Hire_Date) = 1985;


--9. How many employees joined each month in 1985?-- each month, GROUP BY is necessaryselect MONTH(Hire_Date),COUNT(*) as c_emp from Employee
WHERE YEAR(Hire_Date) = 1985
group by MONTH(Hire_Date);-- Trainer's answerselect month(Hire_Date) as month_hd,COUNT(*) as no_of_emp from Employeewhere YEAR(Hire_Date)=1985group by MONTH(Hire_Date);--10. How many employees were joined in April 1985?select COUNT(*) as c_emp from Employee
WHERE YEAR(Hire_Date) = 1985 and MONTH(Hire_Date) = 4;

-- using month name directly
select COUNT(*) as c_emp from Employee
WHERE YEAR(Hire_Date) = 1985 and DATENAME(MONTH, Hire_Date) = 'April';

-- Trainer's answer
select COUNT(*) as no_of_emp from Employeewhere MONTH(Hire_Date)=4 and YEAR(Hire_Date)=1985;-- 11. Which is the Department ID having -- greater than or equal to 3 employees joining in April 1985?select Department_Id, count(*) as [no. of employees]from Employeewhere MONTH(Hire_Date)=4 and YEAR(Hire_Date)=1985group by Department_Idhaving count(*) >= 3;-- trainer's answerselect Department_Id,count(*) as no_of_emp from Employeewhere MONTH(Hire_Date)=4 and YEAR(Hire_Date)=1985group by Department_Idhaving COUNT(*)>=3;										--- Joins ---select * from Job;select * from Location; -- needs to join 3 tables (Emp, Dept, Location)select * from Employee; --- is like dimension table (main table) -- from which we can connect to other tablesselect * from Department;--1. List out employees with their department names.select *from Employeejoin Departmenton Employee.Department_Id = Department.Department_Id;-- trainer used inner join--2. Display employees with their designations.select *from Employeejoin Jobon Employee.Job_Id = Job.Job_ID;-- trainer used inner join--3. Display the employees with their department names and city.select *from Employeeinner join Departmenton Employee.Department_Id = Department.Department_Idinner join Locationon Department.Location_Id = Location.Location_ID;-- trainer's answerselect * from Employeejoin Departmenton Employee.Department_Id=Department.Department_Idjoin Locationon Department.Location_Id=Location.Location_ID;
--4. How many employees are working in different departments? -- Display with department names.-- right join is used to display 0 count as well-- in our case, department name is mapped to only one unique department Id,-- but in other data, -- if name is mapped to more than one department ID,-- then should we group by DEPARTMENT_ID, NAME ???-- answer from trainer -- YES, you can do like that alsoselect Department.Name, count(Employee_Id) as [no of employees]from Employeeright join Departmenton Employee.Department_Id = Department.Department_Idgroup by Department.Name;-- Trainer's answer- they took dept as left and emp as right -- and did left join--5. How many employees are working in the sales department?select count(Employee_Id) as [no of employees]from Employeeright join Departmenton Employee.Department_Id = Department.Department_Idwhere Department.Name = 'Sales';-- to see sales in dept name column in output,-- use group by--6. Which is the department having greater than or equal to 3 employees and --display the department names in ascending order.select Name, count(Employee_Id)from Department left join Employeeon Department.Department_Id = Employee.Department_Idgroup by Namehaving count(Employee_Id) >=3order by Name;-- trainer's answer-- no need left join or right join here-- since we are not selecting 0 count hereselect Name,COUNT(*) as no_of_emp from Departmentinner join Employeeon Department.Department_Id=Employee.Department_Idgroup by Namehaving COUNT(*)>=3order by Name;--7. How many employees are working in 'Dallas'?-- Safe handling , incase if there is 0 employees in Dallasselect count(Employee_Id) as no_of_employees from Employeeright join Departmenton Employee.Department_Id=Department.Department_Idright join Locationon Department.Location_Id=Location.Location_IDwhere City = 'Dallas';-- Trainer's answer-- When there is nothing type mentioned,-- Use inner join-- if inner join is failing, use other joins-- But inner join is most preferredselect count(*) as count_emp from Employeejoin Departmenton Employee.Department_Id=Department.Department_Idjoin Locationon Department.Location_Id=Location.Location_IDwhere City='Dallas';--8. Display all employees in sales or operation departments.select * from Department;-- NOTE: Operations is the name in department tableselect * from Employeeinner join Departmenton Employee.Department_Id = Department.Department_Idwhere Name in ('Sales', 'Operations');-- Trainer's answerselect  * from Departmentinner join Employeeon Department.Department_Id=Employee.Department_Idwhere Name in ('Sales','Operations');