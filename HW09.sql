#Q1
CREATE VIEW authors_without_books AS
SELECT a.au_id, a.au_fame, a.au_lname
FROM Authors a
LEFT JOIN Title_Authors ta ON a.au_id = ta.au_id
WHERE ta.au_id IS NULL;

#Q2
CREATE VIEW AuthorRoyalties AS
Select DISTINCT Concat(au_fname, ' ', au_lname) AS 'Full Name',
					title_name, royalty_rate
From Authors INNER JOIN Title_Authors
ON Authors.au_id = Title_Authors.au_id
INNER JOIN Royalties ON title_Authors.title_id = Royalties.title_id
INNER JOIN Titles ON Royalties.title_id = Titles.title_id;

#Q3
CREATE OR REPLACE VIEW CheapestPublisher AS
SELECT pub_name
FROM Publishers
WHERE pub_id IN(Select pub_id
FROM Titles
WHERE title_id IN (SELECT title_id
From Royalties
WHERE royalty_rate = (SELECT MIN(royalty_rate) From Royalties)));

#Q4 Homework
CREATE OR REPLACE VIEW NewView AS
SELECT *
FROM Titles
WHERE price >18
WITH CHECK OPTION;

#Q5
CREATE OR REPLACE VIEW NewView AS
SELECT *
FROM Titles
WHERE price > 20
WITH CHECK OPTION;