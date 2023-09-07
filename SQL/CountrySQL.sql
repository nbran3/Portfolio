--- Demographics Table Queries

--- Country with highest population 
SELECT TOP 1 Country, Population
From demographics$
Order By Population DESC

--- Average Population in entire dataset
SELECT AVG(Population) as AveragePop
From demographics$

--- Top 5 countries by C02 emissions per capita
SELECT TOP 5 Country, (Co2_Emissions / Population) as C02perCapita
FROM demographics$
GROUP by Country, Co2_Emissions, Population
ORDER by C02perCapita DESC

--- Top 5 countries by lowest population density
SELECT TOP 5 Country, (Land_area / Population) as PopDensity
FROM demographics$
GROUP by Country, Land_area, Population
ORDER by PopDensity DESC


--- Economics Table 

--- Average GDP in dataset
SELECT AVG(GDP) as AverageGDP
FROM economics$

--- Countries with a higher unemployment rate than 30% of their labor participation rate
SELECT Country, Unemployment_rate, LPR
FROM economics$
WHERE Unemployment_rate > LPR*.3

--- Average Unemployment for Countries who had a CPI change of greater than 2%
SELECT AVG(Unemployment_rate) as AvgUnemployment
FROM economics$
WHERE CPI_Change > .02

--- Country with highest GDP per capita
SELECT TOP 1 econ.Country, (econ.GDP / demo.Population) as GDPPerCapita
FROM economics$ as econ
JOIN demographics$ as demo
on econ.[country_id ] = demo.[country_id ]
ORDER by GDPPerCapita DESC

--- Health Table 


--- Average Life Expectancy for dataset
SELECT AVG([Life expectancy]) as LifeExpectancy
FROM health$

--- Countries with a birth rate higher than 20 births per 1000 people
SELECT health.Country, [Birth Rate], demo.Population
FROM health$ as health
JOIN demographics$ as demo
ON health.[country_id ] = demo.[country_id ]
WHERE [Birth Rate] > (20.0 / (demo.Population / 1000.0))
ORDER by [Birth Rate] DESC

---Countries with a infant mortality rate as the number of infant deaths per 1000 live births
SELECT Country, ([Infant mortality] / ([Birth Rate] / 1000)) as InfantDeathsper1000
FROM health$ 
GROUP by Country, [Infant mortality], [Birth Rate]
ORDER by InfantDeathsper1000 DESC

--- Top 5 countries with the highest ratio life expetancy to GDP per capita
SELECT TOP 5 health.Country, (((GDP/ Population) / [Life expectancy])) as Ratio, GDP, [Life expectancy]
FROM health$ as health
JOIN economics$ as econ
on health.[country_id ] = econ.[country_id ]
JOIN demographics$ as demo
ON demo.[country_id ] = health.[country_id ]
WHERE GDP is not null and [Life expectancy] is not null
ORDER by Ratio DESC

--- More Joining Examples

--- Finding countries where their unemployment rate is higher than the average, and their population
SELECT econ.Country, Unemployment_rate, LPR, Population 
FROM economics$ as econ
JOIN demographics$ as demo
on econ.[country_id ] = demo.[country_id ]
WHERE Unemployment_rate < (
    SELECT AVG(Unemployment_rate)
    FROM economics$
)
GROUP by econ.Country, Unemployment_rate, LPR, Population


--- Finding Top 15 countries by GDP per capita and their language
SELECT TOP 15 econ.Country, (GDP / Population) as GDPPerCapita, Official_language
FROM economics$ as econ
JOIN demographics$ as demo
on econ.[country_id ] = demo.[country_id ]
ORDER by GDPPerCapita DESC

--- Finding countries where their GDP, life expectancy and urban population is above the average, and for those countries displaying  minimum wage, infant mortality rate per 1000, and population density
SELECT econ.Country, Minimum_wage, ([Infant mortality] / 1000) as Infantper1000, (Population / Land_area) as PopDensity
FROM economics$ as econ
JOIN demographics$ as demo
on econ.[country_id ] = demo.[country_id ]
JOIN health$ as health
on econ.[country_id ] = health.[country_id ]
WHERE GDP >(
    SELECT AVG(GDP)
    FROM economics$ 
)
AND [Life expectancy] > (
    SELECT AVG([Life expectancy])
    FROM health$
)
AND Urban_population > (
    SELECT AVG(Urban_population)
    FROM demographics$
)
AND [Minimum wage] is not NULL
ORDER by PopDensity, [Minimum wage], [Infant mortality]
