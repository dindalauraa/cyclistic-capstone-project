# Cyclistic Bike-Share Case Study

## Act Phase

### 1. Final Conclusion

The analysis of 5,552,912 Cyclistic trips from January 1 to December 31, 2025 shows that annual members and casual riders differ most in trip duration and weekly riding patterns.

Annual members accounted for 63.99% of rides and recorded most of their trips on weekdays. Casual riders accounted for 36.01% of rides, took longer trips (19.14 minutes on average, compared with 11.96 minutes for members), and recorded a larger share of their rides on weekends (37.31%, compared with 23.43%).

Both groups recorded their highest monthly ride volume in August and their highest hourly ride volume at 17:00. Electric bikes accounted for most rides in both groups (66.36% of casual rides and 64.11% of member rides). These findings identify trip duration and weekly riding patterns as the clearest differences between casual riders and annual members.

These findings describe recorded usage during 2025. They do not explain why casual riders choose their current passes or whether a marketing campaign would convert them into annual members.

### 2. Top Three Recommendations

The following recommendations are proposed marketing actions based on the observed usage patterns. Each represents an opportunity to test rather than a proven outcome.

#### Recommendation 1: Target weekend casual riders with membership campaigns

**Supporting evidence:**

- Weekend rides represented 37.31% of casual rides, compared with 23.43% of member rides.
- Saturday recorded the highest combined daily volume, at 864,405 rides.
- Casual riders represented 47.9% of Saturday rides, compared with 28.6% of Tuesday rides.
- Casual riders recorded 745,989 weekend rides.

**Proposed action:** Test weekend-focused membership campaigns through email, social media, and in-app promotions. Schedule messages from Friday through Sunday and highlight the benefits of annual membership to riders who frequently use the service on weekends.

**Success measure:** Track membership sign-ups and campaign engagement from weekend-focused campaigns. Compare the results with a comparable control group that does not receive the weekend-specific messaging.

#### Recommendation 2: Demonstrate the potential value of annual membership

**Supporting evidence:**

- Casual riders averaged 19.14 minutes per trip, compared with 11.96 minutes for members.
- The 90th percentile of casual trip duration was 38.75 minutes, compared with 23.25 minutes for members.

**Proposed action:** Develop an illustrative cost comparison between single-ride, full-day, and annual membership options using different trip-frequency scenarios. Use the comparison in marketing materials to communicate the potential value of annual membership. Pricing, pass-type, and rider-frequency data are needed to complete this comparison.

**Success measure:** Compare engagement and membership sign-up rates between campaigns that use cost-comparison messaging and campaigns that do not.

#### Recommendation 3: Align campaign timing with seasonal and hourly activity patterns

**Supporting evidence:**

- Casual ride volume rose from 24,124 rides in January to 337,878 rides in August, and August was also the highest-volume month for annual members.
- Casual riders accounted for 43.02% of all rides in June, their highest monthly share.
- Casual ride activity was relatively high between 12:00 and 18:00, with the highest volume at 17:00.

**Proposed action:** Test digital acquisition campaigns during periods of higher casual rider activity, particularly in the summer months and afternoon hours. Use the 2025 patterns to inform the initial campaign schedule, then evaluate results before repeating the strategy.

**Success measure:** Track campaign engagement and membership sign-ups by month and time window to identify the periods that generate the strongest results.

### 3. Next Steps

The findings and recommendations are intended to inform Cyclistic's marketing strategy, with the Marketing Director and relevant decision-makers as the intended stakeholders. If the recommendations are adopted, the suggested next steps are:

1. Prioritize the three recommendations and select one for an initial marketing pilot.
2. Define the campaign's target audience, channels, duration, budget, and success measures.
3. Obtain pricing, pass-type, and rider-frequency data to complete the cost comparison in Recommendation 2.
4. Establish a comparable control group and baseline measures before implementing the pilot.
5. Monitor campaign performance and compare results against the defined success measures before considering a wider rollout.
6. Further investigate why casual riders choose their current passes and what factors could motivate them to purchase annual memberships.

### 4. Pilot Success Measures

The following metrics would be used to evaluate a pilot campaign if the recommendations are implemented.

| Measure | Purpose |
|---|---|
| Campaign reach and engagement | Assess how many riders the campaign reaches and how they respond |
| Click-through rate | Evaluate the effectiveness of campaign messages |
| Membership sign-up rate | Measure membership conversions associated with the campaign |
| Cost per acquisition | Evaluate the cost efficiency of membership acquisition |
| Incremental sign-ups | Measure additional sign-ups compared with a comparable control group |

### 5. Additional Data for Further Analysis

| Data | Purpose |
|---|---|
| Pricing for single-ride, full-day, and annual plans | Compare costs across different trip-frequency scenarios and estimate potential savings |
| Pass type among casual riders (single-ride or full-day) | Distinguish casual rider segments, since `member_casual` does not identify pass type |
| Rider frequency | Build realistic trip-frequency scenarios for the cost comparison |
| Prior-year trip data | Examine whether seasonal and weekly riding patterns remain consistent across years |
| Rider surveys | Understand why casual riders choose their current pass and what would motivate them to purchase an annual membership |
| Campaign performance data | Evaluate campaign effectiveness and refine marketing strategies |
| Station-level data | Support location-based targeting. Start station IDs and names are missing for about 21% of raw records, while coordinates are missing for 5,535 records |
| Weather data | Examine how weather conditions relate to seasonal riding patterns |

### 6. Considerations

- **Study period:** The analysis covers one year of trip data, from January to December 2025. The observed monthly patterns should be interpreted within this period and do not establish long-term seasonal trends.
- **Descriptive findings:** The analysis identifies differences in recorded riding patterns but does not establish the reasons behind them or prove that a particular marketing strategy will increase annual memberships.
- **Trip purpose:** The available trip records do not establish whether rides were for commuting, leisure, or other purposes. Further research would be needed to understand riders' motivations.
- **Data privacy:** The recommendations are based on aggregated riding patterns and membership categories rather than attempts to identify individual riders.
- **Ride duration:** Average ride duration calculations include trips lasting from one second to 24 hours. Trips shorter than one second and longer than 24 hours were excluded from duration statistics but retained in overall ride counts. The 90th percentile values are approximate estimates calculated with BigQuery's `APPROX_QUANTILES` function.

### 7. Act Deliverables

| Deliverable | Location |
|---|---|
| Top three recommendations | Section 2 of this document |
| Supporting findings | `documentation/04_analyze.md` and `documentation/05_share.md` |
| Published dashboard | [Ridership Analytics Dashboard](https://public.tableau.com/views/CyclisticBike-ShareAnalysisDashboard_17934258541930/CyclisticBike-ShareAnalysisDashboard) |
| Validation record | `logs/validation_logs.md` |

**Act Outcome:** The analysis resulted in three proposed marketing recommendations, accompanied by suggested evaluation measures, implementation considerations, and additional data requirements for future testing.