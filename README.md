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

## Data Models Overview

###  Dimensions (`dim_`)
- `dim_customers`: Customer details
- `dim_products`: Product catalog
- `dim_employees`: Store and employee info
- `dim_time`: Calendar table

###  Fact
- `fact_sales`: Raw sales transactions

###  Marts (Business Models)
- `customer_segments`: High/Medium/Low value classification
- `monthly_sales`: Aggregated monthly KPIs




## Getting Started
##  1. Create Tables in Redshift
You can just run the provided queries to create and fill your tables in the retail schema (Redshift_queries.sql).

##  2. Connect dbt Cloud
- Link your Redshift dev credentials

- Connect your GitHub repo (project code)

- Set up environment & job schedules

##  3. Run dbt Models
In dbt Cloud:

- Build all models: dbt run

- Run tests: dbt test

- View docs: dbt docs generate && dbt docs serve


