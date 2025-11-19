{{ config(materialized='view') }}

-- Model: stg_posts_questions
-- Purpose: This intermediate model filters records for questions posts.

    select
        s_post.post_id as question_id,
        s_post.post_owner_user_id as post_owner_user_id,
        s_post.question_post,
        s_post.post_creation_date as question_created_date, 
        s_post.accepted_answer_id 
    from {{ ref('stg_posts') }} s_post
    where s_post.post_type_id = 1