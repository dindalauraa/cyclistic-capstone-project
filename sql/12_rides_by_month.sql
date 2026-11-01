-- Cyclistic Case Study
-- Analyze Phase: Rides by Month
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025

-- Purpose:
-- Compare monthly ride volume and average ride duration
-- between annual members and casual riders.

WITH monthly_rides AS (
    SELECT
        member_casual,
        EXTRACT(MONTH FROM started_at) AS month_number,
        FORMAT_DATE('%B', DATE(started_at)) AS month_name,
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
        month_number,
        month_name
)

SELECT
    member_casual,
    month_number,
    month_name,
    total_rides,
    ROUND(
        SAFE_DIVIDE(
            total_rides,
            SUM(total_rides) OVER (PARTITION BY month_number)
        ) * 100,
        2
    ) AS monthly_ride_share_percentage,
    rides_in_duration_analysis,
    average_duration_minutes
FROM
    monthly_rides
ORDER BY
    month_number,
    member_casual;