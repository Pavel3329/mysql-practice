USE northwind;

-- 1.--
SELECT *, quantity * unit_price AS total_price
FROM order_details
WHERE purchase_order_id IS NULL;

-- 2 --
SELECT CONCAT(first_name, ' ', last_name) AS fullname 
FROM employees
LIMIT 3 OFFSET 2;
-- OR OFFSET 1 ?? Исходя из образца (screenshot) задания, всё выполнено верно,  
-- Но начало с третьей строки, - не со второй--

-- 3 --
SELECT LEFT (order_date, 7) AS order_date
FROM orders;

-- 4 --
SELECT DISTINCT company
FROM customers 
ORDER BY company DESC ;

-- 5. CASE --
SELECT id, order_id,
CASE
	WHEN unit_price > 10 THEN 'Expensive'
    ELSE 'Cheap'
END AS category
FROM order_details;

-- 5. IF --
SELECT id, order_id,
IF(unit_price > 10, 'Expensive', 'Cheap') AS category
FROM order_details;






