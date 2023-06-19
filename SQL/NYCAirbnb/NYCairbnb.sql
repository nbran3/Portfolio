--This is a dataset that has AirBNB listings of New York City from 2019-2020
SELECT *
FROM new_york$

-- Finding the average price of an AirBNB in NYC
SELECT AVG(Price) as AverageNYCPrice
FROM new_york$

-- Finding the average price of an AirBNB in NYC by neighbourhood
SELECT AVG(Price) as AveragePrice, neighbourhood
FROM new_york$
GROUP by neighbourhood

-- Finding the average days occupied for an AirBNB by NYC neighbourhood
SELECT AVG(days_occupied_in_2019) as AverageDays, neighbourhood
FROM new_york$
GROUP by neighbourhood

-- Finding the average price and the average days occupied for an AirBNB by NYC neighbourhood
SELECT AVG(Price) as AveragePrice, AVG(days_occupied_in_2019) as AverageDays, neighbourhood
FROM new_york$
GROUP by neighbourhood

-- Creating and adding a new column in the database called "Price_to_Occupancy_Ratio", which is the ratio of the average price divided by the average duration occuppied by NYC neighbourhood. 
SELECT AVG(Price) as AveragePrice, AVG(days_occupied_in_2019) as AverageDays, (AVG(Price)/ AVG(days_occupied_in_2019)) as Price_to_Occupancy_Ratio, neighbourhood
FROM new_york$
GROUP by neighbourhood

ALTER TABLE new_york$
ADD Price_to_Occupancy_Ratio DECIMAL(10, 14)

UPDATE new_york$
SET Price_to_Occupancy_Ratio = temp_utility.Utility
FROM (
  SELECT neighbourhood, AVG(Price) / AVG(days_occupied_in_2019) AS Utility
  FROM new_york$
  GROUP BY neighbourhood
) AS temp_utility
WHERE new_york$.neighbourhood = temp_utility.neighbourhood;

-- Looking at the new column
SELECT *
from new_york$

-- Finding the average number of AirBNB reviews per NYC neighbourhood
SELECT AVG(number_of_reviews) as AverageReviews, neighbourhood
FROM new_york$
GROUP by neighbourhood

-- Creating and adding a new column in the database called "Price_to_Reviews_Ratio", which is the ratio of the average price divided by the average total number of reviews of AirBNBs by NYC neighbourhood. 
SELECT AVG(Price) as AveragePrice, AVG(number_of_reviews) as AverageReviews, (AVG(Price)/ AVG(number_of_reviews)) as Price_to_Reviews_Ratio, neighbourhood
FROM new_york$
GROUP by neighbourhood

ALTER TABLE new_york$
ADD Price_to_Reviews_Ratio DECIMAL(18, 10)

UPDATE new_york$
SET Price_to_Reviews_Ratio = temp_reviews.Reviews
FROM (
  SELECT neighbourhood, AVG(Price) / AVG(number_of_reviews) AS Reviews
  FROM new_york$
  GROUP BY neighbourhood
) AS temp_reviews
WHERE new_york$.neighbourhood = temp_reviews.neighbourhood;

-- Looking at the new column
SELECT *
from new_york$

-- Finding the Average Price and the Average Price to Occupancy and Reviews ratios for all NYC AirBnb's
SELECT Avg(Price_to_Occupancy_Ratio) as PtOratio, AVG(Price_to_Reviews_Ratio) as PtRratio, AVG(price) as AveragePrice
from new_york$

-- Finding specific AirBnB's that have a high Price to Occupancy Ratio
SELECT Price, Price_to_Occupancy_Ratio, neighbourhood, id 
from new_york$
WHERE Price_to_Occupancy_Ratio > 1.50
GROUP by neighbourhood, price, Price_to_Occupancy_Ratio, id
ORDER by Price DESC

-- Finding specific AirBnB's that have a high Price to Reviews Ratio
SELECT Price, Price_to_Reviews_Ratio, neighbourhood, id 
from new_york$
WHERE Price_to_Reviews_Ratio > 3.50
GROUP by neighbourhood, price, Price_to_Reviews_Ratio, id
ORDER by neighbourhood, Price DESC

-- Finding the Average Price and the Average Price to Occupancy and Reviews ratios for the 5 major NYC borough AirBnb's
SELECT AVG(Price) as PriceBorough, AVG(days_occupied_in_2019) as OccupancyDaysBorough, AVG(Price_to_Occupancy_Ratio) as PtORatioBorough, AVG(number_of_reviews) as AvgNumberofReviewsBorough, AVG(Price_to_Reviews_Ratio) as PtRRatioBorough, neighbourhood
from new_york$
WHERE neighbourhood IN ('Manhattan', 'Brooklyn', 'Queens', 'Staten Island', 'The Bronx')
GROUP by neighbourhood
ORDER by PtORatioBorough DESC, PtRRatioBorough DESC

-- Case statemnt to catergorize each NYC neighbourhood as being above or below average for Average Price and the Average Price to Occupancy and Reviews ratios
SELECT id ,neighbourhood, AVG(Price_to_Occupancy_Ratio) AS PtOratio, AVG(Price_to_Reviews_Ratio) AS PtRratio, AVG(price) AS AveragePrice,
  CASE
    WHEN neighbourhood IN (
      SELECT neighbourhood
      FROM new_york$
      GROUP BY neighbourhood
      HAVING AVG(Price_to_Occupancy_Ratio) > 0.83280508877192
    ) THEN 'Above Average'
    ELSE 'Below Average'
  END AS PtoO_Comparison,
  CASE 
    WHEN neighbourhood IN (
      SELECT neighbourhood
      FROM new_york$
      GROUP BY neighbourhood
      HAVING AVG(Price_to_Reviews_Ratio) > 2.7584223984
    ) THEN 'Above Average'
    ELSE 'Below Average'
  END AS PtoR_Comparison,
  CASE
    WHEN neighbourhood IN (
      SELECT neighbourhood
      FROM new_york$
      GROUP BY neighbourhood
      HAVING AVG(Price) > 145.4554898511752
    ) THEN 'Above Average'
    ELSE 'Below Average'
  END AS PriceComparison
FROM new_york$
GROUP BY id, neighbourhood;

-- Adding columns to table/database
ALTER TABLE new_york$
ADD PtoO_Comparison VARCHAR(15);

UPDATE new_york$
SET PtoO_Comparison = CASE
                        WHEN id IN (
                          SELECT id
                          FROM new_york$
                          GROUP BY id
                          HAVING AVG(Price_to_Occupancy_Ratio) > 0.83280508877192
                        ) THEN 'Above Average'
                        ELSE 'Below Average'
                      END;

ALTER TABLE new_york$
ADD PtoR_Comparison VARCHAR(15);

UPDATE new_york$
SET PtoR_Comparison = CASE
                        WHEN id IN (
                          SELECT id
                          FROM new_york$
                          GROUP BY id
                          HAVING AVG(Price_to_Reviews_Ratio) > 2.7584223984
                        ) THEN 'Above Average'
                        ELSE 'Below Average'
                      END;

ALTER TABLE new_york$
ADD PriceComparison VARCHAR(15);

UPDATE new_york$
SET PriceComparison = CASE
                        WHEN id IN (
                          SELECT id
                          FROM new_york$
                          GROUP BY id
                          HAVING AVG(Price) > 145.4554898511752
                        ) THEN 'Above Average'
                        ELSE 'Below Average'
                      END;


select *
from new_york$
