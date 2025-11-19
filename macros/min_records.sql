{% test min_records(model) %}
    select count(*) as row_count
    from {{ model }}
    having count(*) < 1
{% endtest %}
