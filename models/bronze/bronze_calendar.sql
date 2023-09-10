{{ config(materialized="table", schema="bronze_airbnb") }}

select *
from {{ source("redshift_raw_airbnb", "calendar") }}
where listing_id is not null
