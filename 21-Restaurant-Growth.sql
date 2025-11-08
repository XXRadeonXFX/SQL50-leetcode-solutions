USE leetcode;

DROP TABLE IF EXISTS customer;
CREATE TABLE Customer (
    customer_id INT,
    name VARCHAR(100) NOT NULL,
    visited_on DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (customer_id, visited_on)
);


INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES
(1, 'Jhon',    '2019-01-01', 100),
(2, 'Daniel',  '2019-01-02', 110),
(3, 'Jade',    '2019-01-03', 120),
(4, 'Khaled',  '2019-01-04', 130),
(5, 'Winston', '2019-01-05', 110),
(6, 'Elvis',   '2019-01-06', 140),
(7, 'Anna',    '2019-01-07', 150),
(8, 'Maria',   '2019-01-08', 80),
(9, 'Jaze',    '2019-01-09', 110),
(1, 'Jhon',    '2019-01-10', 130),
(3, 'Jade',    '2019-01-10', 150);

WITH CTE AS (
SELECT * , DATE_ADD(visited_on, INTERVAL 6 DAY) AS till
, LAST_VALUE( visited_on) OVER( ORDER BY visited_on ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS ld
FROM customer ) ,
CTE2 AS ( 

SELECT DISTINCT visited_on , ls FROM (
SELECT
customer_id , name , visited_on , amount , 
CASE WHEN till <= ld THEN till ELSE NULL END AS ls
 FROM CTE ) AS t 
 WHERE ls IS NOT NULL )

SELECT 
 B.ls AS visited_on, SUM(A.amount) AS amount , ROUND(SUM(A.amount) / COUNT( DISTINCT A.visited_on ),2)   AS average_amount
 FROM customer A, CTE2 B 
 WHERE A.visited_on BETWEEN B.visited_on AND B.ls
GROUP BY ls
ORDER BY 1
;

Restaurant Growth
