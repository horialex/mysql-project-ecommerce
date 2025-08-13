-- TABLES --
CREATE TABLE `Customers`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `firstName` VARCHAR(60) NOT NULL,
    `lastName` VARCHAR(60) NOT NULL,
    `email` VARCHAR(60) NOT NULL UNIQUE,
    `address` VARCHAR(60) NOT NULL,
    `phone` VARCHAR(20) NOT NULL
);

CREATE TABLE `Products`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_id` SMALLINT UNSIGNED NOT NULL,
    `sku` VARCHAR(60) NULL UNIQUE,
    `name` VARCHAR(60) NOT NULL,
    `description` TEXT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL
);

CREATE TABLE `Orders`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMAR Y KEY,
    `customer_id` INT UNSIGNED NOT NULL,
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status_id` TINYINT UNSIGNED NOT NULL DEFAULT '1'
);

CREATE TABLE `OrderItems`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT UNSIGNED NOT NULL,
    `product_id` INT UNSIGNED NOT NULL,
    `quantity` SMALLINT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL
);

CREATE TABLE `Categories`(
    `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(60) NOT NULL,
    `description` TEXT NOT NULL
);

CREATE TABLE `OrderStatus`(
    `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30) NOT NULL UNIQUE
);


-- FOREIGN KEYS AND DELETE CONSTRAINTS --
ALTER TABLE `Orders`
ADD CONSTRAINT `fk_orders_status` 
FOREIGN KEY(`status_id`) REFERENCES `OrderStatus`(`id`);

ALTER TABLE `OrderItems`
ADD CONSTRAINT `fk_orderitems_order_id`
FOREIGN KEY(`order_id`) REFERENCES `Orders`(`id`)
ON DELETE CASCADE;

ALTER TABLE `Orders`
ADD CONSTRAINT `fk_orders_customer_id`
FOREIGN KEY(`customer_id`) REFERENCES `Customers`(`id`);

ALTER TABLE `Products`
ADD CONSTRAINT `fk_products_category_id`
FOREIGN KEY(`category_id`) REFERENCES `Categories`(`id`)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE `OrderItems`
ADD CONSTRAINT `fk_orderitems_product_id`
FOREIGN KEY(`product_id`) REFERENCES `Products`(`id`)
ON DELETE RESTRICT;



-- TRIGGERS --

-- Add a trigger to copy the price form Products table before inserting a new row in OrderItems table
-- This is usefull so we don't add manually the price and makes sure that the price that the product is ordered is the 
-- correct price at that date

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