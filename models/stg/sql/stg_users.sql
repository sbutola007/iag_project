{{ config(materialized='view') }}

-- Model: stg_users
-- Purpose: Raw users table with readable column names

select
    Id as user_id,                 
    DisplayName as user_display_name,    
    Reputation as user_reputation,       
    CreationDate as user_creation_date,
    LastAccessDate as user_last_access_date,
    views as user_views
from {{ ref('src_users') }}