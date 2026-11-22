CREATE DATABASE IF NOT EXISTS customer_behavior;
USE customer_behavior;

-- Q1. What is the recorded purchase amount by gender?
SELECT gender, SUM(purchase_amount) AS recorded_purchase_amount
FROM customer
GROUP BY gender
ORDER BY recorded_purchase_amount DESC;

-- Q2. Which customers used a discount and spent more than the average recorded purchase amount?
SELECT customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes'
  AND purchase_amount > (SELECT AVG(purchase_amount) FROM customer)
ORDER BY purchase_amount DESC;

-- Q3. Which five products have the highest average review rating? Show rating counts for context.
SELECT item_purchased,
       ROUND(AVG(review_rating), 2) AS average_product_rating,
       COUNT(review_rating) AS rating_count
FROM customer
GROUP BY item_purchased
ORDER BY average_product_rating DESC, rating_count DESC
LIMIT 5;

-- Q4. Compare average recorded purchase amount for Standard and Express shipping.
SELECT shipping_type,
       ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
       COUNT(*) AS purchase_count
FROM customer
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type
ORDER BY average_purchase_amount DESC;

-- Q5. Compare average recorded purchase amount and summed purchase amount by subscription status.
SELECT subscription_status,
       COUNT(*) AS purchase_count,
       ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
       ROUND(SUM(purchase_amount), 2) AS recorded_purchase_amount
FROM customer
GROUP BY subscription_status
ORDER BY recorded_purchase_amount DESC, average_purchase_amount DESC;

-- Q6. Which five products have the highest share of records with a discount applied?
SELECT item_purchased,
       ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS discount_rate_percent,
       COUNT(*) AS purchase_count
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate_percent DESC, purchase_count DESC
LIMIT 5;

-- Q7. How many records fall into each previous-purchase band?
-- These descriptive bands avoid calling customers with prior purchases "New."
WITH customer_segment AS (
    SELECT customer_id,
           CASE
               WHEN previous_purchases BETWEEN 1 AND 10 THEN '1-10 previous purchases'
               WHEN previous_purchases BETWEEN 11 AND 25 THEN '11-25 previous purchases'
               ELSE '26+ previous purchases'
           END AS purchase_history_band
    FROM customer
)
SELECT purchase_history_band, COUNT(*) AS customer_count
FROM customer_segment
GROUP BY purchase_history_band
ORDER BY MIN(CASE purchase_history_band
                 WHEN '1-10 previous purchases' THEN 1
                 WHEN '11-25 previous purchases' THEN 2
                 ELSE 3
             END);

-- Q8. Show the top three products by purchase count within each category.
-- RANK keeps all products tied at the third position.
WITH item_counts AS (
    SELECT category,
           item_purchased,
           COUNT(*) AS purchase_count,
           RANK() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS item_rank
    FROM customer
    GROUP BY category, item_purchased
)
SELECT category, item_purchased, purchase_count, item_rank
FROM item_counts
WHERE item_rank <= 3
ORDER BY category, item_rank, item_purchased;

-- Q9. Among repeat buyers (more than five previous purchases), what share are subscribers?
SELECT COUNT(*) AS repeat_buyer_count,
       SUM(CASE WHEN subscription_status = 'Yes' THEN 1 ELSE 0 END) AS subscribed_repeat_buyer_count,
       ROUND(100.0 * SUM(CASE WHEN subscription_status = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS subscribed_share_percent
FROM customer
WHERE previous_purchases > 5;

-- Q10. What is the recorded purchase amount by age group?
SELECT age_group,
       SUM(purchase_amount) AS recorded_purchase_amount,
       COUNT(*) AS purchase_count
FROM customer
GROUP BY age_group
ORDER BY recorded_purchase_amount DESC;
