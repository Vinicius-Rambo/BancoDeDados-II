SELECT c.name AS name, r.rentals_date as rentals_date 
FROM customers AS c, rentals AS r 
WHERE c.id = r.id_customers
and extract(month from r.rentals_date) = 9
and extract(year from r.rentals_date) = 2016;