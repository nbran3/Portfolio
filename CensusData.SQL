Select *
FROM Projects.dbo.Education$

Select count(state) as State
from Projects.dbo.Education$

-- Bachelor Degree Percentage by State 
Select College_Graduate / Total_State as Total_Bachelor_State, State
from Projects.dbo.Education$

--- Ordering State by Highest Bachelor Degree Percentage 
Select College_Graduate / Total_State as Total_Bachelor_State, State
from Projects.dbo.Education$
ORDER BY Total_Bachelor_State DESC

--- Ordering by Highest Bachelor Degree Percentage, where percentage is greater than 20%, limiting top 10 
Select TOP 10 College_Graduate / Total_State as Total_Bachelor_State, State
from Projects.dbo.Education$
WHERE College_Graduate / Total_State > .20
ORDER BY Total_Bachelor_State DESC

--- Between example
Select College_Graduate / Total_State * 100 as Total_Bachelor_State, State
from Projects.dbo.Education$
WHERE College_Graduate / Total_State BETWEEN .19 and .25
ORDER by Total_Bachelor_State DESC

--- Total number of Bachelor Degrees in the United States
Select sum(College_Graduate) as Total_Bachelor_US
from Projects.dbo.Education$

--- Average number of Bachelor Degree in the United States (by state)
Select AVG(College_Graduate / Total_State) as Avg_Bachelor_State
from Projects.dbo.Education$

--- RANK operator with ties
SELECT state, College_Graduate / Total_State * 100 as Total_Bachelor_State, RANK()  OVER(ORDER by College_Graduate / Total_State DESC) as Rank_Bachelor_State
From Projects.dbo.Education$

--- Joining Earnings Data by State (INNER)
Select College_Graduate, [Median _earnings], edu.State
FROM Projects.dbo.Education$ as edu
INNER JOIN Projects.dbo.earnings$ as ear
on edu.State = ear.State

--- JOIN example using round, 
Select ROUND(College_Graduate/Total_State * 100 , 2) as Total_Bachelor_State, ear.[Median _earnings], edu.State
FROM Projects.dbo.Education$ as edu
LEFT JOIN Projects.dbo.earnings$ as ear
on edu.State = ear.State

--- Subquery example
Select ROUND(HS_Grad / Total_State * 100,2) as HS_Total_State, ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State, edu.State, [Median _earnings]
FROM Projects.dbo.Education$ as edu
INNER JOIN Projects.dbo.earnings$ as ear
ON edu.State = ear.State 
WHERE edu.State IN (
SELECT State 
FROM Projects.dbo.earnings$
WHERE [Median _earnings] > 40000
)

--- CASE Example
SELECT State, ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State,
	CASE
		WHEN College_Graduate / Total_State > .24 Then 'High'
		When College_Graduate / Total_State > .209 Then 'Above Average'
		ELSE 'Below Average'
		END as College_Percent
FROM Projects.dbo.Education$ as edu

--- Using LIKE operator with subquery
SELECT edu.State, ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State 
FROM Projects.dbo.Education$ as edu
Inner JOIN Projects.dbo.earnings$ as ear
on edu.State = ear.State 
WHERE edu.State LIKE 'M%' AND edu.State IN ( 
select STATE
FROM Projects.dbo.earnings$
WHERE [Median _earnings] < 40000
)
ORDER BY Total_Bachelor_State DESC


--- Three Joins 
SELECT edu.State ,ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State , ROUND(Insured / Total_State_Pop * 100,2) as Total_Insured_State, [Median _earnings]
FROM Projects.dbo.Education$ as edu
JOIN Projects.dbo.earnings$ as ear 
on edu.State = ear.State
JOIN Projects.dbo.insurance$ as ins
on ear.State = ins.[State]
ORDER by Total_Insured_State DESC

--- Three Joins with subqueries
SELECT edu.State ,ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State , ROUND(Insured / Total_State_Pop * 100,2) as Total_Insured_State, [Median _earnings]
FROM Projects.dbo.Education$ as edu
JOIN Projects.dbo.earnings$ as ear 
on edu.State = ear.State
JOIN Projects.dbo.insurance$ as ins
on ear.State = ins.[State]
WHERE edu.State IN (
	SELECT State 
	FROM Projects.dbo.earnings$
	WHERE [Median _earnings] > 40000
)	AND edu.[State] IN( 
	SELECT [State]
	FROM Projects.dbo.insurance$
	WHERE Insured / Total_State_Pop > .94
)
ORDER BY Total_Insured_State DESC


