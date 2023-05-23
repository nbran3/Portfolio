--- Finding the average price of a home for the year it was built
SELECT AVG(SalePrice) as AverageYearPrice, YearBuilt
FROM [Projects].[dbo].[Nashville$]
Group by YearBuilt 
ORDER by YearBuilt

--- finding the count of each different LandUse catergories 
SELECT LandUse, Count(*) as CountofLandUse
FROM [Projects].[dbo].[Nashville$]
GROUP by LandUse
ORDER by CountofLandUse DESC

--- Finding the top 50 properties in regard to Sale Price
SELECT TOP 50 SalePrice, PropertySplitAddress
FROM [Projects].[dbo].[Nashville$]
ORDER by SalePrice DESC

--- Finding propetery with the highest Total Value to Land Value ratio
SELECT Top 50 OwnerName, PropertySplitAddress, (TotalValue / LandValue) as ValuetoLandRatio
FROM [Projects].[dbo].[Nashville$]
ORDER by ValuetoLandRatio DESC

--- Finding the average Sales price with properties with at least 3 bedrooms and 2 full baths
SELECT AVG(SalePrice) as MiddleClassHomeSalePrice
FROM [Projects].[dbo].[Nashville$]
WHERE Bedrooms >= 3 AND 
FullBath >= 2

--- Finding the average sale price for each Land use category
SELECT LandUse, Count(*), AVG(SalePrice) as AvgLandUsePrice
FROM [Projects].[dbo].[Nashville$]
GROUP by LandUse
Order by AvgLandUsePrice DESC

--- Finding the Average sale price for homes by decade
SELECT
    CONCAT(FLOOR(YearBuilt / 10) * 10, '-', FLOOR(YearBuilt / 10) * 10 + 9) AS Decade,
    AVG(SalePrice) AS AverageSalePrice
FROM [Projects].[dbo].[Nashville$]
WHERE YearBuilt BETWEEN 1900 AND 2020
GROUP BY FLOOR(YearBuilt / 10)
ORDER by Decade


--- Finding average Total Value by decade
SELECT
    CONCAT(FLOOR(YearBuilt / 10) * 10, '-', FLOOR(YearBuilt / 10) * 10 + 9) AS Decade,
    AVG(TotalValue) AS AverageTotalValue
FROM [Projects].[dbo].[Nashville$]
WHERE YearBuilt BETWEEN 1900 AND 2020
GROUP BY FLOOR(YearBuilt / 10)
ORDER by Decade

--- Seeing if there is a correlation between the number of bedrooms and totalvalue
SELECT 
    (COUNT(*) * SUM(Bedrooms * totalvalue) - SUM(Bedrooms) * SUM(totalvalue)) /
    (SQRT((COUNT(*) * SUM(bedrooms * bedrooms) - SUM(bedrooms) * SUM(bedrooms)) *
          (COUNT(*) * SUM(totalvalue * totalvalue) - SUM(totalvalue) * SUM(totalvalue))))
    AS Correlation
FROM [Projects].[dbo].[Nashville$]

Create View AvgPriceByYear as 
SELECT AVG(SalePrice) as AverageYearPrice, YearBuilt
FROM [Projects].[dbo].[Nashville$]
Group by YearBuilt 

Create View LandUseCount as 
SELECT LandUse, Count(*) as CountofLandUse
 FROM [Projects].[dbo].[Nashville$]
 GROUP by LandUse

CREATE View Top50Properties as 
SELECT TOP 50 SalePrice, PropertySplitAddress
FROM [Projects].[dbo].[Nashville$]


Create View Top50ValuetoLand as
SELECT TOP 50 OwnerName, PropertySplitAddress, (TotalValue / LandValue) as ValuetoLandRatio
 FROM [Projects].[dbo].[Nashville$]


Create View AvgPriceofMiddleClassHouse as 
SELECT AVG(SalePrice) as MiddleClassHomeSalePrice
FROM [Projects].[dbo].[Nashville$]
 WHERE Bedrooms >= 3 AND 
FullBath >= 2

Create view AvgSalePriceLandUse as
SELECT LandUse, Count(*) as CountofLanduse, AVG(SalePrice) as AvgLandUsePrice
FROM [Projects].[dbo].[Nashville$]
GROUP by LandUse


Create view AvgSalePricebyDecade as 
SELECT
CONCAT(FLOOR(YearBuilt / 10) * 10, '-', FLOOR(YearBuilt / 10) * 10 + 9) AS Decade,
AVG(SalePrice) AS AverageSalePrice
FROM [Projects].[dbo].[Nashville$]
WHERE YearBuilt BETWEEN 1900 AND 2020
GROUP BY FLOOR(YearBuilt / 10)


Create view AvgTotalValuebyDecade as 
SELECT
CONCAT(FLOOR(YearBuilt / 10) * 10, '-', FLOOR(YearBuilt / 10) * 10 + 9) AS Decade,
AVG(TotalValue) AS AverageTotalValue
 FROM [Projects].[dbo].[Nashville$]
WHERE YearBuilt BETWEEN 1900 AND 2020
GROUP BY FLOOR(YearBuilt / 10)
