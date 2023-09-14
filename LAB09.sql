#Q1
CREATE OR REPLACE VIEW NumberofArtists AS
SELECT YEAR(EntryDate), COUNT(ArtistID)
From Artists
GROUP BY YEAR(EntryDate);

#Q2
CREATE OR REPLACE VIEW ArtistsNotInUSA AS
SELECT DISTINCT A.ArtistID, A.ArtistName
FROM Artists A INNER JOIN XrefArtistsMembers X INNER JOIN Members M
ON A.ArtistID = X.ArtistID AND X.MemberID = M.MemberID
WHERE NOT M.Country = "USA";

#Q3
CREATE OR REPLACE VIEW ArtistsNotInUSA AS
SELECT DISTINCT ArtistName, WebAddress
FROM Artists A, Members M, XrefArtistsMembers X
WHERE A.ArtistID = X.ArtistID AND 
M.MemberID NOT IN (Select MemberID From Members Where Country = "USA");

#Q4
CREATE OR REPLACE VIEW ArtistTitle AS
SELECT a.ArtistName, COUNT(*)
FROM Member m JOIN XrefArtistsMembers x JOIN Artists a
ON m.MemberID = x.MemberID AND x.ArtistID = a.ArtistID
Group By a.ArtistID;

#Q5
CREATE OR REPLACE VIEW longestTitlesInfo AS
SELECT  *
FROM Titles T
WHERE length(Title) >= ALL (Select length(Title)
FROM Titles);

#Q6
CREATE OR REPLACE VIEW TrackStats AS
SELECT TitleID, TrackNum, TrackTitle, LengthSeconds,
	(Select MAX(LengthSeconds) AS "Max Length"
    From Tracks t2 WHERE t2.titleID = t1.title.ID),
    LengthSeconds - (Select MAX(LengthSeconds)
    From Tracks t2 WHERE t2.titleID = t1.title.ID), "Difference From Max Length"
From Tracks t1
Order by TitleID, TrackNum;

#Q7
CREATE OR REPLACE VIEW TrackLength AS
SELECT *
FROM Tracks
WHERE LengthSeconds > 300
WITH CHECK OPTION;

#Q8
CREATE OR REPLACE VIEW TrackLength AS
Select *
From Tracks
WHERE LengthSeconds >= 280
WITH CHECK OPTION;

#Q9
RENAME TABLE TrackLength
TO NewName;

#Q10
DROP VIEW IF EXISTS ArtistsNotInUSA;
DROP VIEW IF EXISTS ArtistTitle;
DROP VIEW IF EXISTS longestTitlesInfo;