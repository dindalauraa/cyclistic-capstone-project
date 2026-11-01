# Cyclistic Bike-Share Analysis

## Data Validation Log

### 1. Project Information

- **Project:** Cyclistic Bike-Share Analysis
- **Business Question:** How do annual members and casual riders use Cyclistic bikes differently?
- **Data Period:** January 1–December 31, 2025
- **Data Source:** Divvy trip data
- **BigQuery Project:** `cyclistic-case-study-513112`
- **BigQuery Dataset:** `cyclistic_2025`
- **Raw Tables:** `raw_202501` through `raw_202512`
- **Combined Raw Table:** `trips_2025_raw`
- **Cleaned Table:** `trips_2025_cleaned`
- **Dashboard Table:** `dashboard_2025`
- **Visualization Tool:** Tableau Public
- **Dashboard:** [Ridership Analytics Dashboard](https://public.tableau.com/views/CyclisticBike-ShareAnalysisDashboard_17934258541930/CyclisticBike-ShareAnalysisDashboard)
- **Phases Covered:** Ask, Prepare, Process, Analyze, Share, and Act
- **Log Created:** October 29, 2026
- **Last Updated:** November 1, 2026

### 2. Validation Activity Log

| Date | Phase | Activity | Reference | Result |
|---|---|---|---|---|
| 2026-10-29 | Ask | Business question definition | Case study brief | Defined the business question and analytical objective |
| 2026-10-29 | Prepare | Schema validation | `01_schema_validation.sql` | 12 monthly tables with 13 consistent columns |
| 2026-10-29 | Prepare | Initial data quality checks | `02_initial_quality_checks.sql` | 5,552,994 records, no missing values in five key fields, and 29 negative-duration records |
| 2026-10-29 | Prepare | Category counts | `03_category_counts.sql` | Raw counts: 3,553,497 members, 1,999,497 casual riders, 3,604,953 electric bikes, and 1,948,041 classic bikes |
| 2026-10-29 | Prepare | Source-month validation | `04_outside_source_month_counts.sql` | 1,075 records with start dates outside their source table's calendar month |
| 2026-10-29 | Prepare | Duplicate ID check | `05_duplicate_ride_id_check.sql` | No duplicate non-null `ride_id` values |
| 2026-10-30 | Process | Raw table creation | `06_create_combined_raw_table.sql` | Created `trips_2025_raw` from 12 monthly tables |
| 2026-10-30 | Process | Combined data audit | `07_audit_combined_raw.sql` | Reviewed data quality, categories, timestamps, and durations |
| 2026-10-30 | Process | Data cleaning and validation | `08_clean_trip_data.sql` | Created `trips_2025_cleaned` with 5,552,912 records |
| 2026-10-30 | Analyze | Ride volume analysis | `09_ride_volume_analysis.sql` | 5,552,912 rides, comprising 3,553,461 member rides (63.99%) and 1,999,451 casual rides (36.01%) |
| 2026-10-30 | Analyze | Ride duration analysis | `10_ride_duration_analysis.sql` | Average, median, and P90 durations by rider type, documented in Section 6 |
| 2026-10-30 | Analyze | Day-of-week analysis | `11_rides_by_day_of_week.sql` | Ride volume and duration by weekday and rider type, with daily totals matching 5,552,912 |
| 2026-10-30 | Analyze | Monthly analysis | `12_rides_by_month.sql` | Ride volume and duration by month and rider type |
| 2026-10-30 | Analyze | Start-hour analysis | `13_rides_by_start_hour.sql` | Ride volume and duration by start hour and rider type, covering 48 combinations |
| 2026-10-30 | Analyze | Bike type analysis | `14_bike_type_analysis.sql` | Electric and classic bike usage by rider type |
| 2026-10-30 | Analyze | Dashboard data preparation and validation | `15_create_dashboard_aggregation.sql` and `16_validate_dashboard_aggregation.sql` | Created and validated 8,060 aggregated rows |
| 2026-10-31 | Share | Dashboard development | Tableau Public | Built chart sheets, KPI cards, filters, and dashboard layout |
| 2026-10-31 | Share | Dashboard styling | Tableau Public | Applied consistent colors, layout, and formatting |
| 2026-11-01 | Share | KPI investigation and validation | Tableau Public, `10_ride_duration_analysis.sql`, `11_rides_by_day_of_week.sql`, and `17_peak_hour_validation.sql` | Corrected KPI discrepancies and reconciled average durations, Peak Day, and Peak Hour with BigQuery |
| 2026-11-01 | Share | Dashboard refinement | Tableau Public | Refined titles, chart types, KPI presentation, and filters |
| 2026-11-01 | Share | Dashboard publication | Tableau Public | Published the dashboard and recorded its URL in Project Information |
| 2026-11-01 | Act | Recommendation development | `documentation/06_act.md` | Developed three marketing recommendations based on membership, weekly, duration, and seasonal riding patterns |
| 2026-11-01 | Act | Action planning and success measures | `documentation/06_act.md` | Documented proposed campaign actions, performance measures, next steps, and additional data requirements |

### 3. Data Quality Findings

Initial checks on the combined raw table identified the following:

| Data Quality Check | Findings |
|---|---:|
| Duplicate non-null ride IDs | 0 |
| Missing key fields | 0 |
| Missing start station IDs or names | 1,184,673 |
| Missing end station IDs or names | 1,243,305 |
| Records with missing coordinates | 5,535 |
| Invalid coordinate ranges | 0 |
| Negative-duration records | 29 |
| Trips under one second | 1,808 |
| Trips over 24 hours | 5,585 |
| Start dates outside the Data Period | 53 |
| Start dates outside their source month | 1,075 |

**Notes:**

- All 29 negative-duration records originated from `raw_202511` and were dated November 2, 2025.
- The 53 records outside the Data Period included trips starting on December 31, 2024.
- The 1,075 source-month discrepancies were assessed separately and were not treated as automatic exclusion criteria.
- Missing station information and coordinates were retained in the dataset.
- Trips under one second and over 24 hours were retained in the cleaned dataset and assessed separately for duration analysis.

### 4. Cleaning and Validation Results

The cleaning process excluded records with start dates outside the 2025 Data Period and records with negative trip durations.

Additional analytical fields included:

`ride_length_seconds`, `ride_length_minutes`, `ride_length`, `day_of_week`, `day_of_week_name`, `is_under_one_second`, and `is_over_24_hours`.

| Validation Metric | Result |
|---|---:|
| Raw records | 5,552,994 |
| Records outside the Data Period | 53 |
| Negative-duration records excluded | 29 |
| Total excluded records | 82 |
| Cleaned records | 5,552,912 |
| Unique ride IDs | 5,552,912 |
| Remaining negative durations | 0 |
| Missing calculated durations | 0 |
| Trips under one second | 1,808 |
| Trips over 24 hours | 5,585 |
| Earliest start date | 2025-01-01 |
| Latest start date | 2025-12-31 |

**Record reconciliation:**

`5,552,994 - 53 - 29 = 5,552,912`

The cleaned dataset retains trips under one second and over 24 hours. These records remain available for ride-volume analysis but are excluded from duration statistics.

### 5. Dashboard Aggregation Validation

The `dashboard_2025` table was created from the complete cleaned dataset to support Tableau visualization.

| Validation Metric | Result |
|---|---:|
| Aggregation rows | 8,060 |
| Total aggregated rides | 5,552,912 |
| Months | 12 |
| Days of the week | 7 |
| Starting hours | 24 |
| Rider types | 2 |
| Bike types | 2 |
| Duration-eligible rides | 5,545,519 |

**Rider-level reconciliation:**

| Rider Type | Total Rides | Eligible Rides |
|---|---:|---:|
| Casual | 1,999,451 | 1,993,980 |
| Member | 3,553,461 | 3,551,539 |
| **Total** | **5,552,912** | **5,545,519** |

Aggregated ride counts matched the cleaned dataset. The dashboard table was accepted as a visualization source and does not replace the trip-level cleaned table.

### 6. Ride Duration Analysis

Results from `10_ride_duration_analysis.sql`. Duration statistics include trips lasting from 1 second to 24 hours, inclusive.

| Rider Type | Total Rides | Eligible Rides | Under 1 Second | Over 24 Hours | Average (min) | Median (min) | P90 (min) |
|---|---:|---:|---:|---:|---:|---:|---:|
| Casual | 1,999,451 | 1,993,980 | 794 | 4,677 | 19.14 | 11.38 | 38.75 |
| Member | 3,553,461 | 3,551,539 | 1,014 | 908 | 11.96 | 8.58 | 23.25 |

**Reconciliation:**

- Eligible rides: **5,545,519**, matching Section 5.
- Trips excluded from duration statistics: **7,393**, comprising 1,808 trips under one second and 5,585 trips over 24 hours.
- `5,552,912 - 5,545,519 = 7,393`.

### 7. Dashboard Development and Validation

**Dashboard components**

- **KPIs:** Total Rides, Member Avg Ride, Casual Avg Ride, Peak Day, and Peak Hour.
- **Charts:** Membership distribution, rides by day, monthly trends, hourly trends, and bike type distribution.
- **Filters:** Month, Time of Day, Week Type, and Bike Type.
- **Rider categories:** Member and Casual, distinguished through a consistent color legend.

**Metric definitions**

| Metric | Definition |
|---|---|
| Total Rides | Sum of ride counts under the selected filters |
| Member Avg Ride | Total eligible member ride duration divided by eligible member rides, then converted to minutes |
| Casual Avg Ride | Total eligible casual ride duration divided by eligible casual rides, then converted to minutes |
| Peak Day | Day with the highest combined ride count |
| Peak Hour | Starting hour with the highest combined ride count |
| Week Type | Weekday: Monday–Friday. Weekend: Saturday–Sunday |
| Time of Day | Morning: 05:00–09:59. Midday: 10:00–15:59. Evening: 16:00–19:59. Night: 20:00–04:59 |

Average ride duration excludes trips under one second and over 24 hours. These trips remain included in ride counts.

Week Type follows the weekday logic in `11_rides_by_day_of_week.sql`, where `day_of_week` values 2–6 represent weekdays.

**Issue log**

| Date | Issue | Resolution |
|---|---|---|
| 2026-10-31 | Peak Day and Peak Hour returned blank or incorrect results under selected filters | Adjusted filter context for peak calculations |
| 2026-11-01 | Member Avg Ride and Casual Avg Ride both displayed 15.1 minutes | Revised KPI calculations to separate rider categories |

**KPI and dashboard cross-validation**

| Check | Dashboard | Reference | Status |
|---|---:|---:|---|
| Total rides | 5.55M | 5,552,912 | Match (rounding) |
| Member share | 64% | 63.99% | Match (rounding) |
| Casual share | 36% | 36.01% | Match (rounding) |
| Member Avg Ride | 12.0 min | 11.96 min | Match (rounding) |
| Casual Avg Ride | 19.1 min | 19.14 min | Match (rounding) |
| Electric bike rides | 3.61M | `14_bike_type_analysis.sql`: 3,604,904 | Match (rounding) |
| Classic bike rides | 1.95M | `14_bike_type_analysis.sql`: 1,948,008 | Match (rounding) |
| Peak Day | Saturday | `11_rides_by_day_of_week.sql`: 864,405 combined rides | Match |
| Peak Hour | 17:00–18:00 | `17_peak_hour_validation.sql`: 572,442 combined rides at hour 17 | Match |

Cleaned bike type counts (electric: 1,326,798 casual and 2,278,106 member; classic: 672,653 casual and 1,275,355 member) sum to 5,552,912. They differ from the raw counts in Section 2 by 82 rides (49 electric and 33 classic), matching the 82 records excluded during cleaning.

**Peak Day reconciliation**

Member and casual ride counts from `11_rides_by_day_of_week.sql`:

| Day | Member | Casual | Combined |
|---|---:|---:|---:|
| Sunday | 382,293 | 331,783 | 714,076 |
| Monday | 502,767 | 228,253 | 731,020 |
| Tuesday | 563,054 | 225,549 | 788,603 |
| Wednesday | 550,154 | 221,538 | 771,692 |
| Thursday | 576,005 | 258,045 | 834,050 |
| Friday | 528,989 | 320,077 | 849,066 |
| Saturday | 450,199 | 414,206 | 864,405 |
| **Total** | **3,553,461** | **1,999,451** | **5,552,912** |

Saturday recorded the highest combined ride volume, with 864,405 rides. Daily totals reconcile with the cleaned dataset.

**Peak Hour reconciliation**

Combined ride counts from `17_peak_hour_validation.sql`, queried against `trips_2025_cleaned`:

| Start Hour | Combined Rides |
|---|---:|
| 17:00–18:00 | 572,442 |
| 16:00–17:00 | 509,937 |
| 18:00–19:00 | 459,705 |

Hour 17 recorded the highest combined ride volume.

### 8. Evidence Register

| Evidence File | Description | Status |
|---|---|---|
| `01_source_portal.png` | Source data documentation | Listed |
| `02_bigquery_monthly_tables.png` | Monthly raw tables | Listed |
| `03_schema_validation.png` | Schema validation | Listed |
| `04_key_field_validation.png` | Key-field validation | Listed |
| `05_category_counts.png` | Rider and bike category counts | Listed |
| `06_out_of_month_check.png` | Source-month validation | Listed |
| `07_duplicate_ride_id_check.png` | Duplicate ID check | Listed |
| `08_combined_raw_table_preview.png` | Combined raw table preview | Listed |
| `09_combined_table_source_verification.png` | Source verification | Listed |
| `10_combined_data_quality_audit.png` | Combined data quality audit | Listed |
| `11_category_distribution_audit.png` | Category distribution audit | Listed |
| `12_invalid_timestamp_inspection.png` | Invalid timestamp inspection | Listed |
| `13_precise_duration_audit.png` | Duration assessment | Listed |
| `14_negative_duration_date_audit.png` | Negative-duration date audit | Listed |
| `15_annual_study_period_validation.png` | Data Period validation | Listed |
| `16_outside_data_period_inspection.png` | Outside-period inspection | Listed |
| `17_cleaned_table_preview.png` | Cleaned table preview | Listed |
| `18_cleaned_table_validation.png` | Cleaned table validation | Listed |
| `19_ride_volume_analysis.png` | Ride volume analysis | Listed |
| `20_ride_duration_analysis.png` | Ride duration analysis and KPI reference | Listed |
| `21_rides_by_day_of_week.png` | Day-of-week analysis and Peak Day reference | Listed |
| `22_rides_by_month.png` | Monthly analysis | Listed |
| `23_rides_by_start_hour.png` | Start-hour analysis | Listed |
| `24_bike_type_analysis.png` | Bike type analysis | Listed |
| `25_dashboard_aggregation_query.png` | Dashboard aggregation query | Listed |
| `26_dashboard_aggregation_result.png` | Dashboard aggregation results | Listed |
| `27_dashboard_aggregation_validation.png` | Aggregation validation | Listed |
| `28_dashboard_rider_validation.png` | Rider-level validation | Listed |
| `29_tableau_kpi_discrepancy.png` | Initial KPI discrepancy | Saved |
| `30_tableau_kpi_corrected.png` | Corrected KPI values | Saved |
| `31_tableau_dashboard_final.png` | Final dashboard | Saved |
| `32_peak_hour_validation.png` | Peak Hour validation query and results | Saved |

### 9. Change History

| Date | Update |
|---|---|
| 2026-10-29 | Documented schema validation, initial data quality checks, raw category counts, source-month validation, and duplicate trip ID checks. |
| 2026-10-30 | Added combined raw table creation, data quality audit, cleaning and transformation activities, final validation results, and supporting evidence. |
| 2026-10-30 | Added six Analyze SQL activities and their results, with supporting evidence references. |
| 2026-10-30 | Added dashboard aggregation creation and validation activities, reconciliation results, and supporting evidence references. |
| 2026-10-31 | Added the Share phase, including Tableau Public dashboard development, chart sheets, KPI cards, filters, layout, and styling. |
| 2026-11-01 | Added ride duration results, dashboard KPI investigation, cross-validation, and updated evidence references. |
| 2026-11-01 | Validated Peak Day against `11_rides_by_day_of_week.sql` and Peak Hour against `17_peak_hour_validation.sql`. |
| 2026-11-01 | Published the dashboard on Tableau Public. |
| 2026-11-01 | Completed the Act phase documentation, including three marketing recommendations, proposed campaign measures, next steps, and additional data requirements. |