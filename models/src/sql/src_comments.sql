with raw_comments as (
    select *
    from read_parquet('{{ var("comments_path") }}')
)
select *
from raw_comments