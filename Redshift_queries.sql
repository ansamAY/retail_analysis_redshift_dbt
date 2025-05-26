CREATE SCHEMA retail;


-- Customer Dimension
CREATE TABLE retail.dim_customers (
   customer_id INT PRIMARY KEY,
   customer_name VARCHAR(100),
   email VARCHAR(100),
   region VARCHAR(50),
   signup_date DATE
);


-- Product Dimension
CREATE TABLE retail.dim_products (
   product_id INT PRIMARY KEY,
   product_name VARCHAR(100),
   category VARCHAR(50),
   price DECIMAL(10,2)
);


-- Store Dimension
CREATE TABLE retail.dim_stores (
   store_id INT PRIMARY KEY,
   store_name VARCHAR(100),
   location VARCHAR(100),
   manager_name VARCHAR(100)
);


-- Time Dimension
CREATE TABLE retail.dim_time (
   date_id DATE PRIMARY KEY,
   year INT,
   quarter INT,
   month INT,
   day INT,
   day_of_week VARCHAR(20)
);


-- Employee Dimension
CREATE TABLE retail.dim_employees (
   employee_id INT PRIMARY KEY,
   employee_name TEXT,
   department TEXT,
   employment_type TEXT,
   hire_date DATE,
   store_id INT  
);



-- Fact Sales
CREATE TABLE retail.fact_sales (
   sale_id INT PRIMARY KEY,
   customer_id INT REFERENCES retail.dim_customers(customer_id),
   product_id INT REFERENCES retail.dim_products(product_id),
   store_id INT REFERENCES retail.dim_stores(store_id),
   sale_date DATE REFERENCES retail.dim_time(date_id),
   quantity_sold INT,
   total_amount DECIMAL(10,2)
);


-- Fact Inventory
CREATE TABLE retail.fact_inventory (
   inventory_id INT PRIMARY KEY,
   product_id INT REFERENCES retail.dim_products(product_id),
   store_id INT REFERENCES retail.dim_stores(store_id),
   stock_date DATE REFERENCES retail.dim_time(date_id),
   stock_level INT
);



INSERT INTO retail.dim_customers
SELECT
   ROW_NUMBER() OVER() AS id,
   'Customer_' || ROW_NUMBER() OVER() AS customer_name,
   'customer' || ROW_NUMBER() OVER() || '@example.com' AS email,
   CASE
       WHEN ROW_NUMBER() OVER() % 4 = 0 THEN 'North'
       WHEN ROW_NUMBER() OVER() % 4 = 1 THEN 'South'
       WHEN ROW_NUMBER() OVER() % 4 = 2 THEN 'East'
       ELSE 'West'
   END AS region,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 3650) AS INT), CURRENT_DATE) AS signup_date
FROM STV_BLOCKLIST
LIMIT 100000;


############################################################################


INSERT INTO retail.dim_products
SELECT
   ROW_NUMBER() OVER() AS id,
   'Product_' || ROW_NUMBER() OVER() AS product_name,
   CASE
       WHEN ROW_NUMBER() OVER() % 3 = 0 THEN 'Electronics'
       WHEN ROW_NUMBER() OVER() % 3 = 1 THEN 'Clothing'
       ELSE 'Home & Kitchen'
   END AS category,
   ROUND(RANDOM() * 500 + 5, 2) AS price
FROM STV_BLOCKLIST
LIMIT 500;
###########################################################


INSERT INTO retail.dim_stores
SELECT
   ROW_NUMBER() OVER() AS id,
   'Store_' || ROW_NUMBER() OVER() AS store_name,
   CASE
       WHEN ROW_NUMBER() OVER() % 4 = 0 THEN 'New York'
       WHEN ROW_NUMBER() OVER() % 4 = 1 THEN 'Los Angeles'
       WHEN ROW_NUMBER() OVER() % 4 = 2 THEN 'Chicago'
       ELSE 'Houston'
   END AS city,
   'Address_' || ROW_NUMBER() OVER() AS address
FROM STV_BLOCKLIST
LIMIT 100;


############################################################
drop table retail.fact_sales
INSERT INTO retail.fact_sales
SELECT
   ROW_NUMBER() OVER() AS id,
   FLOOR(RANDOM() * 100000) + 1 AS customer_id,
   FLOOR(RANDOM() * 500) + 1 AS product_id,
   FLOOR(RANDOM() * 100) + 1 AS store_id,  -- Ensure store_id is an integer
   DATEADD(day, CAST(-FLOOR(RANDOM() * 1825) AS INT), CURRENT_DATE) AS sale_date,
   FLOOR(RANDOM() * 100) + 1 AS quantity_sold,
   ROUND((FLOOR(RANDOM() * 100) + 1) * (FLOOR(RANDOM() * 100) + 5), 2) AS total_amount
FROM STV_BLOCKLIST
LIMIT 1000000;




#############################################################
INSERT INTO retail.fact_inventory
SELECT
   ROW_NUMBER() OVER() AS id,
   FLOOR(RANDOM() * 500) + 1 AS product_id,
   FLOOR(RANDOM() * 100) + 1 AS store_id,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 1825) AS INT), CURRENT_DATE) AS stock_date,
   FLOOR(RANDOM() * 100) + 1 AS stock_level
FROM STV_BLOCKLIST
LIMIT 500000;


################################################################
-- First create a temporary table with the date series
CREATE TEMPORARY TABLE temp_date_series AS
SELECT CURRENT_DATE - INTERVAL '1 day' * (ROW_NUMBER() OVER() - 1) AS date_id
FROM STV_BLOCKLIST
LIMIT 5000;


-- Then perform the INSERT using the temporary table
INSERT INTO retail.dim_time (date_id, year, quarter, month, day, day_of_week)
SELECT
   date_id,
   EXTRACT(YEAR FROM date_id) AS year,
   EXTRACT(QUARTER FROM date_id) AS quarter,
   EXTRACT(MONTH FROM date_id) AS month,
   EXTRACT(DAY FROM date_id) AS day,
   TO_CHAR(date_id, 'Day') AS day_of_week
FROM temp_date_series;


-- Clean up by dropping the temporary table
DROP TABLE temp_date_series;
#########################################################################


-- Insert data into the employee table
INSERT INTO retail.dim_employees (employee_id, employee_name, department, employment_type, hire_date, store_id)
SELECT
   CAST(ROW_NUMBER() OVER() AS INTEGER) AS employee_id,  -- Explicitly cast employee_id to integer
   'Employee_' || CAST(ROW_NUMBER() OVER() AS TEXT) AS employee_name,  -- employee_name is text
   CASE
       WHEN ROW_NUMBER() OVER() % 3 = 0 THEN 'HR'
       WHEN ROW_NUMBER() OVER() % 3 = 1 THEN 'Sales'
       ELSE 'Operations'
   END AS department,
   CASE
       WHEN ROW_NUMBER() OVER() % 2 = 0 THEN 'Full-time'
       ELSE 'Part-time'
   END AS employment_type,
   DATEADD(day, CAST(-FLOOR(RANDOM() * 3650) AS INT), CURRENT_DATE) AS hire_date,  -- Generates random hire date in the past
   CAST((ROW_NUMBER() OVER() % 5) + 1 AS INT) AS store_id  -- Generate store_id as integer (values between 1 and 5)
FROM STV_BLOCKLIST
LIMIT 10000;  -- Limit to 10,000 rows
