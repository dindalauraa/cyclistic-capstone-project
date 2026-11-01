-- Cyclistic Case Study
-- Analyze Phase: Ride Duration Analysis
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025

-- Purpose:
-- Compare ride duration statistics between annual members
-- and casual riders.

SELECT
  member_casual,

  COUNT(*) AS total_rides,

  COUNTIF(
    ride_length_seconds >= 1
    AND ride_length_seconds <= 86400
  ) AS rides_in_duration_analysis,

  COUNTIF(
    ride_length_seconds < 1
  ) AS rides_under_one_second,

  COUNTIF(
    ride_length_seconds > 86400
  ) AS rides_over_24_hours,

  ROUND(
    AVG(
      IF(
        ride_length_seconds >= 1
        AND ride_length_seconds <= 86400,
        ride_length_minutes,
        NULL
      )
    ),
    2
  ) AS average_duration_minutes,

  ROUND(
    APPROX_QUANTILES(
      IF(
        ride_length_seconds >= 1
        AND ride_length_seconds <= 86400,
        ride_length_minutes,
        NULL
      ),
      100
    )[OFFSET(50)],
    2
  ) AS median_duration_minutes,

  ROUND(
    APPROX_QUANTILES(
      IF(
        ride_length_seconds >= 1
        AND ride_length_seconds <= 86400,
        ride_length_minutes,
        NULL
      ),
      100
    )[OFFSET(90)],
    2
  ) AS p90_duration_minutes

FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`

GROUP BY
  member_casual

ORDER BY
  member_casual;