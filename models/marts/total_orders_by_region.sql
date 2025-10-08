{{ config(
    access = 'public',
    catalog_name = 'iceberg_rest_catalog',
    materialized = 'table'
)}}

with orders as (
    select * from {{ ref('xplat_foundation', 'fct_orders') }}
),

agg as (
    select
        "ordered_at",
        "location_name", 
        count("order_id") as order_count,
        sum("order_total") as orders_revenue
    from orders 
    group by 1,2
)

select * from agg