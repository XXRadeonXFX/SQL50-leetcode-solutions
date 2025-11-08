USE leetcode;

WITH Accounts AS (
    SELECT 3 AS account_id, 108939 AS income UNION ALL
    SELECT 2, 12747 UNION ALL
    SELECT 8, 87709 UNION ALL
    SELECT 6, 91796
)
SELECT 'Low Salary' AS category , SUM(cnt) AS accounts_count 
FROM (
SELECT income , COUNT(income) AS cnt
FROM accounts
WHERE income < 20000
GROUP BY income ) as t
UNION 
SELECT 'Average Salary'  AS category , SUM(cnt) AS accounts_count FROM (
SELECT COUNT( cnt) AS cnt ,account_id 
FROM ( 
SELECT * ,CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE NULL END AS cnt
FROM accounts
) as t 
GROUP BY account_id 
) AS k
UNION
SELECT 'High Salary' AS category , SUM(cnt) AS accounts_count 
FROM (
SELECT income , COUNT(income) AS cnt
FROM accounts
WHERE income > 50000
GROUP BY income ) as t
ORDER BY 2 DESC
;

------------------------------------------------------
WITH Accounts AS (
    SELECT 10 AS account_id, 50001 AS income UNION ALL
    SELECT 6, 19999 UNION ALL
    SELECT 5, 20000 UNION ALL
    SELECT 7, 50000 UNION ALL
    SELECT 1, 72417
)

SELECT 'Low Salary' AS category , SUM(cnt) AS accounts_count 
FROM (
SELECT income , COUNT(income) AS cnt
FROM accounts
WHERE income < 20000
GROUP BY income ) as t
UNION 
SELECT 'Average Salary'  AS category , SUM(cnt) AS accounts_count FROM (
SELECT COUNT( cnt) AS cnt ,account_id 
FROM ( 
SELECT * ,CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE NULL END AS cnt
FROM accounts
) as t 
GROUP BY account_id 
) AS k
UNION
SELECT 'High Salary' AS category , SUM(cnt) AS accounts_count 
FROM (
SELECT income , COUNT(income) AS cnt
FROM accounts
WHERE income > 50000
GROUP BY income ) as t
ORDER BY 2 DESC
;




WITH Accounts AS (
    SELECT 3 AS account_id, 108939 AS income UNION ALL
    SELECT 2, 12747 UNION ALL
    SELECT 8, 87709 UNION ALL
    SELECT 6, 91796
)

SELECT 'Low Salary' AS category , SUM(cnt) AS accounts_count 
FROM (
SELECT income , COUNT(income) AS cnt
FROM accounts
WHERE income < 20000
GROUP BY income ) as t
UNION 
SELECT 'Average Salary'  AS category , SUM(cnt) AS accounts_count FROM (
SELECT COUNT( cnt) AS cnt ,account_id 
FROM ( 
SELECT * ,CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE NULL END AS cnt
FROM accounts
) as t 
GROUP BY account_id 
) AS k
UNION
SELECT 'High Salary' AS category , SUM(cnt) AS accounts_count 
FROM (
SELECT income , COUNT(income) AS cnt
FROM accounts
WHERE income > 50000
GROUP BY income ) as t
ORDER BY 2 DESC
;

