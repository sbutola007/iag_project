select *
from {{ ref('fct_top_rank_users') }}
where (select count(*) from {{ ref('fct_top_rank_users') }}) > 10