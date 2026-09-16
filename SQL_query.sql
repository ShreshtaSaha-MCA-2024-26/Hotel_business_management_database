USE hotel_management_db;



-- 1. CHECK
INSERT INTO rooms (room_number, room_type, capacity, price_per_night, status)
VALUES ('999', 'Standard', 2, -500.00, 'Available');

UPDATE staff SET salary = -5000 WHERE staff_id = 1;


-- 2. UPDATE
START TRANSACTION;
UPDATE rooms SET price_per_night = 2500.00 WHERE room_number = '101';
SELECT room_number, price_per_night FROM rooms WHERE room_number = '101';

UPDATE food_items SET is_available = TRUE WHERE food_name = 'Fish Curry';
SELECT food_name, is_available FROM food_items WHERE food_name = 'Fish Curry';
ROLLBACK;


-- 3. DELETE
START TRANSACTION;

DELETE FROM food_items WHERE food_name = 'Fish Curry';

-- Deletes only customers having no room allocation.
-- In the supplied dataset this deletes 0 rows.
DELETE FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM room_allocations
);
ROLLBACK;


-- 4. SELECT
SELECT * FROM customers;
SELECT name, phone, age FROM customers;


-- 5. WHERE
SELECT * FROM customers WHERE age > 30;
SELECT * FROM rooms WHERE price_per_night > 3000;


-- 6. ORDER BY
SELECT room_number, room_type, price_per_night
FROM rooms
ORDER BY price_per_night DESC;

SELECT staff_id, name, joining_date, position
FROM staff
ORDER BY joining_date ASC;


-- 7. GROUP BY
SELECT room_type, COUNT(*) AS available_rooms
FROM rooms
WHERE status = 'Available'
GROUP BY room_type;

SELECT category, COUNT(*) AS food_item_count
FROM food_items
GROUP BY category;


-- 8. HAVING
SELECT category, COUNT(*) AS food_item_count
FROM food_items
GROUP BY category
HAVING COUNT(*) > 2;

SELECT s.staff_id, s.name, COUNT(*) AS leave_count
FROM staff AS s
INNER JOIN attendance AS a ON s.staff_id = a.staff_id
WHERE a.status = 'Leave'
GROUP BY s.staff_id, s.name
HAVING COUNT(*) > 1;


-- 9. AGGREGATE FUNCTIONS
SELECT AVG(price_per_night) AS average_room_price
FROM rooms;

SELECT SUM(amount) AS total_successful_payments
FROM payments
WHERE status = 'Successful';


-- 10. INNER JOIN
SELECT
    c.name AS customer_name,
    r.room_number,
    ra.check_in,
    ra.check_out
FROM customers AS c
INNER JOIN room_allocations AS ra ON c.customer_id = ra.customer_id
INNER JOIN rooms AS r ON ra.room_id = r.room_id;

SELECT
    f.food_name,
    oi.order_id,
    oi.quantity,
    oi.unit_price
FROM food_items AS f
INNER JOIN order_items AS oi ON f.food_id = oi.food_id;


-- 11. LEFT JOIN
SELECT
    r.room_id,
    r.room_number,
    r.room_type,
    COUNT(ra.allocation_id) AS allocation_count
FROM rooms AS r
LEFT JOIN room_allocations AS ra ON r.room_id = ra.room_id
GROUP BY r.room_id, r.room_number, r.room_type
ORDER BY allocation_count DESC;

SELECT
    s.staff_id,
    s.name,
    COUNT(rs.service_id) AS room_service_count
FROM staff AS s
LEFT JOIN room_services AS rs ON s.staff_id = rs.staff_id
GROUP BY s.staff_id, s.name
ORDER BY room_service_count DESC;


-- 12. SUBQUERIES
SELECT room_number, room_type, price_per_night
FROM rooms
WHERE price_per_night > (
    SELECT AVG(price_per_night) FROM rooms
)
ORDER BY price_per_night DESC;

SELECT staff_id, name, salary
FROM staff
WHERE salary > (
    SELECT AVG(salary) FROM staff
)
ORDER BY salary DESC;


-- 13. CASE
SELECT
    room_number,
    price_per_night,
    CASE
        WHEN price_per_night >= 5000 THEN 'Premium'
        WHEN price_per_night >= 3000 THEN 'Standard Premium'
        ELSE 'Budget'
    END AS room_category
FROM rooms
ORDER BY price_per_night DESC;

SELECT
    name,
    salary,
    CASE
        WHEN salary >= 40000 THEN 'High'
        WHEN salary >= 30000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM staff
ORDER BY salary DESC;


-- 14. STRING FUNCTIONS
SELECT name, UPPER(name) AS name_uppercase
FROM customers;

SELECT name, LEFT(name, 3) AS first_three_characters
FROM customers;


-- 15. DATE FUNCTIONS
SELECT
    allocation_id,
    customer_id,
    room_id,
    check_in,
    check_out,
    DATEDIFF(check_out, check_in) AS stay_days
FROM room_allocations;

SELECT COUNT(*) AS august_2026_allocations
FROM room_allocations
WHERE YEAR(check_in) = 2026
  AND MONTH(check_in) = 8;
