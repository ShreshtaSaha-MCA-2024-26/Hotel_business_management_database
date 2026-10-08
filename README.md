# 🏨 Hotel Management Database — MySQL

A real-world **Hotel Management Database** designed and implemented from scratch using **MySQL** to practice relational database design, SQL, data integrity, and business-oriented analysis.

This project focuses not only on writing SQL queries, but on understanding **how a real business operates and translating those operations into a structured relational database**.

---

## 🎯 Project Objective

The goal of this project is to simulate the data operations of a hotel and build a database capable of answering practical business questions.

The project follows a complete database development process:

> **Understand the Business → Identify Entities → Design Relationships → Build Schema → Apply Constraints → Insert Structured Data → Validate with SQL → Analyze Business Questions**

Rather than creating tables only for SQL practice, the database was designed around actual hotel processes such as:

* Customer stays and room allocation
* Food ordering
* Payments
* Staff attendance
* Room services
* Hotel expenses
* Staff performance

---

## 🏗️ Database Architecture

The database contains **12 relational tables** divided conceptually into master data and transactional data.

### Master Data

| Table        | Purpose                                |
| ------------ | -------------------------------------- |
| `customers`  | Stores customer information            |
| `rooms`      | Stores physical hotel room information |
| `food_items` | Stores the hotel's food/menu items     |
| `staff`      | Stores employee information            |

### Transactional & Operational Data

| Table                       | Purpose                                        |
| --------------------------- | ---------------------------------------------- |
| `room_allocations`          | Records customer room stays                    |
| `food_orders`               | Records food orders during a stay              |
| `order_items`               | Stores individual items within an order        |
| `payments`                  | Records customer payments                      |
| `attendance`                | Records daily staff attendance                 |
| `room_services`             | Records services provided during a stay        |
| `expenses`                  | Records hotel expenses                         |
| `staff_performance_reviews` | Records periodic staff performance evaluations |

---

## 🔗 Relational Design

The database was designed around relationships between business entities rather than storing everything in a single table.

```text
                         CUSTOMERS
                             │
                             │ 1:M
                             ▼
                     ROOM_ALLOCATIONS
                       │             │
                     M:1             │ 1:M
                       │             ▼
                       ▼        FOOD_ORDERS
                     ROOMS           │
                                     │ 1:M
                                     ▼
                                ORDER_ITEMS
                                  │      │
                                M:1      M:1
                                  │      │
                                  ▼      ▼
                             FOOD_ITEMS


                     ROOM_ALLOCATIONS
                           │
                           │ 1:M
                           ▼
                        PAYMENTS


                         STAFF
                       /   │    \
                      /    │     \
                     ▼     ▼      ▼
              ATTENDANCE  ROOM   PERFORMANCE
                         SERVICES  REVIEWS


                        EXPENSES
```

### Key design principle

The project separates:

* **What exists** → Customers, Rooms, Staff, Food Items
* **What happened** → Allocations, Orders, Payments, Attendance, Services, Expenses
* **What can be calculated** → Revenue, Profit, Occupancy, Attendance %, etc.

This avoids unnecessary duplication and makes the database easier to analyze.

---

## 🧠 Database Design Decisions

### Room vs Room Allocation

A physical room and a customer's stay are different concepts.

```text
Room 101
    ↓
Allocation #1 → Customer A → July
Allocation #2 → Customer B → August
```

This allows the same physical room to have multiple customers over time while maintaining historical records.

### Food Items vs Food Orders vs Order Items

One order can contain multiple food items:

```text
Order #1001
├── Chicken Biryani × 2
├── Butter Naan × 4
└── Masala Tea × 2
```

Therefore, menu information, order information, and individual ordered items are stored separately.

### Revenue and Profit

Revenue and profit are treated as **derived business metrics**, rather than independent input tables.

Conceptually:

```text
Successful Payments
        ↓
      Revenue
        ↓
  Revenue - Expenses
        ↓
      Profit
```

This allows the database to calculate business metrics dynamically.

---

## 🔐 Data Integrity

The database uses MySQL constraints to maintain reliable data.

### Primary Keys

Every major entity has a unique identifier:

```text
customer_id
room_id
allocation_id
food_id
order_id
order_item_id
payment_id
staff_id
...
```

### Foreign Keys

Relationships are enforced using foreign keys.

For example:

```text
room_allocations.customer_id
        ↓
customers.customer_id
```

