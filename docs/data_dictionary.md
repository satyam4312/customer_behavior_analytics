# Data dictionary

The source CSV contains 3,900 records. It has 18 source fields; the notebook adds `age_group` and `purchase_frequency_days` before loading the MySQL table.

| Field | Meaning |
| --- | --- |
| `customer_id` | Identifier in the source dataset. Each ID appears once in this file. |
| `age` | Customer age in years. |
| `gender` | Gender category provided by the source. |
| `item_purchased` | Product named in the recorded purchase. |
| `category` | Product category. |
| `purchase_amount_(usd)` / `purchase_amount` | Amount in USD for the recorded row. The notebook renames this to `purchase_amount`. |
| `location` | US state associated with the customer record. |
| `size` | Product size. |
| `color` | Product color. |
| `season` | Season associated with the record. |
| `review_rating` | Product review rating; 37 source values are missing. The notebook fills missing values with the median rating within that product category. |
| `subscription_status` | Whether the record is marked as subscribed (`Yes` or `No`). |
| `shipping_type` | Shipping method. |
| `discount_applied` | Whether a discount was applied. |
| `promo_code_used` | Whether the source record indicates a promo code was used. It duplicates `discount_applied` in this dataset and should not be treated as an independent feature. |
| `previous_purchases` | Number of previous purchases recorded for the customer. |
| `payment_method` | Payment method category. |
| `frequency_of_purchases` | Purchase-frequency category from the source. |
| `age_group` | Notebook-generated quartile group based on this dataset's age distribution; boundaries depend on this sample. |
| `purchase_frequency_days` | Notebook-generated approximate days per frequency label. These are mappings, not observed intervals. |

## Analysis limits

There is no transaction date, order ID, or customer with multiple rows. As a result, summed amounts describe the total of the recorded rows, not lifetime spend. This dataset cannot establish trends over time, retention, cohorts, or customer-level repeat behavior. The SQL purchase-history bands are descriptive cutoffs, not validated marketing segments. The category-median rating imputation should be considered when interpreting rating averages.
