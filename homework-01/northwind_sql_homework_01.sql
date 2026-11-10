USE northwind;
-- полный справочник поставщиков-- 
SELECT *
FROM suppliers;

-- Поиск поставщика-- 
SELECT *
FROM suppliers
WHERE company = 'Supplier A';

-- все закупочные заказы компании.-- 
SELECT *
FROM purchase_orders;

-- Заказы поставщика-- 
SELECT id
FROM suppliers
WHERE company = 'Supplier B';

SELECT *
FROM purchase_orders
WHERE supplier_id = 2;

-- Заказы Supplier B, созданные Mariya Sergienko
SELECT id
FROM employees
WHERE last_name = 'Sergienko'
  AND first_name = 'Mariya';

SELECT *
FROM purchase_orders
WHERE supplier_id = 2
  AND created_by = 4;

-- памятка - '_%s%_' - перед s есть хотя бы один символ и после s тоже есть хотя бы один символ.-- 
SELECT id, first_name, last_name, job_title
FROM employees
WHERE last_name LIKE '_%s%_';

-- Заказы без информации о перевозчике
SELECT id, employee_id, customer_id, order_date, shipper_id
FROM orders
WHERE shipper_id IS NULL;



