select * , 
year(order_date) as order_year ,
month(order_date) as order_month
from clean_sales;

alter table clean_sales add profit_margin float;
SET SQL_SAFE_UPDATES = 0;
update clean_sales 
set profit_margin = profit/ sales;

ALTER TABLE clean_sales ADD order_month INT;
UPDATE clean_sales
SET order_month = MONTH(order_date);
SET SQL_SAFE_UPDATES = 1;

-- KPI
SELECT SUM(sales) AS total_sales FROM clean_sales;
SELECT SUM(profit) AS total_profit FROM clean_sales;
SELECT COUNT(DISTINCT order_id) FROM clean_sales;
SELECT SUM(sales) / COUNT(DISTINCT order_id) FROM clean_sales;

-- MONTHLY SALES 
select order_month , sum(sales) as monthly_sales
from clean_sales
group by order_month
order by order_month;

-- REGIONAL SALES PROFIT
select region , sum(sales) as total_sales , sum(profit) as total_profit
from clean_sales
group by region 
order by total_profit desc; 

-- CATEGORY WISE PROFIT 
select category , sum(profit) as total_profit
from clean_sales
group by category;

-- PRODUCT WISE PROFIT 
select product_name , sum(sales) as total_sales
from clean_sales
group by product_name
order by total_sales desc
limit 10;

-- PRODUCTS THAT ARE IN LOSS
SELECT product_name, SUM(profit) AS total_profit
FROM clean_sales
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

-- DISCOUNT WISE PROFIT 
SELECT discount, SUM(profit) AS total_profit
FROM clean_sales
GROUP BY discount
ORDER BY discount;

-- SUB CATEGORY WISE PROFIT
SELECT sub_category, SUM(profit) AS total_profit
FROM clean_sales
GROUP BY sub_category
ORDER BY total_profit ASC;

-- TOTAL PROFIT BY SALES CATEGORY (LOW , MEDIUM , HIGH)
SELECT 
  CASE 
    WHEN sales < 100 THEN 'Low Sales'
    WHEN sales BETWEEN 100 AND 500 THEN 'Medium Sales'
    ELSE 'High Sales'
  END AS sales_bucket,
  SUM(profit) AS total_profit
FROM clean_sales
GROUP BY sales_bucket;