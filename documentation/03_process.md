# Cyclistic Bike-Share Case Study

## Process Phase

### 1. Tools Selection

Google BigQuery and SQL were selected to process the Cyclistic 2025 trip data. BigQuery was used to handle the large dataset efficiently, while SQL supported data consolidation, quality assessment, cleaning, transformation, and validation.

### 2. Data Quality Assessment

The combined raw dataset was examined to assess its integrity and identify potential issues before analysis. The assessment covered:

- Duplicate ride IDs.
- Missing values in key columns.
- Invalid timestamp sequences and trip durations.
- Trips lasting less than one second or longer than 24 hours.
- Missing station information and coordinates.
- Invalid coordinate ranges.
- Records outside the intended analysis period.
- Value distributions in the `member_casual` and `rideable_type` columns.

The initial assessment identified the following issues:

- 29 records with negative trip durations.
- 1,075 records with start dates outside their respective source months.
- 53 records with start dates outside calendar year 2025.
- 1,184,673 records with missing start station IDs and names.
- 1,243,305 records with missing end station IDs and names.
- 5,535 records with missing coordinates.
- 5,585 trips lasting longer than 24 hours.
- 1,837 records with non-positive trip durations.

No duplicate ride IDs or invalid coordinate ranges were identified.

### 3. Data Cleaning and Transformation

The combined raw table was processed using SQL to create a separate cleaned analytical table. The following operations were performed.

#### Record Filtering

Records with start dates outside calendar year 2025 and records with negative trip durations were excluded from the cleaned dataset.

A total of 82 records were excluded: 53 records outside the 2025 analysis period and 29 records with negative trip durations.

#### Trip Duration Calculation

The following calculated columns were added:

- `ride_length_seconds`: Trip duration in seconds.
- `ride_length_minutes`: Trip duration in minutes.
- `ride_length`: Trip duration formatted as HH:MM:SS.

#### Day of Week Calculation

Two columns were added to identify when each trip started:

- `day_of_week`: Numeric representation of the starting day, where 1 represents Sunday and 7 represents Saturday.
- `day_of_week_name`: Corresponding day name in English.

#### Duration Quality Indicators

Two additional columns were created:

- `is_under_one_second`: Flags trips lasting less than one second.
- `is_over_24_hours`: Flags trips lasting longer than 24 hours.

Trips with unusual durations were retained and flagged rather than automatically removed.

#### Missing Station Information

Records with missing station IDs, station names, or coordinates were retained because these missing values do not necessarily indicate invalid trip records. This preserves potentially useful trip information for subsequent analysis.

### 4. Data Validation

The cleaned table was validated to verify the results of the cleaning and transformation process.

| Validation metric | Result |
|---|---:|
| Total cleaned records | 5,552,912 |
| Unique ride IDs | 5,552,912 |
| Negative-duration records | 0 |
| Missing-duration records | 0 |
| Trips under one second | 1,808 |
| Trips over 24 hours | 5,585 |
| Earliest start date | 2025-01-01 |
| Latest start date | 2025-12-31 |

The validation confirmed that the cleaned table contained no negative trip durations or duplicate ride IDs. All retained trip start dates fell within calendar year 2025.

### 5. Final Output

The cleaned dataset was stored in the `cyclistic_2025` BigQuery dataset and prepared for the Analyze phase.

The final table retains the original trip attributes and source metadata, along with the calculated duration, weekday, and duration quality indicator columns.

The SQL cleaning script and validation screenshots were retained as supporting documentation to make the process reviewable and reproducible.

**Process Outcome:** The trip data was consolidated, assessed, cleaned, transformed, and validated, resulting in an analytical dataset ready for further analysis of Cyclistic's 2025 bike-share usage patterns.
