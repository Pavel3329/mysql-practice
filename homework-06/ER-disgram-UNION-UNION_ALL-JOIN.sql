USE sakila;


-- 1 Контактные данные клиентов сети видеопрокатов.
SELECT customer.first_name, customer.last_name, address.address, address.phone
FROM customer             -- Начинаем с таблицы клиентов
JOIN address              -- Подключаем таблицу адресов
ON customer.address_id = address.address_id;            -- Соединяем строки, у которых совпадают номера адресов
    


   -- 2. Фильмы и их категории.
SELECT film.title, category.name
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id;



-- 3 Кто обслуживает клиентов, какой сотрудник закреплен за каждым.
SELECT customer.first_name AS customer_first_name, customer.last_name AS customer_last_name,
       staff.first_name AS staff_first_name,
       staff.last_name AS staff_last_name
FROM customer
JOIN staff
ON customer.store_id = staff.store_id;



-- 4 Актерский состав фильмов
SELECT film.title, actor.first_name, actor.last_name
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
JOIN actor
ON film_actor.actor_id = actor.actor_id;



-- 5. Клиенты и даты аренды
SELECT customer.first_name, customer.last_name,
       rental.rental_date
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id





