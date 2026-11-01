-- Cyclistic Case Study
-- Process Phase: Clean and transform trip data
-- Project: cyclistic-case-study-513112
-- Dataset: cyclistic_2025
--
-- Purpose:
-- Create an analytical table from the combined raw data.
-- Retain trips within the 2025 data period.
-- Exclude records with negative trip durations.
-- Create trip duration and day-of-week variables.
-- Preserve the original raw table.

CREATE OR REPLACE TABLE
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`
AS

WITH period_filtered AS (
  SELECT *
  FROM
    `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
  WHERE
    DATE(started_at) >= DATE '2025-01-01'
    AND DATE(started_at) < DATE '2026-01-01'
),

duration_calculated AS (
  SELECT
    *,
    TIMESTAMP_DIFF(
      ended_at,
      started_at,
      MICROSECOND
    ) / 1000000.0 AS ride_length_seconds
  FROM period_filtered
  WHERE
    ended_at >= started_at
)

SELECT
  *,
  ride_length_seconds / 60.0 AS ride_length_minutes,

  FORMAT(
    '%02d:%02d:%02d',
    CAST(FLOOR(ride_length_seconds / 3600) AS INT64),
    MOD(
      CAST(FLOOR(ride_length_seconds / 60) AS INT64),
      60
    ),
    MOD(
      CAST(FLOOR(ride_length_seconds) AS INT64),
      60
    )
  ) AS ride_length,

  EXTRACT(DAYOFWEEK FROM DATE(started_at)) AS day_of_week,

  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week_name,

  ride_length_seconds < 1 AS is_under_one_second,

  ride_length_seconds > 86400 AS is_over_24_hours

FROM duration_calculated;

-- =====================================================
-- Validation: Cleaned Analytical Table
-- =====================================================

SELECT
  COUNT(*) AS total_cleaned_records,

  COUNT(DISTINCT ride_id) AS unique_ride_ids,

  COUNTIF(ride_length_seconds < 0) AS negative_duration_records,

  COUNTIF(ride_length_seconds < 1) AS under_one_second_records,

  COUNTIF(is_over_24_hours) AS over_24_hours_records,

  COUNTIF(ride_length_seconds IS NULL) AS missing_duration_records,

  MIN(DATE(started_at)) AS earliest_start_date,

  MAX(DATE(started_at)) AS latest_start_date

FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_cleaned`;