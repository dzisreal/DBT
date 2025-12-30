with source as (
    select * from {{ ref('raw_customers') }}
)

select
    id as customer_id,
    first_name,
    last_name,
    email,
    created_at
from source
where
    {% if target.name == 'dev' %}
        created_at >= '2023-01-10'
    {% else %}
        created_at >= '2023-01-05'
    {% endif %}
