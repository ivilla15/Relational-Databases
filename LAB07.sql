#Q1
Insert INTO Artists
(ArtistID, ArtistName, City, Region, Country, WebAddress, EntryDate, LeadSource)
Values (12, 'November', 'New Orleans', 'LA', 'USA', 'www.november.com', CurDate(), 'Directmail');
#Q2
INSERT INTO Tracks
(TitleID, TrackNum, TrackTitle, LengthSeconds, MP3, RealAud)
Values (4, 11, 'Spring', 150, 1, 0);
#Q3
Create Table Members2(
MemberID int ,
FirstName varchar (25) NULL ,
LastName varchar (25) NULL ,
Address varchar (60) NULL ,
City varchar (25) NULL ,
Region varchar (15) NULL ,
PostalCode varchar (10) NULL ,
Country varchar (20) NULL ,
HomePhone varchar (16) NULL ,
WorkPhone varchar (16) NULL ,
EMail varchar (40) NULL ,
Gender char (1) NULL ,
Birthday date NULL ,
SalesID smallint NULL 
);
#Q4
Insert into Members2
Select *
From Members;
#Q5
Update Members2 
Set HomePhone=Concat('899', right(HomePhone, 7))
WHERE Region='OH' AND City='Columbus' AND HomePhone Like '277%';

Update Members2 
Set WorkPhone=Concat('899', right(WorkPhone, 7))
WHERE Region='OH' AND City='Columbus' AND WorkPhone Like '277%';
#Q6
Update Members2
Set SalesID=2
Where salesID=(Select salesID
			  FROM SalesPeople
              Where FirstName='Bob' AND Lastname='Bentley')AND Gender='F';
#Q7
Insert Into Artists(ArtistID, ArtistName, City, Region, Country, WebAddress, EntryDate, LeadSource)
Select 12, 'Doug and Terry', m.City, m.Region, m.Country, NULL, curdate(), NULL
From Members m
Where m.FirstName='Doug' AND m.LastName='Finney';
#Q8
INSERT INTO XrefArtistsMembers(MemberID, ArtistID, RespParty)
(Select MemberID, 13, 1 From Members Where FirstName='Doug' AND LastName='Finney');
INSERT INTO XrefArtistsMembers(MemberID, ArtistID, RespParty)
(Select MemberID, 13, 0 From Members Where FirstName='Terry' AND LastName='Irving');
#Q9
UPDATE Artists
Set WebAddress=Concat('www.lyricmusic.com/', ArtistID)
Where WebAddress IS NULL;
#Q10
Delete From Members2
Where MemberID IN (Select MemberID
					From XrefArtistsMembers X INNER JOIN Artists A ON X.ArtistID=A.ArtistID
                    Where ArtistName='Sonata');
#Q11
Alter Table Members2
Add name Varchar(50)null,
Drop FirstName, Drop LastName;
#Q12
Drop Table if exists Members2;
show tables;