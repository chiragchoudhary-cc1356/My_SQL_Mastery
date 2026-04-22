USE mysql_practice;
CREATE TABLE customer_16a1(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(25),
city VARCHAR(25)
);

INSERT INTO customer_16a1 VALUES
(1,'Amit','Delhi'),
(2,'Neha','Mumbai'),
(3,'Rohit','Delhi'),
(4,'Priya','Chennai'),
(5,'Karan','Mumbai'),
(6,'Sneha','Delhi'),
(7,'Vikas','Chennai'),
(8,'Anjali','Mumbai'),
(9,'Manish','Delhi'),
(10,'Pooja','Chennai'),
(11,'Arjun','Delhi'),
(12,'Kavita','Mumbai'),
(13,'Ramesh','Delhi'),
(14,'Divya','Chennai'),
(15,'Sahil','Mumbai'),
(16,'Nisha','Delhi'),
(17,'Tarun','Chennai'),
(18,'Meena','Mumbai'),
(19,'Deepak','Delhi'),
(20,'Ritu','Chennai'),
(21,'Aakash','Delhi'),
(22,'Simran','Mumbai'),
(23,'Gaurav','Delhi'),
(24,'Tina','Chennai'),
(25,'Raj','Mumbai'),
(26,'Komal','Delhi'),
(27,'Ankit','Chennai'),
(28,'Rekha','Mumbai'),
(29,'Varun','Delhi'),
(30,'Seema','Chennai'),
(31,'Kunal','Delhi'),
(32,'Riya','Mumbai'),
(33,'Yash','Delhi'),
(34,'Neelam','Chennai'),
(35,'Harsh','Mumbai'),
(36,'Payal','Delhi'),
(37,'Nitin','Chennai'),
(38,'Sonal','Mumbai'),
(39,'Aman','Delhi'),
(40,'Isha','Chennai'),
(41,'Lokesh','Delhi'),
(42,'Pallavi','Mumbai'),
(43,'Suresh','Delhi'),
(44,'Jyoti','Chennai'),
(45,'Mohit','Mumbai'),
(46,'Kriti','Delhi'),
(47,'Rahul','Chennai'),
(48,'Preeti','Mumbai'),
(49,'Vivek','Delhi'),
(50,'Shreya','Chennai');

CREATE TABLE order_16a2(
order_id INT,
customer_id INT,
order_date DATE
);

INSERT INTO order_16a2 VALUES
(101,1,'2024-01-10'),
(102,2,'2024-01-15'),
(103,3,'2024-02-01'),
(104,1,'2024-02-10'),
(105,5,'2024-02-18'),
(106,7,'2024-03-05'),
(107,8,'2024-03-12'),
(108,10,'2024-03-20'),
(109,12,'2024-03-22'),
(110,15,'2024-03-25'),
(111,18,'2024-04-01'),
(112,20,'2024-04-05'),
(113,22,'2024-04-07'),
(114,25,'2024-04-10'),
(115,30,'2024-04-12'),
(116,35,'2024-04-14'),
(117,40,'2024-04-15');

CREATE TABLE order_details_16a3(
detail_id INT,
order_id INT,
product VARCHAR (25),
amount INT
);

INSERT INTO order_details_16a3 VALUES
(1,101,'Laptop',70000),
(2,101,'Mouse',2000),
(3,102,'Phone',30000),
(4,103,'Tablet',20000),
(5,104,'Laptop',80000),
(6,105,'Phone',25000),
(7,106,'Laptop',90000),
(8,107,'Tablet',22000),
(9,108,'Phone',28000),
(10,109,'Laptop',85000),
(11,110,'Tablet',21000),
(12,111,'Laptop',95000),
(13,112,'Phone',27000),
(14,113,'Tablet',23000),
(15,114,'Laptop',88000),
(16,115,'Phone',26000),
(17,116,'Tablet',24000),
(18,117,'Laptop',99000);

-- Task 1 > Customers + unke orders + products ( Hint: 3 table JOIN, Chain_follow karo )
SELECT c.customer_name, o.order_id, p.product
FROM customer_16a1 c
LEFT JOIN order_16a2 o
ON c.customer_id = o.customer_id
RIGHT JOIN order_details_16a3 p
ON o.order_id = p.order_id;


-- Task 2 > Har customer ka total spend ( Hint: Aggregate )
SELECT c.customer_name, SUM(p.amount) AS total_spend
FROM customer_16a1 c
JOIN order_16a2 o
ON c.customer_id = o.customer_id
JOIN order_details_16a3 p
ON o.order_id = p.order_id
GROUP BY c.customer_name;
 
-- Task 3 > Jinke koi order nahi hai ( Hint: Join + NULL )
SELECT c.*
FROM customer_16a1 c
LEFT JOIN order_16a2 o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Task 4 > Har city ka total revenue ( Hint: Aggregate )
SELECT c.city, SUM(p.amount) AS total_revenue
FROM customer_16a1 c
JOIN order_16a2 o
ON c.customer_id = o.customer_id
JOIN order_details_16a3 p
ON o.order_id = p.order_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Task 5 > Jinka total spend average se zyada ( Hint: Subquery )
SELECT c.customer_name, SUM(p.amount) AS total_spend
FROM customer_16a1 c
JOIN order_16a2 o
ON c.customer_id = o.customer_id
JOIN order_details_16a3 p
ON o.order_id = p.order_id
GROUP BY c.customer_name
HAVING SUM(p.amount) > (
	SELECT AVG(amount)
      FROM order_details_16a3
);

-- Final Task > Top 3 customers by total spend ( Hint: Aggregate + Limit )
SELECT c.customer_name, SUM(p.amount) AS total_spend
FROM customer_16a1 c
JOIN order_16a2 o
ON c.customer_id = o.customer_id
JOIN order_details_16a3 p
ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY total_spend DESC
LIMIT 3;
	
# End of query 17_April_2026 
