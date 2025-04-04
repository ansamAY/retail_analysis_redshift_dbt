with 

source as (

    select * from {{ source('retail', 'dim_time') }}

),

stg_dim_time as (

    select
        date_id,
        year,
        quarter,
        month,
        day,
        day_of_week

    from source

)

select * from stg_dim_time
