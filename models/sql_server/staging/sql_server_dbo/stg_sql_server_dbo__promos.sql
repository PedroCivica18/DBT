{{
  config(
    materialized='view'
  )
}}

with 

src_promos as (
    select * from {{ source('sql_server_dbo', 'promos') }}
),

filtered_promos as (
    select
        *,
        case
            when status = 'active' then 1
            when status = 'inactive' then 0
            else null  -- handle other cases as needed
        end as status_numeric
    from src_promos
    -- Add WHERE clause to filter out deleted records
    where _fivetran_deleted = false or _fivetran_deleted is null
),

transformed_promos as (
    select
        md5(promo_id) as promo_id,
        promo_id as promo_name,
        discount as discount_euros,
        status_numeric as status,
        _fivetran_deleted,
        -- Convert _fivetran_synced to UTC time
        CONVERT_TIMEZONE('UTC', _fivetran_synced) as _fivetran_synced_utc
    from filtered_promos

    union all

    select
        md5('sin_promo') as promo_id,
        'sin_promo' as promo_name,
        NULL as discount_euros,
        NULL as status,
        NULL as _fivetran_deleted,  -- assuming NULL for 'sin_promo'
        NULL as _fivetran_synced_utc  -- assuming NULL for 'sin_promo'
)

select * from transformed_promos






