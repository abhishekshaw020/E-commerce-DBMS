#E-COMMERCE DATABASE MANAGEMENT SYSTEM

create database management;
CREATE TABLE categories (category_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(50) NOT NULL);
CREATE TABLE products (product_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100) NOT NULL,price DECIMAL(10, 2) NOT NULL,
    category_id INT,FOREIGN KEY (category_id) REFERENCES categories(category_id));
CREATE TABLE orders (order_id INT PRIMARY KEY AUTO_INCREMENT,product_id INT,quantity INT NOT NULL,total_price DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (product_id) REFERENCES products(product_id));
    
INSERT INTO categories (name) VALUES
    ('Electronics'),
    ('Clothing'),
    ('Books'),
    ('Home and Kitchen');
    
INSERT INTO products (name, price, category_id) VALUES
    ('Laptop', 1200.00, 1),
    ('T-shirt', 19.99, 2),
    ('Programming Book', 39.99, 3),
    ('Cookware Set', 99.99, 4);
    
INSERT INTO orders (product_id, quantity, total_price) VALUES
    (1, 2, 2400.00),
    (2, 3, 59.97),
    (3, 1, 39.99),
    (4, 1, 99.99);
    
#Q.1 Retrieve all products along with their categories?
SELECT p.product_id, p.name AS product_name, p.price, c.name AS category_name FROM products p JOIN categories c ON p.category_id = c.category_id;

#Q.2 Calculate the total revenue generated from orders?
SELECT SUM(total_price) AS total_revenue FROM orders;

#Q.3 Find the product with the highest price?
SELECT * FROM products ORDER BY price DESC LIMIT 1;

#Q.4  List all categories along with the number of products in each category?
SELECT c.name AS category_name, COUNT(p.product_id) AS product_count FROM categories c LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name;

#Q.5 Update the price of the 'Laptop' to $1099.99?
UPDATE products SET price = 1099.99 WHERE name = 'Laptop';

#Q.6 Insert a new category 'Sports' with category_id = 5?
INSERT INTO categories (category_id, name) VALUES (5, 'Sports');

#Q.7 Find the average price of products in each category?
SELECT c.name AS category_name, AVG(p.price) AS avg_price FROM categories c LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name;

#Q.8 Identify the top 3 products with the highest total sales (quantity * price)?
SELECT p.product_id, p.name AS product_name, SUM(o.quantity * p.price) AS total_sales
FROM products p JOIN orders o ON p.product_id = o.product_id GROUP BY p.product_id, p.name ORDER BY total_sales DESC LIMIT 3;

#Q.9 Retrieve the latest order for each product, including the product name, order date, and quantity?
SELECT p.name AS product_name, o.order_date, o.quantity
FROM products p JOIN orders o ON p.product_id = o.product_id WHERE o.order_date = (SELECT MAX(order_date) FROM orders WHERE product_id = p.product_id);

#Q.10 Calculate the total number of orders and the average order quantity?
SELECT COUNT(order_id) AS total_orders, AVG(quantity) AS avg_order_quantity FROM orders;

#Q.11 Delete the category 'Books' and update the category of all 'Books' products to 'Literature'?
#update product categories
UPDATE products
SET category_id = (SELECT category_id FROM categories WHERE name = 'Literature')
WHERE category_id = (SELECT category_id FROM categories WHERE name = 'Books');

DELETE FROM categories WHERE name = 'Books';









