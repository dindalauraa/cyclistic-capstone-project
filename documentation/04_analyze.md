# Cyclistic Bike-Share Case Study

## Analyze Phase

### 1. Analysis Overview

The Analyze phase examined differences in how annual members and casual riders used Cyclistic bikes from January 1 to December 31, 2025.

The analysis was conducted using SQL in Google BigQuery on `cyclistic_2025.trips_2025_cleaned`, which contains 5,552,912 records.

Six analyses examined ride volume, trip duration, day-of-week patterns, monthly patterns, starting-hour patterns, and bike type usage. Descriptive statistics and aggregated ride counts were used to identify differences between the two rider groups.

### 2. Data Organization and Analysis Approach

The cleaned dataset was maintained at the trip level, with each row representing one recorded bike trip. The `member_casual` field distinguishes annual members (`member`) from casual riders (`casual`).

SQL aggregation was used to compare ride counts, ride shares, and duration statistics across relevant dimensions.

Duration analysis included trips lasting at least one second and no more than 24 hours, covering 5,545,519 eligible rides. Trips outside this range remained in the cleaned dataset and were included in ride counts but excluded from duration calculations.

Median and 90th percentile durations were estimated using BigQuery's `APPROX_QUANTILES` function. Ride shares were calculated using the relevant group or overall ride count as the denominator.

### 3. Key Findings

#### 3.1 Ride Volume

Annual members recorded 3,553,461 rides (63.99% of all trips), while casual riders recorded 1,999,451 rides (36.01%).

Annual members accounted for the larger share of total rides during the data period.

#### 3.2 Ride Duration

Casual riders recorded longer trip durations than annual members across all three measures.

| Metric | Casual Riders | Annual Members |
|---|---:|---:|
| Average duration | 19.14 minutes | 11.96 minutes |
| Median duration | 11.38 minutes | 8.58 minutes |
| 90th percentile | 38.75 minutes | 23.25 minutes |

The average trip duration for casual riders was 7.18 minutes, or approximately 60%, longer than that of annual members. The median was approximately 33% longer, while the 90th percentile was approximately 67% longer.

The larger difference between the casual average and median indicates a longer upper tail of trip durations, which raises the average.

#### 3.3 Day-of-Week Patterns

Annual members recorded more rides on weekdays, while casual riders had a greater proportion of weekend rides.

| Metric | Casual Riders | Annual Members |
|---|---:|---:|
| Weekday rides | 1,253,462 | 2,720,969 |
| Weekend rides | 745,989 | 832,492 |
| Weekend ride share | 37.31% | 23.43% |

Annual members recorded their highest daily ride volume on Thursday, with 576,005 rides. Their lowest volume occurred on Sunday, with 382,293 rides.

Casual riders recorded their highest daily ride volume on Saturday, with 414,206 rides, and their lowest on Wednesday, with 221,538 rides.

Saturday recorded the highest combined daily volume, with 864,405 rides, followed by Friday with 849,066 rides. Casual riders accounted for 47.9% of Saturday rides, compared with 28.6% of Tuesday rides.

#### 3.4 Monthly Patterns

Both rider groups recorded their highest monthly ride volume in August.

| Metric | Casual Riders | Annual Members |
|---|---:|---:|
| Highest month | August | August |
| Highest monthly rides | 337,878 | 452,439 |
| Lowest month | January | December |
| Lowest monthly rides | 24,124 | 112,447 |

Casual riders accounted for 43.02% of all rides recorded in June, their highest monthly share during the data period.

Both groups recorded relatively high ride volumes during the middle of the year, followed by lower volumes toward the end of the year.

These results describe monthly variation within the 2025 data period and do not establish long-term seasonal trends or their causes.

#### 3.5 Starting-Hour Patterns

Both rider groups recorded their highest ride volume at 17:00. Combined, 572,442 rides started during this hour, representing approximately 10% of all rides.

| Starting Hour | Combined Rides |
|---|---:|
| 17:00–17:59 | 572,442 |
| 16:00–16:59 | 509,937 |
| 18:00–18:59 | 459,705 |

Annual members recorded 381,788 rides at 17:00, while casual riders recorded 190,654 rides.

Annual members also showed increased ride volume during the morning, particularly around 07:00–09:00, and during the afternoon around 16:00–18:00.

Casual riders recorded relatively high ride volumes from 12:00 to 18:00, with their highest volume at 17:00.

These results represent recorded trip starting times and do not establish the purposes of individual trips.

#### 3.6 Bike Type Usage

