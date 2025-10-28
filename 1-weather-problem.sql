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


SHOW DATABASES ;
USE leetcode;

DELETE FROM Weather WHERE 1=1;

TRUNCATE TABLE Weather;

SELECT * FROM Weather;


    SELECT *,
        LEAD(temperature, 1) OVER(ORDER BY recordDate) AS next_temp,
        LEAD(recordDate, 1) OVER(ORDER BY recordDate) AS next_date,
        LEAD(id, 1) OVER(ORDER BY recordDate) AS next_id
    FROM Weather