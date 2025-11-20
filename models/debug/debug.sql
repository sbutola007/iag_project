-- models/debug/stg_posts_filtered.sql
-- this is just for running my own tests.
 {{ config(materialized='view') }}

select 
*
from {{ ref('stg_posts') }} 
where post_type_id = 2 and question_post is not null
/*

   select
       *
pragma_table_info({{ ref('stg_posts') }})

*/