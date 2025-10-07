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
        ordered_at,
        sum(order_total) as order_revenue 
    from orders 
    group by 1
)

select * from agg