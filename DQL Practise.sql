use practice_db;
-- 1. Basic SELECT Query
-- Fetch all columns from the students table
SELECT * 
FROM students;

-- 2. SELECT Specific Columns
-- Fetch only first_name and email columns
SELECT first_name, email 
FROM students;

SELECT last_name,student_id
FROM students;

-- 3.WHERE Clause
-- Fetch students enrolled after a specific date
SELECT first_name,last_name,enrollment_date
FROM students
WHERE enrollment_date > '2025-03-24' 
-- it will display two rows

-- fetch details where enrollment date is 26mar 2025
SELECT first_name,last_name,enrollment_date
FROM students
WHERE enrollment_date = '2025-03-26'

select * from students;

-- 4.Logical Operators
-- Fetch students enrolled in 2024 with a specific last name
SELECT first_name,last_name,enrollment_date
FROM students
WHERE enrollment_date BETWEEN '2024-01-01' AND '2024-12-31' AND last_name = 'TAYLOR'; 

-- 5.OrderBy
-- Fetch students ordered by enrollment_date in descending order
SELECT first_name, last_name, enrollment_date 
FROM students 
ORDER BY first_name DESC;

-- 6.Limit
-- Fetch the first 5 rows
SELECT first_name, last_name 
FROM students 
LIMIT 2;

-- 7. Aggregation with GROUP BY
-- Perform calculations on groups of rows using aggregate functions.
-- Common Aggregate Functions:
-- COUNT(): Counts the number of rows.
-- SUM(): Adds up values.
-- AVG(): Calculates the average.
-- MAX(): Finds the maximum value.
-- MIN(): Finds the minimum value.

SELECT  COUNT(enrollment_date) AS total_students
FROM students
GROUP BY enrollment_date;

SELECT COUNT(*) AS total_students -- includes the count of null values also
FROM students
WHERE marks>20
GROUP BY marks;

SELECT marks, COUNT(*) AS total_students -- includes the count of null values also
FROM students
WHERE marks>20
GROUP BY marks;

-- ORDER BY marks;


ALTER TABLE students 
ADD marks VARCHAR(3);

-- i wnat marks toi be in integer not as a character
ALTER TABLE students 
MODIFY marks int ;

select * from students;

UPDATE  students
SET marks = (35,45,80)
WHERE student_id=(2,3,5); -- wrong query

UPDATE students SET marks = 35 WHERE student_id = 2;
UPDATE students SET marks = 45 WHERE student_id = 3;
UPDATE students SET marks = 80 WHERE student_id = 5;

-- using case converting to single query
UPDATE students
SET marks = CASE 
    WHEN student_id = 2 THEN 35
    WHEN student_id = 3 THEN 45
    WHEN student_id = 5 THEN 80
    ELSE marks
END
WHERE student_id IN (2, 3, 5);

-- Count the number of students by enrollment_date
SELECT sum(marks)
FROM students ;

SELECT sum(marks)AS total_sumofmarks
FROM students ;

SELECT avg(marks) AS avergeMark
FROM students ;

SELECT min(marks) AS minMark
FROM students ;

SELECT max(marks) AS maxMark
FROM students ;

-- all together combined aggregation
SELECT 
    SUM(marks) AS total_mark,
    AVG(marks) AS average_mark,
    MIN(marks) AS min_mark,
    MAX(marks) AS max_mark
FROM students;

SELECT 
    SUM(marks) AS total_mark,
    AVG(marks) AS average_mark,
    MIN(marks) AS min_mark,
    MAX(marks) AS max_mark
FROM students
GROUP BY enrollment_date;

-- HAVING Clause
-- Fetch enrollment dates with more than 5 students
SELECT enrollment_date, COUNT(*) AS total_students 
FROM students 
GROUP BY enrollment_date
HAVING total_students > 0;

select * from courses;
select * from enrollments;
select * from students;

INSERT INTO students (student_id,first_name, last_name, email, enrollment_date) 
VALUES ('1','John', 'Doe', 'john.doe@example.com', '2025-03-21');

Insert into courses (course_id,course_name,credits)
values (101,"AI",3),
(102,"ML",2),
(103,"DL",3);

insert into enrollments(enrollment_id,student_id,course_id)
values(001,1, 101),  -- John Doe enrolls in AI
       (002,2, 102),  -- Jane Smith enrolls in ML
       (003,3, 103);  -- Alice Johnson enrolls in DL

-- inner joins
-- Fetch students and their associated course names
SELECT students.first_name, students.last_name, courses.course_name ,courses.course_id,students.student_id
FROM students 
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id = courses.course_id;

SELECT students.first_name, students.last_name, enrollments.course_id,students.student_id,courses.course_name
FROM students 
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id= courses.course_id;

-- left joins
-- Fetch all students, including those not enrolled in any course
SELECT students.first_name, courses.course_name 
FROM students 
LEFT JOIN enrollments ON students.student_id = enrollments.student_id 
LEFT JOIN courses ON enrollments.course_id = courses.course_id;

-- Right Joins
SELECT students.student_id, first_name,enrollments.course_id
FROM students
RIGHT JOIN enrollments
ON students.student_id = enrollments.student_id;

-- practise examples
-- table creation using ddl
CREATE TABLE customers
( customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name  VARCHAR(50),
country VARCHAR(50)
);

SELECT * FROM customers;

-- updating table values using dml

INSERT INTO customers (customer_name,country)
VALUES ('Alice','US');

INSERT INTO customers VALUES (2,'Bob','Canada');
INSERT INTO customers (customer_name,country) VALUES ('Charlie','UK'),('Diana','Australia');

CREATE TABLE orders ( order_id INT UNIQUE NOT NULL, customer_ID INT NOT NULL, order_date DATE, Amount INT);
SELECT * FROM orders;

INSERT INTO orders ( order_id, customer_id, order_date, Amount)
VALUES (101,1,'2025-04-01',150),(102,3,'2025-03-28',200),(103,1,'2025-03-26',300),(104,5,'2025-03-24',250);

-- IN MY SQL I AM UNABLE TO RUN FULL JOIN SO I DID A UNION OF LEFT JOIN AND RIGHT JOIN
SELECT customers.customer_id,customers.customer_name,orders.order_id,orders.order_date,orders.amount
FROM customers
left JOIN orders
ON customers.customer_id=orders.customer_id
UNION
SELECT customers.customer_id,customers.customer_name,orders.order_id,orders.order_date,orders.amount
FROM orders
LEFT JOIN customers
ON orders.customer_id=customers.customer_id;

SELECT customers.customer_id,customers.customer_name,orders.order_id,orders.order_date,orders.amount
FROM customers
left JOIN orders
ON customers.customer_id=orders.customer_id
UNION
SELECT customers.customer_id,customers.customer_name,orders.order_id,orders.order_date,orders.amount
FROM customers
RIGHT JOIN orders
ON customers.customer_id=orders.customer_id;

