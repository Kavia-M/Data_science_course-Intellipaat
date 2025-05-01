# SQL Case Study 2 - Tables Descriptions & Records 

## **1. LOCATION Table**  
Stores details about the **cities** where departments operate.  

| Column Name   | Description                      |
|--------------|----------------------------------|
| Location_ID  | Unique identifier for each location (Primary Key).  |
| City         | Name of the city where the department is located. |

### **Records**  
| Location_ID | City     |
|------------|---------|
| 122        | New York  |
| 123        | Dallas    |
| 124        | Chicago   |
| 167        | Boston    |

---

## **2. DEPARTMENT Table**  
Stores department details and their **associated locations**.  

| Column Name   | Description                     |
|--------------|---------------------------------|
| Department_ID | Unique identifier for each department (Primary Key).  |
| Name          | Name of the department.  |
| Location_ID   | Foreign Key linking to `LOCATION(Location_ID)`. |

### **Records**  
| Department_ID | Name       | Location_ID |
|--------------|-----------|------------|
| 10           | Accounting | 122        |
| 20           | Sales      | 124        |
| 30           | Research   | 123        |
| 40           | Operations | 167        |

---

## **3. JOB Table**  
Stores details of **job roles** in the organization.  

| Column Name   | Description                         |
|--------------|------------------------------------|
| Job_ID       | Unique identifier for each job role (Primary Key).  |
| Designation  | Title of the job position. |

### **Records**  
| Job_ID | Designation  |
|--------|-------------|
| 667    | Clerk       |
| 668    | Staff       |
| 669    | Analyst     |
| 670    | Salesperson |
| 671    | Manager     |
| 672    | President   |

---

## **4. EMPLOYEE Table**  
Stores information about **employees**, their departments, salaries, and job roles.  

| Column Name   | Description                           |
|--------------|--------------------------------------|
| Employee_ID  | Unique identifier for each employee. |
| Last_Name    | Employee's last name.  |
| First_Name   | Employee's first name.  |
| Middle_Name  | Middle initial of the employee.  |
| Job_ID       | Foreign Key linking to `JOB(Job_ID)`. |
| Manager_ID   | Manager assigned to the employee. |
| Hire_Date    | Date of hiring. |
| Salary       | Salary of the employee. |
| Commission   | Additional commission earned (if applicable). |
| Department_ID| Foreign Key linking to `DEPARTMENT(Department_ID)`. |

### **Records**  
| Employee_ID | Last_Name | First_Name | Middle_Name | Job_ID | Manager_ID | Hire_Date  | Salary | Commission | Department_ID |
|------------|----------|------------|-------------|--------|-----------|------------|--------|------------|--------------|
| 7369       | Smith    | John       | Q           | 667    | 7902      | 17-Dec-84  | 800    | NULL       | 20           |
| 7499       | Allen    | Kevin      | J           | 670    | 7698      | 20-Feb-85  | 1600   | 300        | 30           |
| 7505       | Doyle    | Jean       | K           | 671    | 7839      | 04-Apr-85  | 2850   | NULL       | 30           |
| 7506       | Dennis   | Lynn       | S           | 671    | 7839      | 15-May-85  | 2750   | NULL       | 30           |
| 7507       | Baker    | Leslie     | D           | 671    | 7839      | 10-Jun-85  | 2200   | NULL       | 40           |
| 7521       | Wark     | Cynthia    | D           | 670    | 7698      | 22-Feb-85  | 1250   | 500        | 30           |

---
