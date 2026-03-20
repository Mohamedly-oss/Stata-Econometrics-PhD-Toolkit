********MCO**************************
*Load auto data
sysuse auto, clear

*Help etnry for regression
help regress

*OLS regression of price using mpg, weight and length as explanatory variables
regress price mpg weight length

*OLS regression of price using mpg, weight, length and turn as explanatory variables
regress price mpg weight length turn
********************variable_factoriel**************
*Load auto data
sysuse auto, clear

*Estimate a OLS regression of price using mpg, weight and length as explanatory variables
regress price mpg weight length

*Tabulate foreign and repair record
tab rep78
tab foreign

*Naive inclusion of categorical variables
regress price mpg weight length foreign rep78

*Examine help file for factor variables
help fvvarlist

*Using Stata's expansion capability with the i. prefix
regress price mpg weight length i.foreign i.rep78

*Using Stata's expansion capability with the i. prefix and setting foreign's base category to 5
regress price mpg weight length i.foreign ib5.rep78
*************statistique_diagnostique***********
*load the data
sysuse auto, clear

*run model 1
reg price mpg length turn i.foreign

*Help file for postestimation 
help regress postestimation

*graphical diagnostics
	*normality of error term
	predict resid, resid
	predict xb, xb
	su price xb resid
	tw (kdensity price) ( kdensity xb)
	tw (kdensity resid)
	*residuals vs fitted plot
	sc resid xb, yline(0)
	rvfplot, yline(0)
	*influential outliers
	lvr2plot
	*graph matrix plot
	graph matrix price mpg length turn

*statistical diagnostics
	*summary statistics
	estat su
	*multicollinearity
	estat vif
	estat vce, corr
	*heteroskedasticity
	estat hettest
	estat hettest, rhs mtest
	*functional form
	estat ovtest
	*effect size
	estat esize
	estat esize, omega
	***************LOG_MCO************************
	*Load auto data
sysuse auto, clear

*Specify a baseline OLS regression
reg price mpg length i.foreign

*Generate the log of price
gen logprice = log(price)

*Use logprice as the dependent variable in a new OLS regression
reg logprice mpg turn length i.foreign

*Add a quadratic relationship between price and mpg to the OLS model
reg logprice c.mpg##c.mpg turn length i.foreign

*Predict the values of logprice at various mpg values
margins, at(mpg=(0(2)40))

*Plot the values obtained by margin on a graph
marginsplot

*Add a squared mpg term and also interaction the foreign variable 
reg logprice c.mpg##c.mpg##i.foreign turn length 

*Predict the values of logprice at various mpg values
margins foreign, at(mpg=(0(2)40))

*Plot the values obtained by margin on a graph
marginsplot
************test_hypothese******************
*Load auto data
sysuse auto, clear

*A OLS regression of price
reg price mpg length i.foreign i.rep78

*Test whether the coefficent on mpg is equal to 100
test mpg = 100

*Test whether the coefficent on mpg is equal to the coefficient on length
test mpg = length

*Group test that all repair variables are jointly different from 0
test 2.rep78 3.rep78 4.rep78 5.rep78

*shortcut to group test
testparm i.rep78

*Linear combination of all rep78 variables
lincom 2.rep78+3.rep78+4.rep78+5.rep78
***********************word_reg*********************
*Load auto data
sysuse auto, clear

*Install software to use esttab and outreg2
ssc install estout, replace
ssc install outreg2, replace

*Initial regressions
reg price mpg
reg price mpg length
reg price mpg length turn

*Help file entry for estimates
help estimates

*Initial regressions wioth stores estimates
reg price mpg
estimate store a1
reg price mpg length
estimate store a2
reg price mpg length turn
estimate store a3

*See stored estimates
estimates dir

*Replay stored estimates
estimates replay a1

*Create table with estimates table
estimates table a1 a2 a3
estimates table a1 a2 a3, se

