use sakila;

#creating rental may with info of june
CREATE TABLE rental_may AS
    SELECT *
    FROM rental
    WHERE MONTH(rental_date) = 5;
    
#creating rental june with info of june
CREATE TABLE rental_june AS
    SELECT *
    FROM rental
    WHERE MONTH(rental_date) = 6;
   
#check for customer rentals in may
select count(rental_id) as Number_of_Rentals, customer_id as Customer
from rental_may
group by customer_id;

#check for customer rentals in june
select count(rental_id) as Number_of_Rentals, customer_id as Customer
from rental_june
group by customer_id;
