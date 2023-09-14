#Q1
Select title_id, COUNT(*)
From Title_Authors
Group By title_id;
#Q2
Select state, COUNT(*)
From Authors
Group by state;
#Q3
Select type, COUNT(*), AVG(pages)
From Titles
Group by type;
#Q4
Select pub_id AS 'Publisher_ID', COUNT(*) AS 'Number', MIN(price)AS 'Min Price', MAX(price) AS 'Max Price', AVG(price) AS 'Average Price'
From Titles
GROUP BY pub_id
ORDER BY AVG(price) DESC;
#Q5
Select type, AVG(price)
From Titles
GROUP BY type
HAVING AVG(price)>15
ORDER BY AVG(price) DESC;
#Q6
SELECT au_fname, au_lname
From Authors
Where address LIKE '%St%';