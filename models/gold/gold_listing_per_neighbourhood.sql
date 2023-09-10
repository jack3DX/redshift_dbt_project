{{ config(materialized="table", schema="gold_airbnb") }}

select neighbourhood_cleansed as location, count(id) as listing_count
from {{ ref("silver_detailed_listings") }}
group by location
order by listing_count desc