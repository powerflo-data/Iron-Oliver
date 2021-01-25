#Activity 3.01 
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;
#Activity 1
#1
use bank;
select * from district;
select d.A2, count(c.client_id) as Number_of_Clients, rank() over (order by count(c.client_id)) as 'Rank' from client c
join district d
on d.A1 = c.district_id
group by d.A2
order by Number_of_Clients DESC;

#2
select d.A2, count(c.client_id) as Number_of_Clients from client c
right join district d
on d.A1 = c.district_id
group by d.A2
order by Number_of_Clients DESC;

# there are no districts without clients, since there are no rows with any null values
select * from district
where A2 = 'Strakonice';
# ID = 20 for Strakonice

Insert into district(A1, A2)
Values(100,'Heaven');

select * from district;

UPDATE client
SET  district_id = 80
where district_id = 20;

select * from client
where district_id = 20;
#zero people

select * from client
where district_id = 100;
#multiple outputs

#3
#Spotting works with checking for Null values on right join or with the count compare of grouped client_ids by disctrict_id
# with the number of rows of district table
select d.A2, count(c.client_id) as Number_of_Clients from client c
left join district d
on d.A1 = c.district_id
group by d.A2
order by Number_of_Clients DESC;

#4
UPDATE client
SET  district_id = 20
where district_id = 80;


#Activity 4
#1
select d.A2 as District, d.A3 as Region, c.client_id as Client_Id from client c
join district d
on c.district_id = d.district_id
order by Region, District;


