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

title1 'Top 5 Median Household Income by Region';

proc sort data=CENSUS.MEDIANINCOMERANK out=WORK.SORTTEMP;
	where rank_MedianIncome <=5;
	by Region;
run;

proc print data=WORK.SORTTEMP label;
	var State MedianIncome;
	by Region;
	id Region;
run;

proc delete data=work.SORTTEMP;
run;

title1;
