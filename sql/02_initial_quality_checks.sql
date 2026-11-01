-- File: 02_initial_quality_checks.sql
-- Purpose: Perform initial data quality checks across all 12 monthly tables.
-- Checks: Total rows, missing key fields, and invalid timestamp sequences.

WITH all_raw AS (
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202501`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202502`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202503`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202504`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202505`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202506`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202507`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202508`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202509`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202510`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202511`
  UNION ALL
  SELECT * FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202512`
)

SELECT
  COUNT(*) AS total_rows,
  COUNTIF(ride_id IS NULL OR TRIM(ride_id) = '') AS missing_ride_id,
  COUNTIF(started_at IS NULL) AS missing_started_at,
  COUNTIF(ended_at IS NULL) AS missing_ended_at,
  COUNTIF(member_casual IS NULL OR TRIM(member_casual) = '') AS missing_member_casual,
  COUNTIF(rideable_type IS NULL OR TRIM(rideable_type) = '') AS missing_rideable_type,
  COUNTIF(ended_at < started_at) AS end_before_start
FROM all_raw;
