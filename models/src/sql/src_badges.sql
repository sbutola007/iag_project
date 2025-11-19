with raw_badges as (
    select *
    from read_parquet('{{ var("badges_path") }}')
)
select *
from raw_badges