{{ config(materialized='table') }}

-- Model: fct_top_rank_users
-- Purpose: Identify the top 10 user based on the most views on questions they post

with user_question_views as (
    select
        s_post.post_owner_user_id,
        sum(s_post.post_view_count) as total_question_views
    from {{ ref('stg_posts') }} s_post
    where s_post.post_type_id = 1
    and s_post.post_view_count is not null
    group by s_post.post_owner_user_id
),

ranked_users as (
    select
        s_user.user_id,
        s_user.user_display_name as user_name,
        uqv.total_question_views,
        row_number() over (
            order by uqv.total_question_views desc
        ) as rank
    from user_question_views uqv
    inner join {{ ref('stg_users') }} s_user
        on uqv.post_owner_user_id = s_user.user_id
)

-- Return only the top 10 ranked users
select
    rank,
    user_id,
    user_name,
    total_question_views
from ranked_users
where rank <= 10
order by rank
