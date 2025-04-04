-- data definition language
-- 1. creating a database
-- Create a database named 'practice_db'
CREATE DATABASE practise_db;
-- now you have craeted a practise database
-- you have multiple databases, you have to choose the one that you will work on
USE practise_db;
-- the practise_db is chosen and highlighted
SHOW DATABASES;

-- 2) Creating Tables
-- Create a table named 'students'
CREATE TABLE students ( student_id INT AUTO_INCREMENT PRIMARY KEY , -- Unique ID, auto-increment
first_name VARCHAR(50) NOT NULL,                                      -- Cannot be NULL
last_name VARCHAR(50),                                                -- Optional
email VARCHAR(100) UNIQUE,                                            -- Must be unique
enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP                   -- Default to today's date
);

SELECT * FROM students; 

-- 3) Altering tables 
-- Add a new column 'phone_number' to the 'students' table
 ALTER TABLE students
 ADD phone_number VARCHAR(15);
 
 -- Modify the 'last_name' column to be NOT NULL
ALTER TABLE students 
MODIFY last_name VARCHAR(50) NOT NULL;

-- Rename the 'students' table to 'university_students'
ALTER TABLE students 
RENAME TO university_students;

SELECT * FROM university_students;
 
 -- 4) Dropping Tables
-- Drop the table 'university_students'
DROP TABLE university_students;

-- 5) Creating Constraints
-- Create a table with constraints
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    credits INT CHECK (credits BETWEEN 1 AND 5)  -- Ensure credits are between 1 and 5
);

ALTER TABLE university_students 
RENAME TO students;

-- Create a table with a foreign key
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Remove all rows from the 'students' table
TRUNCATE TABLE students;

-- To delete single column
ALTER TABLE table_name
DROP COLUMN column_name;

-- To delete single column
ALTER TABLE students
DROP COLUMN phone_number;

   








 