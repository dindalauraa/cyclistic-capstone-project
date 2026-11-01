-- Create an aggregated dataset for Tableau Public
-- Source: cyclistic_2025.trips_2025_cleaned
-- Output: cyclistic_2025.dashboard_2025

CREATE OR REPLACE TABLE
  `cyclistic-case-study-513112.cyclistic_2025.dashboard_2025`
AS

SELECT
  member_casual,

  EXTRACT(MONTH FROM started_at) AS month_number,
  FORMAT_DATE('%B', DATE(started_at)) AS month_name,

  EXTRACT(DAYOFWEEK FROM DATE(started_at)) AS day_of_week_number,
  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week_name,

  EXTRACT(HOUR FROM started_at) AS start_hour,

  FORMAT(
    '%02d:00',
    EXTRACT(HOUR FROM started_at)
  ) AS start_hour_label,

  rideable_type,

  COUNT(*) AS ride_count,

  COUNTIF(
    ride_length_seconds BETWEEN 1 AND 86400
  ) AS duration_eligible_count,

  SUM(
    IF(
      ride_length_seconds BETWEEN 1 AND 86400,
      ride_length_seconds,
      0
    )
  ) AS duration_sum_seconds

FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`

GROUP BY
  member_casual,
  month_number,
  month_name,
  day_of_week_number,
  day_of_week_name,
  start_hour,
  start_hour_label,
  rideable_type;