Electric bikes accounted for the majority of rides in both rider groups.

| Rider Type | Electric Bike | Classic Bike |
|---|---:|---:|
| Casual riders | 66.36% | 33.64% |
| Annual members | 64.11% | 35.89% |

Among casual riders, 1,326,798 rides used electric bikes and 672,653 used classic bikes.

Among annual members, 2,278,106 rides used electric bikes and 1,275,355 used classic bikes.

The difference in electric bike ride share was 2.25 percentage points, indicating a broadly similar distribution across the two recorded bike types.

### 4. Overall Analysis and Conclusion

The analysis identified differences between annual members and casual riders in ride volume, duration, and temporal patterns.

Annual members accounted for a larger share of total rides and recorded a greater proportion of weekday trips. Casual riders generally had longer trip durations and a greater proportion of weekend rides.

Both groups recorded their highest monthly ride volume in August and their highest hourly ride volume at 17:00. They also showed similar bike type preferences, with electric bikes accounting for the majority of rides in both groups.

Overall, the clearest differences were in trip duration and the distribution of rides across the week. These findings answer the primary business question by describing how the two rider groups used Cyclistic bikes differently during 2025.

The results provide an evidence base for identifying potential marketing opportunities but do not independently explain rider motivations or establish the effectiveness of membership conversion strategies.

### 5. Analytical Limitations

- The analysis describes recorded trip patterns and does not establish the purpose of individual trips.
- Starting-hour and day-of-week patterns cannot independently confirm whether trips were for commuting, leisure, or other activities.
- Monthly patterns are limited to the 2025 data period and do not establish long-term seasonal trends.
- Duration statistics exclude trips shorter than one second and longer than 24 hours.
- Median and 90th percentile duration values are approximate estimates calculated using BigQuery's `APPROX_QUANTILES` function.
- The descriptive analysis identifies observed differences but does not establish statistical significance or causal relationships.

These limitations were considered when interpreting the findings and communicating them in the Share phase.

### 6. Analysis Deliverables

The Analyze phase produced six SQL analyses using the cleaned BigQuery dataset.

| No. | Analysis | SQL File |
|---|---|---|
| 1 | Ride Volume Analysis | `09_ride_volume_analysis.sql` |
| 2 | Ride Duration Analysis | `10_ride_duration_analysis.sql` |
| 3 | Rides by Day of Week | `11_rides_by_day_of_week.sql` |
| 4 | Rides by Month | `12_rides_by_month.sql` |
| 5 | Rides by Start Hour | `13_rides_by_start_hour.sql` |
| 6 | Bike Type Analysis | `14_bike_type_analysis.sql` |

The SQL scripts and query-result screenshots are retained in `sql/` and `logs/screenshots/`. Their activities and evidence references are recorded in `logs/validation_logs.md`.

The aggregated findings provide the analytical basis for the Share phase, where the results are communicated through an interactive Tableau Public dashboard.

### 7. Dashboard Dataset Preparation

To support visualization in Tableau Public, an aggregated dataset was created from `cyclistic_2025.trips_2025_cleaned`.

The resulting table, `cyclistic_2025.dashboard_2025`, contains 8,060 rows representing 5,552,912 trips. The data is grouped by rider type, month, day of week, starting hour, and bike type.

The aggregated measures include:

- `ride_count`: Total trips per group.
- `duration_eligible_count`: Trips with durations between one second and 24 hours.
- `duration_sum_seconds`: Total duration of eligible trips.

The aggregation was validated against the cleaned dataset, confirming that total ride counts and rider-level counts were preserved.

The aggregated table serves as the visualization source for Tableau Public. Average duration is calculated as a weighted average using the aggregated duration and eligible ride counts. Median and 90th percentile durations remain based on the trip-level analysis because they cannot be accurately recalculated from these aggregated measures.

The cleaned trip-level table remains the primary analytical dataset, while `dashboard_2025` serves as its derived visualization dataset.

**Additional SQL Deliverables**

| No. | Activity | SQL File |
|---|---|---|
| 1 | Dashboard aggregation creation | `15_create_dashboard_aggregation.sql` |
| 2 | Dashboard aggregation validation | `16_validate_dashboard_aggregation.sql` |

The SQL scripts and supporting screenshots are retained in `sql/` and `logs/screenshots/`, with validation results documented in `logs/validation_logs.md`.

**Analyze Outcome:** The cleaned trip data was analyzed to compare annual members and casual riders across six dimensions, and a validated aggregated dataset was prepared for dashboard development in the Share phase.