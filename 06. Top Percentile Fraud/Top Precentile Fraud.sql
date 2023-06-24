WITH cte AS (
	SELECT *, 
		PERCENT_RANK() OVER (PARTITION BY state ORDER BY fraud_score DESC) percentile_rank
	FROM fraud_score)
SELECT 
	policy_num, 
	state, 
	claim_cost, 
	fraud_score
FROM cte
WHERE percentile_rank <= 0.05;