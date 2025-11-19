with raw_post_links as (
    select *
    from read_parquet('{{ var("post_links_path") }}')
)
select *
from raw_post_links