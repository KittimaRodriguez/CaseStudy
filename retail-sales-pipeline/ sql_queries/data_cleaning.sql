/*
Script Name: data_cleaning.sql
Purpose: Clean and preprocess retail sales data from 'thelook_ecommerce.order_items' in BigQuery.
Author: Kittima Rodriguez
Created Date: YYYY-MM-DD
Version: 1.0
Description: 
This script removes duplicates, handles missing values, standardizes date formats, 
and ensures valid sales data for further analysis.
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

-- 3️⃣ Remove Duplicate Records
-- Creates a cleaned table with distinct order records.
CREATE OR REPLACE TABLE `your_project.cleaned_order_items` AS
SELECT DISTINCT * FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- 4️⃣ Standardize Date Format
-- Convert created_at timestamps into proper DATE format for easier analysis.
CREATE OR REPLACE TABLE `your_project.cleaned_order_items` AS
SELECT 
  order_id, 
  user_id, 
  product_id, 
  DATE(created_at) AS order_date, 
  sale_price
FROM `your_project.cleaned_order_items`;

-- 5️⃣ Remove Invalid Transactions
-- Delete transactions with negative or zero sale prices.
DELETE FROM `your_project.cleaned_order_items`
WHERE sale_price <= 0;

/*
Summary:
✔ Identified missing values in key columns.
✔ Removed duplicate order records.
✔ Standardized date format to 'YYYY-MM-DD'.
✔ Deleted invalid transactions with non-positive sales prices.

Next Steps:
- Perform deeper data transformation (aggregations, revenue calculations).
- Analyze trends in sales and customer purchasing behavior.
*/

