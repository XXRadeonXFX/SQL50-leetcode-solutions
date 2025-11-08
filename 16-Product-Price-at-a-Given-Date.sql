USE leetcode;

WITH Products AS (
    SELECT 1 AS product_id, 20 AS new_price, DATE('2019-08-14') AS change_date UNION ALL
    SELECT 2, 50, DATE('2019-08-14') UNION ALL
    SELECT 1, 30, DATE('2019-08-15') UNION ALL
    SELECT 1, 35, DATE('2019-08-16') UNION ALL
    SELECT 2, 65, DATE('2019-08-17') UNION ALL
    SELECT 3, 20, DATE('2019-08-18')
)
SELECT product_id , new_price AS price
FROM Products 
WHERE (product_id , change_date) IN ( 
SELECT product_id , MAX(change_date)  AS change_date
FROM products
WHERE change_date <= '2019-08-16'
GROUP BY product_id
HAVING MAX(change_date) <= '2019-08-16' )

UNION 
SELECT product_id , 10 AS price
FROM products
GROUP BY product_id 
HAVING MIN(change_date) > '2019-08-16';


------------------------------------


USE leetcode;

WITH Products AS (
    SELECT 1 AS product_id, 20 AS new_price, DATE('2019-08-14') AS change_date UNION ALL
    SELECT 2, 50, DATE('2019-08-14') UNION ALL
    SELECT 1, 30, DATE('2019-08-15') UNION ALL
    SELECT 1, 5, DATE('2019-08-16') UNION ALL
    SELECT 2, 65, DATE('2019-08-17') UNION ALL
    SELECT 3, 20, DATE('2019-08-18')
)
SELECT product_id , new_price AS price
FROM Products 
WHERE (product_id , change_date) IN ( 
SELECT product_id , MAX(change_date)  AS change_date
FROM products
WHERE change_date <= '2019-08-16'
GROUP BY product_id
HAVING MAX(change_date) <= '2019-08-16' )

UNION 
SELECT product_id , 10 AS price
FROM products
GROUP BY product_id 
HAVING MIN(change_date) > '2019-08-16';


