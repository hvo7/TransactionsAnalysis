---- Show all of the data
--SELECT *
--FROM dbo.Retail_Transaction_Dataset

---- Summary: What is the total revenue, number of customers, number of transactions, and total goods sold?

---- Total Revenue
--SELECT SUM(TotalAmount) AS Total_Revenue
--FROM dbo.Retail_Transaction_Dataset

---- Number of Customers
--SELECT COUNT(DISTINCT(CustomerID)) AS Num_of_Customers
--FROM dbo.Retail_Transaction_Dataset

---- Number of Transactions
--SELECT COUNT(CustomerID)
--FROM dbo.Retail_Transaction_Dataset

---- Total Goods sold
--SELECT SUM(Quantity) AS Total_Volume
--FROM dbo.Retail_Transaction_Dataset



---- Which Product sells the most sales on average and how many units are sold?

--SELECT ProductID, ProductCategory, ROUND(AVG(TotalAmount),2) AS Avg_Sales, COUNT(ProductID) AS AmountSold
--FROM dbo.Retail_Transaction_Dataset
--GROUP BY ProductID, ProductCategory
--ORDER BY Avg_Sales DESC


---- What times of the year sell the most on average?

--SELECT MONTH(TransactionDate) AS MONTH, DAY(TransactionDate) AS DAY, AVG(TotalAmount) AS Avg_Sales
--FROM dbo.Retail_Transaction_Dataset
--GROUP BY MONTH(TransactionDate), DAY(TransactionDate)
--ORDER BY Avg_Sales DESC




-- What year has sold the most avg sales? *

--SELECT YEAR(TransactionDate) AS YEAR, AVG(TotalAmount) AS Avg_Sales
--FROM dbo.Retail_Transaction_Dataset
--GROUP BY Year(TransactionDate)
--ORDER BY Avg_Sales DESC




-- How many types for each Product Category?

--SELECT ProductCategory, COUNT(*) AS Count
--FROM dbo.Retail_Transaction_Dataset
--GROUP BY ProductCategory
--ORDER BY Count DESC




-- What is the range of dates of the data?
 
--SELECT DISTINCT 
--		MONTH(TransactionDate) AS month,
--		Year(TransactionDate) AS year
--FROM dbo.Retail_Transaction_Dataset
--ORDER BY year, month




-- What is the sum of the sales in April 2023?

--SELECT SUM(TotalAmount) AS Total_Sales, 
--       MONTH(TransactionDate) AS month,
--       YEAR(TransactionDate) AS year
--FROM dbo.Retail_Transaction_Dataset AS Sales
--WHERE MONTH(TransactionDate) = 4 AND YEAR(TransactionDate) = 2023
--GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)

-- Are there any customers or StoreLocations with more than 2 transactions?


--SELECT CustomerID
--FROM dbo.Retail_Transaction_Dataset
--GROUP BY CustomerID
--HAVING COUNT(*) > 2

--SELECT StoreLocation
--FROM dbo.Retail_Transaction_Dataset
--GROUP BY StoreLocation
--HAVING COUNT(*) > 1



-- Also, for recurring customers, do they buy the same products?

--SELECT CustomerID, ProductID, COUNT(*) AS PurchaseCount
------FROM (
------  SELECT *,
------         ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY TransactionDate) AS RowNum
------  FROM dbo.Retail_Transaction_Dataset
------) AS RankedTransactions

------WHERE CustomerID = PreviousCustomerID
------  AND ProductID = PreviousProductID
------  AND RowNum > PreviousRowNum + 1
------GROUP BY CustomerID, ProductID
------HAVING COUNT(*) > 1;

---- Check for Total Revenue in Louisiana for each zipcode

--WITH LA_Zipcodes AS (
--	SELECT TotalAmount, StoreLocation, SUBSTRING(StoreLocation, LEN(StoreLocation) - 4, 5) AS Zipcode
--	FROM dbo.Retail_Transaction_Dataset
--	WHERE StoreLocation LIKE '%, LA%'
--)

--SELECT Zipcode, Sum(TotalAmount) AS Total_Sales
--FROM LA_Zipcodes
--GROUP BY Zipcode;
