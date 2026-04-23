use superstore;
SELECT * FROM storesale LIMIT 10;

SELECT COUNT(*) FROM storesale;

SELECT `Order_ID`, COUNT(*) AS duplicate_count
FROM storesale
GROUP BY `Order_ID`
HAVING COUNT(*) > 1;

SELECT 
    SUM(CASE WHEN `Order_ID` IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN `Order_Date` IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END)
FROM storesale;

DESCRIBE storesale;

SELECT *
FROM storesale
WHERE Sales < 0 OR Profit < 0;

SELECT DISTINCT Category FROM storesale;
SELECT DISTINCT `Sub_Category` FROM storesale;
SELECT DISTINCT Region FROM storesale;

SELECT 
    MIN(`Order_Date`),
    MAX(`Order_Date`)
FROM storesale;

CREATE TABLE clean_sales AS
SELECT *
FROM storesale;
