USE project;

--1. Top 10 Products by Sales

SELECT TOP 10 PRODUCTCODE, SUM(SALES) AS total_sales  
FROM invoice_fact_table_sql  
GROUP BY PRODUCTCODE  
ORDER BY total_sales DESC;

--2. Total Revenue from All Sales
SELECT SUM(SALES) AS total_revenue  
FROM invoice_fact_table_sql;

--3. Total Invoices Per Year
SELECT DATE_ID, COUNT(DISTINCT ORDERNUMBER) AS total_invoices  
FROM invoice_fact_table_sql  
GROUP BY DATE_ID  
ORDER BY total_invoices DESC;

--4. Top 5 Customers by Total Purchases
SELECT TOP 5 CUSTOMERNAME, SUM(SALES) AS total_spent  
FROM invoice_fact_table_sql  
GROUP BY CUSTOMERNAME  
ORDER BY total_spent DESC;

--5. Sales by Country
SELECT COUNTRY, SUM(SALES) AS total_sales  
FROM invoice_fact_table_sql  
GROUP BY COUNTRY  
ORDER BY total_sales DESC;

--6. Average Sales Amount Per Invoice
SELECT AVG(SALES) AS avg_sales_per_invoice  
FROM invoice_fact_table_sql;

--7 Total Quantity Sold Across All Products
SELECT SUM(QUANTITYORDERED) AS total_quantity_sold  
FROM invoice_fact_table_sql;

--8. Count of Orders Per Payment Method
SELECT PAYMENT_METHOD, COUNT(ORDERNUMBER) AS total_orders  
FROM invoice_fact_table_sql  
GROUP BY PAYMENT_METHOD  
ORDER BY total_orders DESC;

--9. Top 10 Selling Products with Names
SELECT TOP 10 i.PRODUCTCODE, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
GROUP BY i.PRODUCTCODE  
ORDER BY total_sales DESC;

--10. Total Sales by Country Name
SELECT c.COUNTRY, c.TERRITORY, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN country_dimension_sql c ON i.COUNTRY = c.COUNTRY  
GROUP BY c.COUNTRY, c.TERRITORY  
ORDER BY total_sales DESC;

--11. Monthly Sales Analysis
SELECT d.year, d.month, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN date_dimension_sql d ON i.DATE_ID = d.date_id  
GROUP BY d.year, d.month  
ORDER BY d.year DESC, d.month DESC;

--12. Customer with Highest Total Purchase and Name
SELECT c.CUSTOMERNAME, c.CONTACTFIRSTNAME, c.CONTACTLASTNAME,  
       c.PHONE, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN customer_dimension_sql c ON i.CUSTOMERNAME = c.CUSTOMERNAME  
GROUP BY c.CUSTOMERNAME, c.CONTACTFIRSTNAME, c.CONTACTLASTNAME, c.PHONE  
ORDER BY total_sales DESC;

--13. Products Sold in Each Country
SELECT c.COUNTRY, p.PRODUCTLINE, SUM(i.QUANTITYORDERED) AS total_quantity  
FROM invoice_fact_table_sql i  
JOIN country_dimension_sql c ON i.COUNTRY = c.COUNTRY  
JOIN product_dimension_sql p ON i.PRODUCTCODE = p.PRODUCTCODE  
GROUP BY c.COUNTRY, p.PRODUCTLINE  
ORDER BY c.COUNTRY, total_quantity DESC;


--14. Total Sales Per Year with Date Information
SELECT YEAR(d.ORDERDATE) AS year, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN date_dimension_sql d ON i.DATE_ID = d.DATE_ID  
GROUP BY YEAR(d.ORDERDATE)  
ORDER BY year DESC;

--15 Best-Selling Product Category
SELECT p.PRODUCTLINE, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN product_dimension_sql p ON i.PRODUCTCODE = p.PRODUCTCODE  
GROUP BY p.PRODUCTLINE  
ORDER BY total_sales DESC;

--16. Revenue Share by Customer Name
SELECT cu.CUSTOMERNAME,  
       SUM(i.SALES) AS total_spent,  
       SUM(i.SALES) * 100 / (SELECT SUM(SALES) FROM invoice_fact_table_sql) AS revenue_share  
FROM invoice_fact_table_sql i  
JOIN customer_dimension_sql cu ON i.CUSTOMERNAME = cu.CUSTOMERNAME  
GROUP BY cu.CUSTOMERNAME  
ORDER BY total_spent DESC;

--17.. Total Sales
SELECT SUM(SALES) AS total_sales  
FROM invoice_fact_table_sql;

--18.Total Number of Orders
SELECT COUNT(DISTINCT ORDERNUMBER) AS total_orders  
FROM invoice_fact_table_sql;

--19.Total Quantity Sold
SELECT SUM(QUANTITYORDERED) AS total_quantity_sold  
FROM invoice_fact_table_sql;

--20.Average Order Value
SELECT SUM(SALES) / COUNT(DISTINCT ORDERNUMBER) AS avg_order_value  
FROM invoice_fact_table_sql;

--21.Total Sales Per Payment Method
SELECT PAYMENT_METHOD, SUM(SALES) AS total_sales  
FROM invoice_fact_table_sql  
GROUP BY PAYMENT_METHOD  
ORDER BY total_sales DESC;

--22. Total Sales Per Product Line
SELECT p.PRODUCTLINE, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN product_dimension_sql p ON i.PRODUCTCODE = p.PRODUCTCODE  
GROUP BY p.PRODUCTLINE  
ORDER BY total_sales DESC;


--23.Total Sales Per Year
SELECT YEAR(d.ORDERDATE) AS year, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN date_dimension_sql d ON i.DATE_ID = d.DATE_ID  
GROUP BY YEAR(d.ORDERDATE)  
ORDER BY year DESC;

--24.Total Number of Customers
SELECT COUNT(DISTINCT CUSTOMERNAME) AS total_customers  
FROM invoice_fact_table_sql;

--25. Total Sales Per Territory
SELECT c.TERRITORY, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN country_dimension_sql c ON i.COUNTRY = c.COUNTRY  
GROUP BY c.TERRITORY  
ORDER BY total_sales DESC;

--26. Customers Who Have Not Ordered Yet
SELECT c.CUSTOMERNAME  
FROM customer_dimension_sql c  
LEFT JOIN invoice_fact_table_sql i ON c.CUSTOMERNAME = i.CUSTOMERNAME  
WHERE i.CUSTOMERNAME IS NULL;

--27 Total Revenue Per City
SELECT c.CITY, SUM(i.SALES) AS total_sales  
FROM invoice_fact_table_sql i  
JOIN customer_dimension_sql c ON i.CUSTOMERNAME = c.CUSTOMERNAME  
GROUP BY c.CITY  
ORDER BY total_sales DESC;