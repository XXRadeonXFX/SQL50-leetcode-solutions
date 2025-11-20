USE leetcode;
-- Create Prices table
CREATE TABLE Prices (
    product_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (product_id, start_date, end_date),
    CHECK (end_date >= start_date)
);

-- Create UnitsSold table
CREATE TABLE UnitsSold (
    product_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    units INT NOT NULL,
    PRIMARY KEY (product_id, purchase_date),
    CHECK (units > 0)
);


-- Insert data into Prices table
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);

-- Insert data into UnitsSold table
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);



--------------------------------------
-- Create Prices1 table
CREATE TABLE Prices1 (
    product_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (product_id, start_date, end_date),
    CHECK (end_date >= start_date)
);

-- Create UnitsSold1 table
CREATE TABLE UnitsSold1 (
    product_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    units INT NOT NULL,
    PRIMARY KEY (product_id, purchase_date),
    CHECK (units > 0)
);

INSERT INTO Prices1 (product_id, start_date, end_date, price) VALUES
(1, '2023-01-01', '2023-01-31', 10),
(2, '2023-01-01', '2023-01-31', 20);




# Solution 1:
SELECT
B.product_id , COALESCE(ROUND(SUM( COALESCE(units,0) * B.price)/ SUM( COALESCE(units,0) ), 2 ),0) AS average_price
FROM unitssold1 A RIGHT JOIN prices1 B
ON A.product_id = B.product_id 
AND A.purchase_date BETWEEN B.start_date AND B.end_date
GROUP BY B.product_id;




# Solution 2:
WITH CTE AS (
SELECT 
A.product_id
, COALESCE(B.units,0) * A.price AS mul 
, B.units AS units
FROM prices A LEFT JOIN unitssold B
ON A.product_id = B.product_id
AND B.purchase_date BETWEEN A.start_date AND A.end_date
) 


SELECT 
product_id,
COALESCE(ROUND( SUM(mul) / SUM(units) , 2 ),0 ) AS average_price 
FROM CTE 
GROUP BY 1;
