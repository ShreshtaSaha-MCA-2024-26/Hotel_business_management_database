USE hotel_management_db;

-- ============================================================
-- SAMPLE / DUMMY DATA
-- Designed for JOIN, GROUP BY, aggregate, date, subquery,
-- payment, revenue, expense and business-analysis practice.
-- ============================================================

-- 1. CUSTOMERS (10)
INSERT INTO customers
    (customer_id, name, gender, age, aadhaar_id, phone)
VALUES
    (1, 'Aarav Sharma', 'Male', 28, 'AADHAR1001', '9000000001'),
    (2, 'Priya Singh', 'Female', 32, 'AADHAR1002', '9000000002'),
    (3, 'Rahul Verma', 'Male', 41, 'AADHAR1003', '9000000003'),
    (4, 'Sneha Das', 'Female', 26, 'AADHAR1004', '9000000004'),
    (5, 'Vikram Patel', 'Male', 35, 'AADHAR1005', '9000000005'),
    (6, 'Ananya Roy', 'Female', 29, 'AADHAR1006', '9000000006'),
    (7, 'Rohan Mehta', 'Male', 24, 'AADHAR1007', '9000000007'),
    (8, 'Neha Khan', 'Female', 38, 'AADHAR1008', '9000000008'),
    (9, 'Arjun Nair', 'Male', 45, 'AADHAR1009', '9000000009'),
    (10, 'Meera Joshi', 'Female', 31, 'AADHAR1010', '9000000010');

-- 2. ROOMS (10)
INSERT INTO rooms
    (room_id, room_number, room_type, capacity, price_per_night, status)
VALUES
    (1, '101', 'Standard', 2, 2000.00, 'Available'),
    (2, '102', 'Standard', 2, 2000.00, 'Occupied'),
    (3, '103', 'Deluxe', 3, 3000.00, 'Occupied'),
    (4, '104', 'Deluxe', 3, 3000.00, 'Available'),
    (5, '201', 'Suite', 4, 5000.00, 'Occupied'),
    (6, '202', 'Suite', 4, 5000.00, 'Maintenance'),
    (7, '203', 'Standard', 2, 2000.00, 'Available'),
    (8, '204', 'Deluxe', 3, 3000.00, 'Occupied'),
    (9, '301', 'Suite', 4, 5500.00, 'Available'),
    (10, '302', 'Standard', 2, 2200.00, 'Out of Service');

-- 3. ROOM ALLOCATIONS (15)
-- Includes repeated customers and repeated rooms over different dates.
INSERT INTO room_allocations
    (allocation_id, customer_id, room_id, check_in, check_out,
     no_of_guests, room_price, status)
VALUES
    (1, 1, 2, '2026-07-01 14:00:00', '2026-07-03 11:00:00', 2, 2000.00, 'Checked Out'),
    (2, 2, 3, '2026-07-02 15:00:00', '2026-07-05 11:00:00', 2, 3000.00, 'Checked Out'),
    (3, 3, 5, '2026-07-04 14:00:00', '2026-07-08 11:00:00', 4, 5000.00, 'Checked Out'),
    (4, 4, 8, '2026-07-06 16:00:00', '2026-07-08 11:00:00', 2, 3000.00, 'Checked Out'),
    (5, 5, 2, '2026-07-10 14:00:00', '2026-07-13 11:00:00', 2, 2000.00, 'Checked Out'),
    (6, 6, 3, '2026-07-12 15:00:00', '2026-07-15 11:00:00', 3, 3000.00, 'Checked Out'),
    (7, 7, 1, '2026-07-15 14:00:00', '2026-07-17 11:00:00', 1, 2000.00, 'Checked Out'),
    (8, 8, 5, '2026-07-18 14:00:00', '2026-07-21 11:00:00', 3, 5000.00, 'Checked Out'),
    (9, 9, 8, '2026-07-20 15:00:00', '2026-07-22 11:00:00', 2, 3000.00, 'Checked Out'),
    (10, 10, 4, '2026-07-22 14:00:00', '2026-07-24 11:00:00', 2, 3000.00, 'Checked Out'),
    (11, 1, 2, '2026-08-01 14:00:00', '2026-08-04 11:00:00', 2, 2200.00, 'Checked Out'),
    (12, 2, 3, '2026-08-03 15:00:00', '2026-08-06 11:00:00', 2, 3200.00, 'Checked Out'),
    (13, 5, 5, '2026-08-05 14:00:00', '2026-08-10 11:00:00', 4, 5200.00, 'Checked Out'),
    (14, 6, 8, '2026-08-08 15:00:00', '2026-08-12 11:00:00', 3, 3200.00, 'Checked Out'),
    (15, 10, 4, '2026-08-15 14:00:00', '2026-08-18 11:00:00', 2, 3000.00, 'Checked Out');

