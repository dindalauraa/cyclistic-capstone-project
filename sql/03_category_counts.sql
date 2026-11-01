-- File: 03_category_counts.sql
-- Purpose: Count records by rider type and bike type across all monthly raw tables.

WITH all_raw AS (
  SELECT member_casual, rideable_type
  FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202501`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202502`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202503`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202504`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202505`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202506`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202507`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202508`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202509`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202510`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202511`
  UNION ALL SELECT member_casual, rideable_type FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202512`
)

SELECT 'member_casual' AS column_name, member_casual AS category, COUNT(*) AS total
FROM all_raw
GROUP BY member_casual

UNION ALL

SELECT 'rideable_type' AS column_name, rideable_type AS category, COUNT(*) AS total
FROM all_raw
GROUP BY rideable_type

ORDER BY column_name, total DESC;
