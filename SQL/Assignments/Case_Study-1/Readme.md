# SQL Case Study 1  

## Dataset: fact, Location, Product
This folder contains 3 dataset files:
- `fact.csv`
- `Location.csv`
- `Product.csv`

## Problem Statement  
As a database administrator, you need to analyze customer data to answer key business questions, focusing on **sales, profit, marketing expenditures, inventory, and costs**. You will use SQL queries to extract insights and help determine **top-selling products**. Due to privacy concerns, only a **sample dataset** has been provided, but it should be sufficient to build meaningful queries.

---

## About the Dataset   
The **case study** consists of three key tables:

### **Fact Table** (Sales & Financial Data)  
| Column Name       | Description                     |
|------------------|---------------------------------|
| Date            | Transaction date                 |
| ProductID       | Unique product identifier        |
| Profit         | Total profit generated           |
| Sales          | Total sales value                |
| Margin         | Profit margin percentage         |
| COGS           | Cost of Goods Sold               |
| Total Expenses | Overall expenses incurred        |
| Marketing      | Marketing expenditure            |
| Inventory      | Available stock inventory        |
| Budget Profit  | Projected profit                 |
| Budget COGS    | Estimated cost of goods sold     |
| Budget Margin  | Expected profit margin           |
| Budget Sales   | Forecasted sales value           |
| Area Code      | Location identifier              |

---

### **Product Table** (Product Details)  
| Column Name     | Description                        |
|---------------|----------------------------------|
| Product Type  | General category of the beverage  |
| Product       | Specific name of the product      |
| ProductID     | Unique identifier for each item  |
| Type         | Classification (*Regular* or *Decaf*) |

The **Product Table** includes various beverages such as **Coffee, Espresso, Herbal Tea, and Tea**, categorized further into **Regular and Decaf** options.

---

### **Location Table** (Geographical Data)  
| Column Name  | Description                     |
|-------------|---------------------------------|
| Area Code   | Unique identifier for locations |
| State       | Name of the state               |
| Market      | **Geographical Classification** (*East, West, Central*) |
| Market Size | Size category of the market     |

The **Market column** categorizes locations into **East, West, and Central**, helping businesses analyze regional sales performance.

---

## Tasks to be Performed  

1. Display the number of **states** present in the Location Table.  
2. Identify how many **products are of Regular type**.  
3. Determine the **total marketing expenditure** for Product ID 1.  
4. Find the **minimum sales value** of a product.  
5. Display the **maximum Cost of Goods Sold (COGS)**.  
6. Retrieve details where **Product Type is Coffee**.  
7. Display details where **Total Expenses are greater than 40**.  
8. Calculate the **average sales in Area Code 719**.  
9. Find out the **total profit generated in Colorado state**.  
10. Display the **average inventory for each Product ID**.  
11. Arrange **States sequentially** in the Location Table.  
12. Compute the **average budget margin**, ensuring values exceed 100.  
13. Retrieve the **total sales** recorded on `2010-01-01`.  
14. Calculate the **average total expenses** for each Product ID.  
15. Display a table with attributes: **Date, Product ID, Product Type, Product, Sales, Profit, State, Area Code**.  
16. Rank **Sales** without gaps.  
17. Retrieve **Profit and Sales** figures by State.  
18. Retrieve **Profit and Sales** figures by **State and Product Name**.  
19. Simulate a **5% increase in sales** and compute new sales figures.  
20. Find **maximum profit** along with **Product ID and Product Type**.  
21. Create a **Stored Procedure** to fetch results based on **Product Type**.  
22. Implement conditional logic:  
    - If **Total Expenses < 60**, classify as **Profit**  
    - Otherwise, classify as **Loss**  
23. Compute **total weekly sales values**, using **ROLLUP** for hierarchical grouping.  
24. Apply **UNION & INTERSECTION** operators using **Area Code**.  
25. Develop a **User-Defined Function** for fetching product types.  
26. Modify **Product Type from Coffee to Tea** for **Product ID 1**, then undo the change.  
27. Retrieve **Date, Product ID, and Sales**, where **Total Expenses are between 100 and 200**.  
28. Delete records in **Product Table** where products are of **Regular type**.  
29. Display the **ASCII value of the fifth character** in the **Product** column.  

---

## Important Note

Ownership of the data files and assignment questions belongs to **Intellipaat**. This folder is uploaded for **educational and demonstration purposes** only, with permission from Intellipaat support.

> "Contact us: support@intellipaat.com / © Copyright Intellipaat / All rights reserved"

**Republishing the original course material or datasets without permission is strictly prohibited.**
