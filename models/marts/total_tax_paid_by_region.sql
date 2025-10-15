with orders as (
    select * from {{ ref('project_or_package', 'model_name') }}
),

final as (
    select 
        "location_name",
        "tax_rate",
        sum("tax_paid"::number(5,2)) as total_tax_paid,
        count("order_id") as order_count
    from orders
    group by 1,2
)

select * from final
