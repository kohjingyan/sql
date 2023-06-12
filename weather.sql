SELECT id, city, temperature, day FROM 
(SELECT *,
CASE
WHEN LEAD(temperature,2) OVER() < 0 AND LEAD(temperature) OVER() < 0 AND temperature < 0
THEN 'Y'
WHEN LEAD(temperature) OVER() < 0 AND LAG(temperature) OVER() < 0 AND temperature < 0
THEN 'Y'
WHEN LAG(temperature,2) OVER() < 0 AND LAG(temperature) OVER() < 0 AND temperature < 0
THEN 'Y'
ELSE 'N'
END as cold
FROM weather) x
WHERE x.cold = 'Y';

with cte as (
SELECT *,
CASE
WHEN LEAD(temperature,2) OVER() < 0 AND LEAD(temperature) OVER() < 0 AND temperature < 0
THEN 'Y'
WHEN LEAD(temperature) OVER() < 0 AND LAG(temperature) OVER() < 0 AND temperature < 0
THEN 'Y'
WHEN LAG(temperature,2) OVER() < 0 AND LAG(temperature) OVER() < 0 AND temperature < 0
THEN 'Y'
ELSE 'N'
END as cold
FROM weather)
select id, city, temperature, day from cte where cold = 'Y';