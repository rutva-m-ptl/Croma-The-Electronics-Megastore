create database croma;

use croma;


-- Create the Manufacturers table first
CREATE TABLE Manufacturers (
    Manufacturer_Code INT PRIMARY KEY,
    Manufacturer_Name VARCHAR(255) NOT NULL
);

-- Create the Product Inventory table
CREATE TABLE Product_Inventory (
    Product_Code INT PRIMARY KEY,
    Product_Name VARCHAR(255) NOT NULL,
    Product_Price INT,
    Manufacturer_Code INT,
    FOREIGN KEY (Manufacturer_Code) REFERENCES Manufacturers(Manufacturer_Code)
);

select * from Manufacturers;
select * from Product_Inventory;

-- 1. Select the names of all the products in the inventory.
SELECT Product_Name FROM Product_Inventory;

-- 2. Select the names and the prices of all the products in the inventory.
SELECT Product_Name, Product_Price FROM Product_Inventory;

-- 3. Use an Alias "Name" and print all the product names
SELECT Product_Name AS Name FROM Product_Inventory;

-- 4. Select the name of the products with a price less than or equal to 8000 Indian Rupees.
SELECT Product_Name FROM Product_Inventory WHERE Product_Price <= 8000;

-- 5. Select all the products with a price between 2000 and 10000 Indian Rupees.
SELECT * FROM Product_Inventory WHERE Product_Price BETWEEN 2000 AND 10000;

-- 6. List the details of all such products whose manufacturer_code is 6.
SELECT * FROM Product_Inventory WHERE Manufacturer_Code = 6;

-- 7. List the details of all such products whose manufacturer_code is 6 as well as their price is greater than 5000.
SELECT * FROM Product_Inventory WHERE Manufacturer_Code = 6 AND Product_Price > 5000;

-- 8. List the details of all such products other than whose manufacturer_code is 6.
SELECT * FROM Product_Inventory WHERE Manufacturer_Code <> 6;

-- 9. Select the name of the products whose name starts with 'M'.
SELECT Product_Name FROM Product_Inventory WHERE Product_Name LIKE 'M%';

-- 10. List the name of products whose name starts with "M" and ends with "D".
SELECT Product_Name FROM Product_Inventory WHERE Product_Name LIKE 'M%D';

-- 11. List the name of products which starts from "M" ends with "D" but also has ONLY 9 characters in between. (Total 11 chars)
SELECT Product_Name FROM Product_Inventory WHERE Product_Name LIKE 'M_________D';

-- 12. Concatenate name of the product with its price in a single column.
SELECT CONCAT(Product_Name, ' - ', Product_Price) AS Product_Detail FROM Product_Inventory;

-- 13. Select the name and price in dollars (i.e. the price must be divided by 80.)
SELECT Product_Name, (Product_Price / 80) AS Price_In_Dollars FROM Product_Inventory;

-- 14. Compute the average price of all the products in Indian Rupees.
SELECT AVG(Product_Price) FROM Product_Inventory;

-- 15. Compute the average price of all products with manufacturer code equal to 3.
SELECT AVG(Product_Price) FROM Product_Inventory WHERE Manufacturer_Code = 3;

-- 16. What is the total cost of products where manufacturer_code is 2?
SELECT SUM(Product_Price) FROM Product_Inventory WHERE Manufacturer_Code = 2;

-- 17. Compute the number of products with a price greater than or equal to 5000.
SELECT COUNT(*) FROM Product_Inventory WHERE Product_Price >= 5000;

-- 18. Select the name and price of all products (>= 5000) sorted by price (desc) then name (asc).
SELECT Product_Name, Product_Price 
FROM Product_Inventory 
WHERE Product_Price >= 5000 
ORDER BY Product_Price DESC, Product_Name ASC;

-- 19. Select all data from inventory, including all data for each product's manufacturer.
SELECT * FROM Product_Inventory 
JOIN Manufacturers ON Product_Inventory.Manufacturer_Code = Manufacturers.Manufacturer_Code;

-- 20. Select the product name, price, and manufacturer name of all the products.
SELECT p.Product_Name, p.Product_Price, m.Manufacturer_Name 
FROM Product_Inventory p 
JOIN Manufacturers m ON p.Manufacturer_Code = m.Manufacturer_Code;

-- 21. Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT Manufacturer_Code, AVG(Product_Price) FROM Product_Inventory GROUP BY Manufacturer_Code;

-- 22. Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT m.Manufacturer_Name, AVG(p.Product_Price) 
FROM Product_Inventory p 
JOIN Manufacturers m ON p.Manufacturer_Code = m.Manufacturer_Code 
GROUP BY m.Manufacturer_Name;

-- 23. Select the names of manufacturer whose products have an average price greater than or equal to 5000.
SELECT m.Manufacturer_Name 
FROM Manufacturers m 
JOIN Product_Inventory p ON m.Manufacturer_Code = p.Manufacturer_Code 
GROUP BY m.Manufacturer_Name 
HAVING AVG(p.Product_Price) >= 5000;

-- 24. Select the name and price of the cheapest product.
SELECT Product_Name, Product_Price FROM Product_Inventory ORDER BY Product_Price ASC LIMIT 1;

-- 25. Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT m.Manufacturer_Name, p.Product_Name, p.Product_Price
FROM Manufacturers m
JOIN Product_Inventory p ON m.Manufacturer_Code = p.Manufacturer_Code
WHERE p.Product_Price = (SELECT MAX(Product_Price) FROM Product_Inventory WHERE Manufacturer_Code = m.Manufacturer_Code);

-- 26. Add a new product: Speaker with a price 1000 INR and manufacturer code 10.
INSERT INTO Product_Inventory (Product_Code, Product_Name, Product_Price, Manufacturer_Code) 
VALUES (21, 'Speaker', 1000, 10);

-- 27. Update the name of the product "Speakers" to "Wired Speakers".
UPDATE Product_Inventory SET Product_Name = 'Wired Speakers' WHERE Product_Name = 'Bluetooth Speakers';

-- 28. Apply a 10% discount to all products.
UPDATE Product_Inventory SET Product_Price = Product_Price * 0.9;

-- 29. Apply a 10% discount to all products with a price greater than or equal to 5000.
UPDATE Product_Inventory SET Product_Price = Product_Price * 0.9 WHERE Product_Price >= 5000;

-- 30. List the name of products along with manufacturer name and price arranged as per price.
SELECT p.Product_Name, m.Manufacturer_Name, p.Product_Price 
FROM Product_Inventory p 
JOIN Manufacturers m ON p.Manufacturer_Code = m.Manufacturer_Code 
ORDER BY p.Product_Price ASC;