-- 4. FOOD ITEMS (15)
INSERT INTO food_items
    (food_id, food_name, category, veg_nonveg, price,
     preparation_time, is_available)
VALUES
    (1, 'Chicken Biryani', 'Main Course', 'Non-Veg', 280.00, 25, TRUE),
    (2, 'Paneer Butter Masala', 'Main Course', 'Veg', 240.00, 20, TRUE),
    (3, 'Dal Tadka', 'Main Course', 'Veg', 160.00, 15, TRUE),
    (4, 'Butter Naan', 'Bread', 'Veg', 60.00, 8, TRUE),
    (5, 'Chicken Tikka', 'Starter', 'Non-Veg', 300.00, 20, TRUE),
    (6, 'Paneer Tikka', 'Starter', 'Veg', 260.00, 18, TRUE),
    (7, 'French Fries', 'Starter', 'Veg', 140.00, 12, TRUE),
    (8, 'Veg Sandwich', 'Snacks', 'Veg', 120.00, 10, TRUE),
    (9, 'Club Sandwich', 'Snacks', 'Non-Veg', 180.00, 12, TRUE),
    (10, 'Masala Tea', 'Beverage', 'Veg', 50.00, 5, TRUE),
    (11, 'Coffee', 'Beverage', 'Veg', 80.00, 5, TRUE),
    (12, 'Fresh Lime Soda', 'Beverage', 'Veg', 100.00, 6, TRUE),
    (13, 'Gulab Jamun', 'Dessert', 'Veg', 90.00, 7, TRUE),
    (14, 'Ice Cream', 'Dessert', 'Veg', 120.00, 5, TRUE),
    (15, 'Fish Curry', 'Main Course', 'Non-Veg', 350.00, 30, FALSE);

-- 5. FOOD ORDERS (20)
INSERT INTO food_orders
    (order_id, allocation_id, order_datetime, order_status)
VALUES
    (1, 1, '2026-07-01 19:30:00', 'Served'),
    (2, 1, '2026-07-02 08:30:00', 'Served'),
    (3, 2, '2026-07-02 20:15:00', 'Served'),
    (4, 3, '2026-07-05 13:00:00', 'Served'),
    (5, 3, '2026-07-06 20:30:00', 'Served'),
    (6, 4, '2026-07-07 09:00:00', 'Served'),
    (7, 5, '2026-07-10 20:00:00', 'Served'),
    (8, 5, '2026-07-11 08:15:00', 'Served'),
    (9, 6, '2026-07-13 19:45:00', 'Served'),
    (10, 7, '2026-07-16 21:00:00', 'Served'),
    (11, 8, '2026-07-19 13:15:00', 'Served'),
    (12, 8, '2026-07-20 20:45:00', 'Served'),
    (13, 9, '2026-07-21 09:15:00', 'Served'),
    (14, 10, '2026-07-23 19:00:00', 'Served'),
    (15, 11, '2026-08-02 20:00:00', 'Served'),
    (16, 12, '2026-08-04 13:30:00', 'Served'),
    (17, 13, '2026-08-07 20:30:00', 'Served'),
    (18, 14, '2026-08-10 19:30:00', 'Served'),
    (19, 15, '2026-08-16 20:00:00', 'Served'),
    (20, 15, '2026-08-17 08:00:00', 'Cancelled');

-- 6. ORDER ITEMS (45)
-- Repeated food items are intentional for demand/revenue analysis.
INSERT INTO order_items
    (order_item_id, order_id, food_id, quantity, unit_price)
