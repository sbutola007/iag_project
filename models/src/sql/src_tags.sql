with raw_tags as (
    select *
    from read_parquet('{{ var("tags_path") }}')
)
select *
from raw_tags