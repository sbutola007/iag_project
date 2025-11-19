{{ config(materialized='view') }}

-- Model:   stg_qna_joined
-- Purpose: This intermediate model derive minutes difference for every posted question whose answer is marked accepted.

select 
    ipq.question_id,
    ipa.answer_id, 
    ipq.question_created_date, 
    ipa.answer_created_date,
    date_diff('minute', ipq.question_created_date, ipa.answer_created_date) as diff_in_minutes
from {{ ref('stg_posts_questions') }} ipq inner join {{ ref('stg_posts_answers') }} ipa
on ipq.accepted_answer_id = ipa.answer_id
and ipa.parent_id = ipq.question_id
where ipa.answer_created_date >= ipq.question_created_date 