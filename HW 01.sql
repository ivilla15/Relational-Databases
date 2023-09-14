#Isaiah Villalobos
#Q1
Select *
From Publishers;
#Q2
Select pub_name
From Publishers;
#Q3
Select *
From Publishers
Where state='CA';
#Q4
Select title_name
From Titles
Where type='history';
#Q5
Select title_name, sales, pubdate
From Titles
Where pub_id= 'P01'