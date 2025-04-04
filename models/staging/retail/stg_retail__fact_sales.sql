with 

source as (

    select * from {{ source('retail', 'fact_sales') }}

),

stg_fact_sales as (

    select
        sale_id,
        customer_id,
        product_id,
        store_id,
        sale_date,
        quantity_sold,
        total_amount

    from source

)

select * from stg_fact_sales



