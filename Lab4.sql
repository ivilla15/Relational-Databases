#Q2
Select A.ArtistName
From Artists A LEFT JOIN  Titles T
ON A.ArtistID = T.ArtistID
Where A.LeadSource = 'email' AND T.ArtistID IS NULL;

#Q4
Select A.ArtistName, S.StudioID
From (Artists A LEFT join Titles t On A.artistID=t.TitleID)
				Left JOIN Studios S ON t.StudioID=S.StudioID;

#Q6
Select M.FirstName, M.LastName, Sales.FirstName AS 'Primary Contact First Name', Sales.LastName AS 'Primary Contact Last Name', Sup.FirstName AS 'Secondary Contact First Name', Sup.LastName AS 'Secondary Contact Last Name'
From (Members M Left Join SalesPeople Sales On M.SalesID=Sales.SalesID) 
				INNER JOIN SalesPeople Sup ON Sales.Supervisor=Sup.SalesID;
                
#Q7
Select Sales.FirstName, Sales.LastName
From SalesPeople Sales Left Join SalesPeople Sup
On Sales.Supervisor=Sup.SalesID
WHere Sup.SalesID IS NULL;

#Q8
Select M.FirstName, M.LastName
From (Members M Left JOIN XrefArtistsMembers Xref ON M.MemberID=Xref.MemberID)
				Left JOIN Artists A ON Xref.ArtistID=A.ArtistID
Where A.ArtistName='Highlander';

#9
SELECT T.Title, S.StudioName, A.ArtistName, COUNT(TrackNum)
FROM (Titles T INNER JOIN Studios S ON T.StudioID = S.StudioID)
 INNER JOIN Artists A ON A.ArtistID = T.ArtistID
 INNER JOIN Tracks Tr ON Tr.TitleID = T.TitleID
GROUP BY T.Title, S.StudioName, A.ArtistName; 

#Q10
SELECT G.Genre 
FROM Genre G LEFT JOIN Titles T
ON G.Genre = T.Genre
WHERE T.Genre IS NULL;

#11
SELECT G.Genre, SUM(Tr.LengthSeconds)/60
FROM (Genre G LEFT JOIN Titles T ON G.Genre = T.Genre)
LEFT JOIN Tracks Tr ON Tr.TitleID = T.TitleID
GROUP BY G.Genre;

#12
SELECT XA.RespParty, A.ArtistName, M. FirstName,M.LastName
FROM (XrefArtistsMembers XA LEFT JOIN Artists A 
ON XA.ArtistID = A.ArtistID)
INNER JOIN Members M ON M.MemberID = XA.MemberID
WHERE RespParty = 1;