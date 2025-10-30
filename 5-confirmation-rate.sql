USE leetcode;
-- Create Signups table
CREATE TABLE Signups (
    user_id INT PRIMARY KEY,
    time_stamp DATETIME NOT NULL
);

-- Create Confirmations table
CREATE TABLE Confirmations (
    user_id INT NOT NULL,
    time_stamp DATETIME NOT NULL,
    action VARCHAR(20) NOT NULL,
    PRIMARY KEY (user_id, time_stamp),
    FOREIGN KEY (user_id) REFERENCES Signups(user_id)
);

-- Insert data into Signups table
INSERT INTO Signups (user_id, time_stamp) VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

-- Insert data into Confirmations table
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

WITH CTE AS (
SELECT 
A.user_id , CASE WHEN B.action is NULL OR B.action = 'timeout' THEN 0 
	ELSE 1 END AS action1

FROM signups A LEFT JOIN confirmations B
ON A.user_id = B.user_id
)
SELECT user_id , ROUND(SUM(action1) / COUNT(action1),2 ) AS confirmation_rate 
 FROM CTE 
 GROUP BY 1;
