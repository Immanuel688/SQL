-- Answers with query
-- 1. List all customers who have made purchases of more than $80.
SELECT orders.user_id, users.name
FROM orders
INNER JOIN users ON orders.user_id=users.user_id AND total_amount>80;

SELECT orders.user_id, users.name
FROM orders
INNER JOIN users ON orders.user_id=users.user_id 
WHERE total_amount>80;

-- 2. Retrieve all orders placed in the last 280 days along with the customer name and email.

SELECT orders.user_id, users.name , users.email
FROM orders
INNER JOIN users ON orders.user_id=users.user_id
WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 280 DAY);

SELECT orders.user_id, users.name , users.email
FROM orders
INNER JOIN users ON orders.user_id=users.user_id
WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 332 DAY);

-- 3. Find the average product price for each category.
SELECT category,avg(price) AS avg_price FROM products GROUP BY category;

-- 4. List all customers who have purchased a product from the category Electronics. 

SELECT product_id
FROM products
Where category ='electronics';


SELECT users.name
FROM products
INNER JOIN orderdetails ON products.product_id = orderdetails.product_id
INNER JOIN orders ON orderdetails.order_id=orders.order_id
INNER JOIN users ON orders.user_id= users.user_id
WHERE category = 'electronics';

SELECT users.name
FROM users
INNER JOIN orders on orders.user_id= users.user_id
INNER JOIN orderdetails ON orders.order_id=orderdetails.order_id
INNER JOIN products ON orderdetails.product_id = products.product_id
WHERE category = 'electronics';

SELECT DISTINCT users.name
FROM users
INNER JOIN orders on orders.user_id= users.user_id
INNER JOIN orderdetails ON orders.order_id=orderdetails.order_id
INNER JOIN products ON orderdetails.product_id = products.product_id
WHERE category = 'electronics';

SELECT DISTINCT users.name,email
FROM products
INNER JOIN orderdetails ON products.product_id = orderdetails.product_id AND category = 'electronics'  -- Filter here!
INNER JOIN orders ON orderdetails.order_id = orders.order_id
INNER JOIN users ON orders.user_id = users.user_id;

SELECT DISTINCT U.name, U.email
FROM Users U
JOIN Orders O ON U.user_id = O.user_id
JOIN OrderDetails OD ON O.order_id = OD.order_id
JOIN Products P ON OD.product_id = P.product_id
WHERE P.category = 'Electronics';

-- 5.Find the total number of products sold and the total revenue generated for each product.
SELECT sum(quantity) AS number_of_products_sold
FROM orderdetails;

SELECT sum(od.quantity) as quantity, p.name
FROM orderdetails od
LEFT JOIN products p ON od.product_id=p.product_id
GROUP BY p.name;

SELECT 
    p.product_id,
    p.name,
    SUM(od.quantity) as total_ordered
FROM orderdetails od
LEFT JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_ordered DESC;


SELECT p.name , od.quantity , SUM(p.price * od.quantity)-- , sum(od.quantity) , sum(p.price)
FROM orderdetails od 
INNER JOIN  products p ON od.product_id=p.product_id
GROUP BY p.name, od.quantity;

SELECT p.name,
SUM(p.price * od.quantity) AS total_revenue,  -- Fixed: Multiply price by quantity
SUM(od.quantity) AS total_quantity_sold
FROM orderdetails od 
INNER JOIN products p ON od.product_id = p.product_id
GROUP BY p.name;

-- 6. Update the price of all products in the Books category, increasing it by 10%.
SET SQL_SAFE_UPDATE= 0;

UPDATE products
SET price= price+(price/10) -- OR PRICE=PRICE* 1.1
WHERE category='books';

UPDATE products
SET price = 129.99
WHERE category = 'books';

-- 7. Remove all orders that were placed before 2020.
DELETE FROM orders
WHERE order_date < '2020-01-01';

-- 8.Write a query to fetch the order details, including customer name, product name, and quantity, for orders placed on 2024-05-01.
SELECT orders.order_id, orders.user_id, orderdetails.quantity, products.name, users.name
FROM orders
INNER JOIN orderdetails ON orders.order_id=orderdetails.order_id AND order_date = '2024-05-01'
INNER JOIN products ON orderdetails.product_id=products.product_id
INNER JOIN users ON orders.user_id= users.user_id;

-- 9. Fetch all customers and the total number of orders they have placed.
SELECT count(orderdetails.order_id) AS order_per_customer , users.name
FROM orders
INNER JOIN orderdetails ON orders.order_id=orderdetails.order_id
right JOIN users ON orders.user_id=users.user_id
GROUP BY users.name ;

SELECT count(orderdetails.order_id) AS order_per_customer , users.name
FROM orders
RIGHT JOIN orderdetails ON orders.order_id=orderdetails.order_id
RIGHT JOIN users ON orders.user_id=users.user_id
GROUP BY users.name ;

-- THE below qury gives only the list of customers who ordered but we have to fetch all customers so above query is right
SELECT count(orderdetails.order_id) AS order_per_customer , users.name
FROM orders
INNER JOIN orderdetails ON orders.order_id=orderdetails.order_id
INNER JOIN users ON orders.user_id=users.user_id
GROUP BY users.name ;

SELECT 
    U.name AS customer_name, 
    U.email, 
    COUNT(O.order_id) AS total_orders
FROM 
    Users U
LEFT JOIN 
    Orders O ON U.user_id = O.user_id
GROUP BY 
    U.user_id;

-- 10. Retrieve the average rating for all products in the Electronics category
-- SELECT AVG(rating) AS Avg_Rating FROM products WHERE category='electronics'

-- 11. List all customers who purchased more than 1 units of any product, including the product name and total quantity purchased.
SELECT  users.name AS customer_name , sum(orderdetails.quantity) AS total_quantity ,  products.name AS product
FROM orders
INNER JOIN users ON orders.user_id= users.user_id
INNER JOIN orderdetails ON orders.order_id=orderdetails.order_id
INNER JOIN products ON orderdetails.product_id=products.product_id
GROUP BY users.name,products.name
having total_quantity> 1;

-- in having clause you can use only grouped or aggregate columns and it should always be used after group by

-- 12. Find the total revenue generated by each category along with the category name.
SELECT category , price -- , sum(price) -- , sum(products.price), quantity
FROM orderdetails
JOIN products ON orderdetails.product_id=products.product_id WHERE category ='electronics';

SELECT category , sum(price*quantity) AS revenue 
FROM orderdetails
JOIN products ON orderdetails.product_id=products.product_id WHERE category ='electronics'
GROUP BY category;

SELECT category , sum(price*quantity) AS revenue 
FROM orderdetails
JOIN products ON orderdetails.product_id=products.product_id
GROUP BY category;

SELECT category , sum(price*quantity) AS revenue 
FROM orderdetails
JOIN products ON orderdetails.product_id=products.product_id
GROUP BY category
HAVING revenue> 130; -- SIMPLY INCLUDING HAVING CLAUSE FOR FURTHER FILTERING