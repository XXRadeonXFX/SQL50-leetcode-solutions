SELECT 1;
SHOW DATABASES;
USE leetcode;


SELECT * FROM weather;


CREATE TABLE Activity (
    machine_id INT NOT NULL,
    process_id INT NOT NULL,
    activity_type VARCHAR(10) NOT NULL,
    timestamp DECIMAL(10, 3) NOT NULL,
    PRIMARY KEY (machine_id, process_id, activity_type)
);

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES
    (0, 0, 'start', 0.712),
    (0, 0, 'end', 1.520),
    (0, 1, 'start', 3.140),
    (0, 1, 'end', 4.120),
    (1, 0, 'start', 0.550),
    (1, 0, 'end', 1.550),
    (1, 1, 'start', 0.430),
    (1, 1, 'end', 1.420),
    (2, 0, 'start', 4.100),
    (2, 0, 'end', 4.512),
    (2, 1, 'start', 2.500),
    (2, 1, 'end', 5.000);
    
 
WITH CTE AS (
SELECT 
* , LEAD(timestamp) OVER( PARTITION BY machine_id , process_id  ORDER BY timestamp ) AS RN
FROM Activity ORDER BY machine_id, process_id, timestamp 
)    

SELECT machine_id, ROUND(SUM((RN-timestamp)/2),3) AS processing_time FROM CTE
WHERE RN is not NULL
GROUP BY machine_id;


CREATE TABLE Activity1 (
    machine_id INT NOT NULL,
    process_id INT NOT NULL,
    activity_type VARCHAR(10) NOT NULL,
    timestamp DECIMAL(10, 3) NOT NULL,
    PRIMARY KEY (machine_id, process_id, activity_type)
);

-- DML: Insert the data
INSERT INTO Activity1 (machine_id, process_id, activity_type, timestamp)
VALUES
    (4, 0, 'end', 98.227),
    (0, 0, 'start', 89.478),
    (2, 0, 'start', 4.060),
    (4, 0, 'start', 35.617),
    (0, 0, 'end', 93.686),
    (1, 0, 'end', 97.821),
    (1, 0, 'start', 73.793),
    (3, 0, 'end', 85.537),
    (3, 0, 'start', 35.138),
    (2, 0, 'end', 48.225),
    (5, 0, 'start', 22.284),
    (5, 0, 'end', 53.926);
    
WITH CTE AS (
SELECT 
* , LEAD(timestamp) OVER( PARTITION BY machine_id , process_id  ORDER BY timestamp ) AS RN
FROM Activity1 ORDER BY machine_id, process_id, timestamp 
)    
SELECT machine_id , SUM(processing_time)  AS processing_time
FROM (
SELECT machine_id, RN-timestamp AS processing_time
 FROM CTE
WHERE RN is not NULL ) AS t
GROUP BY machine_id;    


-- DDL: Create the Activity2 table
CREATE TABLE Activity2 (
    machine_id INT NOT NULL,
    process_id INT NOT NULL,
    activity_type VARCHAR(10) NOT NULL,
    timestamp DECIMAL(10, 3) NOT NULL,
    PRIMARY KEY (machine_id, process_id, activity_type)
);

-- DML: Insert the data
INSERT INTO Activity2 (machine_id, process_id, activity_type, timestamp)
VALUES
    (0, 0, 'start', 0.712),
    (0, 0, 'end', 1.520),
    (0, 1, 'start', 3.140),
    (0, 1, 'end', 4.120),
    (1, 0, 'start', 0.550),
    (1, 0, 'end', 1.550),
    (1, 1, 'start', 0.430),
    (1, 1, 'end', 1.420),
    (2, 0, 'start', 4.100),
    (2, 0, 'end', 4.512),
    (2, 1, 'start', 2.500),
    (2, 1, 'end', 5.000);
    
WITH CTE AS (
SELECT 
* , LEAD(timestamp) OVER( PARTITION BY machine_id , process_id  ORDER BY timestamp ) AS RN
FROM Activity1 ORDER BY machine_id, process_id, timestamp 
)    

SELECT machine_id, ROUND(SUM(val)/ COUNT(machine_id) ,3) AS processing_time   
FROM (
SELECT * , RN- timestamp AS val 
 FROM CTE
WHERE RN is not NULL ) AS t
GROUP BY machine_id;        
    