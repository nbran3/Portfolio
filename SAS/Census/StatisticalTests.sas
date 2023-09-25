/* One way Distribution Test */
Title;
ods noproctitle;
ods graphics / imagemap=on;

proc glm data=CENSUS.STATEINFO_COMBINED plots(only)=(boxplot diagnostics);
	class Region;
	model MedianIncome=Region;
	means Region / hovtest=levene plots=none;
	lsmeans Region / adjust=tukey pdiff alpha=.05 plots=none;
	run;
quit;

/* Correlation Tests */ 
ods noproctitle;
ods graphics / imagemap=on;

proc corr data=CENSUS.STATEINFO_COMBINED pearson nosimple noprob 
		plots=scatter(ellipse=none);
	var MeanHoursWorked TotalPopulation MedianAge MedianCurrentMarriageDuration 
		MedianMonthlyHousingCosts;
	with MedianIncome;
run;
