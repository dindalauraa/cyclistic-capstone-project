-- File: 04_outside_source_month_counts.sql
-- Purpose: Count records whose started_at date falls outside
-- the calendar month associated with each monthly raw table.
-- Note: Flagged records are not automatically considered errors.

SELECT 
  '202501' AS file_month,
  COUNTIF(
    DATE(started_at) < DATE '2025-01-01'
    OR DATE(started_at) >= DATE '2025-02-01'
  ) AS starts_outside_month
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202501`

UNION ALL

SELECT '202502', COUNTIF(
  DATE(started_at) < DATE '2025-02-01'
  OR DATE(started_at) >= DATE '2025-03-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202502`

UNION ALL

SELECT '202503', COUNTIF(
  DATE(started_at) < DATE '2025-03-01'
  OR DATE(started_at) >= DATE '2025-04-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202503`

UNION ALL

SELECT '202504', COUNTIF(
  DATE(started_at) < DATE '2025-04-01'
  OR DATE(started_at) >= DATE '2025-05-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202504`

UNION ALL

SELECT '202505', COUNTIF(
  DATE(started_at) < DATE '2025-05-01'
  OR DATE(started_at) >= DATE '2025-06-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202505`

UNION ALL

SELECT '202506', COUNTIF(
  DATE(started_at) < DATE '2025-06-01'
  OR DATE(started_at) >= DATE '2025-07-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202506`

UNION ALL

SELECT '202507', COUNTIF(
  DATE(started_at) < DATE '2025-07-01'
  OR DATE(started_at) >= DATE '2025-08-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202507`

UNION ALL

SELECT '202508', COUNTIF(
  DATE(started_at) < DATE '2025-08-01'
  OR DATE(started_at) >= DATE '2025-09-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202508`

UNION ALL

SELECT '202509', COUNTIF(
  DATE(started_at) < DATE '2025-09-01'
  OR DATE(started_at) >= DATE '2025-10-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202509`

UNION ALL

SELECT '202510', COUNTIF(
  DATE(started_at) < DATE '2025-10-01'
  OR DATE(started_at) >= DATE '2025-11-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202510`

UNION ALL

SELECT '202511', COUNTIF(
  DATE(started_at) < DATE '2025-11-01'
  OR DATE(started_at) >= DATE '2025-12-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202511`

UNION ALL

SELECT '202512', COUNTIF(
  DATE(started_at) < DATE '2025-12-01'
  OR DATE(started_at) >= DATE '2026-01-01'
)
FROM `cyclistic-case-study-513112.cyclistic_2025.raw_202512`;
