with 

source as (

    select * from {{ source('retail', 'dim_customers') }}

),

stg_dim_customers as (

    select
        customer_id,
        customer_name,
        email,
        region,
        signup_date

    from source

)

select * from stg_dim_customers
