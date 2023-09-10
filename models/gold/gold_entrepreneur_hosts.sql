{{ config(materialized="table", schema="gold_airbnb") }}

select host_id, host_name, host_location
from {{ ref("silver_host_details") }}
where host_listings_count <> host_total_listings_count
