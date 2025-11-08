WITH CTE1 AS (
SELECT title, AVG(rating) rt
 FROM movierating A , movies B
WHERE A.movie_id = B.movie_id
AND created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY title ) ,

CTE AS (
SELECT name, COUNT(rating) AS CNT
FROM MovieRating A , Users B
WHERE A.user_id = B.user_id
GROUP BY name ) 


SELECT DISTINCT name AS results FROM (
SELECT *, ROW_NUMBER() OVER( ORDER BY name ) AS RN FROM CTE 
WHERE CNT = ( SELECT MAX(cnt) FROM CTE )
) as t 
WHERE RN = 1

UNION ALL
SELECT DISTINCT title AS results FROM(
SELECT *, ROW_NUMBER() OVER(ORDER BY title) AS RN FROM CTE1
WHERE rt = (SELECT MAX(rt) FROM CTE1  )
) AS t
WHERE rn =1
