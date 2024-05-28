{{
  config(
    materialized='view'
  )
}}

with 

src_addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed_casted as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        _fivetran_synced

    from src_addresses

)

select * from renamed_casted
