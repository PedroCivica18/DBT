CREATE TABLE dim_time_date (
    date_id INT PRIMARY KEY,
    date_value DATE,
    year INT,
    month INT,
    day INT,
    hour INT,
    minute INT
);

-- Populate the Time/Date dimension table
INSERT INTO dim_time_date (date_id, date_value, year, month, day, hour, minute)
SELECT 
    DATE_FORMAT(date_value, '%Y%m%d%H%i') AS date_id,
    date_value,
    YEAR(date_value) AS year,
    MONTH(date_value) AS month,
    DAY(date_value) AS day,
    HOUR(date_value) AS hour,
    MINUTE(date_value) AS minute
FROM 
    (
        SELECT 
            ADDDATE('2020-01-01', INTERVAL a.i*10000 + b.i*1000 + c.i*100 + d.i*10 + e.i DAY) AS date_value
        FROM 
            (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS a,
            (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS b,
            (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS c,
            (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS d,
            (SELECT 0 AS i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS e
    ) AS dates
WHERE 
    date_value BETWEEN '2020-01-01' AND '2025-12-31';
