{{ config(materialized="table", schema="bronze_airbnb") }}

select *
from {{ source("redshift_raw_airbnb", "detailed_reviews") }}
where id is not null and listing_id is not null
