USE mysql_practice;
CREATE TABLE employees_18apr1(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(25),
department VARCHAR(25),
city VARCHAR(25),
salary INT
);

INSERT INTO employees_18Apr1 VALUES
(1,'Amit','IT','Delhi',80000),
(2,'Neha','HR','Mumbai',45000),
(3,'Rohit','Sales','Delhi',60000),
(4,'Priya','Finance','Chennai',75000),
(5,'Karan','IT','Mumbai',90000),
(6,'Sneha','HR','Delhi',48000),
(7,'Vikas','Sales','Chennai',65000),
(8,'Anjali','Finance','Mumbai',72000),
(9,'Manish','IT','Delhi',55000),
(10,'Pooja','Sales','Mumbai',62000),
(11,'Arjun','Finance','Delhi',88000),
(12,'Kavita','HR','Chennai',50000),
(13,'Ramesh','IT','Delhi',95000),
(14,'Divya','Sales','Chennai',70000),
(15,'Sahil','Finance','Mumbai',68000),
(16,'Nisha','HR','Delhi',47000),
(17,'Tarun','Sales','Chennai',64000),
(18,'Meena','Finance','Mumbai',71000),
(19,'Deepak','IT','Delhi',85000),
(20,'Ritu','HR','Chennai',46000),
(21,'Aakash','IT','Delhi',87000),
(22,'Simran','Sales','Mumbai',63000),
(23,'Gaurav','Finance','Delhi',82000),
(24,'Tina','HR','Chennai',49000),
(25,'Raj','IT','Mumbai',91000),
(26,'Komal','Sales','Delhi',66000),
(27,'Ankit','Finance','Chennai',73000),
(28,'Rekha','HR','Mumbai',51000),
(29,'Varun','IT','Delhi',88000),
(30,'Seema','Sales','Chennai',69000),
(31,'Kunal','Finance','Delhi',84000),
(32,'Riya','HR','Mumbai',52000),
(33,'Yash','IT','Delhi',89000),
(34,'Neelam','Sales','Chennai',67000),
(35,'Harsh','Finance','Mumbai',76000),
(36,'Payal','HR','Delhi',53000),
(37,'Nitin','IT','Chennai',78000),
(38,'Sonal','Sales','Mumbai',61000),
(39,'Aman','Finance','Delhi',83000),
(40,'Isha','HR','Chennai',54000),
(41,'Lokesh','IT','Delhi',92000),
(42,'Pallavi','Sales','Mumbai',62000),
(43,'Suresh','Finance','Delhi',81000),
(44,'Jyoti','HR','Chennai',55000),
(45,'Mohit','IT','Mumbai',94000),
(46,'Kriti','Sales','Delhi',68000),
(47,'Rahul','Finance','Chennai',77000),
(48,'Preeti','HR','Mumbai',56000),
(49,'Vivek','IT','Delhi',93000),
(50,'Shreya','Sales','Chennai',70000);

CREATE TABLE projects_18apr2(
project_id INT,
emp_id INT,
project_name VARCHAR(25),
budget INT
);

INSERT INTO projects_18apr2 VALUES
(101,1,'AI Tool',300000),
(102,2,'HR App',80000),
(103,3,'CRM',150000),
(104,5,'ML Model',400000),
(105,7,'Dashboard',120000),
(106,8,'Audit',180000),
(107,10,'Sales App',220000),
(108,13,'Cloud System',500000),
(109,19,'Automation',350000),
(110,21,'Analytics',270000), 
(111,25,'AI Bot',450000),
(112,29,'Security',380000),
(113,33,'Data Lake',420000),
(114,37,'ETL Pipeline',260000),
(115,41,'DevOps',310000),
(116,45,'Monitoring',330000),
(117,49,'Optimization',290000);

CREATE TABLE attendance_18apr3(
att_id INT,
emp_id INT,
present_days INT
);

INSERT INTO attendance_18apr3 VALUES
(1,1,25),
(2,2,20),
(3,3,22),
(4,4,24),
(5,5,26),
(6,6,21),
(7,7,23),
(8,8,25),
(9,9,20),
(10,10,22),
(11,11,24),
(12,12,19),
(13,13,27),
(14,14,23),
(15,15,21),
(16,16,20),
(17,17,22),
(18,18,24),
(19,19,26),
(20,20,18);

-- 1] Employees + Projects { Hint : joins  }
SELECT *
FROM employees_18apr1 e
LEFT JOIN projects_18apr2 p
ON e.emp_id = p.emp_id;

-- 2] Employees + Attendance { Hint : joins }
SELECT *
FROM employees_18apr1 e
LEFT JOIN attendance_18apr3 a
ON e.emp_id = a.emp_id; 

-- 3] Har department ka avg salary { Hint : GROUP BY }
SELECT department, AVG(salary) AS average_salary
FROM employees_18apr1
GROUP BY department;

-- 4] Har city ka total salary { Hint : SUM }
SELECT city, SUM(salary) AS total_salary
FROM employees_18apr1
GROUP BY city;

-- 5] Jinke salary avg se zyada { Hint : Subquery }
SELECT *
FROM employees_18apr1
WHERE salary > (
	SELECT AVG(salary)
      FROM employees_18apr1
      );

-- 6] Har department ka highest salary { Hint : GROUP BY + MAX }
SELECT department, MAX(salary) AS highest_salary
FROM employees_18apr1
GROUP BY department;

-- 7] Top 3 salary employees { Hint : ORDER BY + LIMIT }
SELECT *
FROM employees_18apr1
ORDER BY salary DESC
LIMIT 3;

-- 8] Jinke paas project nahi { Hint : LEFT JOIN + NULL }
SELECT e.emp_name, p.project_name
FROM employees_18apr1 e
LEFT JOIN projects_18apr2 p
ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL;

-- 9] Har department ke top 2 salary { Hint : WINDOW (RANK) }
SELECT *
FROM (
	SELECT emp_name, department, salary,
		RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
	FROM employees_18apr1
) t
WHERE rnk <= 2;

-- 10] Salary rank nikalo sabka { Hint : RANK() }
SELECT emp_name, salary,
      RANK() OVER (ORDER BY salary DESC) AS rnk
	FROM employees_18apr1;

-- 11] Attendance ke basis pe top employee { Hint : ORDER BY }
SELECT DISTINCT e.emp_name, a.att_id
FROM employees_18apr1 e
LEFT JOIN attendance_18apr3 a
ON e.emp_id = a.emp_id
ORDER BY att_id DESC
LIMIT 3;

#Sorry according to question result was repeat 1 emp highest number of attendance & not show top 3 employess attendance that's why am use DISTINCT function...

-- 12] Jinke salary department avg se zyada { Hint : Subquery + GROUP }
SELECT e.emp_name, e.department, e.salary
FROM employees_18apr1 e
WHERE e.salary > (
	SELECT AVG(salary)
      FROM employees_18apr1
      WHERE department = e.department
);

-- 14] Har department ka total project budget { Hint : JOIN + SUM }
SELECT e.department, SUM(p.budget) AS total_project_budget
FROM employees_18apr1 e
JOIN projects_18apr2 p
ON e.emp_id = p.emp_id
GROUP BY e.department;

-- 15] CTE use karke top salary per dept { Hint : WITH }
WITH ranked_data AS (
    SELECT emp_name, department, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees_18apr1
)
SELECT emp_name, department, salary
FROM ranked_data
WHERE rnk = 1;

# End of query 21_April_2026
