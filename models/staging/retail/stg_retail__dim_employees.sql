with 

source as (

    select * from {{ source('retail', 'dim_employees') }}

),

stg_dim_employees as (

    select
        employee_id,
        employee_name,
        department,
        employment_type,
        hire_date,
        store_id

    from source

)

select * from stg_dim_employees
