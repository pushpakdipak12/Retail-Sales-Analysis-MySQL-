

use retail;


select * from `retail sales analysis`;


SELECT COUNT(*) FROM `retail sales analysis`;

SELECT COUNT(DISTINCT customer_id) FROM `retail sales analysis`;

SELECT DISTINCT category FROM `retail sales analysis`;

SELECT * FROM `retail sales analysis`
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
DELETE FROM `retail sales analysis`
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    

#What is the total revenue generated each month?

select month(sale_date) as month,sum(total_sale) as Revenue from `retail sales analysis`
group by month;

#How do daily and hourly sales trends look? (Peak sales times)

select day(sale_date) as daily,hour(sale_date) as hourly,sum(total_sale) as Revenue from `retail sales analysis`
group by daily,hourly
order by daily,hourly;
    

#What is the average order value per customer?

select avg(total_sale) as average from  `retail sales analysis`;

#What is the gender distribution of customers?

select gender,count(*) from `retail sales analysis` where gender='Male'
union
select gender,count(*) from `retail sales analysis` where gender='Female';

#Which age group makes the most purchases?

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_group, 
    COUNT(*) AS total_purchases
FROM `retail sales analysis`
GROUP BY age_group
ORDER BY total_purchases DESC;

#Which product category generates the most revenue?

select distinct(category),sum(total_sale) as revenue from `retail sales analysis`
group by category order by revenue desc;

#What is the most frequently purchased category?

SELECT category, SUM(quantiy) AS total_quantity_sold
FROM `retail sales analysis`
GROUP BY category
ORDER BY total_quantity_sold DESC;

#Which category has the highest average order value?
SELECT category, AVG(total_sale) AS avg_order_value
FROM `retail sales analysis`
GROUP BY category
ORDER BY avg_order_value DESC;


#What is the total Cost of Goods Sold (COGS) per month?

select month(sale_Date) as month,sum(cogs) as total_cost from `retail sales analysis`
group by month
order by month,total_cost;

#What is the profit margin for each product category?

SELECT category, 
       SUM(total_sale - cogs) AS total_profit, 
       (SUM(total_sale - cogs) * 100.0 / SUM(total_sale)) AS profit_margin
FROM `retail sales analysis`
GROUP BY category
ORDER BY total_profit DESC;

#Which day of the week generates the most sales?

SELECT (sale_date) AS weekday, 
       SUM(total_sale) AS total_revenue
FROM `retail sales analysis`
GROUP BY weekday
ORDER BY total_revenue DESC;

#How many customers make repeat purchases?

SELECT customer_id, COUNT(*) AS purchase_count
FROM `retail sales analysis`
GROUP BY customer_id
HAVING purchase_count > 1
ORDER BY purchase_count DESC;

#Average quantity of items purchased per transaction

SELECT AVG(quantiy) AS avg_items_per_transaction
FROM `retail sales analysis`;

#Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM `retail sales analysis`
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

#Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM `retail sales analysis`
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;








