/*
Script Name: data_analysis.sql
Purpose: Analyze sales data to gain insights into top-selling products, sales distribution, trends, and revenue.
Author: Kittima Rodriguez
Created Date: 03/04/2025
Version: 1.1
Description: 
This script performs exploratory data analysis (EDA) on the cleaned order items dataset.
It includes queries to identify best-selling products, revenue distribution, sales trends, and peak sales periods.
*/

-- 1️⃣ Top-Selling Products
-- Identify the products with the highest sales volume.
SELECT 
    product_name, 
    COUNT(product_id) AS total_sales
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 2️⃣ Sales Distribution Across Product Categories
-- Determine which product categories generate the most sales.
SELECT 
    category, 
    SUM(sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY category
ORDER BY total_revenue DESC;

-- 3️⃣ Sales Trend Over Time
-- Analyze monthly sales trends to observe growth patterns.
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(sale_price) AS monthly_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY year, month
ORDER BY year, month;

-- 4️⃣ Sales Distribution by Order Date
-- Identify the busiest days for sales.
SELECT 
    order_date, 
    COUNT(order_id) AS total_orders
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY order_date
ORDER BY total_orders DESC
LIMIT 10;

-- 5️⃣ Revenue Generated Per Order
-- Calculate the average revenue per order.
SELECT 
    order_id,
    SUM(sale_price) AS order_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY order_id
ORDER BY order_revenue DESC;

-- 6️⃣ Top Customer Spending
-- Identify customers who spent the most.
SELECT 
    user_id,
    SUM(sale_price) AS total_spent
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

-- 7️⃣ Peak Month Sales
-- Find the month with the highest total sales revenue.
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(sale_price) AS monthly_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY year, month
ORDER BY monthly_revenue DESC
LIMIT 1;

/*
📌 Summary:
✔ Top-Selling Products: Identified best-selling items based on total sales.
✔ Sales by Category: Determined which product categories contribute most to revenue.
✔ Sales Trend: Analyzed monthly sales trends.
✔ Busiest Days: Found peak order dates.
✔ Revenue per Order: Calculated average earnings per order.
✔ Top Customer Spending: Identified high-value customers.
✔ Peak Month Sales: Determined the highest revenue-generating month.
*/


Next Steps:
- Create visualizations in Tableau based on the extracted insights.
*/

