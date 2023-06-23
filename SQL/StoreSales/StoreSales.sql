--- Creating new columns such as Revenue, Profit Margin, and more
Alter Table [Projects].[dbo].[StoreSales$] ADD Revenue DECIMAL(10,2)

Update [Projects].[dbo].[StoreSales$]
SET Revenue = Sales * Quantity

Alter Table [Projects].[dbo].[StoreSales$] ADD ProfitMargin DECIMAL(10,2)

Update [Projects].[dbo].[StoreSales$]
SET ProfitMargin = (Profit/ Revenue) * 100

Alter Table [Projects].[dbo].[StoreSales$] ADD DiscountedPriceDiff DECIMAL(10,2)

Update Projects.dbo.StoreSales$
SET DiscountedPriceDiff  =  Sales - (Sales * Discount)

Alter Table [Projects].[dbo].[StoreSales$] ADD OrderDuration INT

Update [Projects].[dbo].[StoreSales$]
SET OrderDuration = DATEDIFF(day, Order_Date, Ship_Date)

ALTER TABLE Projects.dbo.StoreSales$ ADD Order_Month INT;
ALTER TABLE Projects.dbo.StoreSales$ ADD Order_Year INT;

UPDATE Projects.dbo.StoreSales$
SET Order_Month = MONTH(Order_Date),
    Order_Year = YEAR(Order_Date);

SELECT *
from Projects.dbo.StoreSales$

---Looking at average Sales, the sum of sales, average discount, and other metrics per region (East, South, Midwest, West) 
Select DISTINCT State
from Projects.dbo.StoreSales$
WHERE region = 'West'


SELECT AVG(sales) as AvgSales, Region, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Order_Year, Region
ORDER by AvgSales

SELECT sum(sales) as TotalSales, Region, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Order_Year, Region
ORDER by Order_Year

SELECT sum(revenue) as TotalRev, Region, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Region, Order_Year
ORDER by Order_Year

SELECT avg(Discount) as AVGDiscount, Region, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Order_Year,Region
ORDER by Order_Year, AvgDiscount

SELECT sum(Quantity) as TotalQuan, Region, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Region, Order_Year
ORDER by Order_Year

SELECT avg(OrderDuration) as AvgOrderDuration, Region, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Region, Order_Year
ORDER by Order_Year

--- Finding metrics by states
SELECT AVG(sales) as AvgSales, [State], Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Order_Year, [State]
ORDER by AvgSales

SELECT sum(sales) as TotalSales, State, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Order_Year, [State]
ORDER by Order_Year

SELECT sum(revenue) as TotalRev, [State], Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY [State], Order_Year
ORDER by Order_Year

SELECT avg(Discount) as AVGDiscount, [State], Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Order_Year,[State]
ORDER by Order_Year, AvgDiscount

SELECT sum(Quantity) as TotalQuan, [State], Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY [State], Order_Year
ORDER by Order_Year

SELECT avg(OrderDuration) as AvgOrderDuration, State, Order_Year
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State, Order_Year
ORDER by Order_Year

--- Finding the most common shipping method by state, that is not standard class
SELECT MAX(Ship_Mode) as MostCommonShipMethod, State
FROM [Projects].[dbo].[StoreSales$]
WHERE Ship_Mode <> 'Standard Class'
Group by State
ORDER by MostCommonShipMethod

--- Finding the most popular category purchase state
SELECT Max(Category) as MostPopularCategory, State
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State

--- Finding average discount by category
Select category, avg(discount) as AvgDiscount
FROM [Projects].[dbo].[StoreSales$]
GROUP by category

--- Finding individual customers most purchase categories
SELECT Customer_ID, Max(Category) as MostPopularCategory
FROM [Projects].[dbo].[StoreSales$]
GROUP by Customer_ID

--- Finding the most profitable category by state
SELECT Category, State, SUM(profit) as TotalProfits
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State, Category
ORDER by TotalProfits DESC


--- Finding the average profits by category by state
SELECT Category, State, AVG(profit) as AverageProfits
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State, Category
ORDER by AverageProfits DESC

--- Which customers generate the most sales
SELECT Customer_Id, Sum(sales) as CustomerSales
FROM [Projects].[dbo].[StoreSales$]
GROUP by Customer_ID
ORDER by CustomerSales DESC

--- Which customers generate the most profit.
SELECT Customer_Id, Sum(profit) as CustomerProfit
FROM [Projects].[dbo].[StoreSales$]
GROUP by Customer_ID
ORDER by CustomerProfit DESC

--- Which customers use discounts
SELECT Customer_Id, Sum(profit) as CustomerProfit, sum(sales) as CustomerSales
FROM [Projects].[dbo].[StoreSales$]
WHERE discount <> '0'
GROUP by Customer_ID
ORDER by CustomerProfit DESC


--- Seeing the difference in profit from a customer when there is a discount versus when there is no discount
SELECT Customer_Id, Sum(CASE WHEN Discount > 0 Then profit ELSE 0 END) As ProfitWithDiscount,
SUM(CASE When Discount = 0 THEN profit ELSE 0 END) AS ProfitWithoutDiscount,
(SUM(CASE WHEN Discount > 0 Then profit Else 0 END)- SUM(CASE When Discount = 0 THEN profit ELSE 0 END)) AS ProfitDifference
FROM [Projects].[dbo].[StoreSales$]
GROUP by Customer_ID


--- Finding total profits with discount versus no discount by state
SELECT State, Sum(CASE WHEN Discount > 0 Then profit ELSE 0 END) As StateProfitWithDiscount,
SUM(CASE When Discount = 0 THEN profit ELSE 0 END) AS StateProfitWithoutDiscount
FROM [Projects].[dbo].[StoreSales$]
Group by State
ORDER by State DESC


--- Finding if there is any correlation between sales and discounts, since azure has no CORREL function I have to do it the long way
SELECT 
    (COUNT(*) * SUM(Sales * Discount) - SUM(Sales) * SUM(Discount)) /
    (SQRT((COUNT(*) * SUM(Sales * Sales) - SUM(Sales) * SUM(Sales)) *
          (COUNT(*) * SUM(Discount * Discount) - SUM(Discount) * SUM(Discount))))
    AS Correlation
FROM [Projects].[dbo].[StoreSales$]

--- Finding average profit by year by state
SELECT YEAR(Order_Date) as OrderYear, State, AVG(Profit) as AvgProfit
FROM [Projects].[dbo].[StoreSales$]
GROUP BY YEAR(Order_Date), State
ORDER by OrderYear, State

--- Finding average sale price for individual customers in techonology cateimgory
SELECT Customer_ID, AVG(Sales) as AvgSales
FROM [Projects].[dbo].[StoreSales$]
WHERE Category = 'Technology'
GROUP by Customer_ID


--- Finding biggest profit margin by customer
SELECT Customer_ID, (Profit / Sales) as ProfitMargin
FROM [Projects].[dbo].[StoreSales$]
ORDER by ProfitMargin DESC

--- Finding the Sales, Profit and ProfitMargin for each month of the dataset
Select YEAR(Order_Date) as OrderYear, DATENAME(Month, Order_Date) as OrderMonth, MONTH(Order_Date) as MonthNumber, SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, (SUM(Profit) / SUM(Sales) * 100) as TotalProfitMargin
FROM [Projects].[dbo].[StoreSales$]
GROUP BY YEAR(Order_Date), DATENAME(Month, Order_Date), MONTH(Order_Date)
ORDER BY YEAR(Order_Date), MONTH(Order_Date)

