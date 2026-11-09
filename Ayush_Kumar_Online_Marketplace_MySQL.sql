-- DBMS Capstone Project: Online Marketplace System
-- Student: Ayush Kumar | Roll No.: 2501420003 | Faculty: Dr. Swati Gupta

DROP DATABASE IF EXISTS online_marketplace_db;
CREATE DATABASE online_marketplace_db;
USE online_marketplace_db;

CREATE TABLE categories (
category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE sellers (
seller_id INT PRIMARY KEY AUTO_INCREMENT,
seller_name VARCHAR(120) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
joined_at DATE NOT NULL
);

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(120) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
joined_at DATE NOT NULL
);

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
seller_id INT NOT NULL,
category_id INT NOT NULL,
title VARCHAR(200) NOT NULL,
description TEXT NOT NULL,
price DECIMAL(10,2) NOT NULL CHECK (price > 0),
stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_product_seller FOREIGN KEY (seller_id) REFERENCES sellers(seller_id),
CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
order_date DATETIME NOT NULL,
order_status ENUM('PLACED','PAID','SHIPPED','DELIVERED','CANCELLED','RETURNED') NOT NULL,
shipping_city VARCHAR(100) NOT NULL,
CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK (quantity > 0),
unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews (
review_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT NOT NULL,
customer_id INT NOT NULL,
rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
review_text VARCHAR(500),
review_date DATE NOT NULL,
UNIQUE KEY uq_review (product_id, customer_id),
CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES products(product_id),
CONSTRAINT fk_review_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE returns_log (
return_id INT PRIMARY KEY AUTO_INCREMENT,
order_item_id INT NOT NULL UNIQUE,
return_date DATE NOT NULL,
reason VARCHAR(200) NOT NULL,
CONSTRAINT fk_return_item FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id)
);

INSERT INTO categories (category_name) VALUES
('Electronics'), ('Books'), ('Home and Kitchen');

INSERT INTO sellers (seller_name, email, joined_at) VALUES
('Tech Haven', 'techhaven@example.com', '2026-01-05'),
('Book Nest', 'booknest@example.com', '2026-01-12'),
('Home Essentials', 'home@example.com', '2026-02-02');

INSERT INTO customers (customer_name, email, joined_at) VALUES
('Aarav Sharma', 'aarav@example.com', '2026-01-02'),
('Diya Verma', 'diya@example.com', '2026-01-16'),
('Kabir Singh', 'kabir@example.com', '2026-02-08'),
('Meera Iyer', 'meera@example.com', '2026-02-25'),
('Rohan Das', 'rohan@example.com', '2026-03-03'),
('Sara Khan', 'sara@example.com', '2026-03-19'),
('Vivaan Jain', 'vivaan@example.com', '2026-04-04'),
('Anaya Roy', 'anaya@example.com', '2026-04-21');

INSERT INTO products (seller_id, category_id, title, description, price, stock_qty) VALUES
(1, 1, 'Wireless Headphones', 'Bluetooth over ear headphones with noise isolation', 2499.00, 50),
(1, 1, 'Smart Watch', 'Fitness tracking smart watch with heart rate monitor', 3199.00, 35),
(1, 1, 'USB C Hub', 'Seven port USB C hub for laptop connectivity', 1299.00, 60),
(2, 2, 'Database Systems Book', 'Practical database design and SQL guide', 799.00, 80),
(2, 2, 'Python for Data Science', 'Hands on Python analytics and machine learning book', 999.00, 70),
(2, 2, 'Algorithms Made Easy', 'Algorithm concepts with coding examples', 699.00, 65),
(3, 3, 'Steel Water Bottle', 'Insulated reusable steel bottle', 549.00, 100),
(3, 3, 'Desk Organizer', 'Compact wooden desk organizer', 899.00, 40),
(3, 3, 'LED Study Lamp', 'Adjustable LED desk lamp with USB charging', 1499.00, 45);

