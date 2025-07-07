Select Customers.id as customer_id, Customers.firstName, Customers.lastName, Customers.email, Customers.phone, Customers.address, Orders.id as order_id, OrderItems.id as order_item_id, Products.name 
FROM Customers
INNER JOIN Orders ON Customers.id = Orders.customer_id
INNER JOIN OrderItems ON Orders.id = OrderItems.order_id
INNER JOIN Products ON OrderItems.product_id = Products.id
WHERE firstName = "Encian";