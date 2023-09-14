#Q1
Select Concat(u.u_first, " ", u.u_last) AS "Name",
(Select Count(s.s_id) From Subscriptions s Where s.u_id=u.u_id AND s.s_active=1 Group By(u_id))As 'Subscriptions',
(Select Count(sub.s_id)*ser.s_price From Services ser INNER JOIN Subscriptions sub Where ser.s_id=sub.s_id AND sub.u_id=u.u_id Group By (u_id))As 'Expenses'
From Users u
Order by u_id;

#Q2
Delete From Users
Where email Like "%@notabot.net" OR (f_name Like "Nota" AND l_name LIKE "Bot");

#Q3
Select s.s_name As 'Name', s.s_price As 'Price', Subs, s.s_price*Subs AS 'Revenue'
from Services s INNER JOIN (Select Count(*) AS Subs
from Subscriptions sub
Where s_active=1) sub
on s.s_id=sub.s_id
Order by s.s_id; 

#Q4
UPDATE Services S, 
Subscriptions sub, 
Users u
SET s_price = 0 AND renew_date=ADDDate(CurrDate(), INTERVAL 1 Month)
WHERE 
u.u_id=sub.u_id
AND sub.s_id=S.s_id
AND sub.s_active = '0'
AND s_name='Apple Music'
AND email LIKE '%@gmail.com';
