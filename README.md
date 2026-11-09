# Online Marketplace System

## DBMS Capstone Project

**Student:** Ayush Kumar  
**Roll Number:** 2501420003  
**Course:** BTech CSE DS  
**Faculty:** Dr. Swati Gupta  
**DBMS:** MySQL 8.0

## Project Overview

This project implements an Online Marketplace System using MySQL. It manages product listings, sellers, customers, orders, order items, customer reviews, and product returns. It also provides SQL-based analysis for sales, customer behaviour, seller performance, search, and revenue reporting.

## Files

- `Ayush_Kumar_Online_Marketplace_MySQL.sql` - complete MySQL database script.
- `Ayush_Kumar_DBMS_Capstone_With_Outputs.pdf` - project report with MySQL Workbench outputs.

## Database Tables

- `categories`
- `sellers`
- `customers`
- `products`
- `orders`
- `order_items`
- `reviews`
- `returns_log`
- `mv_daily_sales_summary`

## How to Run

1. Install MySQL Server 8.0 or later and MySQL Workbench.
2. Open MySQL Workbench and connect to the MySQL server.
3. Open `Ayush_Kumar_Online_Marketplace_MySQL.sql`.
4. Execute the full script using the lightning-bolt button.
5. The script creates and selects the database named `online_marketplace_db`.
6. Run individual queries again whenever a result screenshot is required.

## Features Implemented

- Normalized relational schema with primary and foreign keys.
- Sample data for categories, sellers, customers, products, orders, reviews, and returns.
- Monthly sales trend analysis.
- Top-selling products and customer satisfaction analysis.
- Customer cohort analysis based on first purchase month.
- Composite indexes on `orders(customer_id, order_date)` and `products(category_id, price)`.
- FULLTEXT search on product title and description.
- `EXPLAIN` queries to inspect execution plans.
- Seller performance view with total sales, average rating, and return rate.
- Customer lifetime value view.
- Daily sales summary table refreshed through a stored procedure and scheduled event.
- Window functions: `RANK`, `LAG`, 3-month moving average, `MIN OVER`, and `NTILE(4)`.

## Note

The scheduled event requires MySQL's event scheduler to be enabled. If your MySQL account does not have permission to run `SET GLOBAL event_scheduler = ON`, the remaining database queries and reports will still work normally.
