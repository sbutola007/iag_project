{{ config(materialized='table') }}

-- Model: fct_post_with_at_replies
-- Purpose: Count questions where the question owner is replying with @ 
-- in post comments or owner used @ in his question post.
-- post_type_id = 1 means "Question" and 2 means "Answer" as per StackOverflow dataset

with cte_comments as (
    select
        s_comments.comment_id,
        s_comments.post_id,
        s_comments.comment_user_id,
        s_comments.comment_text
    from {{ ref('stg_comments') }} s_comments
),

-- Step 1: Mapping each comments to its question_id
cte_comment_post as (
    select
        cte_c.comment_id,
        cte_c.comment_user_id,
        cte_c.comment_text,
        case
            when cte_q.question_id is not null then cte_q.question_id
            else cte_a.parent_id
        end as question_id
    from cte_comments cte_c
    left join {{ ref('stg_posts_questions') }} cte_q
      on cte_c.post_id = cte_q.question_id
    left join {{ ref('stg_posts_answers') }} cte_a
      on cte_q.question_id = cte_a.parent_id
),

-- Step 2: Keeping only comments for user who asked the original question and his replies start with '@'
    -- this also includes if @ is in question post.
cte_owner_at_replies as (
    select distinct
        ct.comment_user_id,
        ct.question_id as post_id,
        q.post_owner_user_id,
        ct.comment_text 
    from cte_comment_post ct
    inner join {{ ref('stg_posts_questions') }} q
      on ct.question_id = q.question_id
      and ct.comment_user_id = q.post_owner_user_id
    where (ct.comment_text like '%@%' or q.question_post like '%@%' )
)
select count(*)
as 'questions_with_at_replies'
from cte_owner_at_replies   