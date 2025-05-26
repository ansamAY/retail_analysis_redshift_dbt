-- Step 1: Drop the employee table if it exists
DROP TABLE IF EXISTS retail.dim_employees;

-- Step 2: Recreate the employee table with the proper schema
CREATE TABLE retail.dim_employees (
    employee_id INT PRIMARY KEY,
    employee_name TEXT,
    department TEXT,
    employment_type TEXT,
    hire_date DATE,
    store_id INT  -- Assuming store_id should be an integer
);

-- Step 3: Insert data into the employee table
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
