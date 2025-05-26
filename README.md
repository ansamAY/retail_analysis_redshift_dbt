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

### 📊 Fact
- `fact_sales`: Raw sales transactions

###  Marts (Business Models)
- `customer_segments`: High/Medium/Low value classification
- `monthly_sales`: Aggregated monthly KPIs



##  Incremental Model Configuration

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

## Getting Started
##  1. Create Tables in Redshift
Run the provided DDL & data generation queries to create and populate your tables in the retail schema.

##  2. Connect dbt Cloud
- Link your Redshift dev credentials

- Connect your GitHub repo (project code)

- Set up environment & job schedules

##  3. Run dbt Models
In dbt Cloud:

- Build all models: dbt run

- Run tests: dbt test

- View docs: dbt docs generate && dbt docs serve


