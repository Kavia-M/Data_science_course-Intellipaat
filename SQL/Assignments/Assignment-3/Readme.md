# SQL Assignment 3

## Dataset: Jomato
This folder contains two dataset files:
- `jomato.csv` — the original dataset provided by Intellipaat.
- `jomato1.csv` — a modified version of `jomato.csv`.

### About the Dataset
You work for a data analytics company, and your client is a food delivery platform similar to Jomato. They have provided you with a dataset containing information about various restaurants in a city. Your task is to analyze this dataset using SQL queries to extract valuable insights and generate reports for your client.

- **jomato.csv**: The original dataset as provided.
- **jomato1.csv**: A pre-processed version of the original file, where:
  - The `OrderOnline` and `TableBooking` columns were modified from "Yes"/"No" values to **1**/**0** values.
  - This modification is done to simplify handling specific SQL queries, particularly tasks requiring numeric evaluation (e.g., checking for non-zero values).

---

## Tasks to be Performed

1. **Create a stored procedure** to display the restaurant name, type, and cuisine where the table booking is not zero.
2. **Create a transaction** to update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and roll back the transaction.
3. **Generate a row number column** and find the top 5 areas with the highest restaurant ratings.
4. **Use a WHILE loop** to display numbers from 1 to 50.
5. **Create a "Top Rating" view** to store the top 5 highest-rated restaurants.
6. **Create a trigger** to display a message whenever a new record is inserted.

---

## Important Note

Ownership of the data files and assignment questions belongs to **Intellipaat**. This folder is uploaded for **educational and demonstration purposes** only, with permission from Intellipaat support.

> "Contact us: support@intellipaat.com / © Copyright Intellipaat / All rights reserved"

**Republishing the original course material or datasets without permission is strictly prohibited.**
