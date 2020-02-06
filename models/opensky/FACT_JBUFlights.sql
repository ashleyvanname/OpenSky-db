
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='view') }}

with source_data as (
    select
      icao24,
      (CASE WHEN left(callsign, 3)='JBU' then 'B6' else NULL end) as FlightCarrierCode,
      REPLACE(callsign,'JBU','')  as FlightNumber,
      to_timestamp(cast(time_position as integer)) as Last_position_update,
      to_timestamp(cast(last_contact as integer)) as Last_update,
      Longitude,
      Latitude,
      Baro_Altitude,
      Geo_Altitude,
      On_Ground,
      Velocity,
      True_Track,
      Vertical_Rate,
      Sensors,
      Squawk,
      SPI,
      Position_Source,
      to_timestamp(cast(API_CALLTIMESTAMP as integer)) as API_CALLTIMESTAMP,
      DATABASE_TIMESTAMP

    from {{ ref('RAW_JBUFlights') }}
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
