# Analysis conclusion

## Executive outcome

In this 3,900-record snapshot, subscription status and discount use do not correspond to higher recorded purchase amounts. Subscribers average **$59.49** per record versus **$59.87** for non-subscribers; records with a discount average **$59.28** versus **$60.13** without one. These are descriptive comparisons, not evidence that subscriptions or discounts reduce spending. The data has no campaign exposure, order history, or margin information to measure incremental impact.

The clearest portfolio conclusion is therefore: **this dataset describes who and what appears in the purchase records, but it does not establish which promotion or customer program drives more value.** The next business step should be a controlled test with better outcome data, rather than expanding discounts based on these averages.

## Evidence

| Measure | Result | Interpretation |
| --- | ---: | --- |
| Records and unique customer IDs | 3,900 | One record per customer in this file; not a longitudinal purchase history. |
| Total recorded purchase amount | $233,081 | Sum of the row-level amounts; not lifetime revenue. |
| Overall average recorded purchase amount | $59.76 | Baseline for the comparisons below. |
| Subscriber share | 27.0% (1,053) | Subscribers average $59.49; non-subscribers average $59.87. |
| Discounted-record share | 43.0% (1,677) | Discounted records average $59.28; non-discounted records average $60.13. |
| Repeat-buyer subscriber share | 27.6% (958 of 3,476 with more than five previous purchases) | Close to the overall 27.0% subscriber share; this snapshot does not show a strong subscriber concentration among repeat buyers. |
| Largest categories | Clothing: 44.5%; Accessories: 31.8% | Together they account for 76.3% of records and 76.6% of recorded purchase amount. |
| Highest seasonal average | Fall: $61.56; Spring: $58.74 | A $2.82 difference in this snapshot. There are no dates or evidence that season caused the difference. |

The source has 37 missing review ratings (0.95%). The notebook imputes these using category medians; rating results should be interpreted with that handling in mind. `promo_code_used` exactly matches `discount_applied`, so the two fields cannot be compared as independent factors.

## Recommended business actions

1. **Do not claim that subscriptions increase spending from this dataset.** Test a specific subscription benefit with randomized eligible customers. Compare conversion, repeat purchase rate, net revenue, and margin over a defined follow-up period.
2. **Evaluate discounts on incremental profit.** Run a holdout test and capture discount cost, product margin, and subsequent purchases. A lower average among discounted records alone does not tell whether the discount changed behavior.
3. **Prioritize category reporting for Clothing and Accessories.** They dominate the records. Use the report to monitor purchase amount, rating, discount share, and record count for these categories, while retaining the smaller categories as comparisons.
4. **Treat the Fall pattern as a hypothesis.** Validate it with dated transactions across multiple years before using it to plan seasonal inventory or campaigns.

## Data needed for the next version

Add transaction date, order ID, stable customer ID across multiple orders, item quantity, unit cost/margin, discount amount, campaign exposure, and subscription start/end dates. These fields would support time trends, retention, customer lifetime value, basket analysis, and causal campaign evaluation. Until then, present the current results as descriptive findings only.
