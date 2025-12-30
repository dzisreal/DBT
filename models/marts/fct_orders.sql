with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select
        order_id,
        sum(amount) as total_amount,
        max(payment_date) as last_payment_date
    from {{ ref('stg_payments') }}
    group by order_id
)

select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    coalesce(payments.total_amount, 0) as total_amount,
    payments.last_payment_date
from orders
left join payments
    on orders.order_id = payments.order_id
where
    {% if target.name == 'dev' %}
        orders.order_date >= '2023-02-10'
    {% else %}
        orders.order_date >= '2023-02-01'
    {% endif %}
