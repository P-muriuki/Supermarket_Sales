USE sql_show;

SELECT * FROM sales_data;

# Check data
# Null values
SELECT * FROM sales_data
WHERE `Invoice ID` is Null;

# Check Duplicate values
SELECT `Invoice ID`, `Branch`, `City`, COUNT(`Invoice ID`) AS cnt
FROM sales_data
GROUP BY `Invoice ID`, `Branch`, `City`
HAVING cnt > 1;

SELECT `Product line` FROM sales_data;

### Getting Data
# Find the Most sold product
SELECT `Product line`, SUM(Total) as sales
FROM sales_data
GROUP BY `Product line`
ORDER BY sales DESC;

# City with the most purchases
SELECT City, SUM(Total) as sales
FROM sales_data
GROUP BY City
ORDER BY sales DESC;

# Checking the sales in each city by product
SELECT 'City' AS category, City AS item, sales
FROM (
    SELECT City, SUM(Total) AS sales
    FROM sales_data
    GROUP BY City
    ORDER BY sales DESC
) AS city_sales

UNION ALL

SELECT 'Product line' AS category, `Product line` AS item, sales
FROM (
    SELECT `Product line`, SUM(Total) AS sales
    FROM sales_data
    GROUP BY `Product line`
    ORDER BY sales DESC
) AS product_sales;

# Branch with the most sales
SELECT Branch, SUM(Total) as sales
FROM sales_data
GROUP BY Branch
ORDER BY sales DESC;

# Check Product against Cost of Goods Sold and Sales
SELECT 
    `Product line`, 
    SUM(Total) AS total_sales, 
    SUM(cogs) AS total_cogs, 
    SUM(Total) - SUM(cogs) AS Diff
FROM sales_data
GROUP BY `Product line`
ORDER BY Diff DESC;

# Customer type and Gender against sales
SELECT `Customer type`, Gender, SUM(Total) as sales
FROM sales_data
GROUP BY `Customer type`, Gender
ORDER BY sales DESC;

# Product sales against average ratings
SELECT `Product line`, AVG(Rating) ,SUM(Total) as sales
FROM sales_data
GROUP BY `Product line`
ORDER BY sales DESC;

# Sales volume
SELECT Branch, COUNT(Quantity) as Qty_Sales
FROM sales_data
GROUP BY Branch
ORDER BY Qty_Sales DESC;