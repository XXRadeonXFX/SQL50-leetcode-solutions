Use leetcode;


DROP TABLE IF EXISTS Visits;
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY,
    customer_id INT NOT NULL
);

---

DROP TABLE IF EXISTS transactions;
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    visit_id INT NOT NULL,
    amount INT NOT NULL,
    -- Define visit_id as a Foreign Key referencing the Visits table
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);


-- Insert data into the parent table (Visits) first
INSERT INTO Visits (visit_id, customer_id) VALUES
(1, 23),
(2, 9),
(4, 30),
(5, 54),
(6, 96),
(7, 54),
(8, 54);

---

-- Insert data into the child table (Transactions)
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES
(2, 5, 310),
(3, 5, 300),
(9, 5, 200),
(12, 1, 910),
(13, 2, 970);


-- OR COUNT(B.visit_id) IS NULL 
SELECT COUNT(0);
SELECT COUNT(NULL);


# Write your MySQL query statement below
# Key  thing to remember here is 
-- COUNT(NULL) = 0
-- COUNT(0) = 1  ;

WITH CTE AS (
SELECT 
A.visit_id , A.customer_id , COUNT( B.visit_id ) AS cnt
FROM visits A LEFT JOIN transactions B
ON A.visit_id = B.visit_id
GROUP BY A.visit_id , A.customer_id
HAVING COUNT(B.visit_id) = 0
)

SELECT DISTINCT customer_id, COUNT(cnt) AS count_no_trans 
FROM CTE
GROUP BY customer_id ;


