-- File: 05_duplicate_ride_id_check.sql
-- Purpose: Summarize duplicate ride_id values across all 12 monthly raw tables.

WITH all_raw AS (
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202501`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202502`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202503`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202504`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202505`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202506`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202507`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202508`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202509`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202510`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202511`
  UNION ALL
  SELECT ride_id FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202512`
),
duplicate_ids AS (
  SELECT ride_id
  FROM all_raw
  WHERE ride_id IS NOT NULL
  GROUP BY ride_id
  HAVING COUNT(*) > 1
)
SELECT
  COUNT(*) AS duplicate_ride_id_count
FROM duplicate_ids;