SELECT *
FROM dbo.Deaths$
ORDER BY 3,4

--SELECT *
--FROM dbo.Vaccine$
--order by 3,4

----- By Country

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM dbo.Deaths$
ORDER BY 1,2

-- Looking at total cases vs total deaths by country, Shows the likeihood of dying from COVID-19 infection by country 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM dbo.Deaths$
Where location like '%United States%'
ORDER BY 1,2

-- Looking at total case vs total population by country, shows how much of a population in one country has been infected by COVID-19
SELECT location, date, total_cases, population, (total_cases/population)*100 as InfectedPercentage
FROM dbo.Deaths$
Where location like '%United States%'
ORDER BY 1,2

-- Looking at the highest infected rate compared to population by country
SELECT location, MAX(total_cases) as PeakInfectionCount, population, MAX((total_cases/population))*100 as PeakInfectedPercentage
FROM dbo.Deaths$
--Where location like '%United States%'
GROUP BY population, location
ORDER BY PeakInfectedPercentage DESC


-- Looking at total deaths in a country compared to their population
SELECT location, MAX(cast(total_deaths as int)) as DeathCount
FROM dbo.Deaths$
WHERE continent is not null
GROUP by location
order by DeathCount desc

----- By Continent 
-- Deaths by Continent 
SELECT location, MAX(cast(total_deaths as int)) as ContinentDeathCount
FROM dbo.Deaths$
WHERE continent is null
GROUP by location
order by ContinentDeathCount desc

-- Cases by Continent
SELECT location, MAX(cast(total_cases as int)) as ContinentCasesCount
FROM dbo.Deaths$
WHERE continent is null
GROUP by location
order by ContinentCasesCount desc

----- Global

-- Cases per day 
SELECT date ,SUM(new_cases) as GlobalDailyCases
FROM dbo.Deaths$
WHERE continent is not null AND
new_cases is not null
GROUP by date
Order by 1, 2

-- Deaths per day
SELECT date, SUM(cast(new_deaths as int)) as GlobalDailyDeaths
FROM dbo.Deaths$
WHERE continent is not null and
new_deaths is not NULL
GROUP by date
ORDER by 1,2

-- Global Death Percentage per Day
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/ SUM(new_cases)*100 as GlobalDeathPercentage  
FROM dbo.Deaths$
WHERE continent is not null and
total_cases is not null
GROUP by date
ORDER by date



-------- Vaccination

--- Total Population compared to Vaccinated Population  
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by
dea.date) as DailyTotalVaccinationCount
FROM dbo.Deaths$ as dea
JOIN dbo.Vaccine$ as vac
	ON dea.location = vac.location AND
	dea.date = vac.date
WHERE vac.new_vaccinations is not null and
dea.continent is not null
order by 2,3

-- CTE Method for Total Population compared to Vaccinated Population by country
WITH PopVsVac (Continent, Location, Date, Population, new_vaccinations, DailyTotalVaccinations) 
as( 

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by
dea.date) as DailyTotalVaccinationCount
FROM dbo.Deaths$ as dea
JOIN dbo.Vaccine$ as vac
	ON dea.location = vac.location AND
	dea.date = vac.date
WHERE vac.new_vaccinations is not null and
dea.continent is not null 
)

SELECT *, (DailyTotalVaccinations / Population)*100
from PopVsVac

-- Temp Table Method for Total Population compared to Vaccinated Population by country
DROP Table if exists #PopsVsVac 
CREATE Table #PopsVsVac
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime, 
Population numeric,
new_vaccinations numeric,
DailyTotalVaccinationCount numeric,
)
INSERT into #PopsVsVac
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by
dea.date) as DailyTotalVaccinationCount
FROM dbo.Deaths$ as dea
JOIN dbo.Vaccine$ as vac
	ON dea.location = vac.location AND
	dea.date = vac.date
WHERE vac.new_vaccinations is not null and
dea.continent is not null 

SELECT *, (DailyTotalVaccinationCount/Population)*100
from #PopsVsVac


-- Creating View for Data Visulizations
Create View PopsVsVax as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by
dea.date) as DailyTotalVaccinationCount
FROM dbo.Deaths$ as dea
JOIN dbo.Vaccine$ as vac
	ON dea.location = vac.location AND
	dea.date = vac.date
WHERE vac.new_vaccinations is not null and
dea.continent is not null
