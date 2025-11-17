/*
## Sample Input Table: employee_logins


+-------------+---------------------+
| employee_id | login_time          |
+-------------+---------------------+
| 101         | 2025-11-01 09:00:00 |
| 101         | 2025-11-02 10:30:00 |
| 101         | 2025-11-03 08:15:00 |
| 101         | 2025-11-04 09:45:00 |
| 101         | 2025-11-04 14:20:00 | (duplicate day)
| 101         | 2025-11-07 11:00:00 | (gap)
| 101         | 2025-11-08 10:00:00 |
| 102         | 2025-11-01 08:00:00 |
| 102         | 2025-11-02 09:00:00 |
| 102         | 2025-11-03 10:00:00 |
| 102         | 2025-11-05 11:00:00 | (gap)
| 103         | 2025-11-10 09:00:00 |
| 103         | 2025-11-11 09:00:00 |
| 103         | 2025-11-12 09:00:00 |
| 103         | 2025-11-13 09:00:00 |
| 103         | 2025-11-14 09:00:00 |
+-------------+---------------------+


## Step 1: Distinct Login Dates**
+-------------+------------+
| employee_id | login_date |
+-------------+------------+
| 101         | 2025-11-01 |
| 101         | 2025-11-02 |
| 101         | 2025-11-03 |
| 101         | 2025-11-04 |
| 101         | 2025-11-07 |
| 101         | 2025-11-08 |
| 102         | 2025-11-01 |
| 102         | 2025-11-02 |
| 102         | 2025-11-03 |
| 102         | 2025-11-05 |
| 103         | 2025-11-10 |
| 103         | 2025-11-11 |
| 103         | 2025-11-12 |
| 103         | 2025-11-13 |
| 103         | 2025-11-14 |
+-------------+------------+

## Step 2: RankedLogins CTE (with ROW_NUMBER and grp)
+-------------+------------+----+------------+
| employee_id | login_date | rn | grp        |
+-------------+------------+----+------------+
| 101         | 2025-11-01 | 1  | 2025-10-31 | (2025-11-01 - 1 day)
| 101         | 2025-11-02 | 2  | 2025-10-31 | (2025-11-02 - 2 days)
| 101         | 2025-11-03 | 3  | 2025-10-31 | (2025-11-03 - 3 days)
| 101         | 2025-11-04 | 4  | 2025-10-31 | (2025-11-04 - 4 days) ✓ Same grp!
| 101         | 2025-11-07 | 5  | 2025-11-02 | (2025-11-07 - 5 days) ✗ Different grp
| 101         | 2025-11-08 | 6  | 2025-11-02 | (2025-11-08 - 6 days)
| 102         | 2025-11-01 | 1  | 2025-10-31 |
| 102         | 2025-11-02 | 2  | 2025-10-31 |
| 102         | 2025-11-03 | 3  | 2025-10-31 |
| 102         | 2025-11-05 | 4  | 2025-11-01 | ✗ Different grp (gap)
| 103         | 2025-11-10 | 1  | 2025-11-09 |
| 103         | 2025-11-11 | 2  | 2025-11-09 |
| 103         | 2025-11-12 | 3  | 2025-11-09 |
| 103         | 2025-11-13 | 4  | 2025-11-09 | ✓ Same grp!
| 103         | 2025-11-14 | 5  | 2025-11-09 | ✓ 5 consecutive days!
+-------------+------------+----+------------+


Key Insight: The `grp` column creates the same value for consecutive dates!
## Final Output: Employees with 4+ Consecutive Logins

+-------------+------------+------------+-----------------+
| employee_id | start_date | end_date   | consecutive_days|
+-------------+------------+------------+-----------------+
| 101         | 2025-11-01 | 2025-11-04 | 4               |
| 103         | 2025-11-10 | 2025-11-14 | 5               |
+-------------+------------+------------+-----------------+




## Why Employee 102 is NOT included?

Employee 102 only has **3 consecutive days** (Nov 1-3), then a gap on Nov 4, so they don't meet the `HAVING COUNT(*) >= 4` criteria.


*/

WITH RankedLogins AS (
    SELECT 
        employee_id,
        login_date,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY login_date) as rn,
        DATE_SUB(login_date, INTERVAL ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY login_date) DAY) as grp
    FROM (
        SELECT DISTINCT employee_id, DATE(login_time) as login_date
        FROM employee_logins
    ) distinct_logins
)
SELECT 
    employee_id,
    MIN(login_date) as start_date,
    MAX(login_date) as end_date,
    COUNT(*) as consecutive_days
FROM RankedLogins
GROUP BY employee_id, grp
HAVING COUNT(*) >= 4
ORDER BY employee_id, start_date;
