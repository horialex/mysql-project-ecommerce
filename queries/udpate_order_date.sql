UPDATE Orders
SET date = STR_TO_DATE(CONCAT('2024-', DATE_FORMAT(date, '%m-%d %H:%i:%s')), '%Y-%m-%d %H:%i:%s')
Where id <=10;