use sakila;
SHOW TABLES; #1
DESCRIBE actor; #2
DESCRIBE country; #2
DESCRIBE payment; #2
DESCRIBE film; #2
SELECT title from film; #3
SELECT title as Moviename from film; #4
SELECT DISTINCT(name) as language from language; #4
SELECT COUNT(DISTINCT(staff_id)) as Number_of_employees from staff; #5 
SELECT COUNT(DISTINCT(store_id)) as Number_of_stores from store; 	#5
SELECT first_name from staff; 										#5
SELECT DISTINCT(DATEDIFF(return_date,rental_date)) as Unique_days from rental ORDER by Unique_days ASC; #6
SELECT COUNT(DISTINCT(DATEDIFF(return_date,rental_date))) from rental;									#6



