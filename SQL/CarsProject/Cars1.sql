--- Finding Distinct Countries in Country Dataset.
SELECT DISTINCT(country)
from dbo.country$

--- Finding Distinct manufacturers in Details Dataset. 
SELECT DISTINCT(manufacturer)
from details$

--- Finding most produced model in dataset.
SELECT TOP 1 COUNT(model) TotalCount, model, manufacturer
from details$
GROUP by model, manufacturer
ORDER by TotalCount DESC

--- Finding Average Price and Average Mileage by Car Catergory. (SUV, Sedan, etc) (Aggreagtion used)
SELECT AVG(mileage) as AverageMileage, AVG(price) as AveragePrice, category
from details$
GROUP by category
ORDER by category

--- Finding Average Price by Country. (Join and Aggreagtion used)
SELECT avg(price) as AveragePrice, country
from details$ 
JOIN country$
on details$.ID = country$.ID
GROUP by country
ORDER by AveragePrice DESC

--- Finding Top 5 Models by Price for each country. (Join, Where and Order by used)
SELECT top 5 price, model, country
from details$
JOIN country$
on details$.id = country$.id 
WHERE country = 'Germany'
ORDER by Price DESC


--- Finding Average Price of all cars for each manufacturer and their orginal country. (Join, Aggreagtion, Where, Group and Order by used)
SELECT AVG(price) as AVGPrice, manufacturer, country
from details$
JOIN country$
on details$.id = country$.id
WHERE year >= 2017
GROUP by country, manufacturer
ORDER by AVG(Price) DESC

--- Finding Percent of each car type (SUV,sedan, etc) that have a Black Interior by Country. (Case, Aggreagtion, Join, Where and Group by used)
SELECT category, country, (COUNT(CASE WHEN interior_color = '  Black ' THEN 1 ELSE NULL END) * 100 / COUNT(*)) as percent_black_interior
from details$
JOIN country$
on details$.id = country$.id
WHERE mileage > 100000
GROUP by category, country

--- Finding the total number of cars in the dataset that were made before 2010 for each manufacturer. (Aggreagtion, Join, Where, Group by used)
SELECT COUNT(manufacturer) as CountManufacturer, manufacturer, country
from details$
JOIN country$
on details$.id = country$.id
WHERE Year <= 2010
GROUP by country, manufacturer

--- Finding the Average Mileage, Year, Mininum and Maximum Price for each manufacturer. (Scalar, Aggreagtion, Join, Group by used) 
SELECT AVG(mileage) as AverageMileage, ROUND(AVG(Year),0) as AverageYear, MIN(price) as LowestPrice, MAX(Price) as MaxPrice, manufacturer
from details$
JOIN country$
on details$.id = country$.id
GROUP by manufacturer

--- Finding the total number of cars, total price of all cars summed up, and total mileage for all car summed up for each manufacturer. (Aggreagtion, Join, Group by used)
SELECT Count(manufacturer) as TotalCars, SUM(Price) as TotalPrice, SUM(mileage) as TotalMileage, manufacturer
from details$
JOIN country$
on details$.id = country$.id
GROUP by manufacturer

--- Finding Total Count of Cars over the Price of 20000 for each manufacturer and Average Price of cars that are above 20000. (Case,Aggreagtion, Join, Group and Order by used) 
SELECT (COUNT(CASE WHEN Price >= 20000 THEN 1 ELSE 'No Cars Above $20000' END)) as CountOver20000, AVG(price) as AVGPrice, model, manufacturer, country
from details$
JOIN country$
on details$.id = country$.id
WHERE Price >= 20000
GROUP by country,manufacturer,model
ORDER by country, AVGPrice DESC

---- Finding Cars that have a mileage of under 10000, interior color of black and a leather interior (Comman Table Expression (CTE), Window function, Joins, Where used)
With Cars as (
    SELECT Price, Country, Model, ROW_NUMBER() OVER(PARTITION BY Country order by price DESC) as sure
    from details$
    JOIN country$
    on details$.id = country$.id
    WHERE mileage < 10000 and interior_color = '  Black ' and leather_interior = '1'
)
SELECT Price, country, model
FROM Cars
WHERE sure <= 5

--- Finding top car models that don't have an automatic transmission by country. (CTE, Window, Join, Where used)
With RankModels as(
    SELECT model, category, country, ROW_NUMBER() OVER(PARTITION BY Country order by model) as ok
    FROM details$
    JOIN country$
    ON details$.id = country$.id
    WHERE gear_box_type <> 'Automatic'
)
SELECT model, category, country
FROM RankModels
WHERE ok <= 5

--- Finding top 5 colors of cars for South Korea (Subquery, Join, Where, Order by used)
SELECT TOP 5 color, country
FROM (
    SELECT DISTINCT color, country
    FROM details$
    JOIN country$
    ON details$.id = country$.id
    WHERE country = 'South Korea'
) AS Subquery
ORDER BY color DESC;


--- Finding the top Manufacturer for each country (Subquery, Window function, Aggreagtion, Join, Where, Group and Order by used)
SELECT Country, MAX(PopularManufacturer) AS PopularManufacturer, Manufacturer
from (
    SELECT Country as country, manufacturer as manufacturer, count(manufacturer) as PopularManufacturer, ROW_NUMBER() OVER (PARTITION by COUNTRY ORDER by COUNT(manufacturer) DESC) as sub
    from details$
    join country$
    on details$.id = country$.ID
    GROUP by Country, manufacturer
) as subquery
WHERE sub = 1
GROUP by Country, Manufacturer
ORDER by Country 

--- Finding top type of car (Sedan, SUV, etc) for each country. (Subquery, Window function, Aggreagtion, Join, Where, Group and Order by used)
SELECT Country, MAX(category) as TopCategory
from (
    SELECT Country as country, category as category, count(category) as categoryCount, ROW_NUMBER() OVER(Partition by Country order by COUNT(category) DESC) as sub2
    FROM details$
    JOIN country$ 
    ON details$.id = country$.id
    GROUP BY country, category
) as subquery2
WHERE sub2 = 1
GROUP by country, category
ORDER by Topcategory 

--- Finding top type of car model for each country. (Subquery, Window function, Aggreagtion, Join, Where, Group and Order by used)
SELECT Country, MAX(Model) AS PopularModel
FROM (
    SELECT
        country AS country, model AS model, COUNT(model) AS ModelCount, ROW_NUMBER() OVER (PARTITION BY COUNTRY ORDER BY COUNT(model) DESC) AS RowNum
    FROM details$
    JOIN country$
    ON details$.id = country$.id
    GROUP BY country, model
) AS Subquery3
WHERE RowNum = 1
GROUP BY Country
ORDER BY Country;
