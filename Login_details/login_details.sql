with cte as
(SELECT *,
CASE
WHEN user_name = LEAD(user_name,2) OVER (ORDER BY login_id) 
 AND user_name = LEAD(user_name) OVER (ORDER BY login_id) 
THEN user_name 
ELSE null 
END as repeated_names
FROM login_details
ORDER BY login_id)
SELECT distinct repeated_names
FROM cte
WHERE repeated_names IS NOT NULL;