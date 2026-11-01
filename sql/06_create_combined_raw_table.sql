-- Cyclistic Case Study
-- File: 06_create_combined_raw_table.sql
-- Phase: Process
-- Project ID: cyclistic-case-study-513112
-- Dataset: cyclistic_2025
--
-- Description:
-- Combine the 12 monthly raw tables into a single table.
-- Preserve all source records and add source_month and
-- source_table columns for data traceability.

CREATE OR REPLACE TABLE
  `cyclistic-case-study-513112.cyclistic_2025.trips_2025_raw`
AS

SELECT
  *,
  DATE '2025-01-01' AS source_month,
  'raw_202501' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202501`

UNION ALL

SELECT
  *,
  DATE '2025-02-01' AS source_month,
  'raw_202502' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202502`

UNION ALL

SELECT
  *,
  DATE '2025-03-01' AS source_month,
  'raw_202503' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202503`

UNION ALL

SELECT
  *,
  DATE '2025-04-01' AS source_month,
  'raw_202504' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202504`

UNION ALL

SELECT
  *,
  DATE '2025-05-01' AS source_month,
  'raw_202505' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202505`

UNION ALL

SELECT
  *,
  DATE '2025-06-01' AS source_month,
  'raw_202506' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202506`

UNION ALL

SELECT
  *,
  DATE '2025-07-01' AS source_month,
  'raw_202507' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202507`

UNION ALL

SELECT
  *,
  DATE '2025-08-01' AS source_month,
  'raw_202508' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202508`

UNION ALL

SELECT
  *,
  DATE '2025-09-01' AS source_month,
  'raw_202509' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202509`

UNION ALL

SELECT
  *,
  DATE '2025-10-01' AS source_month,
  'raw_202510' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202510`

UNION ALL

SELECT
  *,
  DATE '2025-11-01' AS source_month,
  'raw_202511' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202511`

UNION ALL

SELECT
  *,
  DATE '2025-12-01' AS source_month,
  'raw_202512' AS source_table
FROM
  `cyclistic-case-study-513112.cyclistic_2025.raw_202512`;
