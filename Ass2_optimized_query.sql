USE optimizer_project;
CREATE INDEX idx_customer_id_sales ON sales(customer_id);
CREATE INDEX idx_customer_id_customers ON customers(customer_id);
CREATE INDEX idx_quantity ON sales(quantity);
CREATE INDEX idx_price ON products(price);
CREATE INDEX idx_product_id_products ON products(product_id);
CREATE INDEX idx_product_id_sales ON sales(product_id);
CREATE INDEX idx_product_category ON products(category);
CREATE INDEX idx_sale_date ON sales(sale_date);
CREATE INDEX idx_customer_name ON customers(customer_name);

EXPLAIN ANALYZE
WITH customer_revenue AS (
-- 1. Calculate revenue for EACH customer and include customer_id
    SELECT
        s.customer_id,
        SUM(s.quantity * p.price) AS revenue
    FROM
        sales s
            JOIN
        products p ON s.product_id = p.product_id
    WHERE
        p.category = 'Electronics'
      AND s.sale_date BETWEEN '2024-01-01' AND '2024-03-31'
    GROUP BY s.customer_id
)
-- 2. JOIN the customers table to the CTE
SELECT
    c.customer_name,
    cr.revenue AS total_revenue
FROM
    customers c
        JOIN
    customer_revenue cr ON c.customer_id = cr.customer_id
WHERE
    c.region = 'North'
ORDER BY
    total_revenue DESC
LIMIT 10;