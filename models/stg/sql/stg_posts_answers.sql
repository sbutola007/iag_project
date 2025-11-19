{{ config(materialized='view') }}

-- Model: stg_posts_answers
-- Purpose: This intermediate model filters records for answers posts.

    select
        s_post.post_id as answer_id,
        s_post.parent_id,
        s_post.post_creation_date as answer_created_date,
        s_post.post_type_id
    from {{ ref('stg_posts') }} s_post
    where s_post.post_type_id = 2