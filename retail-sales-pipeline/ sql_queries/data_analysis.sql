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

-- 5️⃣ Generate Summary Table
-- Creates a consolidated summary of key insights for easy reference.
CREATE OR REPLACE TABLE `retail-sales-pipeline.sales_data.analysis_summary` AS
WITH product_revenue AS (
  SELECT 'Total Revenue' AS metric, CAST(SUM(sale_price) AS STRING) AS value
  FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
),
order_count AS (
  SELECT 'Total Orders' AS metric, CAST(COUNT(DISTINCT order_id) AS STRING) AS value
  FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
),
top_customer AS (
  SELECT 'Top Customer Spending' AS metric, CAST(MAX(total_spent) AS STRING) AS value
  FROM (
    SELECT user_id, SUM(sale_price) AS total_spent
    FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
    GROUP BY user_id
  )
),
seasonal_trends AS (
  SELECT 'Peak Sales Month' AS metric, FORMAT('%04d-%02d', year, month) AS value
  FROM (
    SELECT EXTRACT(YEAR FROM created_at) AS year, EXTRACT(MONTH FROM created_at) AS month, 
           COUNT(order_id) AS total_orders, RANK() OVER (ORDER BY COUNT(order_id) DESC) AS rank
    FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final`
    GROUP BY year, month
  ) WHERE rank = 1
),
top_category AS (
  SELECT 'Top Selling Category' AS metric, category AS value
  FROM (
    SELECT c.category, SUM(o.sale_price) AS total_revenue,
           RANK() OVER (ORDER BY SUM(o.sale_price) DESC) AS rank
    FROM `retail-sales-pipeline.sales_data.cleaned_order_items_final` AS o
    JOIN `bigquery-public-data.thelook_ecommerce.products` AS c
    ON o.product_id = c.id
    GROUP BY c.category
  ) WHERE rank = 1
)
SELECT * FROM product_revenue
UNION ALL
SELECT * FROM order_count
UNION ALL
SELECT * FROM top_customer
UNION ALL
SELECT * FROM seasonal_trends
UNION ALL
SELECT * FROM top_category;

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

