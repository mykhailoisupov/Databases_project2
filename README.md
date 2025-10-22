# SQL Query Optimization

This project explores **SQL query performance optimization** through an example. It documents the process of identifying inefficiencies in a complex query and refactoring it into a high-performance, scalable solution using **Common Table Expressions (CTEs)** and **strategic indexing**.

---

## Project Objective

The goal was to create a report of the **top 10 highest-spending customers** under the following conditions:

- **Region:** North  
- **Category:** Electronics  
- **Timeframe:** Q1 2024 (Jan 1 – Mar 31)

The challenge was to transform a slow, procedural query with correlated subqueries into a set-based, optimized version.

---

## Repository Contents

- `Ass2_non_optimized_query.sql` — Original slow query (with correlated subqueries and redundant scans).  
- `Ass2_optimized_query.sql` — Final optimized query using a CTE and indexes.  
- `README.md` — Explanation of the optimization process and performance analysis.

---

## 1. The Non-Optimized Query

The original query used **correlated subqueries** to compute total revenue per customer. This caused major performance issues:

### Inefficiencies
- **Correlated Subquery:** Re-runs for every row (O(N·M) complexity).  
- **Redundant Scans:** Multiple subqueries repeatedly accessed the same tables.  
- **Late Filtering:** Used `HAVING` after heavy computation.  
- **No Indexes:** Led to full table scans on large datasets.

---

## 2. Optimization Strategy

To resolve these problems, the query was **rewritten** with two main strategies:

### a. Strategic Indexing

Indexes were added on key columns used in joins and filters.  
This allowed the database to replace full table scans with **Index Seeks** and **Range Scans**, significantly improving performance.

### b. Set-Based Logic (CTE)

The correlated subqueries were replaced with a **Common Table Expression (CTE)** that precomputes customer revenues in one pass.  
The CTE is executed once, stores the intermediate results in memory, and then joins efficiently with the customers table to filter by region and sort the top spenders.

---

## 3. Performance Evaluation

Performance was evaluated using `EXPLAIN ANALYZE` before and after optimization.

### Before Optimization
- Execution plan showed **dependent subqueries** and **full table scans**.  
- Runtime was high (more than 40 minutes).  
- CPU and I/O usage were excessive.

### After Optimization
- **No correlated subqueries** in the plan.  
- **Index scans** used for joins and filters.  
- Runtime reduced to **6 seconds**.  
- Query became **scalable and maintainable** for future data growth.

---

## 4. Results and Insights

Through this optimization, the query became:

- **Faster:** Reduced execution time by several orders of magnitude.  
- **More Scalable:** Efficient even with large datasets.  
- **More Maintainable:** Simpler structure and clearer logic.  
- **More Readable:** Easier for future developers or analysts to understand.

---

## Conclusion

This project demonstrates the impact of understanding **SQL execution plans** and applying **indexing**.  
By shifting from a procedural to a declarative model, the database optimizer can fully leverage its capabilities — resulting in a query that is both **high-performance** and **elegant**.

## ***
README was generated with the help of ChatGPT
