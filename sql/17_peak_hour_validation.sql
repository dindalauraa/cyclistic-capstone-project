SELECT
  EXTRACT(HOUR FROM started_at) AS start_hour,
  COUNT(*) AS total_rides
FROM `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`
GROUP BY start_hour
ORDER BY total_rides DESC
LIMIT 3;