--- Case and subquery example
SELECT edu.State ,
    ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State ,
    ROUND(Insured / Total_State_Pop * 100,2) as Total_Insured_State,
    [Median _earnings],
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM Projects.dbo.Education$ as edu1
            JOIN Projects.dbo.earnings$ as ear1
            on edu1.State = ear1.State
            JOIN Projects.dbo.insurance$ as ins1
            on ear1.State = ins1.[State]
            WHERE edu1.State = edu.State
            AND edu1.State IN (
                SELECT State 
                FROM Projects.dbo.earnings$
                WHERE [Median _earnings] > 40000
            )
            AND edu1.[State] IN ( 
                SELECT [State]
                FROM Projects.dbo.insurance$
                WHERE Insured / Total_State_Pop > .94
            )
        ) THEN 'High'
        WHEN EXISTS (
            SELECT 1
            FROM Projects.dbo.Education$ as edu2
            JOIN Projects.dbo.earnings$ as ear2
            on edu2.State = ear2.State
            JOIN Projects.dbo.insurance$ as ins2
            on ear2.State = ins2.[State]
            WHERE edu2.State = edu.State
            AND edu2.State IN (
                SELECT State 
                FROM Projects.dbo.earnings$
                WHERE [Median _earnings] > 38000
            )
            AND edu2.[State] IN ( 
                SELECT [State]
                FROM Projects.dbo.insurance$
                WHERE Insured / Total_State_Pop > .90
            )
        ) THEN 'Average'
        ELSE 'Below Average'
    END as Overall_State    
FROM Projects.dbo.Education$ as edu
JOIN Projects.dbo.earnings$ as ear 
on edu.State = ear.State
JOIN Projects.dbo.insurance$ as ins
on ear.State = ins.[State]


Create View BachelorViewAverage as 
SELECT State, ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State,
	CASE
		WHEN College_Graduate / Total_State > .24 Then 'High'
		When College_Graduate / Total_State > .209 Then 'Above Average'
		ELSE 'Below Average'
		END as BachelorAvgPercent
FROM Projects.dbo.Education$ as edu

Create View EarningViewAverage as 
SELECT State, [Median _earnings],
	CASE
		WHEN [Median _earnings] > 40000 Then 'High'
		When [Median _earnings] > 36000 Then 'Above Average'
		ELSE 'Below Average'
		END as  EarningAvg
FROM Projects.dbo.earnings$

Create View InsuredViewAverage as 
SELECT State, Insured / Total_State_Pop as Total_Insured_State,
	CASE
		WHEN Insured / Total_State_Pop > 0.94 Then 'High'
		When Insured / Total_State_Pop > 0.90 Then 'Above Average'
		ELSE 'Below Average'
		END as  InsuranceAvg
FROM Projects.dbo.insurance$

CREATE View BachelorEarningScatter as 
Select College_Graduate/Total_State * 100 as Total_Bachelor_State, [Median _earnings], edu.State
FROM Projects.dbo.Education$ as edu
INNER JOIN Projects.dbo.earnings$ as ear
on edu.State = ear.State

CREATE View InsuredEarningScatter as 
Select Insured/Total_State_Pop * 100 as Total_Insured_State, [Median _earnings], ins.State
FROM Projects.dbo.insurance$ as ins
INNER JOIN Projects.dbo.earnings$ as ear
on ins.State = ear.State


CREATE VIEW CensusDataView AS
SELECT edu.State ,
    ROUND(College_Graduate / Total_State * 100,2) as Total_Bachelor_State ,
    ROUND(Insured / Total_State_Pop * 100,2) as Total_Insured_State
    [Median _earnings],
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM Projects.dbo.Education$ as edu1
            JOIN Projects.dbo.earnings$ as ear1
            on edu1.State = ear1.State
            JOIN Projects.dbo.insurance$ as ins1
            on ear1.State = ins1.[State]
            WHERE edu1.State = edu.State
            AND edu1.State IN (
                SELECT State 
                FROM Projects.dbo.earnings$
                WHERE [Median _earnings] > 40000
            )
            AND edu1.[State] IN ( 
                SELECT [State]
                FROM Projects.dbo.insurance$
                WHERE Insured / Total_State_Pop > .94
            )
        ) THEN 'High'
        WHEN EXISTS (
            SELECT 1
            FROM Projects.dbo.Education$ as edu2
            JOIN Projects.dbo.earnings$ as ear2
            on edu2.State = ear2.State
            JOIN Projects.dbo.insurance$ as ins2
            on ear2.State = ins2.[State]
            WHERE edu2.State = edu.State
            AND edu2.State IN (
                SELECT State 
                FROM Projects.dbo.earnings$
                WHERE [Median _earnings] > 38000
            )
            AND edu2.[State] IN ( 
                SELECT [State]
                FROM Projects.dbo.insurance$
                WHERE Insured / Total_State_Pop > .90
            )
        ) THEN 'Average'
        ELSE 'Below Average'
    END as Overall_State    
FROM Projects.dbo.Education$ as edu
JOIN Projects.dbo.earnings$ as ear 
on edu.State = ear.State
JOIN Projects.dbo.insurance$ as ins
on ear.State = ins.[State];
