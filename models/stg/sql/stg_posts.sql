{{ config(materialized='view') }}

-- Model: stg_posts
-- Purpose: This staging model filters records for questions

select
    Id as post_id,   
    PostTypeId as post_type_id, 
    AcceptedAnswerId as accepted_answer_id,  
    ParentId as parent_id,     
    CreationDate as post_creation_date,   
    Score as score,   
    ViewCount as post_view_count,   
    OwnerUserId as post_owner_user_id,
    title as question_post
from {{ ref('src_posts') }}