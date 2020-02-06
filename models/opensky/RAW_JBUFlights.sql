
-- Use the `ref` function to select from other models
{{ config(materialized='view') }}

select *
from opensky.dbo.jbu_flights
