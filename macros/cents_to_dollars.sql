{% macro cents_to_dollars(amount_cents) %}
    ({{ amount_cents }} / 100.0)
{% endmacro %}
