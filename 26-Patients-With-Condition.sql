USE leetcode;

WITH Patients AS (
    SELECT 1 AS patient_id, 'Daniel' AS patient_name, 'YFEV COUGH' AS conditions
    UNION ALL
    SELECT 2, 'Alice', ''
    UNION ALL
    SELECT 3, 'Bob', 'DIAB100 MYOP'
    UNION ALL
    SELECT 4, 'George', 'ACNE DIAB100'
    UNION ALL
    SELECT 5, 'Alain', 'DIAB201'
)

SELECT *
FROM Patients
WHERE conditions LIKE 'DIAB1%' 
      OR conditions LIKE '% DIAB1%';

------------------------------------------------
WITH Patients AS (
    SELECT 1 AS patient_id, 'Winston' AS patient_name, '' AS conditions
    UNION ALL
    SELECT 2, 'Moustafa', 'ARTH'
    UNION ALL
    SELECT 3, 'Jonathan', ''
    UNION ALL
    SELECT 4, 'Maria', 'DIAB101 MYOP'
    UNION ALL
    SELECT 5, 'Jade', 'ACNE MYOP CF'
    UNION ALL
    SELECT 6, 'Alain', 'XDIAB100 DIAB1 MYOP'
    )
    
SELECT *
FROM Patients
WHERE conditions LIKE 'DIAB1%' 
      OR conditions LIKE '% DIAB1%';
------------------------------------
WITH Patients AS (
    SELECT 1 AS patient_id, 'Daniel' AS patient_name, 'YFEV COUGH' AS conditions
    UNION ALL
    SELECT 2, 'Alice', ''
    UNION ALL
    SELECT 3, 'Bob', 'DIAB100 MYOP'
    UNION ALL
    SELECT 4, 'George', 'ACNE DIAB100'
    UNION ALL
    SELECT 5, 'Alain', 'DIAB201'
    UNION ALL 
    SELECT 6, 'ruk' , 'SADIAB100'
    UNION ALL 
    SELECT 6, 'Alain', 'XDIAB100 DIAB1 MYOP'

)
SELECT *
FROM Patients
WHERE conditions LIKE 'DIAB1%' 
      OR conditions LIKE '% DIAB1%';
