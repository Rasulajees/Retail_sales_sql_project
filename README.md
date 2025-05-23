# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Rasul`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Rasul`.
- **Table Creation**: A table named `Retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE Rasul;

CREATE TABLE Retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * 
FROM Retail_sales_data
WHERE sale_date='2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
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
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT
  category,
  SUM(total_sale) AS net_sale,
  COUNT(*) AS total_orders
FROM Retail_sales_data
GROUP BY category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
  ROUND(AVG(age),2) AS avg_age
FROM Retail_sales_data
WHERE category='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * 
FROM Retail_sales_data
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
  category,
  gender,
  COUNT(*) AS total_trans
FROM Retail_sales_data
GROUP BY category,
          gender
ORDER BY 1

```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT
  customer_id,
  SUM(total_sale) AS total_sales
FROM Retail_sales_data
GROUP BY customer_id
ORDER BY total_sales DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY; --limit 10 rows only
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
  category,
  COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM Retail_sales_data
GROUP  BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
--End the project
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

Thank you for your support, and I look forward to connecting with you!
