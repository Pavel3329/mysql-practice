USE others;

SELECT * FROM titanic;

-- DATA QUALITY:
-- В таблице titanic обнаружены некорректные данные:
-- 15 строк с ошибочными значениями sex и 174 записи с age = 0.0
-- Нулевой возраст может означать пропущенные данные.
-- Основные запросы выполняются по исходным значениям таблицы.
-- Дополнительные проверки приведены в заданиях 3, 5 и 6.


-- 1. Средний возраст пассажиров по классу билета
SELECT pclass, AVG(age) AS avg_age
FROM titanic
-- WHERE age IS NOT NULL
GROUP BY pclass
ORDER BY pclass DESC;


-- 2 Количество детей в каждом классе
SELECT pclass, COUNT(*) AS children_count
FROM titanic
WHERE age < 18
GROUP BY pclass
ORDER BY pclass ASC;


-- 3. Максимальный возраст пассажиров по полу
SELECT sex, MAX(age)  AS max_age
FROM titanic
-- оставить только строки, где sex равен male или female
WHERE sex IN ('male', 'female')
GROUP BY sex;

-- ...............................................................
-- DATA QUALITY:
-- Обнаружены 15 некорректно импортированных записей:
-- ID: 147, 162, 205, 228, 238, 305, 349, 437,
-- 490, 573, 600, 710, 743, 864, 889.
-- Возможная причина: ошибка обработки кавычек при импорте CSV.
-- В задании 3 учитываются только male и female.


-- Проверка некорректных значений sex
SELECT * FROM others.titanic
WHERE sex NOT IN ('male', 'female')
OR sex IS NULL;
   
-- .................................................................

-- 4. Общая стоимость билетов по классу
SELECT pclass, SUM(fare) AS total_fare
FROM titanic
GROUP BY pclass
ORDER BY pclass ASC;


-- 5. Порты посадки со средним возрастом выше 30 лет
-- Вариант 1. По исходным значениям age
SELECT embarked, ROUND(AVG(age), 1) AS avg_age
FROM others.titanic
WHERE embarked IN ('C', 'Q', 'S')
GROUP BY embarked
HAVING AVG(age) > 30
ORDER BY avg_age DESC;

-- .................................................................
-- DATA QUALITY (Task 5):
-- В embarked обнаружены 15 NULL и 2 пустых значения.
-- При учёте age = 0 результат пустой.
-- Без нулевых возрастов подходят порты C (31.1) и Q (30.1).
-- Причина нулевых возрастов не установлена.

-- Проверка значений портов и среднего возраста
SELECT embarked, COUNT(*) AS passengers_count,
    ROUND(AVG(age), 2) AS avg_age
FROM others.titanic
GROUP BY embarked
ORDER BY embarked;

-- .................................................................

-- (5) Вариант 2. Без нулевых возрастов
SELECT embarked, ROUND(AVG(age), 1) AS avg_age
FROM others.titanic
WHERE embarked IN ('C', 'Q', 'S')
AND age > 0
GROUP BY embarked
HAVING AVG(age) > 30
ORDER BY avg_age DESC;


-- 6. Минимальный возраст пассажиров по классу
-- Вариант 1. Строго по условию задания
SELECT pclass, MIN(age) AS min_age
FROM others.titanic
GROUP BY pclass
ORDER BY pclass ASC;

-- .................................................................
-- DATA QUALITY (Task 6):
-- Обнаружены 174 записи с age = 0.0:
-- 1-й класс: 31, 2-й: 13, 3-й: 130.
-- Возможно, неизвестный возраст был заменён нулём при импорте.
-- Поэтому MIN(age) возвращает 0 для всех трёх классов.

-- Проверка количества нулевых возрастов
SELECT pclass, COUNT(*) AS zero_age_count
FROM others.titanic
WHERE age = 0
GROUP BY pclass
ORDER BY pclass ASC;

-- .................................................................

-- (6) Вариант 2. Минимальный положительный возраст
-- Нулевые значения исключены из расчёта.
SELECT pclass, MIN(age) AS min_age
FROM others.titanic
WHERE age > 0
GROUP BY pclass
ORDER BY pclass ASC;