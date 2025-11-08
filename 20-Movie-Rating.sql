USE leetcode;
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    created_at DATE
--     PRIMARY KEY (movie_id, user_id),
--     FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
--     FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- Movies table
INSERT INTO Movies (movie_id, title) VALUES
(1, 'Avengers'),
(2, 'Frozen 2'),
(3, 'Joker');

-- Users table
INSERT INTO Users (user_id, name) VALUES
(1, 'Daniel'),
(2, 'Monica'),
(3, 'Maria'),
(4, 'James');

-- MovieRating table
INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES
(1, 1, 3, '2020-01-12'),
(1, 2, 4, '2020-02-11'),
(1, 3, 2, '2020-02-12'),
(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),
(2, 2, 2, '2020-02-01'),
(2, 3, 2, '2020-03-01'),
(3, 1, 3, '2020-02-22'),
(3, 2, 4, '2020-02-25');

WITH CTE1 AS (
SELECT title, AVG(rating) rt
 FROM movierating A , movies B
WHERE A.movie_id = B.movie_id
AND created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY title ) ,

CTE AS (
SELECT name, COUNT(rating) AS CNT
FROM MovieRating A , Users B
WHERE A.user_id = B.user_id
GROUP BY name ) 


SELECT DISTINCT name AS results FROM (
SELECT *, ROW_NUMBER() OVER( ORDER BY name ) AS RN FROM CTE 
WHERE CNT = ( SELECT MAX(cnt) FROM CTE )
) as t 
WHERE RN = 1

UNION ALL
SELECT DISTINCT title AS results FROM(
SELECT *, ROW_NUMBER() OVER(ORDER BY title) AS RN FROM CTE1
WHERE rt = (SELECT MAX(rt) FROM CTE1  )
) AS t
WHERE rn =1;


