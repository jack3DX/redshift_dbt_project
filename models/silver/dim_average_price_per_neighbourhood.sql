{{ config(
    materialized='table',
    schema='silver_airbnb') }}

select
    neighbourhood_cleansed as neighbourhood_name, round(avg(price), 1) as average_price
from {{ ref("bronze_detailed_listings") }}
where maximum_nights < 28
group by neighbourhood_name
order by average_price desc