VALUES
    (1, 1, 1, 2, 280.00),
    (2, 1, 4, 4, 60.00),
    (3, 1, 10, 2, 50.00),

    (4, 2, 10, 2, 50.00),
    (5, 2, 8, 1, 120.00),

    (6, 3, 5, 2, 300.00),
    (7, 3, 12, 2, 100.00),

    (8, 4, 1, 3, 280.00),
    (9, 4, 4, 4, 60.00),
    (10, 4, 13, 2, 90.00),

    (11, 5, 2, 2, 240.00),
    (12, 5, 6, 2, 260.00),
    (13, 5, 14, 2, 120.00),

    (14, 6, 10, 3, 50.00),
    (15, 6, 9, 2, 180.00),

    (16, 7, 1, 2, 280.00),
    (17, 7, 7, 1, 140.00),

    (18, 8, 3, 2, 160.00),
    (19, 8, 4, 4, 60.00),
    (20, 8, 11, 2, 80.00),

    (21, 9, 5, 2, 300.00),
    (22, 9, 1, 1, 280.00),

    (23, 10, 8, 2, 120.00),
    (24, 10, 10, 2, 50.00),

    (25, 11, 1, 3, 280.00),
    (26, 11, 6, 2, 260.00),

    (27, 12, 2, 3, 240.00),
    (28, 12, 4, 4, 60.00),
    (29, 12, 14, 2, 120.00),

    (30, 13, 10, 2, 50.00),
    (31, 13, 9, 1, 180.00),

    (32, 14, 5, 2, 300.00),
    (33, 14, 12, 2, 100.00),

    (34, 15, 1, 2, 280.00),
    (35, 15, 4, 4, 60.00),

    (36, 16, 3, 2, 160.00),
    (37, 16, 11, 2, 80.00),

    (38, 17, 1, 4, 280.00),
    (39, 17, 6, 2, 260.00),
    (40, 17, 14, 2, 120.00),

    (41, 18, 2, 2, 240.00),
    (42, 18, 7, 2, 140.00),

    (43, 19, 5, 2, 300.00),
    (44, 19, 10, 2, 50.00),

    (45, 20, 1, 1, 280.00);

-- 7. STAFF (10)
INSERT INTO staff
    (staff_id, name, gender, age, salary, joining_date, position)
VALUES
    (1, 'Amit Kumar', 'Male', 29, 28000.00, '2023-04-10', 'Receptionist'),
    (2, 'Pooja Sharma', 'Female', 31, 32000.00, '2022-08-15', 'Front Office Manager'),
    (3, 'Rahul Das', 'Male', 26, 24000.00, '2024-01-20', 'Housekeeping'),
    (4, 'Sneha Roy', 'Female', 28, 26000.00, '2023-11-05', 'Housekeeping'),
    (5, 'Vivek Singh', 'Male', 35, 42000.00, '2021-06-12', 'Restaurant Manager'),
    (6, 'Neha Gupta', 'Female', 27, 25000.00, '2024-03-18', 'Waiter'),
    (7, 'Arjun Yadav', 'Male', 30, 27000.00, '2023-09-01', 'Waiter'),
    (8, 'Kiran Das', 'Female', 25, 23000.00, '2024-06-10', 'Room Service'),
    (9, 'Rakesh Jain', 'Male', 40, 38000.00, '2020-02-25', 'Maintenance'),
    (10, 'Meena Paul', 'Female', 34, 30000.00, '2022-12-01', 'Housekeeping');

-- 8. ATTENDANCE
INSERT INTO attendance
    (attendance_id, staff_id, attendance_date, status)
