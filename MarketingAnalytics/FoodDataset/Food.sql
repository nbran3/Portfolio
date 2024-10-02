SELECT TOP (1000) *
FROM [Projects].[dbo].[food]

--- Updating Columnn Data Types for SQL querying
ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN Year_Birth INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN Income INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN Recency INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN MntWines INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN MntFruits INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN MntMeatProducts INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN MntFishProducts INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN MntSweetProducts INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN NumDealsPurchases INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN NumStorePurchases INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN NumCatalogPurchases INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN NumWebPurchases INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN AcceptedCmp1 INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN AcceptedCmp2 INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN AcceptedCmp3 INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN AcceptedCmp4 INT

ALTER TABLE [Projects].[dbo].[food]
ALTER COLUMN AcceptedCmp5 INT

--- Finding average, minimum and maximum Years of Birth/ Age.
SELECT AVG(Year_Birth) as Average_BirthYear, MIN(Year_Birth) as Youngest_BirthYear, MAX(Year_Birth) as Oldest_BirthYear
FROM [Projects].[dbo].[food]

--- Summary statistics of Income column
SELECT TOP 1 Income AS Mode_Income
FROM [Projects].[dbo].[food]
WHERE Income <> 0
GROUP BY Income
ORDER BY COUNT(*) DESC;

SELECT AVG(Income) as Average_Income, MIN(Income) as Lowest_Income, MAX(Income) as Biggest_Income
FROM [Projects].[dbo].[food]

--- Finding the education level counts of the population
SELECT DISTINCT(Education), COUNT(Education) as Count_of_Education
FROM [Projects].[dbo].[food]
GROUP by Education

--- Finding the count marital status of the population
SELECT DISTINCT(Marital_Status), COUNT(Marital_Status) as Count_of_Marital_Status
FROM [Projects].[dbo].[food]
GROUP by Marital_Status


--- Finding the percentage of households that have kids, teens, or both at the same time
SELECT ID, COUNT(*) AS Occurrences
FROM [Projects].[dbo].[food]
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT 
    COUNT(CASE WHEN Kidhome > 0 THEN 1 END) AS Households_With_Kids,
    COUNT(ID) AS Total_Households,
    COUNT(CASE WHEN Kidhome > 0 THEN 1 END) * 100.0 / COUNT(ID) AS Percent_With_Kids
    
FROM [Projects].[dbo].[food];


SELECT 
    COUNT(CASE WHEN Teenhome > 0 THEN 1 END) AS Households_With_Teens,
    COUNT(ID) AS Total_Households,
    COUNT(CASE WHEN Teenhome > 0 THEN 1 END) * 100.0 / COUNT(ID) AS Households_With_Teens
    
FROM [Projects].[dbo].[food];

SELECT 
    COUNT(CASE WHEN Teenhome > 0 AND Kidhome > 0 THEN 1 END) AS Households_With_Both,
    COUNT(ID) AS Total_Households,
    COUNT(CASE WHEN Teenhome > 0 and Kidhome > 0  THEN 1 END) * 100.0 / COUNT(ID) AS Households_With_Both
FROM [Projects].[dbo].[food];


--- Finding the average number of since last purchase
SELECT AVG(Recency) as Average_Recency
FROM [Projects].[dbo].[food];


--- Finding the sums of each category
SELECT SUM(MntWines) as Wines, SUM(MntFruits) as Fruits, SUM(MntFishProducts) as Fish, SUM(MntGoldProds) as Gold, SUM(MntSweetProducts) as Sweets, SUM(MntMeatProducts) as Meats
FROM [Projects].[dbo].[food]

--- Finding how many customers used deals for purchase/ CTE
WITH PurchaseStats AS (
    SELECT 
        SUM(NumWebPurchases + NumStorePurchases + NumCatalogPurchases + NumDealsPurchases) AS Total_Purchases,
        SUM(CASE WHEN NumDealsPurchases > 0 THEN NumDealsPurchases ELSE 0 END) AS Total_DealPurchases
    FROM [Projects].[dbo].[food]
)
SELECT 
    Total_Purchases,
    (Total_DealPurchases * 100.0) / Total_Purchases AS PercentofDealPurchases
FROM PurchaseStats;


--- Finding the most succesful marketing campaign 
SELECT COUNT(CASE WHEN AcceptedCmp1 > 0 THEN 1 END) AS Campaign1_Accepted_Count,
       COUNT(ID) AS Total_Users,
       COUNT(CASE WHEN AcceptedCmp1 > 0 THEN 1 END) * 100.0 / COUNT(ID) as Campaign1_Acceptance_Rate
FROM [Projects].[dbo].[food]


SELECT COUNT(CASE WHEN AcceptedCmp2 > 0 THEN 1 END) AS Campaign2_Accepted_Count,
       COUNT(ID) AS Total_Users,
       COUNT(CASE WHEN AcceptedCmp2 > 0 THEN 1 END) * 100.0 / COUNT(ID) as Campaign2_Acceptance_Rate
FROM [Projects].[dbo].[food]

SELECT COUNT(CASE WHEN AcceptedCmp3 > 0 THEN 1 END) AS Campaign3_Accepted_Count,
       COUNT(ID) AS Total_Users,
       COUNT(CASE WHEN AcceptedCmp3 > 0 THEN 1 END) * 100.0 / COUNT(ID) as Campaign3_Acceptance_Rate
FROM [Projects].[dbo].[food]

SELECT COUNT(CASE WHEN AcceptedCmp4 > 0 THEN 1 END) AS Campaign4_Accepted_Count,
       COUNT(ID) AS Total_Users,
       COUNT(CASE WHEN AcceptedCmp4 > 0 THEN 1 END) * 100.0 / COUNT(ID) as Campaign4_Acceptance_Rate
FROM [Projects].[dbo].[food]

SELECT COUNT(CASE WHEN AcceptedCmp5 > 0 THEN 1 END) AS Campaign5_Accepted_Count,
       COUNT(ID) AS Total_Users,
       COUNT(CASE WHEN AcceptedCmp5 > 0 THEN 1 END) * 100.0 / COUNT(ID) as Campaign5_Acceptance_Rate
FROM [Projects].[dbo].[food]

--- Finding the percentage of customers who accepted multiple campaigngs
SELECT 
    COUNT(ID) AS Total_Customers,
    COUNT(CASE WHEN (AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + AcceptedCmp4 + AcceptedCmp5) > 1 THEN 1 END) AS MultiCampaign_Accepted_Count,
    (COUNT(CASE WHEN (AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + AcceptedCmp4 + AcceptedCmp5) > 1 THEN 1 END) * 100.0) / COUNT(ID) AS MultiCampaign_Acceptance_Percentage
FROM [Projects].[dbo].[food];
