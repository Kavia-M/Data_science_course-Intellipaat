-- Creating and using A new database for assignment 3
CREATE DATABASE Mandatory_Assignment3;
USE Mandatory_Assignment3;

--NOTE: Jomato is imported from the actual CSV file given.
-- Jomato1 is modified CSV file in which 2 columns are modified in the CSV file before importing
-- OrderOnline and TableBooking columns are modified to 0 and 1 values in Jomato1
-- Jomato has OrderOnline and TableBooking type varchar(3)
-- Jomato1 has OrderOnline and TableBooking type bit (which would work as boolean with values 0 and 1 only)
-- I have done this to handle Question1 which asks for non zero values but actual table has Yes and No
-- So, I modified it to fit the question (Not ZERO)

-- checking after import
exec sp_help Jomato;
exec sp_help Jomato1;

select * from Jomato1;
select * from Jomato;

-- For Jomato I have marked OrderID as primary Key during import from csv
-- For Jomato1 I am adding using ALTER
alter table Jomato1
add CONSTRAINT PK_Jomato1
PRIMARY KEY (OrderId);

-- checking if 0 and 1 in Jomato1 are of same count as No and Yes in Jomato
select count(OnlineOrder) from Jomato where OnlineOrder='Yes';
select count(OnlineOrder) from Jomato1 where OnlineOrder=1;

select IIF(
(select count(OnlineOrder) from Jomato where OnlineOrder='Yes') = (select count(OnlineOrder) from Jomato1 where OnlineOrder=1),
'EQUAL', 'NOT EQUAL');

select count(OnlineOrder) from Jomato where OnlineOrder='No';
select count(OnlineOrder) from Jomato1 where OnlineOrder=0;

select IIF(
(select count(OnlineOrder) from Jomato where OnlineOrder='No') = (select count(OnlineOrder) from Jomato1 where OnlineOrder=0),
'EQUAL', 'NOT EQUAL');

select count(TableBooking) from Jomato where TableBooking='Yes';
select count(TableBooking) from Jomato1 where TableBooking=1;

select IIF(
(select count(TableBooking) from Jomato where TableBooking='Yes') = (select count(TableBooking) from Jomato1 where TableBooking=1),
'EQUAL', 'NOT EQUAL');

select count(TableBooking) from Jomato where TableBooking='No';
select count(TableBooking) from Jomato1 where TableBooking=0;

select IIF(
(select count(TableBooking) from Jomato where TableBooking='No') = (select count(TableBooking) from Jomato1 where TableBooking=0),
'EQUAL', 'NOT EQUAL');

select count(OnlineOrder) from Jomato where OnlineOrder='Yes' or OnlineOrder='No';
select count(OnlineOrder) from Jomato1 where OnlineOrder=1 or OnlineOrder=0;
select count(TableBooking) from Jomato where TableBooking='Yes' or TableBooking='No';
select count(TableBooking) from Jomato1 where TableBooking=1 or TableBooking=0; 
select count(*) from Jomato;
select count(*) from Jomato1;


-- SOLVING ASSIGNMENT QUESTIONS

-- 1. Create a stored procedure to display the restaurant name, type and cuisine where the
-- table booking is not zero.

-- Stored Proceduer that selects from Jomato1 since it has Table Booking column values 0 and 1
CREATE PROC USP_TABEL_BOOKING_RESTAURANTS
AS
(
	select RestaurantName, RestaurantType, CuisinesType from Jomato1 where not TableBooking=0
);

-- calling or executing stored procedure without exec
USP_TABEL_BOOKING_RESTAURANTS;
-- using exec
EXEC USP_TABEL_BOOKING_RESTAURANTS;

-- Using different syntax to create a stored procedure
-- The below one uses Jomato table to not select 'No' in table Booking
CREATE PROCEDURE USP_RESTAURANTS_WITH_TABLE_BOOKING
AS 
(
	select RestaurantName, RestaurantType, CuisinesType from Jomato where not TableBooking='No'
);

-- calling or executing stored procedure
USP_RESTAURANTS_WITH_TABLE_BOOKING;

EXEC USP_RESTAURANTS_WITH_TABLE_BOOKING;


-- There are multiple ways to write the select statement inside the stored procedure as follows

-- Select from Jomato1 which actually has 0 and 1 values
select RestaurantName, RestaurantType, CuisinesType from Jomato1 where not TableBooking=0;
select RestaurantName, RestaurantType, CuisinesType from Jomato1 where TableBooking<>0;
select RestaurantName, RestaurantType, CuisinesType from Jomato1 where TableBooking=1;

