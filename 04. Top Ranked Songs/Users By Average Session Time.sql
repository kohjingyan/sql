SELECT trackname, COUNT(position) as top
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
GROUP BY trackname
ORDER BY top DESC;