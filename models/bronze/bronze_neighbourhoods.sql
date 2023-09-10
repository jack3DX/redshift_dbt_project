{{ config(materialized="table", schema="bronze_airbnb") }}

select distinct(neighbourhood), neighbourhood_group
from {{ source("redshift_raw_airbnb", "neighbourhoods") }}
where neighbourhood is not null
