use supermarket_basic2026_db;
create table reliance_consumer(
product_id int auto_increment primary key,
name varchar(100) not null,
category varchar (25),
price decimal(10,2) not null,
stock int default 0,
status enum('active', 'inactive') default 'active',
created_at timestamp default current_timestamp
);

select * from reliance_consumer;

create table customers(
customer_id int auto_increment primary key,
customer_name varchar(100) not null,
phone varchar(15) unique,
email varchar(100),
created_at timestamp default current_timestamp
);

select * from customers;

create table orders(
order_id int auto_increment primary key,
customer_id int,
order_date timestamp default current_timestamp,
total_amount decimal(10, 2) default 0,
status enum('pending', 'paid', 'cancelled') default 'pending',
foreign key (customer_id) references customers(customer_id)
);

create table order_items(
item_id int auto_increment primary key,
order_id int,
product_id int,
quantity int not null,
price decimal(10,2) not null,
foreign key(order_id) references orders(order_id)
);

CREATE TABLE payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
payment_method ENUM('CASH','UPI','CARD'),
amount DECIMAL(10,2),
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
-- Complete whole important syntax & now enter some data ...

-- 1] INSERT SAMPLE DATA
INSERT INTO products (name, category, price, stock)
VALUES
('Milk', 'Dairy', 55, 100),
('Bread', 'Bakery', 30, 50),
('Rice 1kg', 'Grocery', 70, 200);

INSERT INTO customers (customer_name, phone)
VALUES ('Rahul Sharma', '9876543210');

-- 2] CREATE ORDER
INSERT INTO orders (customer_id)
VALUES (1);

-- 3] ADD ITEM OR ORDER
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 55);

-- 4] UPDATE STOCK AUTOMATICALLY
UPDATE products
SET stock = stock - 2
WHERE product_id = 1;

-- 5] UPDATE ORDER TOTAL
UPDATE orders o
SET total_amount = (
SELECT SUM(quantity * price)
FROM order_items
WHERE order_id = o.order_id
)
WHERE order_id = 1;

-- 6] MAKE PAYMENT
INSERT INTO payments (order_id, payment_method, amount)
VALUES (1, 'UPI', 110);

UPDATE orders SET status = 'PAID' WHERE order_id = 1;

-- 7] DAILY SALES
SELECT DATE(order_date) AS day,
SUM(total_amount) AS total_sales
FROM orders
WHERE status = 'PAID'
GROUP BY day;

-- 8] LOW STOCK ALERT
SELECT * FROM products
WHERE stock < 20 AND status = 'ACTIVE';

-- 9] TOP SELLING PRODUCTS
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC
LIMIT 5;

-- END OF QUERY --
