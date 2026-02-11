
SELECT ORDERS.order_id, CUSTOMERS.customer_id, first_name, last_name, age, country, ORDERS. item
FROM ORDERS
INNER JOIN CUSTOMERS
ON ORDERS.customer_id = CUSTOMERS.customer_id;


  
SELECT CUSTOMERS. customer_id, first_name, last_name, age, country
FROM CUSTOMERS
INNER JOIN ORDERS
ON CUSTOMERS.customer_id = ORDERS.customer_id;

 

SELECT CUSTOMERS. customer_id, first_name, last_name, age, country
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.customer_id = ORDERS.customer_id;


SELECT CUSTOMERS. customer_id, first_name, last_name, age, country
FROM ORDERS
LEFT JOIN CUSTOMERS
ON CUSTOMERS.customer_id = ORDERS.customer_id;

SELECT CUSTOMERS. customer_id, first_name, last_name, age, country
FROM CUSTOMERS
JOIN ORDERS
ON CUSTOMERS.customer_id = ORDERS.customer_id;

