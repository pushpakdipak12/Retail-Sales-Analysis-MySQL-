# Retail Sales Analysis SQL Project

Project Overview

Objectives

1.Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2.Data Cleaning: Identify and remove any records with missing or null values.
3.Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4.Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

Project Structure

1.Database Setup
Database Creation: The project starts by creating a database named p1_retail_db.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
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

## Overview
This project analyzes retail sales data using SQL queries to uncover trends, customer behavior, and sales performance.

## Dataset Information
The dataset consists of transactional sales records with the following fields:

| Column Name       | Description                              |
|-------------------|------------------------------------------|
| `transactions_id` | Unique transaction identifier           |
| `sale_date`       | Date of the sale                        |
| `sale_time`       | Time of the sale                        |
| `customer_id`     | Unique customer identifier              |
| `gender`         | Customer's gender                       |
| `age`            | Customer's age                          |
| `category`       | Product category                        |
| `quantiy`        | Number of units sold                    |
| `price_per_unit` | Price per unit of the product           |
| `cogs`           | Cost of goods sold                      |
| `total_sale`     | Total revenue generated                 |

## SQL Analysis Performed
### 1️⃣ **Sales Trends & Performance**
- **Monthly Revenue:** Total revenue generated each month.
- **Peak Sales Time:** Finding the hours with the highest sales.
- **Average Order Value:** Analyzing the spending behavior of customers.

### 2️⃣ **Customer Insights**
- **Gender & Age Distribution:** Understanding customer demographics.
- **Repeat Customers:** Identifying loyal customers.

### 3️⃣ **Product & Category Analysis**
- **Top-Selling Categories:** Identifying which product categories generate the most revenue.
- **Category-Wise Profit Margins:** Calculating the most profitable product lines.

### 4️⃣ **Operational Efficiency**
- **COGS vs. Sales:** Analyzing cost of goods sold per month.
- **Best Performing Days:** Finding the most profitable days of the week.

## Sample SQL Queries
```sql
-- Total revenue per month
SELECT strftime('%Y-%m', sale_date) AS month, SUM(total_sale) AS total_revenue
FROM retail_sales_analysis
GROUP BY month
ORDER BY month;

-- Most frequently purchased product category
SELECT category, SUM(quantiy) AS total_quantity_sold
FROM retail_sales_analysis
GROUP BY category
ORDER BY total_quantity_sold DESC
LIMIT 5;