INSERT INTO orders (customer_id, order_date, order_status, shipping_city) VALUES
(1,'2026-01-10 10:20:00','DELIVERED','Delhi'),
(2,'2026-01-22 14:10:00','DELIVERED','Jaipur'),
(1,'2026-02-05 09:30:00','DELIVERED','Delhi'),
(3,'2026-02-12 18:00:00','DELIVERED','Pune'),
(4,'2026-02-28 11:15:00','RETURNED','Chennai'),
(2,'2026-03-08 16:40:00','DELIVERED','Jaipur'),
(5,'2026-03-15 12:05:00','DELIVERED','Kolkata'),
(6,'2026-03-29 17:25:00','CANCELLED','Mumbai'),
(3,'2026-04-06 10:55:00','DELIVERED','Pune'),
(7,'2026-04-18 13:45:00','DELIVERED','Bengaluru'),
(8,'2026-04-27 19:10:00','DELIVERED','Hyderabad'),
(1,'2026-05-03 08:30:00','DELIVERED','Delhi'),
(5,'2026-05-21 15:20:00','DELIVERED','Kolkata'),
(6,'2026-05-30 11:35:00','DELIVERED','Mumbai');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,1,1,2499.00),(1,4,1,799.00),(2,5,1,999.00),(3,2,1,3199.00),
(3,7,2,549.00),(4,1,1,2499.00),(4,3,1,1299.00),(5,8,1,899.00),
(5,9,1,1499.00),(6,4,2,799.00),(6,6,1,699.00),(7,2,1,3199.00),
(7,7,1,549.00),(8,3,1,1299.00),(9,5,2,999.00),(9,9,1,1499.00),
(10,1,1,2499.00),(10,8,1,899.00),(11,6,2,699.00),(11,7,2,549.00),
(12,3,2,1299.00),(12,4,1,799.00),(13,2,1,3199.00),(13,5,1,999.00),
(14,9,2,1499.00),(14,1,1,2499.00);

INSERT INTO reviews (product_id, customer_id, rating, review_text, review_date) VALUES
(1,1,5,'Excellent sound quality','2026-01-18'),(4,1,4,'Clear explanations','2026-01-19'),
(5,2,5,'Very useful for projects','2026-01-28'),(2,1,4,'Good features','2026-02-14'),
(7,1,5,'Keeps water cold','2026-02-15'),(1,3,4,'Comfortable to wear','2026-02-20'),
(3,3,4,'Useful ports','2026-02-21'),(8,4,3,'Decent organizer','2026-03-04'),
(4,2,5,'Best DBMS reference','2026-03-12'),(6,2,4,'Simple and practical','2026-03-13'),
(2,5,5,'Accurate tracking','2026-03-22'),(7,5,4,'Good bottle','2026-03-23'),
(5,3,5,'Great examples','2026-04-13'),(9,3,4,'Bright lamp','2026-04-14'),
(1,7,5,'Worth the price','2026-04-25'),(6,8,4,'Helpful practice problems','2026-05-05'),
(9,6,5,'Perfect for study desk','2026-06-01');

INSERT INTO returns_log (order_item_id, return_date, reason) VALUES
(8, '2026-03-05', 'Changed mind'), (9, '2026-03-05', 'Damaged on arrival');

-- Required indexes
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_products_category_price ON products(category_id, price);
CREATE FULLTEXT INDEX ft_products_title_description ON products(title, description);

-- Q1: Product catalogue with seller and category
SELECT p.product_id, p.title, c.category_name, s.seller_name, p.price, p.stock_qty
FROM products p JOIN categories c ON c.category_id=p.category_id
JOIN sellers s ON s.seller_id=p.seller_id ORDER BY c.category_name, p.title;

-- Q2: Monthly sales trend (completed transactions only)
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
COUNT(DISTINCT o.order_id) AS orders_count
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.order_status IN ('PAID','SHIPPED','DELIVERED','RETURNED')
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m') ORDER BY sales_month;

-- Q3: Top-selling products by units sold
SELECT p.product_id, p.title, SUM(oi.quantity) AS units_sold,
ROUND(SUM(oi.quantity*oi.unit_price),2) AS sales_value
FROM order_items oi JOIN products p ON p.product_id=oi.product_id
JOIN orders o ON o.order_id=oi.order_id
WHERE o.order_status <> 'CANCELLED'
GROUP BY p.product_id, p.title ORDER BY units_sold DESC, sales_value DESC LIMIT 5;

