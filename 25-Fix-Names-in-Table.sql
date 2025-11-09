USE leetcode;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO Users (user_id, name)
VALUES
(1, 'aLice'),
(2, 'bOB');


SELECT user_id, 
        CONCAT( UPPER(LEFT(name,1) ) 
         , SUBSTR( LOWER(name) , 2  ) ) AS name 
         
 FROM users;
