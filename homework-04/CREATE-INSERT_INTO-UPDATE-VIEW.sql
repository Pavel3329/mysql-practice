USE `100726-wdm_rabe`;

-- Создание таблицы заказов
CREATE TABLE delivery_orders (
-- MySQL Уникально идентифицирует заказ и автоматически назначает следующий идентификатор.
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL,
    delivery_days INT NOT NULL CHECK(delivery_days > 0),
    order_amount DECIMAL(8,2) NOT NULL CHECK(order_amount > 0),
-- Статус по умолчанию при добавлении заказа
    delivery_status VARCHAR(100) NOT NULL DEFAULT 'Processing'
);


-- Добавление первого заказа
-- Статус Processing устанавливается автоматически (DEFAULT)
INSERT INTO delivery_orders (
    customer_name,
    order_date,
    delivery_days,
    order_amount
)
VALUES (
    'Anna Weber',
    '2026-11-15',
    3,
    249.90
);

-- Добавление остальных заказов
INSERT INTO delivery_orders (
customer_name,
order_date,
delivery_days,
order_amount,
delivery_status
)
VALUES 
    ('Max Fischer', '2026-11-14', 2, 650.00, 'Processing'),
    ('Olena Ivanova', '2026-11-13', 5, 420.00, 'Shipped'),
	('David Klein', '2026-11-12', 7, 890.00, 'Processing'),
    ('Sofia Müller', '2026-11-11', 1, 180.00, 'Delivered');

-- Проверка структуры и добавленных заказов
DESCRIBE delivery_orders;
SELECT * FROM delivery_orders;


-- Временное отключение Safe Updates
SET @previous_safe_updates = @@SQL_SAFE_UPDATES;
SET @@SQL_SAFE_UPDATES = 0;

-- Увеличение срока доставки на 1 день для заказов в обработке
UPDATE delivery_orders
SET delivery_days = delivery_days + 1
WHERE delivery_status = 'Processing';

-- Восстановление предыдущей настройки Safe Updates
SET @@SQL_SAFE_UPDATES = @previous_safe_updates;

-- Проверка обновлённых данных
SELECT * FROM delivery_orders;


-- Создание аналитического представления
CREATE OR REPLACE VIEW order_overview 
AS SELECT
    order_id,
    customer_name,
    order_amount,
    delivery_days,

    CASE
        WHEN delivery_days <= 2 THEN 'Express'
        WHEN delivery_days <= 5 THEN 'Standard'
        ELSE 'Delayed'
    END AS delivery_priority,

    CASE
        WHEN order_amount > 500 THEN 'Yes'
        ELSE 'No'
    END AS large_order

FROM delivery_orders;

-- Проверка аналитического представления
SELECT * FROM order_overview;

