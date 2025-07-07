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
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
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


-- FOREIGN KEYS --
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
ON DELETE SET NULL;

ALTER TABLE `OrderItems`
ADD CONSTRAINT `fk_orderitems_product_id`
FOREIGN KEY(`product_id`) REFERENCES `Products`(`id`)
ON DELETE RESTRICT;