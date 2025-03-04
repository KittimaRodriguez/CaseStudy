Write SQL Queries for Data Extraction
Start with basic queries to understand the data:

1️⃣ Count total orders

SELECT COUNT(*) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`;
2️⃣ View sample sales transactions

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 10;
3️⃣ Find the top 10 best-selling products

SELECT product_id, product_name, COUNT(order_id) AS total_orders, SUM(sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY product_id, product_name
ORDER BY total_revenue DESC
LIMIT 10;
