USE leetcode;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50) NOT NULL,
    managerId INT,
    FOREIGN KEY (managerId) REFERENCES employees(id)
);

INSERT INTO employees (id, name, department, managerId) VALUES
(101, NULL, 'A', NULL),
(102, NULL, 'A', 101),
(103, NULL, 'A', 101),
(104, NULL, 'A', 101),
(105, NULL, 'A', 101),
(106, NULL, 'B', 101);

SELECT 
A.name 
FROM employees A , employees B
WHERE A.id = B.managerId
GROUP BY A.id 
HAVING COUNT(B.managerId) >= 5 ;