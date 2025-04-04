-- 1. What It Does:
-- Joins the orders table with the users table
-- Matches records where the user_id exists in both tables
-- Filters to only include orders with total_amount > $80
-- Returns two columns: user_id from orders and name from users

-- 2.Key Improvements:
-- Dynamic Date Calculation:
--DATE_SUB(CURRENT_DATE(), INTERVAL 280 DAY) calculates the date 280 days ago from today
-- Automatically stays current (no hardcoded dates)
-- Inclusive Date Range:
-- >= includes orders from exactly 280 days ago through today
-- Proper Date Comparison:
-- Compares order_date directly against the calculated date

-- 5. Why It's Invalid:
--- When you use GROUP BY, every column in your SELECT must either:
-- Be in the GROUP BY clause, or
-- Be wrapped in an aggregate function (like SUM, COUNT, AVG)
-- Here, od.quantity is neither:
-- Not included in GROUP BY
-- Not wrapped in an aggregate function

-- 11. 