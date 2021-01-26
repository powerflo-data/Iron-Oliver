#Lab 3.04
use test;

select * from customer;

# Query 1
select ID, LAST_NAME, FIRST_NAME,  (CHAR_LENGTH(LAST_NAME) + CHAR_LENGTH(FIRST_NAME)) as Name_lengths from customer
where CHAR_LENGTH(LAST_NAME) + CHAR_LENGTH(FIRST_NAME) < 12
order by Name_lengths, LAST_NAME, FIRST_NAME, ID ASC;

#2 Query 2