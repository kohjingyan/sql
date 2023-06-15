SELECT COUNT(DISTINCT user_id)
FROM (
  SELECT user_id,
        created_at,
        product_id,
        MIN(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS initial_purchase_date,
        MIN(created_at) OVER(PARTITION BY user_id, product_id ORDER BY created_at) AS initial_product_purchase_date
  FROM marketing_campaign) x
WHERE x.initial_purchase_date != x.initial_product_purchase_date;
