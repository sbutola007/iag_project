{{ config(materialized='table') }}

-- Model:   fct_question_response_intervals
-- Purpose: This model counts questions grouped by monthly time intervals 
-- based on how quickly their accepted answers were provided.

with time_intervals as (
    select
        strftime(date_trunc('month', question_created_date), '%Y-%m') as month,
        case
            when diff_in_minutes < 1 then '<1 min'
            when diff_in_minutes between 1 and 5 then '1-5 mins'
            when diff_in_minutes between 6 and 60 then '5 mins-1 hour'
            when diff_in_minutes between 61 and 180 then '1-3 hours'
            when diff_in_minutes between 181 and 1440 then '3 hours-1 day'
            else '>1 day'
        end as interval
    from {{ ref('stg_qna_joined') }}
)
---- Pivot counts: one row per month with time intervals to show question counts by response-time
select
    month,
    sum(case when interval = '<1 min' then 1 else 0 end) as "<1 min",
    sum(case when interval = '1-5 mins' then 1 else 0 end) as "1-5 mins",
    sum(case when interval = '5 mins-1 hour' then 1 else 0 end) as "5 mins-1 hour",
    sum(case when interval = '1-3 hours' then 1 else 0 end) as "1-3 hours",
    sum(case when interval = '3 hours-1 day' then 1 else 0 end) as "3 hours-1 day",
    sum(case when interval = '>1 day' then 1 else 0 end) as ">1 day"
from time_intervals
group by month
order by month