VALUES
    (1, 1, '2026-08-01', 'Present'),
    (2, 1, '2026-08-02', 'Present'),
    (3, 1, '2026-08-03', 'Leave'),
    (4, 1, '2026-08-04', 'Present'),
    (5, 1, '2026-08-05', 'Present'),

    (6, 2, '2026-08-01', 'Present'),
    (7, 2, '2026-08-02', 'Present'),
    (8, 2, '2026-08-03', 'Present'),
    (9, 2, '2026-08-04', 'Present'),
    (10, 2, '2026-08-05', 'Leave'),

    (11, 3, '2026-08-01', 'Present'),
    (12, 3, '2026-08-02', 'Leave'),
    (13, 3, '2026-08-03', 'Present'),
    (14, 3, '2026-08-04', 'Absent'),
    (15, 3, '2026-08-05', 'Present'),

    (16, 4, '2026-08-01', 'Present'),
    (17, 4, '2026-08-02', 'Present'),
    (18, 4, '2026-08-03', 'Present'),
    (19, 4, '2026-08-04', 'Present'),
    (20, 4, '2026-08-05', 'Present'),

    (21, 5, '2026-08-01', 'Present'),
    (22, 5, '2026-08-02', 'Present'),
    (23, 5, '2026-08-03', 'Present'),
    (24, 5, '2026-08-04', 'Leave'),
    (25, 5, '2026-08-05', 'Present'),

    (26, 6, '2026-08-01', 'Present'),
    (27, 6, '2026-08-02', 'Leave'),
    (28, 6, '2026-08-03', 'Present'),
    (29, 6, '2026-08-04', 'Absent'),
    (30, 6, '2026-08-05', 'Present'),

    (31, 7, '2026-08-01', 'Present'),
    (32, 7, '2026-08-02', 'Present'),
    (33, 7, '2026-08-03', 'Present'),
    (34, 7, '2026-08-04', 'Leave'),
    (35, 7, '2026-08-05', 'Present'),

    (36, 8, '2026-08-01', 'Present'),
    (37, 8, '2026-08-02', 'Present'),
    (38, 8, '2026-08-03', 'Leave'),
    (39, 8, '2026-08-04', 'Leave'),
    (40, 8, '2026-08-05', 'Present'),

    (41, 9, '2026-08-01', 'Present'),
    (42, 9, '2026-08-02', 'Present'),
    (43, 9, '2026-08-03', 'Present'),
    (44, 9, '2026-08-04', 'Present'),
    (45, 9, '2026-08-05', 'Present'),

    (46, 10, '2026-08-01', 'Present'),
    (47, 10, '2026-08-02', 'Leave'),
    (48, 10, '2026-08-03', 'Present'),
    (49, 10, '2026-08-04', 'Present'),
    (50, 10, '2026-08-05', 'Leave');

-- 9. ROOM SERVICES (20)
INSERT INTO room_services
    (service_id, allocation_id, staff_id, service_type,
     service_date, cost, status)
VALUES
    (1, 1, 3, 'Room Cleaning', '2026-07-02 10:00:00', 300.00, 'Completed'),
    (2, 2, 4, 'Room Cleaning', '2026-07-03 10:30:00', 300.00, 'Completed'),
    (3, 3, 8, 'Laundry', '2026-07-05 18:00:00', 500.00, 'Completed'),
    (4, 3, 3, 'Room Cleaning', '2026-07-06 10:00:00', 300.00, 'Completed'),
    (5, 4, 4, 'Room Cleaning', '2026-07-07 11:00:00', 300.00, 'Completed'),
    (6, 5, 8, 'Laundry', '2026-07-11 17:30:00', 450.00, 'Completed'),
    (7, 5, 3, 'Room Cleaning', '2026-07-12 10:00:00', 300.00, 'Completed'),
    (8, 6, 4, 'Room Cleaning', '2026-07-13 10:00:00', 300.00, 'Completed'),
    (9, 7, 8, 'Extra Bed', '2026-07-16 16:00:00', 700.00, 'Completed'),
    (10, 8, 3, 'Room Cleaning', '2026-07-19 10:00:00', 300.00, 'Completed'),
    (11, 8, 8, 'Laundry', '2026-07-20 18:00:00', 500.00, 'Completed'),
    (12, 9, 4, 'Room Cleaning', '2026-07-21 10:00:00', 300.00, 'Completed'),
    (13, 10, 8, 'Laundry', '2026-07-23 17:00:00', 400.00, 'Completed'),
    (14, 11, 3, 'Room Cleaning', '2026-08-02 10:00:00', 300.00, 'Completed'),
    (15, 12, 4, 'Room Cleaning', '2026-08-04 10:00:00', 300.00, 'Completed'),
    (16, 13, 8, 'Laundry', '2026-08-07 18:00:00', 550.00, 'Completed'),
    (17, 13, 3, 'Room Cleaning', '2026-08-08 10:00:00', 300.00, 'Completed'),
    (18, 14, 4, 'Room Cleaning', '2026-08-10 10:00:00', 300.00, 'Completed'),
    (19, 15, 8, 'Extra Bed', '2026-08-16 15:00:00', 700.00, 'Completed'),
    (20, 15, 3, 'Room Cleaning', '2026-08-17 10:00:00', 300.00, 'Completed');

