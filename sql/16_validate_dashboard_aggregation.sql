-- 1. Overall aggregation validation

SELECT
  SUM(ride_count) AS total_aggregated_rides,
  COUNT(*) AS aggregation_rows,
  COUNT(DISTINCT month_number) AS months,
  COUNT(DISTINCT day_of_week_number) AS days,
  COUNT(DISTINCT start_hour) AS hours,
  COUNT(DISTINCT member_casual) AS rider_types,
  COUNT(DISTINCT rideable_type) AS bike_types,
  SUM(duration_eligible_count) AS total_duration_eligible
FROM
  `cyclistic-case-study-513112.cyclistic_2025.dashboard_2025`;


-- 2. Aggregated ride and duration totals by rider type

SELECT
  member_casual,
  SUM(ride_count) AS total_rides,
  SUM(duration_eligible_count) AS eligible_rides,
  SUM(duration_sum_seconds) AS total_duration_seconds
FROM
  `cyclistic-case-study-513112.cyclistic_2025.dashboard_2025`
GROUP BY
  member_casual
ORDER BY
  member_casual;
