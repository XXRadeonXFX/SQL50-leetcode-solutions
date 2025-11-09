WITH Employee AS (
    SELECT 1 AS id, 100 AS salary
    UNION ALL
    SELECT 2, 200
--     UNION ALL
--     SELECT 3, 200
    UNION ALL
    SELECT 3, 300
)
, CTE1 AS (
SELECT * , DENSE_RANK() OVER( ORDER BY salary DESC ) AS RN
 FROM employee  )
 , CTE2 AS (
 
 SELECT COUNT(salary) AS cnt  FROM CTE1 WHERE RN =2  
 ) , CTE3 AS ( 
 SELECT * , ROW_NUMBER() OVER( order by SecondHighestSalary DESC ) AS RN FROM (
 SELECT DISTINCT salary AS SecondHighestSalary   FROM CTE1 WHERE RN =2 
 UNION 
 SELECT CASE WHEN cnt = 0 THEN NULL END AS SecondHighestSalary FROM CTE2  
  ) AS t  )
 SELECT 
 SecondHighestSalary  
 FROM CTE3;
 
 
 ------------------------------------------------
 WITH Employee AS (
    SELECT 1 AS id, 100 AS salary
)
, CTE1 AS (
SELECT * , DENSE_RANK() OVER( ORDER BY salary DESC ) AS RN
 FROM employee  )
 , CTE2 AS (
 
 SELECT COUNT(salary) AS cnt FROM CTE1 WHERE RN =2  
 ) 
 , CTE3 AS ( 
 SELECT * , ROW_NUMBER() OVER( order by SecondHighestSalary DESC ) AS RN FROM (
 SELECT DISTINCT salary AS SecondHighestSalary   FROM CTE1 WHERE RN =2 
 UNION 
 SELECT CASE WHEN cnt = 0 THEN NULL END AS SecondHighestSalary FROM CTE2  
  ) AS t  )
 SELECT SecondHighestSalary FROM CTE3
 WHERE RN <> 2;
 

------------------------------------------------
 WITH Employee AS (
    SELECT 1 AS id, 100 AS salary
)

SELECT max(salary) AS SecondHighestSalary FROM employee 
WHERE salary NOT IN ( SELECT MAX(salary) FROM employee );
