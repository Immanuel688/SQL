CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID, auto-increment
    first_name VARCHAR(50) NOT NULL,            -- Cannot be NULL
    last_name VARCHAR(50),                      -- Optional
    email VARCHAR(100) UNIQUE,                  -- Must be unique
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP   -- Default to today's date
);

SELECT * from students;

-- 1) Insert
-- Insert single row in 'students' table 
INSERT INTO students (first_name, last_name, email, enrollment_date)
VALUES ('John','Doe','john.doe@example.com','2025-03-26');
-- we did not give student id as it is automatically handled by the tool

-- Insert multiple rows
INSERT INTO students (first_name, last_name, email, enrollment_date)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', '2024-11-20'),
('Alice', 'Johnson', 'alice.johnson@example.com', '2024-11-19');

-- 2)Update data
-- Update the email for a specific student
UPDATE students
SET email='john.newemail@example.com'
WHERE student_id= 1;

-- Disable safe update mode for this session
SET SQL_SAFE_UPDATES = 0;

-- Update multiple columns
UPDATE students 
SET last_name = 'Brown', email = 'jane.brown@example.com' 
WHERE first_name = 'Jane';

-- update selective rows
UPDATE students
SET enrollment_date='2025-03-26'
WHERE first_name='Alice';

-- Update all rows
UPDATE students 
SET enrollment_date = '2025-03-26';

CREATE TABLE archived_students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID, auto-increment
    first_name VARCHAR(50) NOT NULL,            -- Cannot be NULL
    last_name VARCHAR(50),                      -- Optional
    email VARCHAR(100) UNIQUE,                  -- Must be unique
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP   -- Default to today's date
);

-- Insert data into 'archived_students' by selecting from 'students'
INSERT INTO archived_students (student_id, first_name, last_name, email, enrollment_date)
SELECT student_id, first_name, last_name, email, enrollment_date
FROM students
WHERE enrollment_date = '2024-11-22';

SELECT * from archived_students;
-- The archived students table is empty bcuz no body enrolled on that date, if you dont give enrollment date it will move all the values.

SELECT * from students;








