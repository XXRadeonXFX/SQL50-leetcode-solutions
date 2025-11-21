USE leetcode;
-- DDL: Create Tables

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL
);

CREATE TABLE Register (
    contest_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (contest_id, user_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- DML: Insert Data

-- Insert into Users table
INSERT INTO Users (user_id, user_name) VALUES
(6, 'Alice'),
(2, 'Bob'),
(7, 'Alex');

-- Insert into Register table
INSERT INTO Register (contest_id, user_id) VALUES
(215, 6),
(209, 2),
(208, 2),
(210, 6),
(208, 6),
(209, 7),
(209, 6),
(215, 7),
(208, 7),
(210, 2),
(207, 2),
(210, 7);


WITH CTE AS (
SELECT 
B.contest_id , COUNT(B.contest_id) AS cnt
FROM users A LEFT JOIN register B 
ON A.user_id = B.user_id  
GROUP BY B.contest_id ) ,
CTE1 AS ( SELECT COUNT(1) AS cnt1 FROM users )

SELECT 
contest_id , ROUND((cnt/cnt1 * 100) ,2)  AS percentage 
FROM CTE , CTE1
ORDER BY percentage DESC , 1 ASC
;
----------------------------------------------

-- DDL: Create Tables

DROP TABLE IF EXISTS Register1;
DROP TABLE IF EXISTS Users1;

-- Create parent table first
CREATE TABLE Users1 (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL
);

-- Create child table second
CREATE TABLE Register1 (
    contest_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (contest_id, user_id),
    FOREIGN KEY (user_id) REFERENCES Users1(user_id)
);

-- DML: Insert Data

-- Insert into parent table (Users1) FIRST
INSERT INTO Users1 (user_id, user_name) VALUES
(631, 'Freida'),
(112, 'Rachel'),
(392, 'Naftali'),
(674, 'Tikvah'),
(543, 'Adam'),
(675, 'Yehudah'),
(447, 'Moshe'),
(784, 'Naftali'),
(268, 'Freida');

-- Insert into child table (Register1) SECOND
INSERT INTO Register1 (contest_id, user_id) VALUES
(187, 674),
(187, 631),
(187, 784),
(187, 447);



# Solution 1:
WITH CTE AS (
SELECT 
B.contest_id , COUNT(B.contest_id) AS cnt
FROM users1 A LEFT JOIN register B 
ON A.user_id = B.user_id  
GROUP BY B.contest_id ) ,
CTE1 AS ( SELECT COUNT(1) AS cnt1 FROM users )

SELECT 
contest_id , ROUND((cnt/cnt1 * 100) ,2)  AS percentage 
FROM CTE , CTE1
ORDER BY percentage DESC , 1 ASC
;



# Solution 2:
SELECT rg.contest_id  ,    ROUND( ( COUNT(1) / (
          SELECT COUNT(1) FROM users
)  ) * 100 , 2 ) AS percentage    
FROM users us , register rg
WHERE us.user_id = rg.user_id
GROUP BY 1 
ORDER BY  2 DESC ,1;

