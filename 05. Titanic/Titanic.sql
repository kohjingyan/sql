-- Answer 1
select pclass, 
SUM(CASE WHEN survived = 0 THEN 1 ELSE 0 END) AS non_survivors,
SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) AS survivors
from titanic
group by pclass
ORDER BY pclass;

-- Answer 2
SELECT survived,
SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY survived;