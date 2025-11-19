{% test positive_values(model, column_name)%}
select * from {{ model }} where try_cast({{ column_name }} as integer) < 0
{% endtest %}