```text
order_items.food_id
        ↓
food_items.food_id
```

### Additional Constraints

The schema also uses:

* `NOT NULL`
* `UNIQUE`
* `CHECK`
* `DEFAULT`
* `AUTO_INCREMENT`

Examples include:

* Preventing negative room prices
* Preventing invalid staff salaries
* Preventing invalid performance scores
* Preventing duplicate room numbers
* Preventing duplicate attendance records for the same employee/date

---

## 📊 Sample Data

The project includes structured test data designed specifically for SQL practice.

The dataset contains:

* 10 customers
* 10 rooms
* 15 room allocations
* 15 food items
* 20 food orders
* 45 order items
* 10 staff members
* 50 attendance records
* 20 room-service records
* 25 payments
* 20 expenses
* 15 performance reviews

The data intentionally contains **repeated relationships and different business scenarios** so that joins, aggregation, filtering, subqueries, and business calculations can be practiced meaningfully.

---

## 💻 SQL Concepts Practiced

The project is used to practice SQL from basic to intermediate level.

### Basic SQL

* `SELECT`
* `WHERE`
* `ORDER BY`
* `DISTINCT`
* `INSERT`
* `UPDATE`
* `DELETE`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`
* `GROUP BY`
* `HAVING`

### Relationships

* `INNER JOIN`
* `LEFT JOIN`
* Multi-table joins
* Primary key / foreign key relationships

### Intermediate SQL

* Subqueries
* `CASE`
* String functions
* Date functions
* Conditional aggregation
* Transaction handling

### Data Integrity

* Primary key constraints
* Foreign key constraints
* Unique constraints
* Check constraints

---



## 🔄 Development Process

The project was developed iteratively rather than creating a database immediately.

```text
1. Understand Hotel Operations
             ↓
2. Identify Business Entities
             ↓
3. Separate Master & Transaction Data
             ↓
4. Define PK/FK Relationships
             ↓
5. Draw Schema on Paper
             ↓
6. Review & Normalize the Design
             ↓
7. Implement in MySQL
             ↓
8. Apply Data Integrity Constraints
             ↓
9. Insert Structured Test Data
             ↓
10. Validate Using SQL Queries
             ↓
11. Test Business Questions
             ↓
12. Refine the Database
```

This iterative approach helps identify schema problems through actual querying rather than assuming that a database design is correct simply because it looks good on paper.

---

## 📁 Project Structure

```text
hotel-management-database/
│
├── hotel_management_schema.sql
│
├── hotel_management_sample_data.sql
│
├── hotel_management_sql_practice_solutions.sql
│
└── README.md
```

### `hotel_management_schema.sql`

Creates the database and all relational tables with their constraints.

### `hotel_management_sample_data.sql`

Populates the database with structured sample data for testing and analysis.

### `hotel_management_sql_practice_solutions.sql`

Contains SQL practice solutions covering fundamental and intermediate SQL concepts.

---

## 🚀 How to Run

### 1. Create the database

Run:

```sql
CREATE DATABASE hotel_management_db;
```

Or execute the provided schema script directly.

### 2. Create the tables

Run:

```text
hotel_management_schema.sql
```

### 3. Insert sample data

Run:

```text
hotel_management_sample_data.sql
```

### 4. Start querying

Select the database:

```sql
USE hotel_management_db;
```

Then begin with basic queries and gradually move toward multi-table business analysis.

---

## 🛠️ Technology

* **Database:** MySQL 8.0+
* **Language:** SQL
* **Design:** Relational Database Model
* **Approach:** Business-driven database design

---

## 📌 Key Learning Outcomes

Through this project, I practiced:

* Translating real-world business processes into database entities
* Designing relational tables
* Identifying primary and foreign keys
* Understanding one-to-many relationships
* Reducing unnecessary data duplication
* Applying database constraints
* Creating structured test data
* Writing SQL queries across multiple related tables
* Converting business requirements into SQL questions
* Using data to derive business metrics

---

## 👤 Project Focus

This project was built as a practical exercise to bridge the gap between:

**Database Management → SQL → Business Understanding → Data Analysis**

The primary objective is not simply to demonstrate SQL syntax, but to understand how a real-world business can be represented through structured data and then analyzed to support business decisions.

---

👤 Author

Shreshta Saha

MCA | Data Analytics & Machine Learning

This project was created as a practical SQL/database project to demonstrate database design and SQL querying skills.

