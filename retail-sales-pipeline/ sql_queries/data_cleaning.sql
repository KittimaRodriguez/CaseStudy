/*
Script Name: data_cleaning.sql
Purpose: Clean and preprocess retail sales data from 'thelook_ecommerce.order_items' in BigQuery.
Author: Kittima Rodriguez
Created Date: 03/04/2025
Version: 1.3
Description: 
This script removes duplicates, handles missing values, standardizes date formats, 
and ensures valid sales data for further analysis.
NOTE: Since DML queries (DELETE, UPDATE) are not allowed in the free tier, we use a filtered table creation approach instead.
*/

-- 1️⃣ Identify Missing Values
-- Count NULL values in key columns to determine data quality.
SELECT 
  COUNTIF(order_id IS NULL) AS missing_order_id,
  COUNTIF(product_id IS NULL) AS missing_product_id,
  COUNTIF(user_id IS NULL) AS missing_user_id,
  COUNTIF(sale_price IS NULL) AS missing_sale_price
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- 2️⃣ Identify Duplicate Orders
-- Find duplicate order and product combinations.
SELECT order_id, product_id, COUNT(*) AS duplicate_count
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;  

-- 3️⃣ Identify Invalid Transactions
-- Transactions with sale_price ≤ 0 might indicate errors, refunds, or test transactions.
-- This step helps in understanding data inconsistencies.
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE sale_price <= 0;

-- 4️⃣ Data Cleaning: Remove Duplicates, Join Product Names, Standardize Dates, and Filter Valid Sales
-- This step creates a cleaned dataset with:
-- Unique (DISTINCT) transactions to remove duplicates.
-- A JOIN with the "products" table to include product names.
-- A standardized date format (DATE instead of TIMESTAMP).
-- A filter to exclude invalid sales (sale_price ≤ 0).
CREATE OR REPLACE TABLE `retail-sales-pipeline.sales_data.cleaned_order_items` AS
SELECT DISTINCT 
    o.order_id, 
    o.user_id, 
    o.product_id, 
    p.name AS product_name,  
    o.sale_price, 
    DATE(o.created_at) AS order_date  -- Standardizing timestamp to date
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS o
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p 
ON o.product_id = p.id
WHERE o.sale_price > 0;  -- Filtering out invalid transactions.

/*
Summary:
✔ Identified missing values in key columns: No NULL values found.
✔ Removed duplicate order records: Found duplicate in `bigquery-public-data.thelook_ecommerce.order_items`
✔ Standardized date format to 'YYYY-MM-DD': Converted TIMESTAMP → DATE.
✔ Used a filtered table approach to exclude invalid transactions (no DELETE due to free tier restrictions).

Next Steps:
- Perform deeper data transformation (aggregations, revenue calculations).
- Analyze trends in sales and customer purchasing behavior.
*/
