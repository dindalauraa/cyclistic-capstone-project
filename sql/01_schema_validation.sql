-- File: 01_schema_validation.sql
-- Purpose: Validate schema consistency across monthly raw tables.
-- Expected result: 12 tables with 13 columns each,
-- with consistent column names, data types, and order.

SELECT
  table_name,
  column_name,
  data_type,
  ordinal_position
FROM `cyclistic-case-study-513112.cyclistic_2025.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name LIKE 'raw_2025%'
ORDER BY
  table_name,
  ordinal_position;