-- Cyclistic Case Study
-- Analyze Phase: Rides by Start Hour
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025

-- Purpose:
-- Compare hourly ride volume and average ride duration
-- between annual members and casual riders.

WITH hourly_rides AS (
    SELECT
        member_casual,
        EXTRACT(HOUR FROM started_at) AS start_hour,
        COUNT(*) AS total_rides,
        COUNTIF(
            ride_length_seconds >= 1
            AND ride_length_seconds <= 86400
        ) AS rides_in_duration_analysis,
        ROUND(
            AVG(
                CASE
                    WHEN ride_length_seconds >= 1
                         AND ride_length_seconds <= 86400
                    THEN ride_length_minutes
                END
            ),
            2
        ) AS average_duration_minutes
    FROM
        `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`
    GROUP BY
        member_casual,
        start_hour
)

SELECT
    member_casual,
    start_hour,
    total_rides,
    ROUND(
        SAFE_DIVIDE(
            total_rides,
            SUM(total_rides) OVER (PARTITION BY start_hour)
        ) * 100,
        2
    ) AS hourly_ride_share_percentage,
    rides_in_duration_analysis,
    average_duration_minutes
FROM
    hourly_rides
ORDER BY
    start_hour,
    member_casual;
