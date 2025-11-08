USE leetcode ;
WITH Queue AS (
    SELECT 5 AS person_id, 'Alice' AS person_name, 250 AS weight, 1 AS turn UNION ALL
    SELECT 4, 'Bob', 175, 5 UNION ALL
    SELECT 3, 'Alex', 350, 2 UNION ALL
    SELECT 6, 'John Cena', 400, 3 UNION ALL
    SELECT 1, 'Winston', 500, 6 UNION ALL
    SELECT 2, 'Marie', 200, 4
)
SELECT person_name 
FROM (
SELECT * , ROW_NUMBER() OVER( ORDER BY sm DESC ) AS RN
FROM ( 
SELECT *  ,SUM(weight) OVER( ORDER BY turn ) AS sm
FROM Queue 
) AS t
WHERE sm <= 1000 
 ) AS k 
WHERE RN =1			

;




WITH Queue AS (
    SELECT 5 AS person_id, 'Alice' AS person_name, 250 AS weight, 1 AS turn UNION ALL
    SELECT 4, 'Bob', 175, 5 UNION ALL
    SELECT 3, 'Alex', 350, 2 UNION ALL
    SELECT 6, 'John Cena', 400, 3 UNION ALL
    SELECT 1, 'Winston', 500, 6 UNION ALL
    SELECT 2, 'Marie', 200, 4
)

,CTE AS 
(
    SELECT person_name, SUM(weight) OVER(ORDER BY turn ASC) AS sum
    FROM Queue
)
SELECT person_name
FROM cte
WHERE sum <= 1000
ORDER BY sum DESC
LIMIT 1;
