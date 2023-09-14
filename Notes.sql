CREATE TABLE Announcements(
    a_id INT PRIMARY KEY auto_increment,
    message varchar(100) NOT NULL,
    a_time DATETIME
);
# Q1 Report the number of products for each category

# Q2 Report the number of products per brand

# Q3 List the categories of products (no duplicates)

# Q4 Report the brand(s) with the most number of Products

# Q4 Name the least expensive item 

# Q5 List the phone(s) you would call to order Nintendo products 

# Q6 List the products not in stock anywhere

# Q7 For each category report names of products. Output should be sorted.

# Q8 The NY warehouse will now offer the PS Vita. Add a new entry to the Inventory table with 50 stock and TODAY's date.
# NOTE: Your insert query should not hard-code the w_id or p_id. 

# Q9  Create a VIEW that reports product names and whether the item is in-stock or not
# Output format
-- Product         in-Stock
-- Pname1             Yes
-- Pname2             No
-- Pname3             Yes
-- ...                ...

# Q10 Create a trigger to report when a product stock is updated.
--       The trigger should add an entry to the Announcements table.
--       The message should include the product id warehouse id 
--       Note: Think of each scenario and write the message accordingly.