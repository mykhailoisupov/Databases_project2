-- Create the database for the project
CREATE DATABASE IF NOT EXISTS `optimizer_project`;

-- Switch to the new database
USE `optimizer_project`;

-- Drop tables if they already exist to ensure a fresh start
DROP TABLE IF EXISTS `sales`;
DROP TABLE IF EXISTS `customers`;
DROP TABLE IF EXISTS `products`;

-- Table 1: Customers
-- This table will store customer information.
-- We are intentionally not adding indexes on `region` or `join_date`
-- so that you can add them later as part of your optimization task.
CREATE TABLE `customers` (
                             `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                             `customer_name` VARCHAR(100) NOT NULL,
                             `email` VARCHAR(100) NOT NULL,
                             `join_date` DATE NOT NULL,
                             `region` VARCHAR(20) NOT NULL,
                             PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB;

-- Table 2: Products
-- This table will store product information.
-- We are intentionally not adding an index on `category` to create
-- an opportunity for optimization.
CREATE TABLE `products` (
                            `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                            `product_name` VARCHAR(150) NOT NULL,
                            `category` VARCHAR(50) NOT NULL,
                            `price` DECIMAL(10, 2) NOT NULL,
                            PRIMARY KEY (`product_id`)
) ENGINE=InnoDB;

-- Table 3: Sales
-- This is the main fact table, linking customers and products.
-- For faster data insertion and to simulate a non-optimized scenario,
-- foreign key constraints and secondary indexes are omitted initially.
-- You should add these as part of your optimization steps.
CREATE TABLE `sales` (
                         `sale_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `customer_id` INT UNSIGNED NOT NULL,
                         `product_id` INT UNSIGNED NOT NULL,
                         `sale_date` DATETIME NOT NULL,
                         `quantity` SMALLINT UNSIGNED NOT NULL,
                         PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB;
