-- Cyclistic Case Study
-- File: 07_audit_combined_raw.sql
-- Phase: Process
-- Project ID: cyclistic-case-study-513112
-- Dataset: cyclistic_2025
--
-- Description:
-- Audit the combined raw dataset to identify missing values,
-- invalid timestamps, unusual trip durations, duplicate ride IDs,
-- unexpected categories, and coordinate issues.
--
-- Output table:
-- cyclistic_2025.trips_2025_raw

-- =====================================================
-- 1. Overall Data Quality Audit
-- =====================================================

WITH base AS (
  SELECT
    *,
    TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_duration_seconds
  FROM
    `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
),

audit AS (
  SELECT
    COUNT(*) AS total_records,

    COUNTIF(ride_id IS NULL OR TRIM(ride_id) = '')
      AS missing_ride_id,

    COUNTIF(started_at IS NULL)
      AS missing_started_at,

    COUNTIF(ended_at IS NULL)
      AS missing_ended_at,

    COUNTIF(member_casual IS NULL OR TRIM(member_casual) = '')
      AS missing_member_casual,

    COUNTIF(rideable_type IS NULL OR TRIM(rideable_type) = '')
      AS missing_rideable_type,

    COUNTIF(start_station_name IS NULL OR TRIM(start_station_name) = '')
      AS missing_start_station_name,

    COUNTIF(start_station_id IS NULL OR TRIM(start_station_id) = '')
      AS missing_start_station_id,

    COUNTIF(end_station_name IS NULL OR TRIM(end_station_name) = '')
      AS missing_end_station_name,

    COUNTIF(end_station_id IS NULL OR TRIM(end_station_id) = '')
      AS missing_end_station_id,

    COUNTIF(
      start_lat IS NULL OR start_lng IS NULL
      OR end_lat IS NULL OR end_lng IS NULL
    ) AS records_with_missing_coordinates,

    COUNTIF(
      (start_lat IS NOT NULL AND (start_lat < -90 OR start_lat > 90))
      OR (end_lat IS NOT NULL AND (end_lat < -90 OR end_lat > 90))
      OR (start_lng IS NOT NULL AND (start_lng < -180 OR start_lng > 180))
      OR (end_lng IS NOT NULL AND (end_lng < -180 OR end_lng > 180))
    ) AS records_with_invalid_coordinate_ranges,

    COUNTIF(
      started_at IS NOT NULL
      AND ended_at IS NOT NULL
      AND ended_at < started_at
    ) AS invalid_timestamp_order,

    COUNTIF(
      ride_duration_seconds <= 0
    ) AS non_positive_duration,

    COUNTIF(
      ride_duration_seconds > 86400
    ) AS rides_over_24_hours,

    COUNTIF(
      started_at IS NOT NULL
      AND (
        started_at < TIMESTAMP(source_month)
        OR started_at >= TIMESTAMP(
          DATE_ADD(source_month, INTERVAL 1 MONTH)
        )
      )
    ) AS started_at_outside_source_month,

    (
      SELECT COUNT(*)
      FROM (
        SELECT ride_id
        FROM
          `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
        WHERE ride_id IS NOT NULL
        GROUP BY ride_id
        HAVING COUNT(*) > 1
      )
    ) AS duplicated_ride_ids

  FROM base
)

SELECT metric, record_count
FROM audit
CROSS JOIN UNNEST([
  STRUCT('total_records' AS metric, total_records AS record_count),
  STRUCT('missing_ride_id', missing_ride_id),
  STRUCT('missing_started_at', missing_started_at),
  STRUCT('missing_ended_at', missing_ended_at),
  STRUCT('missing_member_casual', missing_member_casual),
  STRUCT('missing_rideable_type', missing_rideable_type),
  STRUCT('missing_start_station_name', missing_start_station_name),
  STRUCT('missing_start_station_id', missing_start_station_id),
  STRUCT('missing_end_station_name', missing_end_station_name),
  STRUCT('missing_end_station_id', missing_end_station_id),
  STRUCT('records_with_missing_coordinates', records_with_missing_coordinates),
  STRUCT('records_with_invalid_coordinate_ranges', records_with_invalid_coordinate_ranges),
  STRUCT('invalid_timestamp_order', invalid_timestamp_order),
  STRUCT('non_positive_duration', non_positive_duration),
  STRUCT('rides_over_24_hours', rides_over_24_hours),
  STRUCT('started_at_outside_source_month', started_at_outside_source_month),
  STRUCT('duplicated_ride_ids', duplicated_ride_ids)
])
ORDER BY metric;

