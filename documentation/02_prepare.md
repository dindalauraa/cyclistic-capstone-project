# Cyclistic Bike-Share Case Study

## Prepare Phase

### 1. Data Sources

This analysis uses publicly available Divvy historical bike-trip data for the Cyclistic case study. Cyclistic is a fictional company, while Divvy is the real bike-share system whose trip data is used for the analysis.

- **Data source:** [Divvy System Data](https://divvybikes.com/system-data)
- **Download archive:** [Divvy Historical Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)
- **Data license:** [Divvy Data License Agreement](https://divvybikes.com/data-license-agreement)
- **Download date:** October 29, 2026
- **Data period:** January 1–December 31, 2025
- **Data format:** Monthly CSV files distributed in ZIP archives
- **Key variables:** `ride_id`, `rideable_type`, `started_at`, `ended_at`, and `member_casual`

The selected period consists of 12 monthly files covering the complete 2025 calendar year. The files were imported into Google BigQuery for initial validation and subsequent analysis.

### 2. Data Organization and Storage

The dataset is organized at the trip level, with each row representing a recorded bike trip. The 13 columns contain trip identifiers, bike types, start and end timestamps, station information, coordinates, and rider categories. The `member_casual` field distinguishes annual members from casual riders.

Google BigQuery is used for data preparation and SQL analysis, while Tableau will be used to develop the interactive dashboard. Google Sheets may be used for supplementary checks or summary tables where needed.

Original source data is kept separate from the analytical dataset. Raw tables will remain unchanged, and data-cleaning decisions will be documented to support traceability and reproducibility.

**Storage Record**

- **Data period:** January–December 2025
- **Monthly source tables imported into BigQuery:** 12
- **BigQuery project:** `cyclistic-case-study-513112`
- **BigQuery dataset:** `cyclistic_2025`
- **Raw data policy:** Original raw tables are preserved.
- **GitHub policy:** Raw ZIP files will not be uploaded to the public repository.

### 3. Data Credibility: ROCCC Assessment

The dataset was assessed using the ROCCC framework: Reliable, Original, Comprehensive, Current, and Cited.

**Reliable:** The data is available through the official Divvy data portal. Its suitability for analysis is assessed through checks of data structure, completeness, and timestamp validity.

**Original:** The dataset consists of historical trip records provided through the Divvy data source rather than a third-party summary or analysis.

**Comprehensive:** Twelve consecutive monthly files cover the full 2025 calendar year and support comparisons of recorded usage by rider type, trip duration, day, time, and month. However, the dataset does not capture every aspect of customer behavior or explain why riders choose a particular membership.

**Current:** The 2025 dataset provides a complete calendar year for the selected analysis. Using a full year supports seasonal comparisons without relying on a partial-year period.

**Cited:** The official Divvy data portal and Data License Agreement are referenced in this document and will also be included in the final project README.

Overall, the dataset is relevant to the research question, subject to the data-quality checks and limitations described in this document.

### 4. Bias, Privacy, Licensing, and Limitations

- **Potential bias:** The records represent trips captured by the Divvy system, not all transportation choices or all potential customers. Usage may vary with season, weather, holidays, and other factors.
- **Privacy:** The analysis will use trip records for aggregate usage comparisons. No attempt will be made to identify individual riders or link records to personal information.
- **Licensing:** The data will be used in accordance with the Divvy Data License Agreement. Raw data will not be redistributed as a standalone dataset, and the project will not imply official affiliation with or endorsement by Divvy.
- **Analytical limitations:** Trip records can reveal observed usage differences but cannot independently establish rider motivations, membership affordability, or the causal effect of marketing campaigns.

These limitations will be considered when interpreting results and developing marketing recommendations.

### 5. Data Integrity and Initial Validation

Initial validation was performed on the 12 monthly tables imported into BigQuery.

**Validation Results**

- **Table structure:** All 12 tables contain the same 13 columns, with consistent names, data types, and column order.
- **Total raw records:** 5,552,994.
- **Missing values:** No missing or blank values were found in the five checked fields: `ride_id`, `started_at`, `ended_at`, `member_casual`, and `rideable_type`.
- **Rider categories:** `member` and `casual`.
- **Bike categories:** `electric_bike` and `classic_bike`.
- **Timestamp sequence:** 29 records have `ended_at` earlier than `started_at` and require review during data processing.
- **Source-month check:** 1,075 records have `started_at` dates outside the calendar month associated with their source tables. Sample checks in January, February, and September showed trips spanning month boundaries. The full set has not been individually verified.
- **Duplicate trip identifiers:** The duplicate-ID summary query found 0 duplicate non-null `ride_id` values across the 12 monthly raw tables.
- **Remaining checks:** Missing values in station names, station IDs, and coordinate fields, as well as trip-duration outliers, still require assessment.

The analytical dataset will include trips with `started_at` timestamps from January 1 through December 31, 2025. Records outside this period will be excluded from the analytical dataset, while the original raw tables will be preserved. Invalid timestamp sequences and other data-quality issues will be reviewed during the Process phase, with cleaning decisions documented.

### 6. Relevance to the Business Task

The dataset supports the primary research question: **How do annual members and casual riders use Cyclistic bikes differently?**

The `member_casual` field allows comparisons between rider groups. Start and end timestamps can be used to calculate trip duration and examine usage by day, hour, and month. Bike type and station information may provide additional context where the data is available and sufficiently complete.

The analysis will identify observable differences in trip frequency, duration, and timing to inform potential marketing opportunities aimed at converting casual riders into annual members. However, the trip data alone cannot establish rider motivations or prove that a marketing strategy will increase conversions.

### 7. Prepare Deliverable: Data Source Description

The primary data source is the publicly available Divvy historical bike-trip dataset accessed through the official Divvy System Data portal. The analysis covers January 1 through December 31, 2025, using 12 monthly CSV files imported into Google BigQuery. Initial validation confirmed consistent table structures and no missing values in five key fields across 5,552,994 raw records. The duplicate-ID summary query found no duplicate non-null `ride_id` values. Timestamp anomalies and records outside their source-table month were identified for further assessment during data processing. The dataset's licensing conditions, privacy considerations, relevance, and limitations will guide the subsequent analysis and interpretation of findings.