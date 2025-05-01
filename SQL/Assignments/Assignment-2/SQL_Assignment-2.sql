CREATE DATABASE Mandatory_Assignment2;

USE Mandatory_Assignment2;

-- checking after improting from file
exec sp_help Jomato;
select TOP 10 * from Jomato;

-- 1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’.
-- Eg: ‘Quick Chicken Bites’.


-- The scalar values function is defined as it takes one argument
-- and if that is 'Quick Bites' it stuffs 'Chicken' into that returning 'Quick Chicken Bites'
-- if that is not 'Quick Bites' it retunrs the input argument as it is
-- I have defined like the above since we want to stuff Chicken into quick bites only

CREATE FUNCTION FN_Stuff_Chicken_Into_Quick_Bites
(
	@RestaurantType VARCHAR(50)
)
RETURNS VARCHAR(50)
AS
BEGIN
	IF @RestaurantType = 'Quick Bites'
		RETURN STUFF(@RestaurantType, CHARINDEX(' ', @RestaurantType), 0, ' Chicken')
	RETURN @RestaurantType
END;

-- other logic like replacing Quick Bites substring into result from stuff function 
-- takes place in query statement as the question clearly mentions 
-- that the User Defined Function is only for stuffing Chicken
select 
REPLACE(RestaurantType, 'Quick Bites', dbo.FN_Stuff_Chicken_Into_Quick_Bites('Quick Bites')) as NewRestaurantType
from Jomato;


-- 2. Use the function to display the restaurant name and cuisine type which has the
-- maximum number of rating.

-- Function name is named accordingly
-- It takes no argument (parameters) because in all cases it returns based on maximum no_of_ratings only
-- It returns a TABLE since it is Table Valued Function
CREATE FUNCTION FN_getPopularRestaurants ()
RETURNS TABLE
AS
	RETURN 
	SELECT RestaurantName, CuisinesType FROM Jomato
	WHERE No_of_Rating = (SELECT MAX(No_of_Rating) FROM Jomato);

-- call to Table valued Function without arguments
SELECT * FROM dbo.FN_getPopularRestaurants();


-- 3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
-- start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
-- and below 3.5 and ‘Bad’ if it is below 3 star rating.

SELECT 
	*,
	CASE
		WHEN Rating >= 4 THEN 'Excellent'
		WHEN Rating >= 3.5 and Rating < 4 THEN 'Good'  -- WHEN Rating >=3.5 then 'Goood' would also work but for better readability I used this
		WHEN Rating >= 3 and Rating < 3.5 THEN 'Average'
		WHEN Rating < 3 THEN 'Bad'
	END AS Rating_Status
FROM Jomato;

-- alternative query that works same as above
-- because of the logic of case statement that evaluates when statements one by one in the given order
-- it goes to 2nd when only if 1st when not satisfies so obviously 2nd when is true only if rating>=3.5 and rating<4
SELECT 
	*,
	CASE
		WHEN Rating >= 4 THEN 'Excellent'
		WHEN Rating >= 3.5 THEN 'Good'
		WHEN Rating >= 3 THEN 'Average'
		WHEN Rating < 3 THEN 'Bad'
	END AS Rating_Status
FROM Jomato;

-- if we want to store the above results in table we need to use
-- ALTER TABLE Jomato ADD Rating_Status Varchar(50);
-- and then update using 
-- UPDATE Jomato 
-- set Rating_Status = CASE
--		WHEN Rating >= 4 THEN 'Excellent'
--		WHEN Rating >= 3.5 THEN 'Good'
--		WHEN Rating >= 3 THEN 'Average'
--		WHEN Rating < 3 THEN 'Bad'
--	END;



-- 4. Find the Ceil, floor and absolute values of the rating column and display the current date
--  and separately display the year, month_name and day.

-- checking getdate() to see that getdate() gives current date along with time
select getdate();

-- so getdate() is converted to date datatype to display only current date
-- current day is asked in question, it might be weekday (Saturday) or day part (12)
-- so displaying both
select 
CEILING(Rating) as Rating_ceil,
FLOOR(Rating) as Rating_floor,
ABS(Rating) as Rating_absolute,
CONVERT(date, GETDATE()) as today_date, -- convert to date datatype is used because getdate() gives current date and time
YEAR(GETDATE()) as current_year,
DATENAME(month, getdate()) as current_month_name,
DAY(GETDATE()) as current_day,
DATENAME(WEEKDAY, GETDATE()) as current_weekday  -- additional information apart from what is asked
from Jomato;


--  5. Display the restaurant type and total average cost using rollup.

-- rollup in SQL server can be used in 2 ways

-- recommended syntax for rollup in SQL Server
-- preferred for complex aggregations and grouping hierarchy
select 
RestaurantType, sum(AverageCost)
from Jomato
group by rollup (RestaurantType);

-- Commonly used in wide range of SQL clients
-- so it works with other SQL clients also
-- but the above one is preferred in SQL server 
-- in WITH ROLLUP we can't combine CUBE nand GROUPING SETS in same GROUP BY Clause 
select 
RestaurantType, sum(AverageCost)
from Jomato
group by RestaurantType
with rollup;
