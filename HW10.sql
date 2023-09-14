#Q1

DROP TABLE IF EXISTS Publisher_Total;
CREATE TABLE Publisher_Total (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pub_id char(3) NOT NULL,
    total INT NOT NULL,
    action VARCHAR(25) DEFAULT 'INSERT'
);

INSERT INTO Publisher_Total (pub_id, total)
SELECT pub_id, count(*)
FROM Titles
GROUP BY pub_id;

DROP TRIGGER before_titles_insert;

DELIMITER //
CREATE TRIGGER before_titles_insert
BEFORE INSERT ON Titles FOR EACH ROW
BEGIN
DECLARE rowcount INT;
SELECT COUNT(*) INTO rowcount
FROM Titles
WHERE pub_ID = new.pub_ID;
IF rowcount > 0 THEN 
UPDATE Publisher_Total
SET total = rowcount + 1
WHERE pub_ID = new.pub_ID;
ELSE
INSERT INTO Publisher_Total(pub_ID, total) VALUES(new.pub_ID, 1);
END IF;
END //
DELIMITER ;

#Test Q1

INSERT INTO Titles
VALUES ('T14', 'title','type', 'P05', '100', 50, 900, '2023-004-27', 1);

SELECT *
FROM Publisher_Total;

#Q2

DROP TABLE IF EXISTS Author_Message;
CREATE TABLE Author_Message(
    id INT AUTO_INCREMENT primary key,
    au_id char(3) NOT NULL,
    message TEXT NOT NULL
);

DROP TRIGGER after_title_author_insert;

Delimiter $$
CREATE TRIGGER after_title_author_insert
AFTER INSERT ON Title_Authors
FOR EACH ROW
INSERT INTO Author_Message
SET
	au_id = new.au_id,
    message = CASE WHEN new.royalty_share < 0.5
				THEN CONCAT(new.au_id, ' your royalty share is low')
			ELSE
				CONCAT(new.au_id, ' your royalty share is high')
			END;
$$
Delimiter ; 

#Q2 Test

INSERT INTO Title_Authors (title_id, au_id, au_order, royalty_share)
Values('T14', 'A07', 3, 0.4);
INSERT INTO Title_Authors (title_id, au_id, au_order, royalty_share)
Values('T15', 'A08', 2, 1);

Select *
From Author_Message;