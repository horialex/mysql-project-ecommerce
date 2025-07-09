SELECT * from Orders 
WHERE YEAR(date) = 2025;

SELECT * from Orders 
WHERE YEAR(date) IN (2024, 2025);

SELECT * FROM `Orders`
WHERE `date` BETWEEN '2024-01-01' AND '2024-12-31 23:59:59';
