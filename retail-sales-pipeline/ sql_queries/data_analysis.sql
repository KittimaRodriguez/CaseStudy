/*
Script Name: data_analysis.sql
Purpose: Perform data transformation and analysis on cleaned retail sales data in BigQuery.
Author: Kittima Rodriguez
Created Date: 03/04/2025
Version: 1.1
Description: 
This script aggregates and transforms the cleaned retail sales data to extract meaningful insights.
*/

-- 1️⃣ Calculate Total Revenue and Orders per Product
-- Aggregates sales data to determine revenue and order count per product.
SELECT 
  product_id, 
  COUNT(order_id) AS total_orders, 
  SUM(sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
GROUP BY product_id
ORDER BY total_revenue DESC;

-- 2️⃣ Analyze Customer Purchase Behavior
-- Calculates the total spending and order frequency per user.
SELECT 
  user_id, 
  COUNT(order_id) AS total_orders, 
  SUM(sale_price) AS total_spent, 
  AVG(sale_price) AS avg_order_value
FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
GROUP BY user_id
ORDER BY total_spent DESC;

-- 3️⃣ Identify Seasonal Sales Trends
-- Aggregates sales by month to find seasonal trends.
SELECT 
  EXTRACT(YEAR FROM created_at) AS year, 
  EXTRACT(MONTH FROM created_at) AS month, 
  COUNT(order_id) AS total_orders, 
  SUM(sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
GROUP BY year, month
ORDER BY year DESC, month DESC;


-- 4️⃣ Analyze Sales by Product Category (Requires Category Mapping Table)
-- If a product category mapping table exists, join it to analyze revenue per category.
SELECT 
  c.category, 
  COUNT(o.order_id) AS total_orders, 
  SUM(o.sale_price) AS total_revenue
FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final` AS o
JOIN `bigquery-public-data.thelook_ecommerce.products` AS c
ON o.product_id = c.id
GROUP BY c.category
ORDER BY total_revenue DESC;

/*
Summary:
✔ Calculated total revenue and orders per product.
✔ Analyzed customer spending patterns.
✔ Identified seasonal trends in sales.
✔ Categorized sales by product category.

Next Steps:
- Perform advanced trend analysis (e.g., year-over-year growth, regional analysis).
- Create visualizations in Tableau based on the extracted insights.
*/

