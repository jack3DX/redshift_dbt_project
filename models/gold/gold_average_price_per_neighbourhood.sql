{{ config(materialized="table", schema="gold_airbnb") }}

select
    neighbourhood_cleansed as neighbourhood_name,
    round(median(price), 1) as average_price
from {{ ref("silver_detailed_listings") }}
group by neighbourhood_name
order by average_price desc
