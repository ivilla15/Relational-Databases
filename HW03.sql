#Q1
Select title_name, type
From Titles
Where Price> ALL(Select Price From Titles Where type='history');
#Q2
Select t.title_id, t.au_id
From Title_Authors t, Authors a
Where t.au_id=a.au_id AND a.au_lname='Hull';
#Q3
Select au_fname, au_lname
From Authors
Where au_id<> All(Select au_id From Title_Authors);
#Q4
Select Distinct(au_id)
From Title_Authors a, Titles t
Where a.title_id=t.title_id AND t.type='children';
#Q5
Select p.pub_name
From Publishers p INNER JOIN Titles t
ON t.pub_id=p.pub_id
Group By t.Pub_ID
HAVING COUNT(*)>1;
#Q6
Select t.title_name, t.type
From Titles t, Royalties r
Where t.title_id=r.title_id AND r.royalty_rate<= (Select MIN(royalty_rate) From Royalties);
#Q7
Select pub_id
From Titles
Where price<= (Select MIN(price) From Titles);
#Q8
Select p.pub_name
From Publishers p, Titles t
Where t.pub_id=p.pub_id AND t.pages>= (Select Max(pages) From Titles);