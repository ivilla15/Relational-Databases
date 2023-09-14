# Final Exam: 
# Write Queries to perform the following:
# Q1 Report the highest price of the product in each category. 
SELECT price, Category
FROM Products p
WHERE price>=(Select MAX(price) FROM Products pr Where p.category=pr.category)
GROUP BY Category, price;

# Q2 Report the brand of the least expensive item(s).
SELECT brand, price
FROM Products
WHERE price<=(Select MIN(price) FROM Products);

# Q3 Report the name and price of the product with the shortest name
SELECT p_name, price
FROM Products
WHERE Length(p_name)<=(SELECT Length(p_name) FROM Products);

# Q4
# Write a query to report: 
# the number of products under $1000
# the number of products from $1000 to $3000
# the number of products over $3000
# NOTE: THIS IS NOT BASED ON INVENTORY NUMBER
SELECT 'Under $1000', COUNT(*)
FROM Products
WHERE price<1000
UNION
Select '$1000-$3000', COUNT(*)
FROM Products
WHERE price>=1000 AND price<=3000
UNION
Select '$1000-$3000', COUNT(*)
FROM Products
WHERE price>3000;

# Q5 Create a view product_report
# For each product report the name, 
# total inventory available, 
# and number of orders that included this product 
# the output format should follow
# Name    Stock     OrderCount
CREATE OR REPLACE VIEW product_report AS
SELECT p_name AS Name, 
(Select SUM(total) FROM Inventory i WHERE i.p_id=p.p_id) AS Stock,
(Select SUM(quantity) FROM Orders o WHERE o.p_id=p.p_id) AS OrderCount
FROM Products p;

SELECT *
FROM product_report;

# Q6: Report the number of orders placed in the same month.
Select COUNT(*), MONTH(o_date)
FROM Orders
GROUP BY MONTH(o_date);

# Q7 List the names of products in stock (no duplicates)
SELECT DISTINCT p_name
FROM Products p
WHERE p.p_id=(Select p_id FROM Inventory i WHERE i.p_id=p.p_id AND total>0);

# Q8 Report the total revenue of completed orders (one value)
SELECT SUM(quantity*price) AS Revenue
FROM Orders o LEFT JOIN (Select price, p_id FROM Products) p
ON o.p_id=p.p_id
WHERE o_status="COMPLETE";

# Q9 Return the w_id of warehouses with NO items in stock 
# NOTE: there are two possible situations for no stock, address both
SELECT w.w_id
FROM Warehouses w LEFT JOIN Inventory i ON w.w_id=i.w_id LEFT JOIN Products p ON p.p_id=i.p_id LEFT JOIN Orders o ON p.p_id=o.p_id
WHERE total=0 OR total-quantity<=0;

# Q10 Return the warehouse phone numbers that start and end with the same number. 
# ie '100-000-0001' <- starts and ends with '1'
Select officephone
FROM Warehouses war
WHERE (Select Left(officephone, 1) FROM Warehouses w WHERE war.w_id=w.w_id)=(Select Right(officephone, 1) FROM Warehouses wa WHERE war.w_id=wa.w_id);

# Q11 Add another column to the Orders table called TrackingNumber 
# This column should accept string values
ALTER TABLE Orders
ADD TrackingNumber VARCHAR(50) NULL;

# Q12
# Continuing from the previous question
# The value of TrackingNumber should be in the sequence: 
# TRK[order id][warehouse id][product id]
# Write the query to set these values
# Sample: TRK1003011 should be the TrackingNumber for Order with id 100
INSERT INTO Orders (TrackingNumber)
	Values(CONCAT('TRK', ord_id, w_id, p_id));

# Q13 
# Create a trigger (new_product_inv) 
# that will add inventory entries after a new product is added to the products table 
# A new entry should be added for each warehouse 
# each warehouse will receive 50 of the product
# use today for the date field
# your trigger should work for any number of warehouse 

DROP TRIGGER IF EXISTS new_product_inv;
DELIMITER $$
CREATE TRIGGER new_product_inv
AFTER INSERT ON Products
FOR EACH ROW
BEGIN
	Declare warehouses INT;
    Select Count(*) INTO warehouses
    FROM Inventory;
    While (warehouses > 0) DO
	INSERT INTO Inventory(p_id, w_id, total, updated)
    VALUES(Old.total+50, CURRDATE());
    SET warehouses=warehouses-1;
    END WHILE;
END$$
DELIMITER ;

# Test query / this should successfully run with your trigger
INSERT INTO Products (p_name, category, brand, price)
    VALUES ("Pro II P Bass", "Bass", "Fender", 1749.99),
            ("Ultra P Bass", "Bass", "Fender", 2149.99);

SELECT * FROM Products;
SELECT * FROM Inventory;

# Q14 
# Create a trigger (order_valid) that will validate updates to the Orders table
# Rules
# 1) UPDATES WILL ONLY BE PERMITTED IF the current order status is 'PENDING'
# 2) The order date field cannot be changed
# Error example(s):
# "The UPDATE could not be completed due to the order status: <status>"
# "You may not change the order date from: <date1> to <date2>"
# NOTE: If the trigger signals an error then the UPDATE should not succeed
DROP TRIGGER IF EXISTS order_valid;

DELIMITER $$
CREATE TRIGGER order_valid
BEFORE UPDATE ON Orders FOR EACH ROW
BEGIN
DECLARE errorMessage VARCHAR(255);
IF OLD.o_status<>"PENDING" THEN
SET errorMessage = CONCAT('The UPDATE could not be completed due to the order status:', OLD.o_status);
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = errorMessage;
END IF;
IF NEW.o_date<>OLD.o_date THEN
SET errorMessage = CONCAT("You may not change the order date from: ", OLD.o_date, " to ", NEW.o_date);
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = errorMessage;
END IF;
END$$
DELIMITER ;


# test query / should throw error for date
UPDATE Orders
SET o_date = current_date()
WHERE p_id = 1 AND w_id = 301;


# test query / should throw error for status
UPDATE Orders
SET o_status = 'PENDING'
WHERE p_id = 3 AND w_id = 302;

SELECT * FROM Orders;


# test query / should succeed
UPDATE Orders
SET quantity = 4
WHERE p_id = 1 AND w_id = 301 AND o_date = "2023-05-05";

# Fill in/Short answer
# Q15 The result of all row combinations between two tables is called cartesian product. 
# Q16 By definition, a self join will join a table to itself using inner join type. 
# Q17 The where clause is most important when using a correlated subquery. 
# Q18 GROUP BY clause should be used to eliminate duplicates from output. (FALSE) 
# Q19 To display all fields in a table we use the * symbol.
# Q20 The best season is winter.