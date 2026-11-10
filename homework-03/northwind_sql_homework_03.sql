use northwind;

DESCRIBE orders;

SELECT * FROM orders;


-- 1 разница между сегодняшней датой и датой заказа.
SELECT id, order_date,
       DATEDIFF(CURDATE(), order_date) AS order_age_days
FROM orders
ORDER BY order_age_days DESC;


-- 2 Заказы, оформленные в рабочие дни, (с понедельника по пятницу.)
SELECT id, order_date
FROM orders
WHERE WEEKDAY(order_date) BETWEEN 0 AND 4;


-- 3 количество дней с момента отправки до сегодняшнего дня
SELECT id, shipped_date,
       DATEDIFF(CURDATE(), shipped_date) AS days_after_shipping
FROM orders
WHERE shipped_date IS NOT NULL
ORDER BY days_after_shipping ASC;


-- 4 система автоматических уведомлений.
SELECT CONCAT(
    'Заказ ',
    id,
    ' был отправлен в ',
    DAYNAME(shipped_date)
) AS shipping_info
FROM orders
WHERE shipped_date IS NOT NULL;


-- 5. плановая дата доставки для всех заказов.
SELECT id, customer_id,
       DATE_ADD(order_date, INTERVAL 7 DAY) AS expected_delivery_date
FROM orders;


-- Дополнительная бизнес-задача 1 - Срок согласования заявки (slack)
SELECT id, submitted_date, approved_date,
       DATEDIFF(approved_date, submitted_date) AS days_to_approve
FROM purchase_orders
WHERE submitted_date IS NOT NULL
  AND approved_date IS NOT NULL
ORDER BY days_to_approve DESC;


-- Дополнительная бизнес-задача 2 - Заказыы, ожидающие отправки (slack)
SELECT id, order_date, shipped_date,
       DATEDIFF(CURDATE(), order_date) AS waiting_days
FROM orders
WHERE shipped_date IS NULL
  AND order_date IS NOT NULL
ORDER BY waiting_days DESC;
