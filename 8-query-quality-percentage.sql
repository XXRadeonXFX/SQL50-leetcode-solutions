USE leetcode;


-- DDL: Drop and Create Table

DROP TABLE IF EXISTS Queries;

CREATE TABLE Queries (
    query_name VARCHAR(100),
    result VARCHAR(100),
    position INT,
    rating INT
);

-- DML: Insert Data

INSERT INTO Queries (query_name, result, position, rating) VALUES
('Dog', 'Golden Retriever', 1, 5),
('Dog', 'German Shepherd', 2, 5),
('Dog', 'Mule', 200, 1),
('Cat', 'Shirazi', 5, 2),
('Cat', 'Siamese', 3, 3),
('Cat', 'Sphynx', 7, 4);


SELECT 
query_name, ROUND(SUM(rating/position)/ COUNT(1 ),2 ) AS quality 
,  ROUND(( SUM(CASE WHEN rating < 3 THEN 1 
    ELSE 0 
    END ) /COUNT(1) ) * 100 ,2 )  AS poor_query_percentage 

FROM Queries 
GROUP BY 1
