WITH cte AS (
	SELECT *, 
		LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at) - created_at diff_days
	FROM amazon_transactions
	WHERE user_id IN (SELECT user_id 
			  FROM amazon_transactions
			  GROUP BY user_id
			  HAVING COUNT(user_id) > 1))
SELECT DISTINCT user_id
FROM cte
WHERE diff_days <= 7;