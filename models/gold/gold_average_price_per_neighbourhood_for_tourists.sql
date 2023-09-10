{{ config(materialized="table", schema="gold_airbnb") }}

select
    neighbourhood_cleansed as neighbourhood_name,
    round(median(price), 1) as average_price
from {{ ref("silver_detailed_listings") }}
where maximum_nights < 28
group by neighbourhood_name
order by average_price desc
