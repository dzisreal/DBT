with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    customers.created_at,
    min(orders.order_date) as first_order_date,
    max(orders.order_date) as last_order_date,
    count(orders.order_id) as total_orders,
    sum(orders.total_amount) as lifetime_value
from customers
left join orders
    on customers.customer_id = orders.customer_id
where
    {% if target.name == 'dev' %}
        customers.created_at >= '2023-01-10'
    {% else %}
        customers.created_at >= '2023-01-05'
    {% endif %}
group by 1,2,3,4,5
