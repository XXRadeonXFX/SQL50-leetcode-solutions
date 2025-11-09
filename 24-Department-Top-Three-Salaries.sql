USE leetcode;
CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    departmentId INT
--     FOREIGN KEY (departmentId) REFERENCES Department(id)
);


-- Insert into Department table
TRUNCATE TABLE department;
INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Insert into Employee table
TRUNCATE TABLE employee;
INSERT INTO Employee (id, name, salary, departmentId) VALUES
(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1);


WITH CTE AS (
SELECT DISTINCT 
B.name AS Department , A.name AS Employee  ,A.salary ,
MAX(salary) OVER( PARTITION BY departmentId ORDER BY salary DESC   )
,DENSE_RANK() OVER( PARTITION BY departmentId ORDER BY salary DESC ) AS RN
 FROM employee A JOIN department B 
ON A.departmentId = B.id
)
SELECT  
Department , Employee  , salary  FROM CTE 
WHERE RN <= 3;
------------------------
-- Insert into Department table
TRUNCATE TABLE department;
INSERT INTO Department (id, name)
VALUES (1, 'Sales');

TRUNCATE TABLE employee;
-- Insert into Employee table
-- (No data provided, add example if needed)
-- Example:
-- INSERT INTO Employee (id, name, salary, departmentId)
-- VALUES (1, 'John', 75000, 1);
