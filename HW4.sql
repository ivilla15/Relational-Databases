#Q1
Select a.au_fname, a.au_lname, ti.title_name
From (Authors a LEFT JOIN Title_Authors t ON a.au_id=t.au_id)
				LEFT JOIN Titles ti ON ti.title_id=t.title_ID;
                
#Q2
Select a.au_fname, a.au_lname, count(ti.title_id)
From (Authors a LEFT JOIN Title_Authors t ON a.au_id=t.au_id)
				LEFT JOIN Titles ti ON ti.title_id=t.title_ID
Group By a.au_id;

#Q3
Select a.au_fname, a.au_lname, r.royalty_rate
From (Authors a LEFT JOIN Title_Authors t ON a.au_id=t.au_id)
				LEFT JOIN Titles ti ON ti.title_id=t.title_ID
                LEFT JOIN Royalties r ON r.title_id=ti.title_id
WHERE (Select count(title_id) FROM Titles)>1;
#Q4
Select p.pub_name
From (Publishers p LEFT JOIN Titles t ON p.pub_id=t.pub_id)
				LEFT JOIN Royalties r ON t.title_id=r.title_id
Where r.royalty_rate= (Select MAX(royalty_rate) From Royalties);
#Q5
Select t.title_name, a.au_fname, a.au_lname, p.pub_name
From ((Titles t Left JOIN Title_Authors ta ON t.title_id=ta.title_id)
				Left Join Authors a ON ta.au_id=a.au_id)
                Left JOIN Publishers p ON p.pub_id=t.pub_id
Where pubdate=(Select MAX(pubdate) From Titles);
#Q6
Select p.pub_name, count(t.title_id), MAX(t.price)
From Publishers p LEFT JOIN Titles t ON p.pub_id=t.pub_id
Group by p.pub_id;
#Q7
Select t.title_name, a.au_fname, a.au_lname, p.pub_name
From ((Titles t LEFT JOIN Title_Authors ta ON t.title_id=ta.title_id)
				Left jOIN Authors a ON a.au_id=ta.au_id)Left JOIN Publishers p ON p.pub_id=t.pub_id;
#Q8
Select t.title_name, a.au_fname, a.au_lname
From (Authors a LEFT JOIN Title_Authors ta ON a.au_id=ta.au_id)
				Left JOIN Titles t ON ta.title_id=t.title_id
Where pages=(Select MAX(pages) From Titles);