-- Q4: Customer satisfaction by product
SELECT p.title, COUNT(r.review_id) AS review_count,
ROUND(AVG(r.rating),2) AS average_rating
FROM products p LEFT JOIN reviews r ON r.product_id=p.product_id
GROUP BY p.product_id,p.title ORDER BY average_rating DESC, review_count DESC;

-- Q5: Cohort analysis by first purchase month
WITH first_purchase AS (
SELECT customer_id, DATE_FORMAT(MIN(order_date),'%Y-%m') AS cohort_month
FROM orders WHERE order_status <> 'CANCELLED' GROUP BY customer_id
), activity AS (
SELECT DISTINCT o.customer_id, DATE_FORMAT(o.order_date,'%Y-%m') AS activity_month
FROM orders o WHERE o.order_status <> 'CANCELLED'
)
SELECT f.cohort_month, a.activity_month, COUNT(DISTINCT a.customer_id) AS active_customers
FROM first_purchase f JOIN activity a ON a.customer_id=f.customer_id
GROUP BY f.cohort_month,a.activity_month ORDER BY f.cohort_month,a.activity_month;

-- Q6: Index usage plan. Compare this with the plan after dropping the index.
EXPLAIN SELECT order_id, order_date, order_status
FROM orders WHERE customer_id=1 AND order_date >= '2026-02-01';

-- Q7: FULLTEXT product search
SELECT product_id, title, price,
MATCH(title,description) AGAINST ('database SQL' IN NATURAL LANGUAGE MODE) AS relevance
FROM products WHERE MATCH(title,description) AGAINST ('database SQL' IN NATURAL LANGUAGE MODE)
ORDER BY relevance DESC;

-- Low-selectivity illustration: most rows may match a common status, so an index is usually less useful.
CREATE INDEX idx_orders_status_demo ON orders(order_status);
EXPLAIN SELECT order_id, customer_id FROM orders WHERE order_status='DELIVERED';

-- Required views
CREATE OR REPLACE VIEW vw_seller_performance AS
SELECT s.seller_id, s.seller_name,
COALESCE(sa.total_sales,0) AS total_sales,
COALESCE(ra.average_rating,0) AS average_rating,
COALESCE(sa.return_rate_pct,0) AS return_rate_pct
FROM sellers s
LEFT JOIN (
SELECT p.seller_id,
ROUND(SUM(CASE WHEN o.order_status <> 'CANCELLED' THEN oi.quantity*oi.unit_price ELSE 0 END),2) AS total_sales,
ROUND(100*SUM(CASE WHEN rl.return_id IS NOT NULL THEN 1 ELSE 0 END)/NULLIF(COUNT(oi.order_item_id),0),2) AS return_rate_pct
FROM products p LEFT JOIN order_items oi ON oi.product_id=p.product_id
LEFT JOIN orders o ON o.order_id=oi.order_id LEFT JOIN returns_log rl ON rl.order_item_id=oi.order_item_id
GROUP BY p.seller_id
) sa ON sa.seller_id=s.seller_id
LEFT JOIN (
SELECT p.seller_id, ROUND(AVG(r.rating),2) AS average_rating
FROM products p LEFT JOIN reviews r ON r.product_id=p.product_id GROUP BY p.seller_id
) ra ON ra.seller_id=s.seller_id;

CREATE OR REPLACE VIEW vw_customer_lifetime_value AS
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT o.order_id) AS orders_placed,
ROUND(COALESCE(SUM(CASE WHEN o.order_status <> 'CANCELLED' THEN oi.quantity*oi.unit_price END),0),2) AS lifetime_value
FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id
LEFT JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.customer_id,c.customer_name;

-- Q8: Read the two views
SELECT * FROM vw_seller_performance ORDER BY total_sales DESC;
SELECT * FROM vw_customer_lifetime_value ORDER BY lifetime_value DESC;

