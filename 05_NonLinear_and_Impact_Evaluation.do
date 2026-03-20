*Load cardkrueger data 
use cardkrueger1994.dta

*describe data
describe

*Tabulate treated/controls vs before/after
tab treated t, su(fte) nost nofreq

*difference-in--difference estimation
	*with regress command
	reg fte i.treated##i.t
	*with diff command
	diff fte, treated(treated) period(t)

*difference-in--difference estimation with controls
	*with regress command
	reg fte i.treated##i.t kfc roys wendys
	*with diff command
	diff fte, treated(treated) period(t) cov(bk kfc roys) report 
	****************************************
	****parallelle 
*With parallel trends
clear

input id time wage treated

id	time	wage	treated
1	-1	800	0
1	0	900	0
1	1	1000	0
2	-1	1000	0
2	0	1100	0
2	1	1200	0
3	-1	1300	1
3	0	1400	1
3	1	1900	1
4	-1	1500	1
4	0	1600	1
4	1	2100	1
end

*Visualise data
tw (sc wage time if treated == 0, mcolor(maroon)) (sc wage time if treated == 1, mcolor(dknavy)) (lfit wage time if treated == 0 & time != 1, lcolor(maroon)) (lfit wage time if treated == 1 & time != 1, lcolor(dknavy)) (lfit wage time if treated == 0 & time != -1, lcolor(maroon)) (lfit wage time if treated == 1 & time != -1, legend(order(1 "Controls" 2 "Treated")) lcolor(dknavy) xline(0.5, lpattern(dash))) 
 
*Regression 
tab time
replace time = time + 1
*diff-in-diff
reg wage i.treated##i.time if time >= 1
*parallel trends
reg wage i.treated##i.time if time <= 1


*Without parallel trends
clear

input id time wage treated

id	time	wage	treated
1	-1	800	0
1	0	900	0
1	1	1000	0
2	-1	1000	0
2	0	1100	0
2	1	1200	0
3	-1	900	1
3	0	1400	1
3	1	1900	1
4	-1	1100	1
4	0	1600	1
4	1	2100	1
end

*Visualise data
tw (sc wage time if treated == 0, mcolor(maroon)) (sc wage time if treated == 1, mcolor(dknavy)) (lfit wage time if treated == 0 & time != 1, lcolor(maroon)) (lfit wage time if treated == 1 & time != 1, lcolor(dknavy)) ///
 (lfit wage time if treated == 0 & time != -1, lcolor(maroon)) (lfit wage time if treated == 1 & time != -1, legend(order(1 "Controls" 2 "Treated")) lcolor(dknavy) xline(0.5, lpattern(dash))) 
 ************************************************************************************************************************************DID***********
 *Non-parallel trends with 3 time periods
clear
input id time wage treated

id	time	wage	treated
1	-1	800	0
1	0	900	0
1	1	1000	0
2	-1	1000	0
2	0	1100	0
2	1	1200	0
3	-1	900	1
3	0	1400	1
3	1	1500	1
4	-1	1100	1
4	0	1600	1
4	1	1700	1
end


*Visualise example 
tw (sc wage time if treated == 0, mcolor(maroon)) (sc wage time if treated == 1, mcolor(dknavy)) (lfit wage time if treated == 0 & time != 1, lcolor(maroon)) (lfit wage time if treated == 1 & time != 1, lcolor(dknavy)) (lfit wage time if treated == 0 & time != -1, lcolor(maroon)) (lfit wage time if treated == 1 & time != -1, legend(order(1 "Controls" 2 "Treated")) lcolor(dknavy))  

*Regression example 
gen post = (time >= 1 )
reg wage i.treated##c.time##i.post 

*Non-parallel trends with 9 time periods
clear
input id time wage treated

id	time	wage	treated
1	-4	500	0
1	-3	600	0
1	-2	700	0
1	-1	800	0
1	0	900	0
1	1	1200	0
1	2	1500	0
1	3	1800	0
1	4	2100	0
2	-4	700	0
2	-3	800	0
2	-2	900	0
2	-1	1000	0
2	0	1100	0
2	1	1400	0
2	2	1700	0
2	3	2000	0
2	4	2300	0
3	-4	1200	1
3	-3	1200	1
3	-2	1200	1
3	-1	1200	1
3	0	1200	1
3	1	1300	1
3	2	1300	1
3	3	1300	1
3	4	1300	1
4	-4	1400	1
4	-3	1400	1
4	-2	1400	1
4	-1	1400	1
4	0	1400	1
4	1	1500	1
4	2	1500	1
4	3	1500	1
4	4	1500	1

end

*Visualise example 
tw (sc wage time if treated == 0, mcolor(maroon)) (sc wage time if treated == 1, mcolor(dknavy)) (lfit wage time if treated == 0  & time <= 0, lcolor(maroon)) (lfit wage time if treated == 1 & time <= 0, lcolor(dknavy)) (lfit wage time if treated == 0  & time >= 1, range(0 4) lcolor(maroon))  (lfit wage time if treated == 1 & time >= 1, lcolor(dknavy) legend(order(1 "Controls" 2 "Treated")) range(0 4) yscale(range(500 1500)))

*Regression example 
gen post = (time >= 1 )
reg wage i.treated##c.time##i.post 

*Regression example 
gen post2 = 0
replace post2 = time if time >= 1
reg wage i.treated##c.time##i.post2
 

*Regression 
tab time
replace time = time + 1
*diff-in-diff
reg wage i.treated##i.time if time >= 1
*parallel trends
reg wage i.treated##i.time if time <= 1
*********************************************************************************************************************************************************************
*Load the auto data
sysuse auto, clear

*Estimate a linear probability model (LPM)
reg foreign price mpg i.rep78

*Predict predicted probabilities from LPM model
predict yhat
su yhat

*Help file for logit and probit
help logit
help probit

*Estimate a logit model
logit foreign price mpg i.rep78
predict yhatlogit

*Estimate a probit model
probit foreign price mpg i.rep78
predict yhatprobit

su foreign yhat*
****diagnostiqueloit**********************************
*Load auto data
sysuse auto, clear

*Estimate logit model
logit foreign price mpg weight

*Produce the classification table
estat classification

*Produce the classification table with a cut point at 0.3
estat classification, cut(0.3)

*Compute Tjur's statistic (the difference between two predicted means)
predict yhat
ttest yhat, by(foreign)

*Estimate a logit model with odds-ratio's
logit foreign price mpg weight, or

*Examines margins help file
help margins

*Compute average marginal effects for all variables
margins, dydx(*)

*Compute marginal effects for all variables at the mean of all variables
margins, dydx(*) atmeans
**************,ultinomiale_logit******************
*Load auto data
sysuse auto, clear

*Tabulate repair record
tab rep78

*Estimate a ordered logit mode for repair record
ologit rep78 price mpg weight

*Estimate a ordered probit mode for repair record
oprobit rep78 price mpg weight

*Estimate average marginal effects of the ordered logit model
margins, dydx(*)

*Install and test the parallel regression assumption of the ordered logit model
ssc install omodel.pkg, replace
omodel logit rep78 price mpg weight

*Estimate a multinomial logit model of repair record
mlogit rep78 price mpg weight

*Estimate a multinomial logit model of repair record and display odds-ratio's
mlogit rep78 price mpg weight, rrr

*Estimate average marginal effects
margins, dydx(*)

*Install and test the Independene of Irrelevant Alternatives (IIA) assumption
net install "http://www.stata.com/stb/stb58/sg155.pkg", replace
mlogtest, haus