-- 10. PAYMENTS (25)
-- Multiple payments per allocation are intentional.
INSERT INTO payments
    (payment_id, allocation_id, amount, payment_method,
     payment_type, payment_date, status)
VALUES
    (1, 1, 4000.00, 'UPI', 'Room', '2026-07-01 13:00:00', 'Successful'),
    (2, 1, 700.00, 'Cash', 'Food', '2026-07-02 20:30:00', 'Successful'),

    (3, 2, 9000.00, 'Card', 'Room', '2026-07-02 14:30:00', 'Successful'),
    (4, 2, 800.00, 'UPI', 'Food', '2026-07-04 21:00:00', 'Successful'),

    (5, 3, 10000.00, 'Bank Transfer', 'Room', '2026-07-04 13:00:00', 'Successful'),
    (6, 3, 2500.00, 'UPI', 'Food', '2026-07-06 21:00:00', 'Successful'),

    (7, 4, 6000.00, 'Card', 'Room', '2026-07-06 15:00:00', 'Successful'),
    (8, 4, 500.00, 'Cash', 'Food', '2026-07-07 12:00:00', 'Pending'),

    (9, 5, 6000.00, 'UPI', 'Room', '2026-07-10 13:00:00', 'Successful'),
    (10, 5, 700.00, 'Cash', 'Food', '2026-07-11 21:00:00', 'Successful'),

    (11, 6, 9000.00, 'Card', 'Room', '2026-07-12 14:00:00', 'Successful'),
    (12, 6, 1000.00, 'UPI', 'Food', '2026-07-13 20:00:00', 'Successful'),

    (13, 7, 4000.00, 'Cash', 'Room', '2026-07-15 13:30:00', 'Successful'),

    (14, 8, 15000.00, 'Bank Transfer', 'Room', '2026-07-18 13:00:00', 'Successful'),
    (15, 8, 1500.00, 'UPI', 'Food', '2026-07-20 21:30:00', 'Successful'),

    (16, 9, 6000.00, 'Card', 'Room', '2026-07-20 14:00:00', 'Successful'),
    (17, 9, 900.00, 'UPI', 'Food', '2026-07-21 10:00:00', 'Successful'),

    (18, 10, 6000.00, 'UPI', 'Room', '2026-07-22 13:00:00', 'Successful'),
    (19, 10, 700.00, 'Cash', 'Food', '2026-07-23 20:00:00', 'Failed'),

    (20, 11, 6600.00, 'Card', 'Room', '2026-08-01 13:00:00', 'Successful'),
    (21, 11, 700.00, 'UPI', 'Food', '2026-08-02 21:00:00', 'Successful'),

    (22, 12, 9600.00, 'Bank Transfer', 'Room', '2026-08-03 14:00:00', 'Successful'),
    (23, 12, 600.00, 'UPI', 'Food', '2026-08-04 14:30:00', 'Pending'),

    (24, 13, 13000.00, 'Card', 'Room', '2026-08-05 13:00:00', 'Successful'),
    (25, 14, 12800.00, 'UPI', 'Room', '2026-08-08 14:00:00', 'Successful');

-- 11. EXPENSES (20)
-- Salary is represented as an expense category and linked to staff.
INSERT INTO expenses
    (expense_id, category, description, amount, expense_date,
     payment_method, staff_id)
