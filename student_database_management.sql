Enter password: *********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 8.0.38 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+------------------------------+
| Database                     |
+------------------------------+
| demo                         |
| food                         |
| information_schema           |
| library_management_system    |
| movie_rental_database        |
| mysql                        |
| online_retail_store_database |
| performance_schema           |
| res                          |
| sakila                       |
| student_database_management  |
| sys                          |
| world                        |
+------------------------------+
13 rows in set (0.00 sec)

mysql> create database  student_database_management;
Query OK, 1 row affected (0.02 sec)

mysql> use  student_database_management;
Database changed
mysql> -- Table for storing student information
mysql> CREATE TABLE students (
    ->     student_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     first_name VARCHAR(50),
    ->     last_name VARCHAR(50),
    ->     dob DATE,
    ->     email VARCHAR(100),
    ->     phone VARCHAR(15)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql>
mysql> -- Table for storing course information
mysql> CREATE TABLE courses (
    ->     course_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     course_name VARCHAR(100),
    ->     course_description TEXT,
    ->     credits INT
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql>
mysql> -- Table for linking students to courses and storing grades
mysql> CREATE TABLE enrollments (
    ->     enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     student_id INT,
    ->     course_id INT,
    ->     grade CHAR(2),
    ->     FOREIGN KEY (student_id) REFERENCES students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES courses(course_id)
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> INSERT INTO students (first_name, last_name, dob, email, phone)
    -> VALUES
    -> ('John', 'Doe', '2000-01-01', 'john.doe@example.com', '1234567890'),
    -> ('Jane', 'Smith', '1999-05-22', 'jane.smith@example.com', '0987654321');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO courses (course_name, course_description, credits)
    -> VALUES
    -> ('Database Systems', 'An introduction to relational databases and SQL.', 3),
    -> ('Software Engineering', 'Software development methodologies and tools.', 4);
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO enrollments (student_id, course_id, grade)
    -> VALUES
    -> (1, 1, 'A'),
    -> (2, 2, 'B');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT s.first_name, s.last_name, c.course_name, e.grade
    -> FROM students s
    -> JOIN enrollments e ON s.student_id = e.student_id
    -> JOIN courses c ON e.course_id = c.course_id;
+------------+-----------+----------------------+-------+
| first_name | last_name | course_name          | grade |
+------------+-----------+----------------------+-------+
| John       | Doe       | Database Systems     | A     |
| Jane       | Smith     | Software Engineering | B     |
+------------+-----------+----------------------+-------+
2 rows in set (0.00 sec)

mysql> SELECT c.course_name, AVG(CASE WHEN e.grade = 'A' THEN 4
    ->                                WHEN e.grade = 'B' THEN 3
    ->                                WHEN e.grade = 'C' THEN 2
    ->                                WHEN e.grade = 'D' THEN 1
    ->                                ELSE 0 END) AS avg_grade
    -> FROM courses c
    -> JOIN enrollments e ON c.course_id = e.course_id
    -> GROUP BY c.course_name;
+----------------------+-----------+
| course_name          | avg_grade |
+----------------------+-----------+
| Database Systems     |    4.0000 |
| Software Engineering |    3.0000 |
+----------------------+-----------+
2 rows in set (0.00 sec)

mysql> select * from courses;
+-----------+----------------------+--------------------------------------------------+---------+
| course_id | course_name          | course_description
          | credits |
+-----------+----------------------+--------------------------------------------------+---------+
|         1 | Database Systems     | An introduction to relational databases and SQL. |       3 |
|         2 | Software Engineering | Software development methodologies and tools.    |       4 |
+-----------+----------------------+--------------------------------------------------+---------+
2 rows in set (0.00 sec)

mysql>
