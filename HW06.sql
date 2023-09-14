#Q1
Select 'A', Concat_ws(" ", au_fname, au_lname), city, state
From Authors
Union
Select 'P', pub_name, city, state
From Publishers;
#Q2
Select Type, title_name As 'Book Name'
From Titles t
Union
Select Concat( Upper(Left(type, 1)), Substring(type, 2, Length(type))," ", "Total"), Count(type) As 'Book Name'
From Titles
Group by type
Order By type;
#Q3
#Use EXISTS and correlated sub-queries.
SELECT pub_name AS 'Publisher Name', CONCAT(au_fname, ' ', au_lname) AS 'Author Name'
FROM Publishers P, Authors A
Where EXISTS (Select pub_id
				From Titles t, Title_Authors ta
                WHere t.title_id=ta.title_id AND ta.au_id=A.au_id AND t.pub_id=p.pub_id);
#Q4
#Use correlated sub-queries in the SELECT clause. 
Select type As 'Book Type', 
title_name As 'Title', 
Pages,(Select AVG(pages) From Titles t Where ti.type=t.type)As 'Average Pages',
(Pages-(Select AVG(pages) From Titles t Where ti.type=t.type))As 'Difference'
From Titles ti
Order by Type;
#Q5
#sub-queries in the FROM clause.
Select t.type As 'Book Type', title_name As 'Title',Pages,avg_page As 'Average Pages',Pages-avg_page as Difference
from Titles t INNER JOIN (Select a.type, avg(Pages) as avg_page
from Titles a
Group by a.type) a
on a.type=t.type
Order by t.Type;