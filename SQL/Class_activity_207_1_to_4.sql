use bank;
#Activity 1
alter table loan
add status_desc varchar(30);
select * from loan;
update loan set status_desc = 
case
when status = 'A' then 'Good - Contract Finished'
when status = 'B' then 'Defaulter - Contract Finished'
when status = 'C' then 'Good - Contract Running'
when status = 'D' then 'In Debt - Contract Running'
end;
select * from loan;

#Activity 2
select avg(amount) as Average, status from bank.loan
group by Status
order by Average asc;
#Objektiv: Max/Min for each status
select max(amount) as Maximum, min(amount) as Minimum, status from bank.loan
group by Status
order by Maximum asc;

#Activity 3
#1
select count(issued) as issued_cards, type from card 
group by type;
#2
select count(client_id) as Number_of_clients, district_id from client group by district_id;
#3
select avg(amount)  as Average_trans_amount,type from trans group by type;
#4
select type, operation, k_symbol, round(avg(balance),2)
from bank.trans
group by type, operation, k_symbol
having k_symbol <> '' and k_symbol <> ' '
order by type, operation, k_symbol;

#Activity 4
#1
select count(client_id) as Number_of_clients, district_id from client
group by district_id
having Number_of_clients >=100
order by district_id;

#2
select * from trans;
select avg(amount) as Average_amount,type,operation from trans
group by type, operation
having Average_Amount >= 10000
order by Average_Amount;


