{{
  config(
    materialized='view'
  )
}}

with 


stg_order_items as (
    select 
        order_id,
        product_id,
        quantity,
        _fivetran_deleted as order_item_deleted,
        _fivetran_synced as order_item_synced
    from {{ ref('stg_sql_server_dbo__order_items') }}
),


stg_orders as (
    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted as order_deleted,
        _fivetran_synced as order_synced
    from {{ ref('stg_sql_server_dbo__orders') }}
),


order_items_orders as (
    select 
        oi.order_id,
        oi.product_id,
        oi.quantity,
        o.shipping_service,
        o.shipping_cost,
        o.address_id,
        o.created_at,
        o.promo_id,
        o.estimated_delivery_at,
        o.order_cost,
        o.user_id,
        o.order_total,
        o.delivered_at,
        o.tracking_id,
        o.status,
        oi.order_item_deleted,
        oi.order_item_synced,
        o.order_deleted,
        o.order_synced
    from stg_order_items oi
    join stg_orders o on oi.order_id = o.order_id
)

select * from order_items_orders
