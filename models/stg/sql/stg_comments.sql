{{ config(materialized='view') }}

-- Model: stg_comments
-- Purpose: Raw comments table with readable column names

select
    Id as comment_id, 
    PostId as post_id,
    UserId as comment_user_id,
    Text as comment_text,
    CreationDate as comment_creation_date
from {{ ref('src_comments') }}