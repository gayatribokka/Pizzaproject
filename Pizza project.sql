CREATE DATABASE project;
USE project;

SELECT * FROM pizzas;
SELECT * FROM orders;
SELECT * FROM pizza_types;
SELECT * FROM order_details;

--Retrieve the total number of orders placed
SELECT COUNT(DISTINCT order_id) FROM orders;

--Find different number of pizzas available
SELECT COUNT(DISTINCT name) FROM pizza_types;

--Show pizza_id,price,size where size = 'M'
SELECT pizza_id,price,size FROM pizzas WHERE size = 'M';

--Show pizza_id,price of pizzas where price is between 10 and 15(inclusive)
SELECT pizza_id,price FROM pizzas 
WHERE price BETWEEN 10 AND 15;

--Show the name, pizza_type_id, price of the pizzas with the highest price.
SELECT pizza_types.name, pizza_types.pizza_type_id, pizzas.price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
WHERE pizzas.price = (SELECT MAX(price) FROM pizzas);

--Show all columns for orders who have one of the following order_ids  as 10
SELECT * FROM order_details
WHERE order_id IN (10);

--Show unique months from orders and order them by ascending
SELECT distinct(MONTH(date)) FROM orders
ORDER BY MONTH(date) ASC;

--List the top 5 most ordered pizza types along with their quantities.
SELECT TOP 5 pizza_types.name, SUM(order_details.quantity) AS  s FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY s DESC;



--Show the difference between the largest price and smallest price for pizzas with the Size 'L'
select MAX(price)-MIN(price) FROM pizzas
WHERE size = 'L';

--Show unique order dates from pizzas orders and order them by ascending
SELECT DISTINCT CONVERT(DATE, date)
FROM orders
ORDER BY CONVERT(DATE, date) ASC;

--Find all pizza types whose name contains the word "Cheese"
SELECT name, category, ingredients
FROM pizza_types
WHERE name LIKE '%Cheese%';

--Find pizza types where the average price is greater than 10
SELECT pizza_types.name, AVG(pizzas.price) AS average_price FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name
HAVING AVG(pizzas.price) > 10;



--Show all columns for order_id 5 with  most recent date.
SELECT * 
FROM orders
WHERE order_id = 5
AND YEAR(date) = (SELECT MAX(YEAR(date)) FROM orders WHERE order_id = 5);

--For each pizza, display their id, name, and the category and last admission date they attended.
SELECT orders.order_id,MIN(orders.date),MAX(orders.date) FROM orders
JOIN order_details on orders.order_id=order_details.order_id
group by orders.order_id;

--Find the most expensive pizza and its details
SELECT pizzas.pizza_id, pizza_types.name, pizzas.size, pizzas.price 
FROM pizzas 
JOIN pizza_types  ON pizzas.pizza_type_id = pizza_types.pizza_type_id
WHERE pizzas.price = (SELECT MAX(price) FROM pizzas);

--Find the top 5 most expensive pizzas
SELECT TOP 5 pizzas.pizza_id, pizza_types.name, pizzas.size, pizzas.price
FROM pizzas 
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC;


--Find the average price of pizzas by pizza category
SELECT pizza_types.category, AVG(pizzas.price) AS average_price
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category;


--Find the total revenue generated for each order
SELECT orders.order_id, SUM(pizzas.price * order_details.quantity) FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas  ON order_details.pizza_id = pizzas.pizza_id
GROUP BY orders.order_id;

--List all orders made for a specific pizza type
SELECT orders.order_id, orders.date, orders.time, pizza_types.name, order_details.quantity
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
WHERE pizza_types.name = 'The Hawaiian Pizza';

--Find the most popular pizza type (most ordered)
SELECT pizza_types.name, SUM(order_details.quantity) t FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizzatype_id
JOIN order_details ON p.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY t DESC
LIMIT 1;