-- =====================================================
-- 2. Category Distribution Audit
-- =====================================================

SELECT
  'member_casual' AS category_type,
  COALESCE(member_casual, 'NULL') AS category_value,
  COUNT(*) AS record_count
FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
GROUP BY
  category_value

UNION ALL

SELECT
  'rideable_type' AS category_type,
  COALESCE(rideable_type, 'NULL') AS category_value,
  COUNT(*) AS record_count
FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
GROUP BY
  category_value

ORDER BY
  category_type,
  category_value;

-- =====================================================
-- 3. Invalid Timestamp Inspection
-- =====================================================

SELECT
  ride_id,
  started_at,
  ended_at,
  TIMESTAMP_DIFF(ended_at, started_at, SECOND)
    AS ride_duration_seconds,
  member_casual,
  rideable_type,
  source_month,
  source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
WHERE
  started_at IS NULL
  OR ended_at IS NULL
  OR ended_at < started_at
  OR ended_at = started_at
ORDER BY
  started_at
LIMIT 50;

-- =====================================================
-- 4. Precise Trip Duration Audit
-- =====================================================

SELECT
  CASE
    WHEN ended_at < started_at THEN 'Negative duration'
    WHEN ended_at = started_at THEN 'Zero duration'
    WHEN TIMESTAMP_DIFF(ended_at, started_at, MICROSECOND) < 1000000
      THEN 'Positive duration under 1 second'
    WHEN TIMESTAMP_DIFF(ended_at, started_at, MICROSECOND) > 86400000000
      THEN 'Over 24 hours'
    ELSE 'Valid duration range'
  END AS duration_category,
  COUNT(*) AS record_count
FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
WHERE
  started_at IS NOT NULL
  AND ended_at IS NOT NULL
GROUP BY
  duration_category
ORDER BY
  duration_category;


-- =====================================================
-- 5. Inspect Negative Duration Records by Date
-- =====================================================

SELECT
  DATE(started_at) AS start_date_utc,
  source_table,
  COUNT(*) AS negative_duration_records,
  MIN(started_at) AS earliest_started_at,
  MAX(started_at) AS latest_started_at
FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
WHERE
  started_at IS NOT NULL
  AND ended_at IS NOT NULL
  AND ended_at < started_at
GROUP BY
  start_date_utc,
  source_table
ORDER BY
  start_date_utc;

-- =====================================================
-- 6. Annual Study Period Validation
-- =====================================================

SELECT
  COUNT(*) AS total_raw_records,

  COUNTIF(
    DATE(started_at) >= DATE '2025-01-01'
    AND DATE(started_at) < DATE '2026-01-01'
  ) AS records_within_2025,

  COUNTIF(
    DATE(started_at) < DATE '2025-01-01'
    OR DATE(started_at) >= DATE '2026-01-01'
  ) AS records_outside_2025,

  MIN(DATE(started_at)) AS earliest_start_date,
  MAX(DATE(started_at)) AS latest_start_date

FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`;


-- =====================================================
-- 7. Inspect Records Outside the Data Period
-- =====================================================

SELECT
  ride_id,
  started_at,
  ended_at,
  member_casual,
  rideable_type,
  source_month,
  source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
WHERE
  DATE(started_at) < DATE '2025-01-01'
  OR DATE(started_at) >= DATE '2026-01-01'
ORDER BY
  started_at;