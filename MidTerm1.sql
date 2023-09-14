#Q1
Select brand, Count(brand)
From Products
Group by brand;
#Q2
Select p_id, p_name
From Products
Where (p_name LIKE '%n%' AND p_name LIKE '%s%');
#Q3
Select p_name
From Products
Where p_id NOT IN (Select p_id From Inventory);
#Q4
Select W.w_id, W.officephone
From (Warehouses W Inner JOIN Inventory I ON W.w_id=I.w_id)
		INNER JOIN Products P on I.p_id=P.p_id
Where P.category='handheld';
#Q5
Select P.p_name AS 'Product Name', count(W.w_id) AS 'Locations'
FROM (Products P LEFT JOIN Inventory I ON P.p_id=I.p_id)
		LEFT JOIN Warehouses W ON I.w_id=W.w_id
GROUP BY P.p_id;
#Q6
Select W.state AS 'Location', SUM(I.total) AS 'Inventory Size'
FROM Warehouses W INNER JOIN Inventory I ON W.w_id=I.w_id
Group By W.w_id;
#Q7
Select DISTINCT W.officephone
FROM (Warehouses W INNER JOIN Inventory I ON W.w_id=I.w_id)
		INNER JOIN Products P ON P.p_id=I.p_id
Where P.brand='Microsoft';
#Q8
Select W.w_id, SUM(I.total)
FROM (Warehouses W INNER JOIN Inventory I ON W.w_id=I.w_id)
		INNER JOIN Products P ON P.p_id=I.p_id
WHERE P.brand='Sony'
GROUP BY W.w_id;
