-- DDL: Create the Students table
CREATE TABLE Students (
    student_id INT NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (student_id)
);

-- DDL: Create the Subjects table
CREATE TABLE Subjects (
    subject_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (subject_name)
);

-- DDL: Create the Examinations table
CREATE TABLE Examinations (
    student_id INT NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_name) REFERENCES Subjects(subject_name)
);

-- DML: Insert data into Students table
INSERT INTO Students (student_id, student_name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (13, 'John'),
    (6, 'Alex');

-- DML: Insert data into Subjects table
INSERT INTO Subjects (subject_name)
VALUES
    ('Math'),
    ('Physics'),
    ('Programming');

-- DML: Insert data into Examinations table
INSERT INTO Examinations (student_id, subject_name)
VALUES
    (1, 'Math'),
    (1, 'Physics'),
    (1, 'Programming'),
    (2, 'Programming'),
    (1, 'Physics'),
    (1, 'Math'),
    (13, 'Math'),
    (13, 'Programming'),
    (13, 'Physics'),
    (2, 'Math'),
    (1, 'Math');


# Write your MySQL query statement below
WITH CTE AS (
SELECT * 
FROM students A CROSS JOIN subjects B
ON B.subject_name = B.subject_name ) 

SELECT student_id, student_name , subject_name ,  SUM(attended_exams)  AS attended_exams
 FROM (
SELECT  
A.student_id, A.student_name , A.subject_name 
, CASE WHEN B.subject_name IS NULL THEN 0
			 ELSE 1 END AS  attended_exams 
FROM CTE A
LEFT JOIN examinations  B
ON A.student_id = B.student_id 
AND A.subject_name = B.subject_name
) AS t
GROUP BY 1,2,3
ORDER BY 1,3;