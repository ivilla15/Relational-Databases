#Isaiah Villalobos
#Q1
Select CONCAT(firstname, ' ', lastname) AS 'Name', homephone
From Members;
#Q2
Select CONCAT(firstname, ' ', lastname) AS 'Name', DateDiff(Now(), Birthday)/365 AS Age
From Members;
#Q3
Select StudioName, Left(Contact, locate(' ', contact)-1) AS FirstName
From Studios;
#Q4
Select StudioName, Right(Contact, Length(Contact)-Locate(' ', contact)) AS LastName
From Studios;
#Q5
Select Tracktitle, Length(TrackTitle)
From Tracks
Where Length(TrackTitle)>=ALL(Select Length(TrackTitle)
								From Tracks);
#Q6
Select g.Genre, IFNULL(t.title, 'No Title') AS Title
From Genre g Left Join Titles t ON g.genre=t.genre;
#Q7
Select CONCAT(UPPER(LEFT(genre, 1)), LOWER(RIGHT(genre, Length(genre)-1))) AS 'Genre Name' 
From Genre;
#Q8
Select g.Genre,
CASE IsNull(t.title)
	When True Then 'No Title'
	When False Then t.title
    End As 'TitleName'
From Genre g Left Join Titles t ON g.genre=t.genre;
#Q9
Select ArtistName, 
Case Leadsource
	When 'Ad' Then LeadSource
    ELSE 'Not Ad'
ENd AS 'Lead'
From Artists;