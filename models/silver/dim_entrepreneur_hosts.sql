{{ config(
    materialized='table',
    schema='silver_airbnb') }}

select host_id, host_name, host_location
from {{ ref("bronze_host_details") }}
where host_listings_count <> host_total_listings_count
