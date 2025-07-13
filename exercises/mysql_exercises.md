
# MySQL Learning Exercises – E-commerce Schema

This document contains a progressive list of SQL exercises based on an e-commerce database schema. Exercises are categorized by difficulty: **Easy**, **Medium**, and **Hard**.

---

## ✅ Easy Level – Basics and Retrieval

1. **List all customers** with their first name, last name, and email.
2. **Find all products** in the database, displaying name and price.
3. **Retrieve all orders** made by a specific customer by their email.
4. **List products priced above €50**, ordered by price descending.
5. **Count the number of customers** in your database.
6. **Get the total number of products** per category.
7. **List the 5 most recent orders** placed.

---

## ⚙️ Medium Level – Joins, Aggregates, and Filtering

8. **List all orders** with the customer’s full name and order date.
9. **Show each product** with its category name using a `JOIN`.
10. **Get the total revenue** per product (sum of quantity × price in OrderItems).
11. **List customers** who have placed more than one order.
12. **Get the total number of items** in each order.
13. **Find the most expensive product** in each category.
14. **List all products** that have never been ordered.
15. **Show each order’s total value** and sort by highest value.
16. **Get all customers who haven’t placed any orders**.
17. **List all orders with the status "Pending" or "Cancelled"**.

---

## 🔥 Hard Level – Subqueries, Window Functions, Data Manipulation

18. **Find the customer** who has spent the most money in total.
19. **List top 3 best-selling products** based on quantity sold.
20. **For each order**, show the number of unique products included.
21. **Get the average number of items per order** for each customer.
22. **List all customers and their most recent order date**, including those who never ordered.
23. **Calculate cumulative sales over time** (by day or month) using a window function or CTE.
24. **Update the price** of all products in a specific category by increasing it by 10%.
25. **Delete all orders with status "Cancelled"**, including their OrderItems.
26. **Insert a new order** with multiple OrderItems for an existing customer.
27. **Create a view** that shows simplified order summaries (customer name, order date, total amount, status).

---

## 🧠 Bonus: Design Thinking & Validation

28. **What indexes would improve query performance** in your schema?
29. **What constraints would you add** to protect data integrity further?
30. **Can you normalize the schema further**, or is it already 3NF (Third Normal Form)?
