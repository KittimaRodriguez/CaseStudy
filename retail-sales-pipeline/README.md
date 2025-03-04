# 🏪 Retail Sales Data Pipeline  
🚀 **An end-to-end ETL pipeline analyzing retail sales data using SQL, Google BigQuery, and Tableau.**  

## 📌 Project Overview  
This project processes retail transaction data to uncover **sales trends, customer behaviors, and product performance.**  

## 🛠️ Skills Used  
- **SQL (BigQuery)** for data extraction & transformation  
- **ETL Pipeline (Google Cloud, dbt)** for automated data processing  
- **Tableau** for data visualization  

## 📌 **Dataset**  
Using [`bigquery-public-data.thelook_ecommerce.orders`](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=thelook_ecommerce&t=orders&page=table), this dataset provides retail transaction records, including order details, customer demographics, and sales revenue.  

## 📂 Project Files
### **🔹 SQL Scripts**
| File Name | Description |
|-----------|-------------|
| [`data_extraction.sql`](./sql_queries/data_extraction.sql) | Extracts raw sales data from BigQuery |
| [`data_cleaning.sql`](./sql_queries/data_cleaning.sql) | Cleans and standardizes data (removes duplicates, handles nulls, formats dates) |
| [`data_analysis.sql`](./sql_queries/data_analysis.sql) | Performs customer segmentation, revenue calculations, and sales trends analysis |

## 📂 Project Files  
📜 **SQL Scripts:**  
- [`data_extraction.sql`](https://github.com/KittimaRodriguez/CaseStudy/blob/main/retail-sales-pipeline/%20sql_queries/data_extraction.sql) – Extract raw sales data  
- [`data_cleaning.sql`](https://github.com/KittimaRodriguez/CaseStudy/blob/main/retail-sales-pipeline/%20sql_queries/data_cleaning.sql) – Clean & transform data  
- [`data_analysis.sql`](https://github.com/KittimaRodriguez/CaseStudy/blob/main/retail-sales-pipeline/%20sql_queries/data_analysis.sql) – Analyze customer trends  

📊 **Tableau Dashboard:**  (On going)
- [`Retail Sales Dashboard`](dashboard/retail_dashboard.twbx) – Interactive visualization  

## 🔍 Key Insights Explored  
✅ What are the **top-selling products**?  
✅ Which **customer segments** generate the most revenue?  
✅ How do **sales vary across different regions & time periods**?  

## 🚀 Next Steps  
- Optimize SQL queries for performance  
- Expand the ETL pipeline for real-time updates  
- Develop machine learning models for sales forecasting  