-- Select from Jomat. Here 'No' is treated as 0
select RestaurantName, RestaurantType, CuisinesType from Jomato where not TableBooking='No';
select RestaurantName, RestaurantType, CuisinesType from Jomato where TableBooking<>'No';
select RestaurantName, RestaurantType, CuisinesType from Jomato where TableBooking='Yes';

-- Using CTE to 1st convert yes and no to 1 and 0 and then select non zero
WITH Converted_Jomato as (
	SELECT *,
		CASE
			WHEN TableBooking = 'Yes' THEN 1
			WHEN TableBooking = 'No' THEN 0
			ELSE NULL
		END AS Bit_TableBooking
	FROM Jomato
)
SELECT RestaurantName, RestaurantType, CuisinesType from Converted_Jomato where NOT Bit_TableBooking = 0;

-- Handle in WHERE clause and select non 0
SELECT 
RestaurantName, RestaurantType, CuisinesType 
FROM Jomato
WHERE 
	NOT CASE	
		WHEN TableBooking = 'Yes' THEN 1
		WHEN TableBooking = 'No' THEN 0
	END = 0; 

-- Using sub query to make a column called Bit_TableBooking
SELECT 
RestaurantName, RestaurantType, CuisinesType 
FROM (
	SELECT *,
		CASE	
			WHEN TableBooking = 'Yes' THEN 1
			WHEN TableBooking = 'No' THEN 0
		END AS Bit_TableBooking
	FROM Jomato
) AS Derived_Jomato
WHERE NOT Bit_TableBooking = 0;


-- 2. Create a transaction and update the cuisine type �Cafe� to �Cafeteria�. Check the result
-- and rollback it.

-- Checking before starting transaction
select CuisinesType from Jomato where CuisinesType like '%Cafe%';
select CuisinesType from Jomato 
where CuisinesType like '%Cafe, %' or CuisinesType like '%, Cafe%' or CuisinesType = 'Cafe';

-- Transaction with name
BEGIN TRANSACTION Update_CusinesType
UPDATE Jomato
set CuisinesType = REPLACE(CuisinesType, 'Cafe', 'Cafeteria');

-- Checking after transaction

-- No rows cuisineType for which are only Cafe and Not Cafetaria
select CuisinesType from Jomato where CuisinesType like '%Cafe%' and CuisinesType not like '%Cafeteria%';
-- Rows are present for for Cafeteria (similar to Cafe while checking before transaction)
select CuisinesType from Jomato where CuisinesType like '%Cafeteria%';
select CuisinesType from Jomato 
where CuisinesType like '%Cafeteria, %' or CuisinesType like '%, Cafeteria%' or CuisinesType = 'Cafeteria';

-- Rollback using Transaction name
ROLLBACK TRANSACTION Update_CusinesType;

-- Checking after Rollback. The Results should be as same as when we checked before transaction
select CuisinesType from Jomato1 where CuisinesType like '%Cafe%';
select CuisinesType from Jomato1 
where CuisinesType like '%Cafe, %' or CuisinesType like '%, Cafe%' or CuisinesType = 'Cafe';

-- Trying another syntax with No Name for Transaction
BEGIN TRANSACTION
UPDATE Jomato1
set CuisinesType = REPLACE(CuisinesType, 'Cafe', 'Cafeteria');

-- checking (gives rows for Cafeteria)
select CuisinesType from Jomato1 where CuisinesType like '%Cafe%' and CuisinesType not like '%Cafeteria%';
select CuisinesType from Jomato1 where CuisinesType like '%Cafeteria%';
select CuisinesType from Jomato1
where CuisinesType like '%Cafeteria, %' or CuisinesType like '%, Cafeteria%' or CuisinesType = 'Cafeteria';

-- Rollaback wihtout transaction name.
ROLLBACK;
-- Can be checked using the same select statements used for the transaction with name


-- 3. Generate a row number column and find the top 5 areas with the highest rating of
-- restaurants.

-- The questions asks to find area with highest rating
-- Each area has many restaurants, so we need to take average of ratings for each area
-- Group by and AVG is used
-- ROW_NUMBER() orders by Descending order of Avaerage rating of each area
-- Average rating is converted to Decimal with 1 decimal digit since that is the format of rating in the table
SELECT TOP 5
	ROW_NUMBER() OVER (ORDER BY AVG(Rating) DESC) as Row_Number,
	Area,
	CONVERT(DECIMAL(2,1), AVG(Rating)) as Avg_Ratings
