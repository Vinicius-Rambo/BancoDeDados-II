--A
SELECT name FROM customers WHERE state = 'RS'; 

--B
SELECT name, street FROM customers WHERE city = 'Porto Alegre';

--C
SELECT id, name FROM products WHERE price < 10 OR price > 100;

--D
SELECT products.name, providers.name FROM products 
JOIN providers ON products.id_providers = providers.id 
JOIN categories ON products.id_categories = categories.id 
WHERE categories.id = 6;

--E
SELECT products.id, products.name FROM products 
JOIN categories ON products.id_categories = categories.id 
WHERE categories.name LIKE 'super%'; 

--F
SELECT city FROM providers ORDER BY city ASC;

--G
SELECT MAX(price) AS price, MIN(price) AS price FROM products; 

--H
SELECT categories.name, SUM(products.amount) FROM products
JOIN categories ON products.id_categories = categories.id 
GROUP BY categories.name;

--I
SELECT ROUND(AVG(price), 2) AS price FROM products;

--J
SELECT DISTINCT city FROM customers ORDER BY city;

--K
SELECT c.name,
CAST(((s.math * 2 + s.specific * 3 + s.project_plan * 5) / 10.0) AS DECIMAL(10,2)) AS avg
FROM candidate c
JOIN score s ON c.id = s.candidate_id
ORDER BY avg DESC;

--L

SELECT name , CASE 
    WHEN type = 'A' THEN 20.0 
    WHEN type = 'B' THEN 70.0 
    WHEN type = 'C' THEN 530.5
END AS price FROM products
ORDER BY 
    type ASC, 
    id DESC;