*Create table with esttab command with standard error option
esttab a1 a2 a3, se

*Using outreg2
outreg2 [a1 a2 a3], replace
***********standrdisation*********************
*Oaxaca decomposition
search oaxaca

*Install
net install "http://www.stata-journal.com/software/sj8-4/st0151.pkg"

*Examine help file
help oaxaca

*Use Oaxaca training data
use oaxaca.dta

*Describe data
describe
tab female, su(lnwage)

*Oaxaca decomposition
oaxaca lnwage educ, by(female) pooled

*Oaxaca decomposition additional covariate
oaxaca lnwage educ exper, by(female) pooled

*Oaxaca decomposition additional reporting options
oaxaca lnwage educ exper, by(female) pooled detail noisily xb

*Oaxaca decomposition full variable list
xi: oaxaca lnwage educ exper tenure married divorced kids6 kids714 i.isco, by(female) pooled
*********************************************************************************************************************************************************************
clear

*Viewing all available functions including random number functions
help functions

*Calling a single random number from the normal distribution
di rnormal()
*repeat
di rnormal()
*repeat
di rnormal()
*repeat
di rnormal()

*Setting a seed
set seed 1234
*repeat
di rnormal()
*repeat
di rnormal()

*Generating multiple draws of random numbers from the normal distribution
set obs 1000
gen x1 = rnormal()

*Generating multiple draws of random numbers from the uniform distribution
gen x2 = runiform()

*Summarize x1 and x2
summarize
***************proportionnement*****************
clear

*set observations to 1000
set obs 1000

*generate random variables
gen x1 = rnormal()
gen x2 = rnormal()
gen e1 = rnormal()

*generate variable y as a function of all previous variables
gen y = 1 + 1*x1 - 1*x2 + 1*e1

*estimate the relationship between x1, x2 and y assuming e is observable
regress y x1 x2 e1

*estimate the relationship between x1, x2 and y assuming e is unobservable
regress y x1 x2

*a non-linear, probit, example
*generate latent score, yhat
gen ystar = 1 + 1*x1 - 1*x2 + 1*e1

*generate observed value of y as a function of yhat
gen ybinary = 1 if ystar > 0
replace ybinary = 0 if ystar <= 0

*tabulate yhat
tab ybinary

*regress ybinary against x1 and x2 using a probit model
probit ybinary x1 x2
****************************************
********** EXAMPLE 1 - Endogeneity of x2
clear

*set observations to 1000
set obs 1000

*generate random variables where x2 is endogenous
gen e1 = rnormal()
gen x1 = rnormal()
gen x2 = rnormal() + 1*e1 

*generate variable y as a function of all previous variables
gen y = 1 + 1*x1 - 1*x2 + 2*e1

*estimate the relationship between x1, x2 and y assuming e1 and e2 are unobservable
regress y x1 x2


********** EXAMPLE 2 - Multicollinearity of x2
clear

*set observations to 1000
set obs 1000

*generate random variables where x2 is endogenous
gen e1 = rnormal()
gen x1 = rnormal()
gen x2 = x1 + 0.1*rnormal()

*generate variable y as a function of all previous variables
gen y = 1 + 1*x1 - 1*x2 + 1*e1 

*estimate the relationship between x1, x2 and y assuming e1 is unobservable
regress y x1 
*******************************************************
clear

*Monte Carlo Simulation
*Write a custom programme that generates a random data structure and then estimates OLS
program define test, rclass
	clear
	set obs 1000
	gen e1 = rnormal()
	gen x1 = rnormal()
	gen x2 = rnormal() + 1*e1
	gen y = 1 + 1*x1 + 1*x2 + 1*e1
	reg y x1 x2
end

*Execute new programme test
test

*Use the simulate command to run the programme "simulate1" 1000 times
simulate, reps(500): test

*Explore the simulation results
summarize

tw (kdensity _b_x1, xline(1)) (kdensity _b_x2)