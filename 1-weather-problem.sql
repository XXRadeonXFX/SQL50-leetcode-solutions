USE leetcode;

DROP TABLE IF EXISTS weather;
CREATE TABLE Weather (
    id INTEGER PRIMARY KEY,
    recordDate DATE NOT NULL,
    temperature INTEGER NOT NULL
);

-- Insert the data

INSERT INTO Weather (id, recordDate, temperature) VALUES
(1, '2015-01-31', 10),
(2, '2015-02-01', 25),
(3, '2015-02-03', 20),
(4, '2015-02-04', 30);


WITH CTE AS (
SELECT 
* , LEAD(recordDate,1) OVER( ORDER BY recordDate ) AS ld_dt
, LEAD(temperature,1) OVER( ORDER BY recordDate ) AS ld_tmp
, LEAD(id,1) OVER( ORDER BY recordDate )  AS ld_id
FROM weather ) 

, CTE1 AS  (
SELECT CASE WHEN DATEDIFF(ld_dt , recordDate) = 1 AND ld_tmp > temperature THEN ld_id END AS id
FROM CTE )

SELECT DISTINCT id FROM CTE1 WHERE id IS NOT NULL;


