--creating database:
USE Rasul
----------------------------------------

--show the entire table;
SELECT * FROM Retail_sales_data

------------------------------------------

--alter the table column dtypes:
ALTER TABLE Retail_sales_data
ALTER COLUMN transactions_id INT

ALTER TABLE Retail_sales_data
ALTER COLUMN sale_date DATE

ALTER TABLE Retail_sales_data
ALTER COLUMN sale_time TIME

ALTER TABLE Retail_sales_data
ALTER COLUMN customer_id INT

ALTER TABLE Retail_sales_data
ALTER COLUMN age INT

ALTER TABLE Retail_sales_data
ALTER COLUMN quantity INT

ALTER TABLE Retail_sales_data
ALTER COLUMN price_per_unit INT

ALTER TABLE Retail_sales_data
ALTER COLUMN cogs FLOAT

ALTER TABLE Retail_sales_data
ALTER COLUMN total_sale INT

--------------------------------------------

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--------------------------------------------

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * 
FROM Retail_sales_data
WHERE sale_date='2022-11-05'

---------------------------------------------

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT 
transactions_id,
sale_date,
sale_time,
customer_id,
gender,
age,
category,
quantity,
price_per_unit,
cogs,
total_sale
FROM Retail_sales_data
  WHERE 
      category = 'Clothing'
      AND 
      FORMAT(sale_date, 'YYYY-MM') = '2022-11'
      AND
      quantity >= 4

------------------------------------------------------

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
  category,
  SUM(total_sale) AS net_sale,
  COUNT(*) AS total_orders
FROM Retail_sales_data
GROUP BY category

--------------------------------------------------

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
  ROUND(AVG(age),2) AS avg_age
FROM Retail_sales_data
WHERE category='Beauty'

-------------------------------------------------

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM Retail_sales_data
WHERE total_sale > 1000

--------------------------------------------

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
  category,
  gender,
  COUNT(*) AS total_trans
FROM Retail_sales_data
GROUP BY category,
          gender
ORDER BY 1

------------------------------------------

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT
  year,
  month,
  avg_sale
FROM
(
  SELECT
    FORMAT(year FROM sale_date) AS year,
    FORMAT(month FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY FORMAT(year FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM Retail_sales_data
GROUP BY 1,2
) AS t1
WHERE rank =1

--------------OR---------------

SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        FORMAT(sale_date, 'yyyy') AS year,
        FORMAT(sale_date, 'MM') AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY FORMAT(sale_date, 'yyyy') ORDER BY AVG(total_sale) DESC) AS rank
    FROM Retail_sales_data
    GROUP BY FORMAT(sale_date, 'yyyy'), FORMAT(sale_date, 'MM')
) AS t1
WHERE rank = 1;

--------------------------------------------

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT
  customer_id,
  SUM(total_sale) AS total_sales
FROM Retail_sales_data
GROUP BY customer_id
ORDER BY total_sales DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY; --limit 10 rows only

-----------------------------------------------

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
  category,
  COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM Retail_sales_data
GROUP  BY category;

------------------------------------------

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale AS (
    SELECT 
        sale_date,
        sale_time,
        CASE 
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retail_sales_data
)
SELECT 
    shift, 
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

--End of Project