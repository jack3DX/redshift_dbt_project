{{ config(
    materialized='table',
    schema='silver_airbnb') }}

with
    ranked_listings as (
        select
            room_type,
            neighbourhood_cleansed as neighbourhood,
            count(*) as num_listings,
            row_number() over (
                partition by neighbourhood_cleansed order by count(*) desc
            ) as rn
        from {{ ref("bronze_detailed_listings") }}
        group by neighbourhood_cleansed, room_type
    )
select neighbourhood, room_type, num_listings
from ranked_listings
where rn = 1
order by num_listings desc
;
