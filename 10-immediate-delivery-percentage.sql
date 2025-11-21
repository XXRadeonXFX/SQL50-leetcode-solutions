USE leetcode;

-- Create Delivery table
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    customer_pref_delivery_date DATE NOT NULL
);

-- Optional: Add index on customer_id for better query performance
CREATE INDEX idx_customer_id ON Delivery(customer_id);

-- Optional: Add index on order_date
CREATE INDEX idx_order_date ON Delivery(order_date);


-- Insert data into Delivery table
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES 
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 2, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-12'),
    (4, 3, '2019-08-24', '2019-08-24'),
    (5, 3, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13'),
    (7, 4, '2019-08-09', '2019-08-09');


-------------------------------------------------------
CREATE TABLE delivery1 (
    delivery_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    customer_pref_delivery_date DATE NOT NULL
);


INSERT INTO delivery1 (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
(289, 7, '2019-07-22', '2019-08-13'),
(85, 90, '2019-08-01', '2019-08-18'),
(982, 82, '2019-08-15', '2019-08-16'),
(325, 61, '2019-08-30', '2019-08-30'),
(652, 18, '2019-08-05', '2019-08-15'),
(176, 64, '2019-07-02', '2019-07-02'),
(248, 86, '2019-07-19', '2019-08-04'),
(720, 7, '2019-07-08', '2019-08-20'),
(557, 41, '2019-07-25', '2019-07-25'),
(426, 47, '2019-07-15', '2019-08-03'),
(1000, 20, '2019-07-17', '2019-07-17'),
(947, 71, '2019-07-14', '2019-08-18'),
(379, 27, '2019-07-09', '2019-08-14'),
(886, 42, '2019-08-10', '2019-08-18'),
(943, 94, '2019-08-06', '2019-08-08'),
(87, 85, '2019-07-19', '2019-07-29'),
(179, 98, '2019-07-31', '2019-07-31'),
(733, 53, '2019-08-22', '2019-08-24'),
(224, 81, '2019-08-31', '2019-08-31'),
(394, 78, '2019-07-29', '2019-07-29'),
(451, 47, '2019-07-01', '2019-08-24'),
(149, 1, '2019-08-29', '2019-08-29'),
(328, 41, '2019-07-10', '2019-07-10'),
(169, 100, '2019-08-31', '2019-08-31'),
(977, 92, '2019-08-17', '2019-08-31'),
(492, 63, '2019-08-23', '2019-08-23'),
(686, 88, '2019-08-25', '2019-08-26'),
(800, 47, '2019-07-16', '2019-07-16'),
(638, 91, '2019-08-19', '2019-08-24'),
(405, 74, '2019-08-29', '2019-08-30'),
(861, 10, '2019-08-08', '2019-08-24'),
(984, 19, '2019-07-17', '2019-07-30'),
(702, 5, '2019-07-21', '2019-08-20'),
(228, 100, '2019-07-27', '2019-08-24'),
(461, 85, '2019-08-13', '2019-08-13'),
(602, 81, '2019-08-29', '2019-08-29'),
(135, 98, '2019-08-23', '2019-08-23'),
(489, 85, '2019-08-14', '2019-08-20'),
(350, 3, '2019-08-05', '2019-08-05'),
(99, 42, '2019-07-02', '2019-08-06'),
(449, 9, '2019-08-07', '2019-08-11'),
(397, 83, '2019-08-12', '2019-08-21'),
(109, 71, '2019-08-29', '2019-08-30'),
(526, 6, '2019-08-02', '2019-08-02'),
(695, 71, '2019-07-24', '2019-07-25'),
(574, 68, '2019-08-15', '2019-08-18'),
(268, 88, '2019-07-06', '2019-07-06'),
(190, 46, '2019-07-18', '2019-08-19'),
(163, 27, '2019-07-28', '2019-07-28'),
(476, 70, '2019-07-21', '2019-07-21'),
(104, 72, '2019-08-30', '2019-08-30'),
(881, 58, '2019-07-18', '2019-07-18'),
(47, 49, '2019-07-23', '2019-07-26'),
(303, 82, '2019-08-08', '2019-08-09'),
(500, 74, '2019-08-27', '2019-08-28'),
(65, 15, '2019-07-28', '2019-08-20'),
(160, 82, '2019-07-01', '2019-08-28');

---------------------------------------------------------------

--# SOLUTIION 1:
SELECT
ROUND(COUNT(DiSTINCT customer_id) / ( SELECT COUNT(DiSTINCT customer_id) FROM delivery1  ) *100,2) AS immediate_percentage 
 FROM (
SELECT 
* ,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS RN
FROM delivery1 ) AS t
WHERE RN = 1
AND DATEDIFF(order_date,customer_pref_delivery_date) = 0;


-- # SOLUTION 1:
WITH CTE AS (
SELECT 
customer_id , 
DATEDIFF( customer_pref_delivery_date , order_date ) = 0 AS val
 FROM (
SELECT 
*,
ROW_NUMBER() OVER( PARTITION BY customer_id ORDER BY order_date   ) AS RN
FROM delivery1 
) AS t 
WHERE RN =1
)

SELECT 
ROUND( ( SUM(val)/COUNT(val) ) * 100 ,2) AS immediate_percentage 
FROM CTE
;


-- # SOLUTION: 2
# Write your MySQL query statement below
WITH CTE AS (

SELECT 
customer_id 
, MIN(order_date) AS order_date 
,MIN(customer_pref_delivery_date) AS customer_pref_delivery_date

FROM delivery
GROUP BY 1
)


SELECT 
ROUND(( SUM( CASE WHEN DATEDIFF( customer_pref_delivery_date , order_date) = 0 THEN 1 ELSE 0 END ) 
/ COUNT(*)  ) * 100 ,2) AS immediate_percentage
FROM CTE 