-- Materialized-view simulation: summary table, procedure, and scheduled refresh.
CREATE TABLE mv_daily_sales_summary (
sales_date DATE PRIMARY KEY, order_count INT NOT NULL, revenue DECIMAL(12,2) NOT NULL, refreshed_at DATETIME NOT NULL
);
DELIMITER //
CREATE PROCEDURE refresh_daily_sales_summary()
BEGIN
TRUNCATE TABLE mv_daily_sales_summary;
INSERT INTO mv_daily_sales_summary (sales_date,order_count,revenue,refreshed_at)
SELECT DATE(o.order_date), COUNT(DISTINCT o.order_id),
ROUND(SUM(oi.quantity*oi.unit_price),2), NOW()
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.order_status <> 'CANCELLED'
GROUP BY DATE(o.order_date);
END //
DELIMITER ;
CALL refresh_daily_sales_summary();
SET GLOBAL event_scheduler = ON;
CREATE EVENT IF NOT EXISTS ev_refresh_daily_sales_summary
ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO CALL refresh_daily_sales_summary();

-- Q9: Summary-table output
SELECT * FROM mv_daily_sales_summary ORDER BY sales_date;

-- Q10: Top 3 products per category by revenue, using RANK
WITH product_revenue AS (
SELECT c.category_name,p.product_id,p.title,
ROUND(SUM(CASE WHEN o.order_id IS NOT NULL THEN oi.quantity*oi.unit_price ELSE 0 END),2) AS revenue
FROM products p JOIN categories c ON c.category_id=p.category_id
LEFT JOIN order_items oi ON oi.product_id=p.product_id
LEFT JOIN orders o ON o.order_id=oi.order_id AND o.order_status <> 'CANCELLED'
GROUP BY c.category_name,p.product_id,p.title
), ranked_products AS (
SELECT category_name,title,revenue,
RANK() OVER (PARTITION BY category_name ORDER BY revenue DESC) AS product_rank
FROM product_revenue
)
SELECT category_name,title,revenue,product_rank
FROM ranked_products WHERE product_rank <= 3
ORDER BY category_name,product_rank,title;

-- Q11: LAG month-over-month revenue growth
WITH monthly_sales AS (
SELECT DATE_FORMAT(o.order_date,'%Y-%m') sales_month, SUM(oi.quantity*oi.unit_price) revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.order_status <> 'CANCELLED' GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')
)
SELECT sales_month,revenue, LAG(revenue) OVER (ORDER BY sales_month) previous_month_revenue,
ROUND(100*(revenue-LAG(revenue) OVER (ORDER BY sales_month))/NULLIF(LAG(revenue) OVER (ORDER BY sales_month),0),2) AS growth_pct
FROM monthly_sales;

-- Q12: Three-month moving average of revenue
WITH monthly_sales AS (
SELECT DATE_FORMAT(o.order_date,'%Y-%m') sales_month, SUM(oi.quantity*oi.unit_price) revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.order_status <> 'CANCELLED' GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')
)
SELECT sales_month,revenue,
ROUND(AVG(revenue) OVER (ORDER BY sales_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS moving_avg_3_months
FROM monthly_sales;

-- Q13: First-purchase cohort using MIN over each customer partition
SELECT DISTINCT customer_id,
DATE_FORMAT(MIN(order_date) OVER (PARTITION BY customer_id),'%Y-%m') AS first_purchase_cohort
FROM orders WHERE order_status <> 'CANCELLED' ORDER BY customer_id;

-- Q14: Customer spending quartiles with NTILE(4)
WITH customer_spend AS (
SELECT c.customer_id,c.customer_name,COALESCE(SUM(oi.quantity*oi.unit_price),0) total_spend
FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id AND o.order_status <> 'CANCELLED'
LEFT JOIN order_items oi ON oi.order_id=o.order_id GROUP BY c.customer_id,c.customer_name
)
SELECT customer_id,customer_name,total_spend,
NTILE(4) OVER (ORDER BY total_spend DESC) AS spending_quartile
FROM customer_spend ORDER BY total_spend DESC;


