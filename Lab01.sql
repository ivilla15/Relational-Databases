#Isaiah Villalobos and George Melendrez
#Q1
Select title, upc, genre
From Titles;
#Q2
Select *
From Titles
Where artistid=2;
#Q3
Select firstname, lastname, homephone, email
From Members;
#Q4
Select MemberID
From Members
Where Gender="M";
#Q5
Select MemberID, country
From Members
Where Country="Canada";
#Q6
Select TitleID, TrackTitle, LengthSeconds
From Tracks
Where LengthSeconds>300 AND MP3=0;
#Q7
Select FirstName, LastName, WorkPhone
From Members
Where WorkPhone IS NOT NULL;
#Q8
Select Distinct LeadSource
From Artists;
#Q9
Select StudioName AS "Studio Name", postalcode AS "Post code", Phone
From Studios;
#Q10
Select ArtistName, EntryDate
From Artists
Where EntryDate Between '2002-01-01' AND '2002-12-31';
#Q11
Select FirstName, LastName, Base*5 AS "Weekly Salary"
From SalesPeople
Where Base*5>1000;
#Q12
Select *
From Tracks
Where TrackNum=TitleID;





