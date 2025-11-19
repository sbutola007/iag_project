-- models/debug/stg_posts_filtered.sql
-- this is just for running my own tests.
 {{ config(materialized='view') }}

select 
parent_id, count(*)
from {{ ref('stg_posts_answers') }} 
--where post_type_id = 1
group by parent_id
having count(*)>1
/*

   select
       *
pragma_table_info({{ ref('stg_posts') }})

*/