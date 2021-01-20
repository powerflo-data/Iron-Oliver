use bank;
select * from bank.district
where a2 regexp 'ch[e-r]';
select * from trans order by type,date;
select * from trans order by k_symbol;
select trans_id from trans order by account_id;