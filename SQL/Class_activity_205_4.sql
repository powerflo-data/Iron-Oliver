use bank;
select sum(isnull(amount)) from loan;
select (count(*)-(sum(isnull(k_symbol))+sum(k_symbol = ' '))) as Cells_with_content,
		(sum(isnull(k_symbol))+sum(k_symbol = ' ')) as Empty_or_spaces 
        from trans;
select * from trans;