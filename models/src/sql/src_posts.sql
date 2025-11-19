with raw_posts as (
    select *
    from read_parquet('{{ var("posts_path") }}')
)
select *
from raw_posts  