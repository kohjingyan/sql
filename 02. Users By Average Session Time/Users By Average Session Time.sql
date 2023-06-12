WITH cte AS (
	SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY timestamp) rn
	FROM facebook_web_log
	WHERE action = 'page_load' OR action = 'page_exit')
SELECT x.user_id, AVG(x.t2 - x.t1)
FROM (
	SELECT c1.user_id,
		c1.timestamp AS t1, 
		c2.timestamp AS t2,
		ROW_NUMBER() OVER (PARTITION BY c2.user_id, c2.rn ORDER BY (c2.user_id, c2.rn) ASC, c1.rn DESC) rn2
	FROM cte c1
	INNER JOIN cte c2
	ON c1.action <> c2.action 
		AND c1.user_id = c2.user_id
		AND c1.timestamp < c2.timestamp
	WHERE c1.action = 'page_load' 
		AND c2.action = 'page_exit') x
WHERE x.rn2 = 1
GROUP BY x.user_id;
