---Looking at average Sales per region (East, South, Midwest, West) 
SELECT AVG(sales) as AvgSales, Region
FROM [Projects].[dbo].[StoreSales$]
GROUP BY Region
ORDER by AvgSales

--- Finding Average profit by State
Select State, AVG(profit)
FROM [Projects].[dbo].[StoreSales$]
GROUP by State

--- Finding the most common shipping method by state, that is not standard class
SELECT MAX(Ship_Mode) as MostCommonShipMethod, State
FROM [Projects].[dbo].[StoreSales$]
WHERE Ship_Mode <> 'Standard Class'
Group by State
ORDER by MostCommonShipMethod

--- Finding the most popular catergory purchase state
SELECT Max(Category) as MostPopularCategory, State
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State

--- Finding average discount by category
Select category, avg(discount) as AvgDiscount
FROM [Projects].[dbo].[StoreSales$]
GROUP by category

--- Finding individual customers most purchase category
SELECT Customer_ID, Max(Category) as MostPopularCategory
FROM [Projects].[dbo].[StoreSales$]
GROUP by Customer_ID

--- Finding the most profitable catergory by state
SELECT Category, State, SUM(profit) as TotalProfits
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State, Category
ORDER by TotalProfits DESC


--- Finding the average profits by catergory by state
SELECT Category, State, AVG(profit) as AverageProfits
FROM [Projects].[dbo].[StoreSales$]
GROUP BY State, Category
ORDER by AverageProfits DESC

--- Which customers generate the most sales
SELECT Customer_Id, Sum(sales) as CustomerSales
FROM [Projects].[dbo].[StoreSales$]
GROUP by Customer_ID
ORDER by CustomerSales DESC

--- Which customers genereate the most profit.
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

--- Finding avereage profit by year by state
SELECT YEAR(Order_Date) as OrderYear, State, AVG(Profit) as AvgProfit
FROM [Projects].[dbo].[StoreSales$]
GROUP BY YEAR(Order_Date), State
ORDER by OrderYear, State
