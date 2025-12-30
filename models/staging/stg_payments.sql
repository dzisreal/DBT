with source as (
    select * from {{ ref('raw_payments') }}
)

select
    id as payment_id,
    order_id,
    payment_method,
    {{ cents_to_dollars('amount_cents') }} as amount,
    payment_date
from source
where
    {% if target.name == 'dev' %}
        payment_method in ('credit_card', 'bank_transfer')
    {% else %}
        payment_method in ('credit_card', 'bank_transfer', 'cash')
    {% endif %}
