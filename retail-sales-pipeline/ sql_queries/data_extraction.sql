/*
Script Name: data_extraction.sql
Purpose: Extract and analyze data from the 'thelook_ecommerce.orders' table in BigQuery.
Author: Kittima Rodriguez
Created Date: YYYY-MM-DD
Version: 1.0
Description: This script includes queries to count total orders, retrieve sample transactions, and identify top-selling products.
*/

-- 1️⃣ Calculate the total number of orders to assess overall sales volume.
SELECT COUNT(*) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`;

-- 2️⃣ Retrieve a sample of 10 sales transactions to understand the data structure and content.
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 10;

-- 3️⃣ Identify the top 10 best-selling products by total revenue to determine product performance.
SELECT product_id, product_name, COUNT(order_id) AS total_orders, SUM(sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY product_id, product_name
ORDER BY total_revenue DESC
LIMIT 10;

/*
Summary:
- Total Orders: [Result]
- Sample Transactions: Retrieved 10 sample records.
- Top 10 Best-Selling Products: Listed with total orders and revenue.

Next Steps:
- Perform deeper analysis on customer demographics.
- Explore sales trends over time.
- Investigate regional sales performance.
*/

