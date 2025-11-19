with raw_votes as (
    select *
    from read_parquet('{{ var("votes_path") }}')
)
select *
from raw_votes