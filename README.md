#  Complete Data Engineering Project with dbt Cloud, Redshift & GitHub

This project showcases a full-stack data engineering pipeline using **dbt Cloud**, **Amazon Redshift**, and **GitHub**, simulating a real-world retail analytics use case — from raw transactional data to business-ready insights and segmentation.

---

##  Tech Stack

- **dbt Cloud**: Data transformation and orchestration
- **Amazon Redshift**: Cloud data warehouse
- **GitHub**: Version control for collaboration
- **SQL + Jinja**: Transformation logic and templating

---

##  Project Structure

---

## 🗂️ Data Models Overview

### ✅ Dimensions (`dim_`)
- `dim_customers`: Customer details
- `dim_products`: Product catalog
- `dim_employees`: Store and employee info
- `dim_time`: Calendar table

### 📊 Fact
- `fact_sales`: Raw sales transactions

### 🎯 Marts (Business Models)
- `customer_segments`: High/Medium/Low value classification
- `monthly_sales`: Aggregated monthly KPIs
- `sales_summary`: Sales by region and department

---

## 🔁 Incremental Model Configuration

We configure `stg_retail__fact_sales` as **incremental** with merge strategy:

```yaml
models:
  my_new_project:
    staging:
      +materialized: view
    marts:
      +materialized: table
    staging/retail/stg_retail__fact_sales:
      +materialized: incremental
      +unique_key: sale_id
      +on_schema_change: merge


