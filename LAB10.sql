#Q1
CREATE TABLE Members_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    memberID INT(11) NOT NULL,
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(25) DEFAULT 'UPDATE'
);

DROP TRIGGER IF EXISTS before_member_update;
DELIMITER //
CREATE TRIGGER before_member_update
BEFORE UPDATE ON Members
FOR EACH ROW
BEGIN
INSERT INTO Members_audit (memberID, firstname, lastname, changedate)
Values (OLD.Member.ID, OLD.firstname, OLD.lastname, NOW());
END;
//
DELIMITER ;

#Q2
DROP TABLE IF EXISTS Titles_Total;
CREATE TABLE Titles_Total(
    id INT AUTO_INCREMENT PRIMARY KEY,
    ArtistID INT(11) NOT NULL,
    total INT NOT NULL,
    action VARCHAR(25) DEFAULT 'INSERT'
);
INSERT INTO Titles_Total(ArtistID, total)
SELECT ArtistID, count(*)
FROM Titles
GROUP BY ArtistID;

DELIMITER //
CREATE TRIGGER before_titles_insert
BEFORE INSERT ON Titles FOR EACH ROW
BEGIN
DECLARE rowcount INT;
SELECT COUNT(*) INTO rowcount
FROM TITLES
WHERE ArtistID = new.ArtistID;
IF rowcount > 0 THEN 
UPDATE Titles_Total
SET total = rowcount + 1
WHERE ArtistID = new.ArtistID;
ELSE
INSERT INTO Titles_Total(ArtistID, total) VALUES(new.ArtistID, 1);
END IF;
END //
DELIMITER ;
#Test Q2
INSERT INTO Titles
VALUES (100, 3, 'title', 3, '1111111111', 'jazz');

#Q3

CREATE TABLE Artist_Welcome(
    id INT AUTO_INCREMENT primary key,
    artistName TEXT,
    message TEXT NOT NULL,
);

DROP TABLE IF EXISTS Artist_Welcome;
DROP TRIGGER after_artists_insert

Delimiter $$
CREATE TRIGGER after_artists_insert
AFTER INSERT ON Artists
FOR EACH ROW
INSERT INTO Artist_Welcome
SET
	id = new.ArtistID,
    artistName = new.ARtistName,
    message = CASE WHEN new.WebAddress IS NULL
				THEN CONCATE('Welcome ', new.ArtistName, '. Please do not forget to provide your web address!')
			ELSE
				CONCAT("Welcome ", new.ArtistName)
			END;
$$
Delimiter ; 

#Test Q3
INSERT INTO Artists(artistID, ArtistName, City, Region, WebAddress, EntryDate, LeadSource)
VALUES(73, 'bread2', 'sd', 'ca', 'ww.sdas.com', '2003-05-14', 'anywho');
INSERT INTO Artists(artistID, ArtistName, City, Region, WebAddress, EntryDate, LeadSource)
VALUES(43, 'bread', 'sd', 'ca', 'ww.sdas.com', '2003-05-14', 'anywho');
INSERT INTO Artist(artistID, ArtistNmae, City, Region, EntryDate, LeadSource)
Values (30, 'Test2', 'sd', 'ca', '2003-05-14', 'anywho');
INSERT INTO Artist(artistID, ArtistNmae, City, Region, EntryDate, LeadSource)
Values (30, 'Test1', 'sd', 'ca', '2003-05-14', 'anywho');

Select *
FROM Artist_Welcome;
