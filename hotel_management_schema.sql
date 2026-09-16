CREATE DATABASE IF NOT EXISTS hotel_management_db;
USE hotel_management_db;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    age INT,
    aadhaar_id VARCHAR(20),
    phone VARCHAR(15),
    CONSTRAINT pk_customers PRIMARY KEY (customer_id),
    CONSTRAINT uq_customers_aadhaar UNIQUE (aadhaar_id),
    CONSTRAINT uq_customers_phone UNIQUE (phone),
    CONSTRAINT chk_customers_age CHECK (age IS NULL OR age > 0)
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Available',
    CONSTRAINT pk_rooms PRIMARY KEY (room_id),
    CONSTRAINT uq_rooms_number UNIQUE (room_number),
    CONSTRAINT chk_rooms_capacity CHECK (capacity > 0),
    CONSTRAINT chk_rooms_price CHECK (price_per_night >= 0),
    CONSTRAINT chk_rooms_status CHECK (
        status IN ('Available','Occupied','Maintenance','Out of Service')
    )
);

CREATE TABLE room_allocations (
    allocation_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out DATETIME NOT NULL,
    no_of_guests INT NOT NULL,
    room_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Reserved',
    CONSTRAINT pk_room_allocations PRIMARY KEY (allocation_id),
    CONSTRAINT fk_room_allocations_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_room_allocations_room
        FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    CONSTRAINT chk_room_allocations_guests CHECK (no_of_guests > 0),
    CONSTRAINT chk_room_allocations_price CHECK (room_price >= 0),
    CONSTRAINT chk_room_allocations_dates CHECK (check_out > check_in),
    CONSTRAINT chk_room_allocations_status CHECK (
        status IN ('Reserved','Checked In','Checked Out','Cancelled','No Show')
    )
);

CREATE TABLE food_items (
    food_id INT AUTO_INCREMENT,
    food_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    veg_nonveg VARCHAR(20) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    preparation_time INT,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_food_items PRIMARY KEY (food_id),
    CONSTRAINT chk_food_items_price CHECK (price >= 0),
    CONSTRAINT chk_food_items_prep_time CHECK (
        preparation_time IS NULL OR preparation_time >= 0
    ),
    CONSTRAINT chk_food_items_type CHECK (veg_nonveg IN ('Veg','Non-Veg'))
);

CREATE TABLE food_orders (
    order_id INT AUTO_INCREMENT,
    allocation_id INT NOT NULL,
    order_datetime DATETIME NOT NULL,
    order_status VARCHAR(30) NOT NULL DEFAULT 'Placed',
    CONSTRAINT pk_food_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_food_orders_allocation
        FOREIGN KEY (allocation_id) REFERENCES room_allocations(allocation_id),
    CONSTRAINT chk_food_orders_status CHECK (
        order_status IN ('Placed','Preparing','Ready','Served','Cancelled')
    )
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_order_items PRIMARY KEY (order_item_id),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES food_orders(order_id),
    CONSTRAINT fk_order_items_food
        FOREIGN KEY (food_id) REFERENCES food_items(food_id),
    CONSTRAINT chk_order_items_quantity CHECK (quantity > 0),
    CONSTRAINT chk_order_items_price CHECK (unit_price >= 0)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT,
    allocation_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    payment_date DATETIME NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    CONSTRAINT pk_payments PRIMARY KEY (payment_id),
    CONSTRAINT fk_payments_allocation
        FOREIGN KEY (allocation_id) REFERENCES room_allocations(allocation_id),
    CONSTRAINT chk_payments_amount CHECK (amount > 0),
    CONSTRAINT chk_payments_method CHECK (
        payment_method IN ('Cash','Card','UPI','Bank Transfer')
    ),
    CONSTRAINT chk_payments_type CHECK (
        payment_type IN ('Room','Food','Room Service','Other')
    ),
    CONSTRAINT chk_payments_status CHECK (
        status IN ('Pending','Successful','Failed','Refunded')
    )
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    age INT,
    salary DECIMAL(10,2) NOT NULL,
    joining_date DATE NOT NULL,
    position VARCHAR(50) NOT NULL,
    CONSTRAINT pk_staff PRIMARY KEY (staff_id),
    CONSTRAINT chk_staff_age CHECK (age IS NULL OR age > 0),
    CONSTRAINT chk_staff_salary CHECK (salary >= 0)
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT,
    staff_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT pk_attendance PRIMARY KEY (attendance_id),
    CONSTRAINT fk_attendance_staff
        FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT uq_attendance_staff_date UNIQUE (staff_id, attendance_date),
    CONSTRAINT chk_attendance_status CHECK (
        status IN ('Present','Absent','Leave')
    )
);

CREATE TABLE room_services (
    service_id INT AUTO_INCREMENT,
    allocation_id INT NOT NULL,
    staff_id INT NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    service_date DATETIME NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Completed',
    CONSTRAINT pk_room_services PRIMARY KEY (service_id),
    CONSTRAINT fk_room_services_allocation
        FOREIGN KEY (allocation_id) REFERENCES room_allocations(allocation_id),
    CONSTRAINT fk_room_services_staff
        FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT chk_room_services_cost CHECK (cost >= 0),
    CONSTRAINT chk_room_services_status CHECK (
        status IN ('Requested','In Progress','Completed','Cancelled')
    )
);

CREATE TABLE expenses (
    expense_id INT AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    amount DECIMAL(10,2) NOT NULL,
    expense_date DATE NOT NULL,
    payment_method VARCHAR(30),
    staff_id INT NULL,
    CONSTRAINT pk_expenses PRIMARY KEY (expense_id),
    CONSTRAINT fk_expenses_staff
        FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT chk_expenses_amount CHECK (amount > 0),
    CONSTRAINT chk_expenses_payment_method CHECK (
        payment_method IS NULL
        OR payment_method IN ('Cash','Card','UPI','Bank Transfer')
    )
);

CREATE TABLE staff_performance_reviews (
    review_id INT AUTO_INCREMENT,
    staff_id INT NOT NULL,
    review_date DATE NOT NULL,
    attendance_score DECIMAL(5,2),
    customer_feedback_score DECIMAL(5,2),
    service_score DECIMAL(5,2),
    manager_score DECIMAL(5,2),
    overall_score DECIMAL(5,2),
    promotion_status VARCHAR(30),
    CONSTRAINT pk_staff_performance_reviews PRIMARY KEY (review_id),
    CONSTRAINT fk_staff_performance_reviews_staff
        FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT chk_performance_attendance CHECK (
        attendance_score IS NULL OR attendance_score BETWEEN 0 AND 100
    ),
    CONSTRAINT chk_performance_customer_feedback CHECK (
        customer_feedback_score IS NULL OR customer_feedback_score BETWEEN 0 AND 100
    ),
    CONSTRAINT chk_performance_service CHECK (
        service_score IS NULL OR service_score BETWEEN 0 AND 100
    ),
    CONSTRAINT chk_performance_manager CHECK (
        manager_score IS NULL OR manager_score BETWEEN 0 AND 100
    ),
    CONSTRAINT chk_performance_overall CHECK (
        overall_score IS NULL OR overall_score BETWEEN 0 AND 100
    ),
    CONSTRAINT chk_performance_promotion_status CHECK (
        promotion_status IS NULL
        OR promotion_status IN ('Eligible','Not Eligible','Under Review')
    )
);



