{{ config(
    access = 'public',
    catalog_name = 'iceberg_rest_catalog',
    materialized = 'table'
)}}

select 
    "ordered_at",
    sum("order_total") as order_revenue 
from {{ ref('xplat_foundation', 'fct_orders') }}
group by 1