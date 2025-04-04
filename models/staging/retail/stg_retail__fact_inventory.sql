with 

source as (

    select * from {{ source('retail', 'fact_inventory') }}

),

stg_fact_inventory as (

    select
        inventory_id,
        product_id,
        store_id,
        stock_date,
        stock_level

    from source

)

select * from stg_fact_inventory
