with raw_users as (
    select *
    from read_parquet('{{ var("users_path") }}')
)
select *
from raw_users