-- MIS Homework:Classic Models SQL
-- By: Kruti Naik

-- Q1: Show the product name, product line, and MSRP for the first 5 products in the products

SELECT productName, productLine, MSRP
FROM products
LIMIT 5;

-- Q2: List the customer name, city, and country of every customer in France 

SELECT customerName, city, country 
FROM customers
WHERE country = 'France';

-- Q3: Which Classic Cars products cost the company more than $80 to buy? Show the product name, buy price, and MSRP. 

SELECT productName, buyPrice, MSRP
FROM products 
WHERE productLine = 'Classic Cars'
AND buyPrice > 80; 

-- Q4: What are the 10 products with the highest MSRP? Show name, poduct line, and MSRP.

SELECT productName, productLine, MSRP
FROM products
ORDER BY MSRP DESC
LIMIT 10;

-- Q5: Find customers in the USA, France, or Australia whose company name contains "Collect". Show name, country, and credit limit, highest credit limit first.

SELECT customerName,country, creditLimit
FROM customers
WHERE country IN ('USA', 'France', 'Australia')
AND customerName LIKE '%collect%'
ORDER BY creditLimit DESC;

-- Q6.1: What are the distinct product lines in the products table?

SELECT DISTINCT productLine 
FROM products;

-- Q6.2: Which orders have never shipped? Show order number, status, and order date.

SELECT orderNumber, status, orderDate
FROM orders
WHERE shippedDate IS NULL;

-- Q7: Produce a one-row payments summary: number of payments, total amount collected, average payment (2 decimals), smallest payment, and largest payment. Give each column a readable name. 

SELECT COUNT(*)        AS    'Number_of_Payments',
SUM(amount)            AS    'Total_Amount_Collected',
ROUND (AVG(amount),2)  AS    'Average_Payment',
MIN(amount)            AS    'Smallest_Payment',
MAX(amount)            AS    'Largest_Payment'
FROM payments;

-- Q8: For each product line, show the number of products, the average buy price, and the average MSRP (both to 2 decimals), sorted by number of products, most first.

SELECT productLine,
COUNT(*)                  AS    'Number_of_Products',
ROUND (AVG(buyPrice),2)   AS    'Average_Buy_Price',
ROUND (AVG(MSRP), 2)      AS    'Average_MSRP'
FROM products 
GROUP BY productLine
ORDER BY COUNT(*) DESC;

-- Q9: Which countries have at least 5 customers? Show the country and the count, highest first.

SELECT country, COUNT(*)  AS 'Number_of_Customers' 
FROM customers
GROUP BY country
Having COUNT(*) >= 5
ORDER BY COUNT(*) DESC;

-- Q10: List every French customer with the sales rep assigned to them. Show customer name, rep first and last name, and the rep's job title, sorted by customer name. Show Name as single column instead of two

SELECT c.customerName,
CONCAT (e.firstName, ' ', e.lastName)  AS 'Sales_Rep_Name', e.jobTitle
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.country = 'France' 
ORDER BY c.customerName; 

-- Extra Credit: For products whose MSRP is above the average MSRP of all products, show the total quantity ordered and total revenue (quantityOrdered * priceEach) from orders with status 'Shipped'. Show the top 10 by revenue.



SELECT p.productCode,
p.productName,
SUM(od.quantityOrdered)                  AS      'Total_Quantity_Ordered',
SUM(od.quantityOrdered * od.priceEach)  AS      'Total_Revenue'
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o        ON od.orderNumber = o.orderNumber
WHERE p.MSRP >(SELECT AVG(MSRP) FROM products)     
AND o.status = 'Shipped'
GROUP BY p.productCode, p.productName
ORDER BY 'Total_Revenue' DESC
LIMIT 10;




 


