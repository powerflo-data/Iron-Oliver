use sakila;
select release_year from film;
select * from film where title regexp 'ARMAGEDDON';
select * from film where title like '%APOLLO';
select * from film order by length DESC LIMIT 10;
select count(*) from film where special_features like '%Behind the Scenes%';
alter table staff
drop column picture;
select * from staff;
select * from customer where first_name = 'TAMMY';
select * from staff;
INSERT INTO staff(staff_id, first_name, last_name, address_id,email, store_id,active,username,password,last_update)
SELECT '3', customer.first_name, customer.last_name, customer.address_id, customer.email, '2', '1', customer.first_name, 'secret', customer.last_update
FROM customer WHERE first_name = 'TAMMY' and last_name = 'SANDERS';
select * from staff;
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
#customer_id is 130
Select film_id from film where title = 'ACADEMY DINOSAUR';
#film_id == 1
Select inventory_id from inventory where film_id =1;
# any id between 1-8 ==> choose inventory_id = 1
Select * from staff;  
# Myke hiler is Staff_id == 1
Insert into rental(rental_date, inventory_id, customer_id, staff_id)
Values(curdate(),1,130,1);
select * from rental where customer_id = 130 and inventory_id = 1;

#9
select * from customer where active =0;
drop table if exists deleted_users;
create TABLE deleted_users(
customer_id int UNIQUE NOT NULL,
email varchar(255) UNIQUE NOT NULL,
delete_date date);
insert into deleted_users
select customer_id, email, curdate() from customer where active=0;
select * from deleted_users;
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;
delete from customer where active = 0;
select * from customer where active =0;
#0 remaining inactive users





