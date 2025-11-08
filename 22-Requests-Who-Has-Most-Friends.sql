USE leetcodel;

CREATE TABLE RequestAccepted (
    requester_id INT NOT NULL,
    accepter_id INT NOT NULL,
    accept_date DATE NOT NULL
);


INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date)
VALUES 
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');


TRUNCATE TABLE requestaccepted;
INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES
(8, 4, '2016-10-10'),
(4, 9, '2016-10-06'),
(4, 10, '2016-08-11'),
(4, 11, '2016-05-27'),
(4, 14, '2016-11-14'),
(15, 4, '2016-11-29'),
(4, 18, '2016-07-12'),
(4, 20, '2016-07-25'),
(10, 13, '2016-02-01'),
(10, 17, '2016-07-17'),
(10, 21, '2016-02-15'),
(23, 10, '2016-12-14'),
(10, 25, '2016-02-23'),
(10, 29, '2016-06-12'),
(10, 30, '2016-07-28'),
(10, 34, '2016-04-24'),
(13, 11, '2016-09-04'),
(16, 11, '2016-10-09'),
(11, 18, '2016-08-19'),
(11, 21, '2016-12-20'),
(11, 24, '2016-09-28'),
(27, 11, '2016-02-15'),
(11, 31, '2016-01-17'),
(33, 11, '2016-01-28'),
(14, 17, '2016-06-28'),
(20, 14, '2016-01-04'),
(21, 14, '2016-04-09'),
(14, 25, '2016-08-15'),
(28, 14, '2016-01-07'),
(14, 29, '2016-03-27'),
(33, 14, '2016-08-28'),
(34, 14, '2016-02-27'),
(17, 19, '2016-01-11'),
(17, 21, '2016-07-08'),
(22, 17, '2016-04-28'),
(23, 17, '2016-03-21'),
(17, 24, '2016-01-21'),
(17, 28, '2016-02-18'),
(31, 17, '2016-03-30'),
(17, 34, '2016-06-17');


WITH CTE AS (
(SELECT 

requester_id AS id , COUNT(DISTINCT accepter_id) AS cnt
FROM requestaccepted
GROUP BY requester_id )
UNION ALL
( SELECT accepter_id AS id, COUNT(DISTINCT requester_id) AS cnt
FROM requestaccepted
GROUP BY accepter_id )
)  ,CTE2 AS (
SELECT id , SUM(cnt) AS sm
FROM CTE
GROUP BY 1 )

SELECT id FROM CTE2 
WHERE sm = (SELECT MAX(sm) AS cnt FROM CTE2);
