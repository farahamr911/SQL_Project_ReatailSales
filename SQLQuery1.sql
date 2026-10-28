use RETAIL_SALES
Create table Retail_Sales(
transactions_id INT PRIMARY KEY,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category	VARCHAR(15),
quantiy	 INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale  FLOAT
);

select *
from[dbo].[SQL - Retail Sales Analysis_utf ];

INSERT INTO dbo.Retail_Sales (
    transactions_id,
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
    quantiy,
    price_per_unit,
    cogs,
    total_sale
)
SELECT
    transactions_id,
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
    quantiy,
    price_per_unit,
    cogs,
    total_sale
FROM dbo.[SQL - Retail Sales Analysis_utf];

selecT * 
FROM [dbo].[Retail_Sales];

SELECT 
COUNT(*)
FROM [dbo].[Retail_Sales]

--Data Cleanning
SELECT * 
FROM [dbo].[Retail_Sales]
WHERE [transactions_id] IS NULL 
OR 
[sale_date] IS NULL 
OR
[sale_time] IS NULL 
OR
[customer_id] IS NULL 
OR
[gender] IS NULL 
OR
[age] IS NULL 
OR
[category] IS NULL 
OR
[quantiy] IS NULL 
OR
[price_per_unit] IS NULL 
OR
[cogs] IS NULL 
OR
[total_sale] IS NULL 


DELETE 
FROM [dbo].[Retail_Sales]
WHERE [transactions_id] IS NULL 
OR 
[sale_date] IS NULL 
OR
[sale_time] IS NULL 
OR
[customer_id] IS NULL 
OR
[gender] IS NULL 
OR
[age] IS NULL 
OR
[category] IS NULL 
OR
[quantiy] IS NULL 
OR
[price_per_unit] IS NULL 
OR
[cogs] IS NULL 
OR
[total_sale] IS NULL 


--Data Exploring

--HOW MANY SALES WE HAVE
SELECT COUNT(*)
AS RETAIL_SALES
FROM [dbo].[Retail_Sales]

--HOW MANY UNIQUE CUSTOMERS WE HAVE
SELECT COUNT (DISTINCT [customer_id])
AS NUMBER_OF_CUSTOMERS
FROM [dbo].[Retail_Sales]

--HOW MANY UNIQUE CATEGORY WE HAVE
SELECT COUNT (DISTINCT [category])
AS NUMBER_OF_CATEGORY
FROM [dbo].[Retail_Sales]

SELECT DISTINCT [category]
FROM [dbo].[Retail_Sales]


-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM [dbo].[Retail_Sales]
WHERE [sale_date] = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT * 
FROM [dbo].[Retail_Sales]
WHERE [category]='Clothing'
AND [quantiy]>3
AND [sale_date] BETWEEN '2022-11-01' AND '2022-11-30'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT
[category],
SUM([total_sale]) AS TOTAL_SALE
FROM [dbo].[Retail_Sales]
GROUP BY [category]

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
[category],
AVG([age])
FROM [dbo].[Retail_Sales]
WHERE [category]='Beauty'
GROUP BY [category]

SELECT AVG([age])
FROM [dbo].[Retail_Sales]
WHERE [category]='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM [dbo].[Retail_Sales]
WHERE [total_sale]>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT [gender], [category], COUNT (*) AS NO_TRANSACTIONS
FROM [dbo].[Retail_Sales]
GROUP BY [gender],[category]

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT*
FROM 
(
SELECT YEAR(sale_date) AS year,
MONTH(sale_date) AS month,
AVG([total_sale]) AS sales,
RANK()OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG([total_sale]) DESC) AS BEST_MONTH
FROM [dbo].[Retail_Sales]
GROUP BY YEAR(sale_date), MONTH(sale_date)) AS MonthlyRanking
WHERE BEST_MONTH=1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 


SELECT *
FROM(SELECT [customer_id],
SUM([total_sale]) AS TOTAL_SALES,
RANK()OVER(ORDER BY SUM([total_sale])DESC) AS HIGHEST_SALES
FROM [dbo].[Retail_Sales]
GROUP BY [customer_id])AS HIGHEST_CUSTOMERS
WHERE HIGHEST_SALES<=5

SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM dbo.Retail_Sales
GROUP BY customer_id
ORDER BY total_sales DESC;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT [category],
COUNT(DISTINCT [customer_id])
FROM [dbo].[Retail_Sales]
GROUP BY [category]


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
HOURS_SHIFT ,COUNT(*)
FROM 
(SELECT *,
CASE 
WHEN DATEPART(HOUR, sale_time)<=12 THEN 'MORNING'
WHEN DATEPART(HOUR, sale_time)>12 AND DATEPART(HOUR, sale_time)<17 THEN 'AFTERNOON'
ELSE 'EVENING'
END AS HOURS_SHIFT
FROM [dbo].[Retail_Sales])AS HOURLY_SHIFTS
GROUP BY HOURS_SHIFT

--END OF PROJECT