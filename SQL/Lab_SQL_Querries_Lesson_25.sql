use sakila;
select * from actor where first_name = 'Scarlett' ;#1
select count(*) as available_for_rent from inventory;#2
select count(*) as amount_of_rented_movies from rental;#2
select max(length) as max_duration_minutes, min(length) as min_duratrion_minutes from film;	#3
select floor(avg(length) / 60) as hours, round(avg(length) % 60) as minutes from film;    #4
select count(distinct last_name) from actor;#5
select Datediff(max(rental_date), min(rental_date)) as active_operating_days from rental;#6
select 	*, date_format(rental_date, '%M') as month, date_format(rental_date, '%W') as weekday from rental limit 20;#7
select *, case when date_format(rental_date, '%W') in ('Saturday','Sunday') then 'weekend' else 'workday' end as day_type from rental;#8
select max(rental_date) from rental; # february is the last months of activity
select *,date_format(rental_date, '%M') as Month_, date_format(rental_date, '%Y') as Year_ from rental having Month_ = 'February' and Year_ = 2006;#9
