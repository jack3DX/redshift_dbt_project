{{ config(
    materialized='table',
    schema='silver_airbnb') }}

select 
    neighbourhood_cleansed as location, 
    count(id) as listing_count
from {{ ref('bronze_detailed_listings') }}
group by location
order by listing_count desc
;