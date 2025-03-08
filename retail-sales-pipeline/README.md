# 📊 Retail Sales Data Pipeline (Ongoing)

🚀 **An end-to-end ETL pipeline analyzing retail sales data using SQL, Google BigQuery, and Tableau.**

---

## 📌 Project Overview
This project focuses on extracting, transforming, and analyzing retail sales data to uncover insights into customer behavior, product performance, and revenue trends. The pipeline processes raw data from **Google BigQuery’s `thelook_ecommerce` dataset**, cleans and structures it for analysis, and visualizes findings using **Tableau**.

---

## 🛠️ Tools & Technologies
- **SQL (BigQuery)** – Data extraction, transformation, and aggregation
- **ETL Pipeline (Google Cloud, dbt)** – Automated data processing
- **Tableau** – Interactive visualizations for insights

---

## 📂 Dataset
The dataset is sourced from **Google BigQuery's public datasets**:
- **Order Items Table:** `bigquery-public-data.thelook_ecommerce.order_items`
- **Products Table:** `bigquery-public-data.thelook_ecommerce.products`
These tables include details on transactions, product categories, customer demographics, and revenue. 

## 📂 Project Files
### **🔹 SQL Scripts**
| File Name | Description |
|-----------|-------------|
| [`data_extraction.sql`](https://github.com/KittimaRodriguez/CaseStudy/blob/main/retail-sales-pipeline/%20sql_queries/data_extraction.sql)| Extracts raw sales data from BigQuery |
| [`data_cleaning.sql`](https://github.com/KittimaRodriguez/CaseStudy/blob/main/retail-sales-pipeline/%20sql_queries/data_cleaning.sql) | Cleans and standardizes data (removes duplicates, handles nulls, formats dates) |
|[`data_analysis.sql`](https://github.com/KittimaRodriguez/CaseStudy/blob/main/retail-sales-pipeline/%20sql_queries/data_analysis.sql)  | Performs customer segmentation, revenue calculations, and sales trends analysis |

### **📊 Tableau Dashboard (Ongoing)**
- **Retail Sales Dashboard** (Coming soon)

---

## 🔍 Key Insights Explored  
- Which products generate the highest sales?
- How are sales distributed across different product categories? 
- How do sales trends vary over time?
- Which days of the week have the highest sales activity?
- What is the average revenue per order?
---

## 🚀 Next Steps
✔ **Optimize SQL queries** for better performance  
✔ **Expand the ETL pipeline** to enable real-time data updates  
✔ **Develop interactive Tableau dashboards** for enhanced business intelligence

---

📌 **Author:** *Kittima Rodriguez*  
📅 **Last Updated:** *March 2025*