VALUES
    (1, 'Salary', 'August salary - Amit Kumar', 28000.00, '2026-08-01', 'Bank Transfer', 1),
    (2, 'Salary', 'August salary - Pooja Sharma', 32000.00, '2026-08-01', 'Bank Transfer', 2),
    (3, 'Salary', 'August salary - Rahul Das', 24000.00, '2026-08-01', 'Bank Transfer', 3),
    (4, 'Salary', 'August salary - Sneha Roy', 26000.00, '2026-08-01', 'Bank Transfer', 4),
    (5, 'Salary', 'August salary - Vivek Singh', 42000.00, '2026-08-01', 'Bank Transfer', 5),
    (6, 'Salary', 'August salary - Neha Gupta', 25000.00, 'Bank Transfer', 6),
    (7, 'Salary', 'August salary - Arjun Yadav', 27000.00, 'Bank Transfer', 7),
    (8, 'Salary', 'August salary - Kiran Das', 23000.00, 'Bank Transfer', 8),
    (9, 'Salary', 'August salary - Rakesh Jain', 38000.00, 'Bank Transfer', 9),
    (10, 'Salary', 'August salary - Meena Paul', 30000.00, 'Bank Transfer', 10),

    (11, 'Electricity', 'Monthly electricity bill', 18000.00, '2026-08-03', 'Bank Transfer', NULL),
    (12, 'Food Supplies', 'Vegetables and groceries', 14000.00, '2026-08-04', 'Cash', NULL),
    (13, 'Maintenance', 'Air conditioner repair', 7500.00, '2026-08-06', 'UPI', 9),
    (14, 'Laundry', 'Laundry supplies', 6000.00, '2026-08-07', 'UPI', NULL),
    (15, 'Marketing', 'Online advertising campaign', 10000.00, '2026-08-09', 'Card', NULL),
    (16, 'Charity', 'Local community donation', 5000.00, '2026-08-12', 'Bank Transfer', NULL),
    (17, 'Complimentary Gift', 'Welcome gifts for guests', 3000.00, '2026-08-13', 'Cash', 1),
    (18, 'Water', 'Monthly water bill', 4500.00, '2026-08-14', 'Bank Transfer', NULL),
    (19, 'Cleaning', 'Cleaning materials', 6500.00, '2026-08-15', 'UPI', 3),
    (20, 'Insurance', 'Hotel insurance premium', 12000.00, '2026-08-16', 'Bank Transfer', NULL);

-- 12. STAFF PERFORMANCE REVIEWS (15)
INSERT INTO staff_performance_reviews
    (review_id, staff_id, review_date, attendance_score,
     customer_feedback_score, service_score, manager_score,
     overall_score, promotion_status)
VALUES
    (1, 1, '2026-06-30', 92.00, 86.00, 84.00, 88.00, 87.20, 'Eligible'),
    (2, 2, '2026-06-30', 96.00, 91.00, 94.00, 92.00, 93.00, 'Eligible'),
    (3, 3, '2026-06-30', 78.00, 82.00, 88.00, 80.00, 82.20, 'Under Review'),
    (4, 4, '2026-06-30', 98.00, 90.00, 92.00, 91.00, 92.20, 'Eligible'),
    (5, 5, '2026-06-30', 95.00, 94.00, 90.00, 95.00, 93.70, 'Eligible'),
    (6, 6, '2026-06-30', 80.00, 85.00, 88.00, 84.00, 84.50, 'Under Review'),
    (7, 7, '2026-06-30', 88.00, 87.00, 86.00, 85.00, 86.40, 'Eligible'),
    (8, 8, '2026-06-30', 75.00, 89.00, 94.00, 87.00, 86.70, 'Eligible'),
    (9, 9, '2026-06-30', 97.00, 84.00, 80.00, 89.00, 87.60, 'Eligible'),
    (10, 10, '2026-06-30', 72.00, 83.00, 86.00, 80.00, 81.10, 'Under Review'),

    (11, 1, '2026-08-15', 94.00, 88.00, 89.00, 90.00, 90.00, 'Eligible'),
    (12, 3, '2026-08-15', 82.00, 85.00, 90.00, 84.00, 85.20, 'Eligible'),
    (13, 6, '2026-08-15', 84.00, 87.00, 91.00, 86.00, 87.40, 'Eligible'),
    (14, 8, '2026-08-15', 86.00, 92.00, 95.00, 90.00, 91.20, 'Eligible'),
    (15, 10, '2026-08-15', 80.00, 86.00, 88.00, 84.00, 84.60, 'Under Review');

-- ============================================================
-- DATA NOTES
-- ============================================================
-- 1. IDs are explicitly supplied so the relationships are easy
--    to understand while learning.
-- 2. Repeated customers and rooms are intentional.
-- 3. Multiple order items per order are intentional.
-- 4. Multiple payments per allocation are intentional.
-- 5. Pending and failed payments are included for status analysis.
-- 6. Salary is stored in Expenses with staff_id as the reference.
-- 7. Some expenses have NULL staff_id because they are not
--    associated with a particular employee.
-- 8. The data contains July and August 2026 so you can practice
--    date/month comparisons and revenue trends.
-- ============================================================
