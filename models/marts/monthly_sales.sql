WITH sales_by_month AS (
   SELECT
       EXTRACT(YEAR FROM sale_date) AS year,
       EXTRACT(MONTH FROM sale_date) AS month,
       SUM(total_amount) AS total_sales,
       COUNT(DISTINCT sale_id) AS total_transactions
   FROM {{ ref('stg_retail__fact_sales') }}
   GROUP BY year,month
)


SELECT
   year,
   month,
   total_sales,
   total_transactions,
   total_sales / total_transactions AS avg_sales_per_transaction
FROM sales_by_month
ORDER BY month