FROM Jomato
GROUP BY Area
ORDER BY Row_Number;

-- Additional implementation
-- The following query finds the top rated RESTAURANTS using ROW_NUMBER()
SELECT TOP 5
	ROW_NUMBER() OVER (ORDER BY Rating DESC) as Row_Number,
	RestaurantName,
	Rating
FROM Jomato
ORDER BY Row_Number;


-- 4. Use the while loop to display the 1 to 50

-- Using @counter as variable name
-- The variable is declared first and then initialized using SET
DECLARE @counter INT;
SET @counter = 1;
    
WHILE @counter <= 50
BEGIN
   PRINT @counter
   SET @counter = @counter + 1;
END;


-- Alternative implementation
-- Here @counter1 is used which can be initialized in the same like as declaration
DECLARE @counter1 INT = 1;
    
WHILE @counter1 <= 50
BEGIN
   PRINT @counter1
   SET @counter1 = @counter1 + 1;
END;


-- 5. Write a query to Create a Top rating view to store the generated top 5 highest rating of
-- restaurants.

-- Checking the TOP 5 Rating
SELECT TOP 5 Rating FROM Jomato order by rating desc;

-- This view if for top 5 Restaurants with highest ratings (ReataurantName and Ratings)
CREATE VIEW VW_HIGHEST_RATING_OF_RESTAURANTS
AS
SELECT TOP 5 RestaurantName, Rating FROM Jomato ORDER BY Rating DESC;

-- This view is same as above but used Row Number. (ReataurantName and Ratings)
CREATE VIEW VW_HIGHEST_RATING_OF_RESTAURANTS_WITH_ROW_NUMBER
AS
SELECT TOP 5
	ROW_NUMBER() OVER (ORDER BY Rating DESC) as Row_Number,
	RestaurantName,
	Rating
FROM Jomato
ORDER BY Row_Number;

-- Select top 5 restaurants with ratings using the above views
SELECT * FROM VW_HIGHEST_RATING_OF_RESTAURANTS;

SELECT * FROM VW_HIGHEST_RATING_OF_RESTAURANTS_WITH_ROW_NUMBER;

-- This View is for the already generated top 5 ratings area wise (in question 3)
CREATE VIEW VW_HIGHEST_RATING_BY_AREA
AS
SELECT TOP 5
	ROW_NUMBER() OVER (ORDER BY AVG(Rating) DESC) as Row_Number,
	Area,
	CONVERT(DECIMAL(2,1), AVG(Rating)) as Avg_Rating
FROM Jomato
GROUP BY Area
ORDER BY Row_Number;

-- select top 5 highest rated areas with average rating using the above view.
SELECT * FROM VW_HIGHEST_RATING_BY_AREA;

-- if you want to select only the top Ratings and not restaurant name or area 
-- you can use below select statement
-- NOTE: using this is not logically relevant to select only the ratings
-- since ratings are just numbers without RestaurantName or Area

SELECT Rating FROM VW_HIGHEST_RATING_OF_RESTAURANTS;
SELECT Rating FROM VW_HIGHEST_RATING_OF_RESTAURANTS_WITH_ROW_NUMBER;
SELECT Avg_Rating FROM VW_HIGHEST_RATING_BY_AREA;


-- 6. Create a trigger that give an message whenever a new record is inserted.

-- Trigger that will be triggered after insert on Jomato is done successfully
-- This is a simple trigger just printing a message after insertion
CREATE TRIGGER Trigger_insert on Jomato
AFTER INSERT
AS BEGIN
PRINT 'A NEW RECORD IS INSERTED'
END;

-- checking to know maximum order id to insert arow with orderId greater than that.
-- orderId cannot be duplicat since it is primary key
select max(OrderId) from Jomato;
insert into Jomato values 
(7105, 'New Restaurant', 'Casual Dining', 3.5, 32, 320, 'No', 'No', 'Traditional Tamil Cuisine', 'Chennai', 'Mount Road', 32);

-- Uncomment and Run the below insert statemnent (2 lines) to check the trigger working
-- insert into Jomato values 
-- (7106, 'Tamil Marabu', 'Casual Dining', 4.9, 32, 30, 'No', 'No', 'Traditional Tamil Cuisine', 'Chennai', 'Anna Nagar', 20);