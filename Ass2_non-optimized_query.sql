-- SCENARIO: Find the total revenue from the top 10 highest-spending customers
-- in the 'North' region who purchased 'Electronics' products in Q1 2024.
USE `optimizer_project`;
EXPLAIN ANALYZE SELECT
    c.customer_name,
    -- Subquery to calculate total revenue for each customer.
    -- This is inefficient because it re-queries the sales and products tables for every customer.
    (
        SELECT SUM(s.quantity * p.price)
        FROM sales s, products p
        WHERE s.product_id = p.product_id
          AND s.customer_id = c.customer_id
          AND p.product_id IN (
            -- Another subquery to find all 'Electronics' products.
            -- This will be executed repeatedly.
            SELECT product_id FROM products WHERE category = 'Electronics'
        )
          AND s.sale_date BETWEEN '2024-01-01' AND '2024-03-31'
    ) AS total_revenue
FROM
    customers c
WHERE
  -- Filter for customers in the 'North' region.
  -- This causes a full table scan on the large customers table.
    c.region = 'North'
  AND c.customer_id IN (
    -- Filter for customers who actually made a relevant purchase.
    -- This subquery is redundant and forces another large table lookup.
    SELECT DISTINCT s.customer_id
    FROM sales s
    WHERE s.sale_date BETWEEN '2024-01-01' AND '2024-03-31'
)
-- We have to use a HAVING clause here because total_revenue is calculated in the SELECT list.
-- This prevents the database from filtering early.
HAVING
    total_revenue IS NOT NULL
ORDER BY
    total_revenue DESC
LIMIT 10;
