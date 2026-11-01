-- Cyclistic Case Study
-- Analyze Phase: Ride Volume Analysis
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025

-- Purpose:
-- Calculate total rides and ride share by rider type.

SELECT
  member_casual,
  COUNT(*) AS total_rides,

  ROUND(
    SAFE_DIVIDE(
      COUNT(*),
      SUM(COUNT(*)) OVER ()
    ) * 100,
    2
  ) AS ride_share_percentage,

  SUM(COUNT(*)) OVER () AS total_dataset_rides

FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`

GROUP BY
  member_casual

ORDER BY
  total_rides DESC;