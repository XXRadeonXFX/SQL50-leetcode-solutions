USE leetcode;

CREATE TABLE Teacher (
    teacher_id INT NOT NULL,
    subject_id INT NOT NULL,
    dept_id INT NOT NULL,
    PRIMARY KEY (teacher_id, subject_id, dept_id)
);


INSERT INTO Teacher (teacher_id, subject_id, dept_id) VALUES
(1, 2, 3),
(1, 2, 4),
(1, 3, 3),
(2, 1, 1),
(2, 2, 1),
(2, 3, 1),
(2, 4, 1);

WITH CTE AS (
SELECT 
* , ROW_NUMBER() OVER( PARTITION BY teacher_id,subject_id ORDER BY subject_id ) AS RN
FROM teacher 
)
SELECT  teacher_id , COUNT( RN ) AS cnt
FROM CTE
WHERE RN = 1
GROUP BY teacher_id
;

SELECT teacher_id ,  COUNT( DISTINCT subject_id ) AS cnt
FROM teacher
GROUP BY teacher_id;
