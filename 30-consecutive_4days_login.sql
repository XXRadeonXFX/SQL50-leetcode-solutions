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
