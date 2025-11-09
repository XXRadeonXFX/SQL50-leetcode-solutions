
USE leetcode ;
CREATE TABLE Person (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);


INSERT INTO Person (id, email) VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

        

 WITH CTE AS ( 
		SELECT * , ROW_NUMBER() OVER( PARTITION BY TRIM(LOWER(email)) ORDER BY id ) AS RN
		FROM Person
		) 
        
DELETE FROM person WHERE id IN (
SELECT
DISTINCT id 
 FROM CTE WHERE RN >= 2 ) 
 ;
 
