proc sort data=CENSUS.MEDIANINCOME_GEO out=WORK.SORTTempTableSorted;
	by Region;
run;

proc rank data=WORK.SORTTempTableSorted descending out=census.medianincomerank;
	by Region;
	var MedianIncome;
	ranks rank_MedianIncome;
run;

proc delete data=WORK.SORTTempTableSorted;
run;
