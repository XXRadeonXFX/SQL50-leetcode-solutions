USE leetcode;

WITH Seat AS (
    SELECT 1 AS id, 'Abbot' AS student UNION ALL
    SELECT 2, 'Doris' UNION ALL
    SELECT 3, 'Emerson' UNION ALL
    SELECT 4, 'Green' UNION ALL
    SELECT 5, 'Jeames'
),
CTE2 AS (
SELECT *, COALESCE( COALESCE( LEAD(id,1) OVER( PARTITION BY RN  )  
        , LAG(id,1) OVER( PARTITION BY RN )  ) , id )AS swap
 FROM (
SELECT * , id- CASE WHEN MOD( id ,2 )= 0 THEN 2 ELSE 1 END AS RN 
FROM Seat ) AS t
 )
SELECT A.id,B.student FROM CTE2 A JOIN Seat B
ON A.swap = B.id  ; 
 ;
