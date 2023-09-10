{{ config(materialized="table", schema="gold_airbnb") }}

select room_type, round(median(price), 1) as average_price
from {{ ref("silver_detailed_listings") }}
group by room_type
order by average_price desc
