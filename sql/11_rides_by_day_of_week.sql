-- Cyclistic Case Study
-- Analyze Phase: Rides by Day of Week
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025

-- Purpose:
-- Compare ride volume and average ride duration by day of week
-- for annual members and casual riders.

SELECT
    member_casual,
    day_of_week,
    day_of_week_name,
    CASE
        WHEN day_of_week BETWEEN 2 AND 6 THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_type,
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
    day_of_week,
    day_of_week_name,
    day_type
ORDER BY
    CASE
        WHEN member_casual = 'member' THEN 1
        ELSE 2
    END,
    day_of_week;