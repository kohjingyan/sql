You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1).

# Question

**Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . Output the user_id and their average session time.**


````
Table: facebook_web_log
| Column Name   | Column Type |
| ------------- | ----------- |
| user_id       | int         |
| timestamp     | datetime    |
| action        | varchar     |
````

## The thinking behind the approach
1. Use **WHERE** clause to filter the table to where users perform page_load and page_exit only.
2. For each user, use the window function **ROW_NUMBER()** to assign a unique sequential number in the chronological order. We name this column as `rn`.
3. Save this as a CTE and perform a self join on three conditions:

    a. `user_id`
    
    b. `action` such that for first table is page_load; for second table is page_exit.
    
    c. page_load should happen before page_exit.
    
4. Naming this column as `rn2`, use the window function **ROW_NUMBER()** to assign a unique sequential number for each user and each `rn`, sorted in:

    a. First table: Chronological order 
    
    b. Second table: Reverse chronological order
    
5. Filter the result to `rn2 = 1` (the latest page_load and earliest page_exit).
6. Group the result by `user_id` and find the average of respective page_exit timestamps and respective page_load timestamps.

## Step-by-step Guide
### 1. Filter the table to where users perform page_load and page_exit only.
````sql
SELECT *
FROM facebook_web_log
WHERE action = 'page_load' OR action = 'page_exit'
````

### 2. Assign a unique sequential number in the chronological order.
````sql
SELECT *, 
	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY timestamp) rn
FROM facebook_web_log
WHERE action = 'page_load' OR action = 'page_exit'
````

### 3. Save the result as a CTE and perform a self join.
````sql
WITH cte AS (
	SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY timestamp) rn
	FROM facebook_web_log
	WHERE action = 'page_load' OR action = 'page_exit')
SELECT *
FROM cte c1
INNER JOIN cte c2
ON c1.action <> c2.action 
	AND c1.user_id = c2.user_id
	AND c1.timestamp < c2.timestamp
WHERE c1.action = 'page_load' 
	AND c2.action = 'page_exit'
````

### 4. Assign a unique sequential number for each user and each `rn`.

````sql
WITH cte AS (
	SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY timestamp) rn
	FROM facebook_web_log
	WHERE action = 'page_load' OR action = 'page_exit')
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
	AND c2.action = 'page_exit'
````

### 5. Filter the result to `rn2 = 1`.

````sql
WITH cte AS (
	SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY timestamp) rn
	FROM facebook_web_log
	WHERE action = 'page_load' OR action = 'page_exit')
SELECT *
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
````

### 6. Group the result by `user_id` and find the average session time for each user.

````sql
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
````

# Final Output
| user_id | avg    |
| ------- | ------ |
| 0       | 1883.5 |
| 1       | 35     |

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
