CREATE DATABASE sql_project_1;
use sql_project_1;
drop table if exists retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id	INT primary key,
				sale_date	DATE,
				sale_time	TIME,
				customer_id	INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(15),
				quantiy	int,
				price_per_unit	float,	
				cogs	float,
				total_sale float
			) ;
ALTER TABLE retail_sales
CHANGE quantiy quantity INT;

            
-- data cleaning
select * from retail_sales
	where 
    transactions_id	is null
	or
	sale_date	is null
    or
	sale_time	is null
    or
	customer_id	is null
    or
	gender is null
    or
	age	is null
    or
	category is null
    or
	quantity	is null
    or
	price_per_unit	is null
	or
	cogs	is null
    or
	total_sale is null;

-- data exploration

-- count total number of sales records
select count(*)  as total_sale from retail_sales;
-- count total number of unique customers
select count(distinct customer_id) as customer from retail_sales;
-- 
select distinct category from retail_sales; 

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * 
from retail_sales
where sale_date='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
from retail_sales
where 
category='Clothing' and
quantity >= 4 and
sale_date between '2022-11-01' and '2022-11-30';
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
category,
sum(total_sale) as total_sale,
count(*) as total_orders
from retail_sales
group by category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age)
from retail_sales
where category='Beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from retail_sales
where total_sale >1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
				