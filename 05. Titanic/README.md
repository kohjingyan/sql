You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class?code_type=1).

# Question

**Make a report showing the number of survivors and non-survivors by passenger class.\
Classes are categorized based on the pclass value as:\
pclass = 1: first_class\
pclass = 2: second_class\
pclass = 3: third_class\
Output the number of survivors and non-survivors by each class.**


````
Table: titanic
| Column Name   | Column Type |
| ------------- | ----------- |
| passengerid   | int         |
| survived      | int         |
| pclass        | int         |
| name          | varchar     |
| sex           | varchar     |
| age           | float       |
| sibsp         | int         |
| parch         | int         |
| ticket        | varchar     |
| fare          | float       |
| cabin         | varchar     |
| embarked      | varchar     |
````

## The thinking behind the approach
There are two ways to think of the expected output:

**Expected Output 1**
| pclass   | non_survivors | survivors |
| -------- | ------------- | --------- |
| 1        |               |           |
| 2        |               |           |
| 3        |               |           |

**Expected Output 2**
| survived   | first_class | second_class | third_class |
| ---------- | ----------- | ------------ | ----------- |
| 0          |             |              |             |
| 1          |             |              |             |

We will look at how to derive at **Expected Output 1**. The same method can be applied for **Expected Output 2**.
1. For each non-survivor, `survived = 0`. We count the number of non-survivor by using **CASE WHEN**.\
````
SUM(IF survived = 0
  1
ELSE 0)
````


## Step-by-step Guide
### 1. Filter the result to songs that ranked the top.

````sql
SELECT *
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
````

### 2. Group the result by songs and count the number of times the song was top.

````sql
SELECT trackname, COUNT(position) as top
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
GROUP BY trackname
````

### 3. Sort the number of times the song was ranked first in descending order.

````sql
SELECT trackname, COUNT(position) as top
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
GROUP BY trackname
ORDER BY top DESC;
````

If you have any questions or feedback, please feel free to email me at kohjingyan@gmail.com or at [LinkedIn](https://www.linkedin.com/in/koh-jing-yan/).
