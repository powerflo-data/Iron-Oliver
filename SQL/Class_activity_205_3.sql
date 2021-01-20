use bank;
SELECT * from card;
SELECT card_id,date_format(convert(left(issued,6),date), '%Y') as year_issued,
date_format(convert(left(issued,6),date), '%Y %M %D') as date_issued,
date_format(convert(left(issued,6),date), '%d of %M of %D') as fecha_emision
from card where type = 'gold' order by date_issued;