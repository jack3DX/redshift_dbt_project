{{ config(materialized="table", schema="gold_airbnb") }}

with
    listings_for_tourists as (
        select
            sum(
                case
                    when (maximum_nights < 28 and availability_30 < 15) then 1 else 0
                end
            ) as popular_listings_for_tourists,
            sum(
                case when (maximum_nights < 28) then 1 else 0 end
            ) as total_listings_for_tourists,
            room_type
        from {{ ref("silver_detailed_listings") }}
        group by room_type
    )
select
    room_type,
    popular_listings_for_tourists,
    total_listings_for_tourists,
    round(
        cast(popular_listings_for_tourists as numeric)
        / cast(total_listings_for_tourists as numeric)
        * 100,
        1
    ) as ratio_percentage
from listings_for_tourists
order by total_listings_for_tourists desc
