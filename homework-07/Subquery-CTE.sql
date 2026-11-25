USE others;

SELECT * FROM titanic;


-- 1. Анализ взрослой аудитории
-- ============================================
WITH adults AS (
    SELECT *
    FROM titanic
    WHERE age >= 18
)
SELECT
    COUNT(*) AS adult_count,
    AVG(age) AS average_age
FROM adults;


-- 2. Анализ выживаемости женщин
-- ============================================
WITH female_passengers AS (
    SELECT *
    FROM titanic
    WHERE sex = 'female'
)
SELECT
    COUNT(*) AS total_women,
    SUM(survived) AS survived_women,
    ROUND(AVG(survived), 4) AS survival_rate
FROM female_passengers;


-- 3. Сравнение классов обслуживания
-- ============================================
WITH class_stats AS (
    SELECT pclass,
        COUNT(*) AS passenger_count,
        AVG(age) AS average_age,
        AVG(survived) AS survival_rate
    FROM titanic
    GROUP BY pclass
)
SELECT *
FROM class_stats
ORDER BY survival_rate DESC;



-- 4. Анализ стоимости билетов
-- ============================================
WITH fare_by_class AS (
    SELECT pclass,
        AVG(fare) AS avg_fare
    FROM others.titanic
    GROUP BY pclass
)
SELECT t.pclass, t.fare, 
       t.fare - f.avg_fare AS fare_difference
FROM others.titanic AS t
JOIN fare_by_class AS f
ON t.pclass = f.pclass
ORDER BY pclass;


-- 5. Пассажиры старше среднего возраста
-- ============================================
SELECT passenger_id, age, pclass
FROM titanic
WHERE age > (
SELECT AVG(age)
FROM titanic
);
-- внутренний запрос возвращает одно число. Поэтому нам не требуется создавать CTE или соединять таблицы.
-- Независимый подзапрос



-- 6. Пассажиры с дорогими билетами в своём классе
-- ============================================
SELECT passenger_id, pclass, fare
FROM titanic AS passenger
WHERE fare > (
SELECT AVG(fare)
FROM titanic AS class_passengers
WHERE class_passengers.pclass = passenger.pclass
);
-- коррелированный подзапрос, -Подзапрос зависит от внешней строки

SELECT * FROM titanic;


-- 7. Самые возрастные пассажиры каждого класса
-- ============================================
SELECT passenger_id, pclass, age
FROM titanic AS passenger
WHERE age = (
SELECT MAX(age)
FROM titanic AS class_passengers
WHERE class_passengers.pclass = passenger.pclass
);












