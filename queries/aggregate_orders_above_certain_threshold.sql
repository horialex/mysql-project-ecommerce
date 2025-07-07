SELECT Customers.id as customer_id, Customers.firstName, Customers.lastName, Customers.email,
       SUM(OrderItems.price * OrderItems.quantity) AS total_price
FROM Customers
INNER JOIN Orders ON Customers.id = Orders.customer_id
INNER JOIN OrderItems ON Orders.id = OrderItems.order_id
GROUP BY Customers.id, Customers.firstName, Customers.lastName, Customers.email
HAVING total_price > 500; # This is used like a where clause but for aggregated fields