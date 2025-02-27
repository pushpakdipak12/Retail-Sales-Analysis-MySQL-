# 🛒 Retail Sales Analysis - SQL Project

## 📌 Project Overview
This project focuses on analyzing retail sales data using SQL. The key objectives include:  
✔️ Setting up a **retail sales database**  
✔️ **Data Cleaning** to remove missing values  
✔️ **Exploratory Data Analysis (EDA)** to understand sales patterns  
✔️ **Business Insights** through SQL queries  

---

## 📂 Dataset Overview
The dataset contains transactional sales records with the following fields:

| Column Name        | Description                               |
|--------------------|-------------------------------------------|
| `transactions_id`  | Unique transaction ID                    |
| `sale_date`        | Date of sale                              |
| `sale_time`        | Time of sale                              |
| `customer_id`      | Unique customer identifier               |
| `gender`          | Customer's gender                        |
| `age`             | Customer's age                           |
| `category`        | Product category                         |
| `quantiy`         | Number of units sold                     |
| `price_per_unit`  | Price per unit of the product            |
| `cogs`           | Cost of goods sold                        |
| `total_sale`      | Total revenue from the transaction       |

---

## 🛠 SQL Queries & Analysis

### **1️⃣ Data Exploration & Cleaning**  

```sql
-- View all records
SELECT * FROM `retail sales analysis`;

-- Count total transactions
SELECT COUNT(*) FROM `retail sales analysis`;

-- Count unique customers
SELECT COUNT(DISTINCT customer_id) FROM `retail sales analysis`;

-- List all unique product categories
SELECT DISTINCT category FROM `retail sales analysis`;

-- Identify missing/null values in the dataset
SELECT * FROM `retail sales analysis`
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Remove records with missing values
DELETE FROM `retail sales analysis`
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

```

### **2️⃣ Sales Performance Analysis**

```sql

-- Total revenue per month
SELECT MONTH(sale_date) AS month, SUM(total_sale) AS Revenue 
FROM `retail sales analysis`
GROUP BY month;

-- Daily & hourly sales trends (Peak sales times)
SELECT DAY(sale_date) AS daily, HOUR(sale_date) AS hourly, SUM(total_sale) AS Revenue 
FROM `retail sales analysis`
GROUP BY daily, hourly
ORDER BY daily, hourly;

-- Average order value per customer
SELECT AVG(total_sale) AS average_order_value 
FROM `retail sales analysis`;

```

### **3️⃣ Customer Insights**

```sql

-- Gender distribution of customers
SELECT gender, COUNT(*) AS total_customers
FROM `retail sales analysis`
GROUP BY gender;

-- Age group that makes the most purchases
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

```

### **4️⃣ Product & Category Insights**

```sql

-- Product category generating the most revenue
SELECT category, SUM(total_sale) AS revenue 
FROM `retail sales analysis`
GROUP BY category
ORDER BY revenue DESC;

-- Most frequently purchased category
SELECT category, SUM(quantiy) AS total_quantity_sold
FROM `retail sales analysis`
GROUP BY category
ORDER BY total_quantity_sold DESC;

-- Category with the highest average order value
SELECT category, AVG(total_sale) AS avg_order_value
FROM `retail sales analysis`
GROUP BY category
ORDER BY avg_order_value DESC;

```

### **5️⃣ Operational Insights**

```sql

-- Total Cost of Goods Sold (COGS) per month
SELECT MONTH(sale_Date) AS month, SUM(cogs) AS total_cost 
FROM `retail sales analysis`
GROUP BY month
ORDER BY month, total_cost;

-- Profit margin for each product category
SELECT category, 
       SUM(total_sale - cogs) AS total_profit, 
       (SUM(total_sale - cogs) * 100.0 / SUM(total_sale)) AS profit_margin
FROM `retail sales analysis`
GROUP BY category
ORDER BY total_profit DESC;

-- Most profitable day of the week
SELECT (sale_date) AS weekday, 
       SUM(total_sale) AS total_revenue
FROM `retail sales analysis`
GROUP BY weekday
ORDER BY total_revenue DESC;

```

### **6️⃣ Customer Behavior Analysis**

```sql

-- Number of customers making repeat purchases
SELECT customer_id, COUNT(*) AS purchase_count
FROM `retail sales analysis`
GROUP BY customer_id
HAVING purchase_count > 1
ORDER BY purchase_count DESC;

-- Average quantity of items purchased per transaction
SELECT AVG(quantiy) AS avg_items_per_transaction
FROM `retail sales analysis`;

-- Total transactions by gender in each category
SELECT 
    category,
    gender,
    COUNT(*) as total_transactions
FROM `retail sales analysis`
GROUP BY category, gender
ORDER BY category;

```

### **7️⃣ Sales Shift Analysis**


```sql

-- Sales by shift (Morning, Afternoon, Evening)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM `retail sales analysis`
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

```

📈 Key Findings

1️⃣ Monthly Revenue Trends

    Highest revenue month: December (₹141,025)
    Lowest revenue month: February (₹41,280)
    Revenue spikes in September (₹129,180), October (₹125,615), and November (₹126,050), indicating strong seasonal demand.

2️⃣ Daily Sales Trends

    Peak sales days: 1st, 10th, 13th, 21st, and 26th of the month.
    Lower sales towards the end of the month (31st), possibly due to budget constraints.

3️⃣ Average Order Value (AOV)

    ₹457.08 per customer on average.

4️⃣ Customer Demographics

    Gender Distribution:
        Male: 975
        Female: 1012
    Age Group with Most Purchases:
        36-50 years: 625 purchases
        50+ years: 617 purchases

5️⃣ Product Performance

    Highest revenue-generating category: Electronics (₹311,445)
    Most frequently purchased category: Clothing (1,780 items)
    Highest average order value:
        Beauty: ₹469.38
        Electronics: ₹459.36
        Clothing: ₹444.12

6️⃣ Cost & Profit Analysis

    Total Cost of Goods Sold (COGS) peaks in September (₹30,294), followed by October and November.
    Profit Margins by Category:
        Beauty: 79.68% (Highest)
        Clothing: 79.31%
        Electronics: 78.57%

7️⃣ Weekly Sales Performance

    High sales spikes on Nov 22, Dec 12, Dec 13, indicating possible promotions or peak shopping days.
    Sales peak at the start and mid-month but decline towards the end of the month.

💡 Business Insights

1️⃣ Holiday Season Boost

    Strong Q4 (Sept-Dec) sales indicate holiday-driven shopping trends.

2️⃣ Product Focus

    Electronics & Beauty categories have high revenue & profit margins.

3️⃣ Target Age Group

    Marketing campaigns should focus on customers aged 36-50 & 50+.

4️⃣ Strategic Discounting

    Implementing end-of-month discounts can help increase sales during slow periods.



