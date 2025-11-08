USE leetcode;

DROP TABLE IF EXISTS insurance;
CREATE TABLE Insurance (
    pid INT , -- PRIMARY KEY
    tiv_2015 FLOAT NOT NULL,
    tiv_2016 FLOAT NOT NULL,
    lat FLOAT NOT NULL,
    lon FLOAT NOT NULL
);



INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon)
VALUES
(1, 10, 5, 10, 10),
(2, 20, 20, 20, 20),
(3, 10, 30, 20, 20),
(4, 10, 40, 40, 40);


TRUNCATE TABLE insurance;
INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon)
VALUES
(1, 224.17, 952.73, 32.4, 20.2),
(2, 224.17, 900.66, 52.4, 32.7),
(3, 824.61, 645.13, 72.4, 45.2),
(4, 424.32, 323.66, 12.4, 7.7),
(5, 424.32, 282.90, 12.4, 7.7),
(6, 625.05, 243.53, 52.5, 32.8),
(7, 424.32, 968.94, 72.5, 45.3),
(8, 624.46, 714.13, 12.5, 7.8),
(9, 425.49, 463.85, 32.5, 20.3),
(10, 624.46, 776.85, 12.4, 7.7),
(11, 624.46, 692.71, 72.5, 45.3),
(12, 225.93, 933.00, 12.5, 7.8),
(13, 824.61, 786.86, 32.6, 20.3),
(14, 824.61, 935.34, 52.6, 32.8);



WITH CTE AS (
SELECT * , COUNT(tiv_2015) OVER( PARTITION BY tiv_2015 ORDER BY tiv_2015 ) AS RN_tiv
         ,COUNT(lat + lon) OVER( PARTITION BY lat,lon ORDER BY lat,lon ) AS ll_rn         
FROM insurance
 )

SELECT SUM(tiv_2016) AS tiv_2016 FROM CTE 
WHERE rn_tiv > 1
AND ll_rn = 1;

;


# Write your MySQL query statement below
SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM 
    Insurance
WHERE 
    tiv_2015 IN (
        SELECT tiv_2015
        FROM Insurance
        GROUP BY tiv_2015
        HAVING COUNT(*) > 1
    )
    AND (lat, lon) IN (
        SELECT lat, lon
        FROM Insurance
        GROUP BY lat, lon
        HAVING COUNT(*) = 1
    );
