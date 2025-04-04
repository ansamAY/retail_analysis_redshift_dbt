with 

source as (

    select * from {{ source('retail', 'dim_products') }}

),

stg_dim_products as (

    select
        product_id,
        product_name,
        category,
        price

    from source

)

select * from stg_dim_products
