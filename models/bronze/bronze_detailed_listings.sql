{{ config(materialized="table", schema="bronze_airbnb") }}

select *
from {{ source("redshift_raw_airbnb", "detailed_listings") }}
where id is not null and host_id is not null
