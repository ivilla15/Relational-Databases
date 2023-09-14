/*Q1*/
SELECT MAX(LengthSeconds)
FROM Tracks 
WHERE RealAud IN (SELECT Genre  
					FROM Titles  
                    WHERE Genre = 'metal');

/*Q2*/
SELECT ArtistID, ArtistName, EntryDate 
FROM Artists 
WHERE EntryDate < ALL (SELECT MIN(EntryDate) 
					FROM Artists 
                    WHERE LeadSource = 'DirectMail');

/*Q3*/
SELECT ArtistID, ArtistName, EntryDate 
FROM Artists 
WHERE EntryDate < ALL (SELECT MAX(EntryDate)
					FROM Artists 
                    WHERE LeadSource = 'DirectMail');
                    
/*Q4*/
SELECT ArtistName, EntryDate
FROM Artists
WHERE EntryDate <= ALL (SELECT MIN(EntryDate)
					FROM Artists);

/*Q5*/
SELECT Title
FROM Titles
WHERE Genre = ALL (SELECT Genre 
					FROM Titles 
                    WHERE Genre = 'alternative');

/*Q6*/
SELECT Genre
FROM Genre
WHERE Genre NOT IN (SELECT Genre
					FROM Titles);


#Q1
Select MAX(LengthSeconds)
From Tracks
Where RealAud=1 AND TitleID=(Select TitleID From Titles Where TitleID=3);
#Q9
Select FirstName, LastName, Birthday
From Members
Where Birthday <= ALL (Select Birthday From Members);
#Q10
Select FirstName, LastName, Birthday
From Members
Where Birthday<=ALL(Select Birthday From Members Where Birthday>(Select MIN(Birthday) From Members)) AND( Birthday<>(Select MIN(Birthday) From Members));
#Q11
Select Title, TrackTitle
From Titles, Tracks 
Where Titles.titleID = Tracks.titleID AND StudioID=1;
#Q12
Select Title, StudioName
From Titles t, Studios s
Where t.StudioID=s.StudioID;
#Q13
Select s.FirstName, s.LastName
From Members m, SalesPeople s
Where m.SalesID=s.SalesID AND m.LastName='Alvarez';
#Q14
Select m.FirstName, m.LastName, s.FirstName, s.LastName
From Members m, SalesPeople s
Where m.SalesID=s.SalesID AND Region='CA';

                    
