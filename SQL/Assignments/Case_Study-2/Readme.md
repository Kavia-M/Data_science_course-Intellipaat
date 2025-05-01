# SQL Case Study 2  

## Problem Statement  
As a database administrator, you need to analyze **employee, department, job, and location data** to answer key business questions. You will use SQL queries to extract insights related to **employee salaries, hiring trends, department distributions, and job roles**. The dataset provides structured information about employees, their roles, and organizational locations.

---

## Dataset  
The **case study** consists of four key tables:
- Location Table (Geographical Data)  
- Department Table (Department Details)  
- Job Table (Job Roles)  
- Employee Table (Employee Details)  

Detailed **table descriptions explaining the columns**, along with **complete records presented in table format**, are provided in the `Database_Schema_and_Records.md` file located in this folder.

Additionally, the `Tables_Creation_and_Records_Insertion.txt` file contains ready-to-use **SQL statements** for creating the tables and inserting all the records.

---

## Folder & File Breakdown 
- `Case_Study-2_GroupBy_Having.sql` – Contains answers for the section `GROUP BY and HAVING Clause`.  
- `Case_Study-2_Joins.sql` – Contains answers for the section `Joins`.  
- `Case_Study-2_SetOperators_Subqueries.sql` – Contains answers for the sections `SET Operators` and `Subqueries`.  
- `Case_Study-2_SimpleQueries_WhereCondition_OrderBy.sql` – Contains answers for the sections `Simple Queries`, `WHERE Condition`, and `ORDER BY Clause`.  
- `Database_Schema_and_Records.md` – Describes all **tables** and **data records** used in the case study.  
- `Tables_Creation_and_Records_Insertion.txt` – SQL script for **table creation and inserting records**.  
- `README.md` – Comprehensive documentation detailing **Case Study 2** including the project structure, SQL File Organization and Tasks.

---

## Tasks to be Performed  

### **Simple Queries**  
1. List all **employee details**.  
2. List all **department details**.  
3. List all **job details**.  
4. List all **locations**.  
5. Retrieve **First Name, Last Name, Salary, and Commission** for all employees.  
6. Display **Employee ID, Last Name, and Department ID**, using aliases.  
7. Calculate the **annual salary** of employees.  

### **WHERE Condition**  
1. Retrieve details about **employee "Smith"**.  
2. List employees working in **Department 20**.  
3. Find employees earning **salaries between 3000 and 4500**.  
4. Retrieve employees working in **Department 10 or 20**.  
5. Find employees **not working in Department 10 or 30**.  
6. List employees whose **names start with 'S'**.  
7. Retrieve employees whose **names start with 'S' and end with 'H'**.  
8. Find employees whose **name length is 4 and starts with 'S'**.  
9. Retrieve employees in **Department 10 earning more than 3500**.  
10. List employees **not receiving commission**.  

### **ORDER BY Clause**  
1. Display **Employee ID and Last Name** in ascending order.  
2. Retrieve **Employee ID and Name**, sorted by **salary in descending order**.  
3. Sort employees by **Last Name in ascending order**.  
4. Sort employees by **Last Name (ascending) and Department ID (descending)**.  

### **GROUP BY and HAVING Clause**  
1. Count employees in **different departments**.  
2. Find **maximum, minimum, and average salary** per department.  
3. Retrieve **maximum, minimum, and average salary** per job role.  
4. Count employees hired **each month in ascending order**.  
5. Count employees hired **each month and year in ascending order**.  
6. Identify **departments with at least four employees**.  
7. Count employees hired in **January**.  
8. Count employees hired in **January or September**.  
9. Count employees hired in **1985**.  
10. Count employees hired **each month in 1985**.  
11. Find employees hired in **March 1985**.  
12. Identify **departments with at least 3 employees hired in April 1985**.  

### **Joins**  
1. List employees with their **department names**.  
2. Display employees with their **designations**.  
3. Retrieve employees with **department names and regional groups**.  
4. Count employees in **different departments**, displaying department names.  
5. Count employees in the **Sales department**.  
6. Identify departments with **at least 5 employees**, sorted in ascending order.  
7. Count **job roles**, displaying designations.  
8. Count employees working in **New York**.  

### **SET Operators**  
1. Display employee details with **salary grades** using conditional statements.  
2. Count employees **grade-wise** using conditional statements.  
3. Retrieve **salary grades and number of employees** earning between **2000 and 5000**.  
4. List employees in **Sales or Operations departments**.  
5. Retrieve **distinct jobs** in Sales and Accounting departments.  
6. List **all jobs** in Sales and Accounting departments.  
7. Find **common jobs** in Research and Accounting departments.  

### **Subqueries**  
1. Retrieve employees with the **maximum salary**.  
2. List employees working in the **Sales department**.  
3. Find employees working as **Clerks**.  
4. Retrieve employees living in **New York**.  
5. Count employees working in the **Sales department**.  
6. Increase salaries of **Clerks by 10%**.  
7. Delete employees working in **Accounting department**.  
8. Retrieve the **second highest salary** employee.  
9. Retrieve the **nth highest salary** employee.  
10. Find employees earning **more than every employee in Department 30**.  
11. Identify departments **with no employees**.  
12. Retrieve employees earning **above the average salary for their department**.  

---

## Important Note

Ownership of the data files and assignment questions belongs to **Intellipaat**. This folder is uploaded for **educational and demonstration purposes** only, with permission from Intellipaat support.

> "Contact us: support@intellipaat.com / © Copyright Intellipaat / All rights reserved"

**Republishing the original course material or datasets without permission is strictly prohibited.**
