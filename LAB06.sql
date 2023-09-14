#Q1
Select ArtistName From Artists A
Where Exists
	(Select ArtistID, Count(TitleID)
     From Titles t
     Where t.ArtistID=A.ArtistID
     Group by ArtistID
     HAVING Count(TitleID<1));
#Q2
Select StudioName As Name, WebAddress
From Studios
Where WebAddress is not null
Union
Select ArtistName as Name, WebAddress
From Artists
Where WebAddress is not null;
#Q3
Select 'Total' As Type, Count(MemberID) As 'Count'
From Members
Union
Select 'Males', Count(Gender) As 'Count'
From Members Where Gender='M'
Union
Select 'Females', Count(Gender) As 'Count'
From Members Where Gender='F';
#Q4
Select 'Total' As Type, Count(ArtistID) As 'Count'
From Artists
Union
Select 'Year: 2003', Count(EntryDate) As 'Count'
From Artists Where EntryDate Like'%2003%'
Union
Select 'Year: 2002', Count(EntryDate) As 'Count'
From Artists Where EntryDate Like '%2002%';
#Q5
Select TitleID, (Select Count(MP3) From Tracks t Where ti.TitleID=t.TitleID) AS 'Count of Sound Files'
From Titles ti;
#Q6
Select TitleID, TrackTitle As 'Track Title', 
(LengthSeconds) As 'Length Seconds', 
(Select AVG(LengthSeconds) From Tracks Where titleID=1)As 'Average',
(LengthSeconds-(Select AVG(LengthSeconds) From Tracks Where titleID=1))As 'Difference'
From Tracks ti
Where ti.TitleID=1;
#7
SELECT TitleID,TrackNum, TrackTitle,LengthSeconds, 
(SELECT AVG(LengthSeconds) 
FROM Tracks T
WHERE T.TitleID = TR.TitleID)
AS 'Average Seconds', 
LengthSeconds - (SELECT AVG(LengthSeconds) 
FROM Tracks T
WHERE T.TitleID = TR.TitleID) AS 'Difference'
FROM Tracks TR;

#8
SELECT T.TitleID, TrackTitle,TrackNum, LengthSeconds, LengthSeconds- 'AVG'
FROM Tracks T INNER JOIN(SELECT TR.TitleID, AVG(LengthSeconds) AS 'AVG' 
FROM Tracks TR
Group BY TitleID) AS D
ON T.TitleID = D.TitleID 
ORDER BY TitleID, TrackNum;

#Q9
SELECT Title, TrackNum AS 'Number of Tracks', LengthSeconds/60 AS 'Total Time'
FROM Tracks TR,Titles T
WHERE TR.TitleID = T.TitleID;

#Q10
SELECT Region AS 'Area Code', COUNT(*) AS 'Count of Phone Numbers' 
FROM(SELECT Region,HomePhone FROM Members
    UNION
    SELECT Region,Phone FROM Studios)
GROUP BY Region;
#Q11
Select 0 as p, A.ArtistName AS Art, Concat_ws(' ', M.FirstName, M.LastName) AS MName
From (Artists A Left JOIN XrefArtistsMembers X on A.ArtistID=X.ArtistID) 
LEFT JOIN Members M ON M.MemberID=X.MemberID
Union
Select X.ArtistID, A.ArtistName, COUNT(M.MemberID)
From Members M INNER JOIN XrefArtistsMembers X INNER JOIN Artists A
on X.MemberID=M.MemberID AND A.ArtistID= X.ArtistID
Group by X.ArtistID, A.ArtistName
Order by Art, p;
#Q12
Select Genre FROM Genre g
Where Not Exists
	(Select Genre, Count(TitleID)
    From Titles t
    Where g.Genre=t.Genre
    Group By TitleID
    Having Count(TitleID)>0);

#Q13
Select Distinct A.ArtistID, A.ArtistName
From Artists A INNER JOIN
	(Select ArtistID
		From Members M INNER JOIN
						XrefArtistsMembers X
						On M.MemberId = X.MemberID
					Where M.Region<>'USA')SC
			ON A.ArtistID=SC.ArtistID;
