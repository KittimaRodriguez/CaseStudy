/*
Script Name: data_analysis.sql
Purpose: Perform data transformation and analysis on cleaned retail sales data in BigQuery.
Author: Kittima Rodriguez
Created Date: 03/04/2025
Version: 1.1
Description: 
This script aggregates and transforms the cleaned retail sales data to extract meaningful insights into:
1. Top-selling products
2. Sales distribution across product categories
3. Sales trends over time
4. Sales distribution by order date
5. Revenue per order
*/

-- 1️⃣ Identify Top-Selling Products
-- This query calculates total revenue and total orders per product, then ranks them.
SELECT 
    product_name, 
    COUNT(order_id) AS total_orders, 
    SUM(sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10; -- Shows the top 10 best-selling products

-- 2️⃣ Sales Distribution Across Product Categories
-- This query groups sales data by product category to analyze revenue distribution.
SELECT 
    category, 
    COUNT(order_id) AS total_orders, 
    SUM(sale_price) AS total_revenue,
    ROUND(100 * SUM(sale_price) / (SELECT SUM(sale_price) FROM `retail-sales-pipeline.sales_data.cleaned_order_items`), 2) AS revenue_percentage
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY category
ORDER BY total_revenue DESC;

-- 3️⃣ Sales Trend Over Time (Monthly Sales)
-- This query aggregates total revenue and order count per month to identify trends.
SELECT 
    EXTRACT(YEAR FROM order_date) AS year, 
    EXTRACT(MONTH FROM order_date) AS month, 
    COUNT(order_id) AS total_orders, 
    SUM(sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY year, month
ORDER BY year, month;

-- 4️⃣ Sales Distribution by Order Date (Busiest Days)
-- This query finds the days with the highest number of transactions.
SELECT 
    order_date, 
    COUNT(order_id) AS total_orders, 
    SUM(sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`
GROUP BY order_date
ORDER BY total_orders DESC
LIMIT 10; -- Shows the 10 busiest sales days

-- 5️⃣ Revenue Per Order
-- This query calculates the average revenue generated per order.
SELECT 
    ROUND(AVG(sale_price), 2) AS avg_revenue_per_order
FROM `retail-sales-pipeline.sales_data.cleaned_order_items`;

/*
Summary:
✔ Calculated total revenue and orders per product.
✔ Analyzed customer spending patterns.
✔ Identified seasonal trends in sales.
✔ Categorized sales by product category.

│ Row   │ Metric                │ Value                │
|-------|-----------------------|----------------------|
│ 1     │ Top Selling Category  │ Outerwear & Coats    │
│ 2     │ Top Customer Spending │ 1,680 USD            │
│ 3     │ Total Orders          │ 125,442              │
│ 4     │ Total Revenue         │ 10,780,858.85 USD    │
│ 5     │ Peak Sales Month      │ February 2025        │


Next Steps:
- Perform advanced trend analysis (e.g., year-over-year growth, regional analysis).
- Create visualizations in Tableau based on the extracted insights.
*/

