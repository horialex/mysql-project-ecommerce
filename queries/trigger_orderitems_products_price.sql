DELIMITER // -- change the delimiter from ;  to // so you can execute multiple statements
             -- for the same trigger as a whole and not individually

CREATE TRIGGER tr_orderitems_before_insert_product_price
BEFORE INSERT ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE current_price DECIMAL(8,2);

    SELECT price INTO current_price
    FROM Products
    WHERE id = NEW.product_id;

    SET NEW.price = current_price;
END;
// -- ends trigger definition

DELIMITER ; -- change back the delimiter