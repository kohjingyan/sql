You may find the source of the SQL question from [StrataScratch](https://platform.stratascratch.com/coding/9991-top-ranked-songs?code_type=1).

# Question

**Find songs that have ranked in the top position. Output the track name and the number of times it ranked at the top. Sort your records by the number of times the song was in the top position in descending order.**


````
Table: spotify_worldwide_daily_song_ranking
| Column Name   | Column Type |
| ------------- | ----------- |
| id            | int         |
| position      | int         |
| trackname     | varchar     |
| artist        | varchar     |
| streams       | int         |
| url           | varchar     |
| date          | datetime    |
| region        | varchar     |
````

## The thinking behind the approach
1. Use **WHERE** to filter the result to songs that ranked the top. (i.e. `position = 1`)
2. Group the result by songs and use the aggregate function **COUNT()** to count the number of times the song was top.
3. Use **ORDER BY** to sort the number of times the song was ranked first in descending order.

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
