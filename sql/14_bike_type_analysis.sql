-- Cyclistic Case Study
-- Analyze Phase: Bike Type Analysis
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025

-- Purpose:
-- Compare ride volume across bike types
-- for annual members and casual riders.

SELECT
  member_casual,
  rideable_type,
  COUNT(*) AS total_rides,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (PARTITION BY member_casual),
    2
  ) AS rider_type_ride_share_percentage,

  ROUND(
    COUNT(*) * 100.0
    / SUM(COUNT(*)) OVER (),
    2
  ) AS overall_ride_share_percentage

FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`

GROUP BY
  member_casual,
  rideable_type

ORDER BY
  member_casual,
  total_rides DESC;