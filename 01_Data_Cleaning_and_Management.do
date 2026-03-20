*Clear all data
clear

*Load data from file path
use "/Applications/Stata/auto.dta"

*Load data from the internet
clear
use "http://www.stata-press.com/data/r15/auto"

*List all training data
sysuse dir

*Load training data
sysuse auto, clear

*Input data manually and then list data
clear
input var1 var2 
1 0.1
2 0.2
3 0.4
4 0.5 
5 0.6
end

list

*Help import
help import

*Import excel data from filepath with firstrow as variable names
import excel "/Users/buschaf/Data/data.xlsx", sheet("Sheet1") firstrow clear

list
****************************************************
*Open the auto training data
sysuse auto, clear

*browse the raw data
browse

*browse only the variables make and price
browse make price 

*browse the first 10 observations
browse in 1/10

*edit the raw data
edit
***************describe**summarise
*Load the auto data set
sysuse auto, clear

*Describe the data and variables
describe

*Describe only variables that have a 'p' in their variable name
describe *p*

*Produce summary statistics for all variables
summarize

*Produce summary statistics for the variable price if cars are foreign or domestic
summarize price if foreign == 1
summarize price if foreign == 0
******************missing value*************************
*Load auto data
sysuse auto, clear

*Help misstable
help misstable

*Produce summary of missing values in data
misstable summarize
misstable patterns
list if missing(rep78)

*Tabulate repair record and its missing values
tab rep78
tab rep78, miss

*Example of how missing values can interfer with summary statistics
su price if rep78 >= 5
su price if rep78 >= 5 & rep78 != .

*Quickly code all missing values to -99 and back again.
mvencode *, mv(-99)
tab rep78
mvdecode *, mv(-99)
tab rep78
************************tabulate****************************
*Load the auto data
sysuse auto, clear

*Initial summary
summarize

*Help tabulate
help tabulate

*One-way tabulate repair record and foreign
tab rep78
tab foreign

*One-way tabulate foreign with no-labels
tab foreign, nolabel

*One-way tabulate repair record with missing option
tab rep78, missing

*Two-way tabulate repair record and foreign
tab rep78 foreign

*Two-way tabulate repair record and foreign with row/column percentages
tab rep78 foreign, col row

*Two-way tabulate repair record and foreign summary statistics of price
tab rep78 foreign, su(price)

*Use table to create a three-way tabulation
table rep78 headroom foreign, contents(freq)
*************weights**********************************
*Load census training data
sysuse census, clear

*Describe the data
describe

*Summarise data
su 

*Examine weight variable
tab pop

*Summarize median age with probability and frequency weights
su medage [weight=pop]
su medage [fweight=pop]

*Weights in a regression
reg marriage medage death 
reg marriage medage death [fweight=pop]

*Scatter plot of number of deaths by median age weighted to state population
scatter death medage [fweight=pop]

*Use tabstat to create a custom table with statistics
tabstat mpg rep78 headroom trunk, statistics(mean count) by(foreign) 
*********************************************************************************************************************************************************************
****************recording******************************
*Load the auto data
sysuse auto, clear

*Tabulate repair record
tab rep78

*Help for recode
help recode

*Recode repair record so that the values 1 and 2 become 1
recode rep78 1 2 = 1
tab rep78

*Recode repair record so that the values 1 and 2 become 1, 3 becomes 2, 4 becomes 3 and 5 becomes 4
recode rep78 (1 2 = 1) (3 = 2) (4 = 3) (5 = 4)

*Recode miles per gallon so that the values 10 to 19 become 1, 20 to 29 becomes 2 and 30 to 99 become 3
recode mpg (10/19 = 1) (20/29=2) (30/99=3)
tab mpg
********************creating a new variable******************
*Load auto data
sysuse auto,clear 

*Generate a variable that is filled with the number 1
gen constant = 1

*Generate the variable newprice that is equal to price divided by weight
gen newprice = price/weight

*Generate the variable pricesquared that is equal to price multiplied by price
gen pricesquared = price*price
******************rename*****************************
*Load auto data
sysuse auto, clear 

*Variable manager menu
varmanage

*Describe data
des

*Help rename
help rename

*Rename the variable rep78 to repair
rename rep78 repair

*Rename the all variables to upper or lower case
rename *, upper
rename *, lower

*Rename all variables to include the suffix 1978
rename * *1978

*Rename all variables so that the suffix 1978 is removed
rename *1978 *

*Label the variable rep78 with the words "repair categories"
label variable repair "repaire categories"

*Tabulate repair
tab repair

*List the current stored labels
label dir

*Define a new value label called repair
label define repair 1 "no repairs" 2 "some repairs" 3 "many repairs" 4 "broken" 5 "otherwise"
 
*Attach the value label called repair to the variable repair 
label values repair repair

*Tabulate repair
tab repair

*Generate the variable price1000 that is equal to price plus 1000
gen price1000 = price+1000

*Summarize 
su
*******************egen************************************
*Load auto data
sysuse auto, clear

*Examine help file for egen
help egen

*Create standard deviation of Price
egen sdprice = sd(price)
su price sdprice

*Cut price into 10 equal deciles using egen
egen deciles = cut(price), group(10)

*Tabulate deciles
tab deciles

*Compute the rowmean for price, mpg and weight for each observations
egen rowmeans = rowmean(price mpg weight)
***************indicator_variable***************************
*Load auto data
sysuse auto, clear

*Generate an indicator variable for high price using generate and replace
generate highprice = 1 if price > 6000
replace highprice = 0 if price <= 6000
tab highprice

*Generate an indicator variable for high price using recode
recode price (min/6000 = 0) (else = 1), gen(highprice2)
tab highprice2

*Generate an indicator variable for high price using tabulate
tab rep78, gen(repdummy)
su repdummy*

*Using autocode to generate spaced category
generate pricecat = autocode(price,10,3000, 16000)
tab pricecat

*Using inlist as a shortcut
generate repair = 0 if rep78 == 1 | rep78 == 2
replace repair = 1 if rep78 == 2 | rep78 == 3 | rep78 == 4
***********drop*keep**************************************
*Load auto data
sysuse auto, clear

*Drop the variable price
drop price

*Keep all variables with the letter "e"
keep *e*

*Drop all foreign cars
drop if foreign == 1

*Drop a list of variables
drop rep78-weight

*Preserve the existing data
preserve

*Make change to the data
drop if weight > 3000

*Restore the original data
restore
generate repair = 0 if inlist(rep78, 1, 2)
replace repair = 1 if inlist(rep78, 3, 4, 5)
tab repair

*Browse data
browse price mpg weight rowmeans

*Generate the variable logprice that is equal to the log of price
gen logprice = log(price)

*Replace repair code value 2 with the value 1.
replace rep78 = 1 if rep78 == 2
************saving_data*********************************
*Load the auto data
sysuse auto, clear

*Check current directory path
cd

*Change current directory path
cd "\Users\MOHAMED\Documents"



*Save the auto data as auto2
  

*Save the auto data to a directory path with the replace option
save  "\Users\MOHAMED\Documents\coursera\STATA/auto2", replace

*Help export
help export

*Export data to excel file
export excel using "C:\Users\MOHAMED\Documents\coursera\STATA\auto2.xlsx", replace
***************converting_string_data*********************
*Open string data
webuse destring1, clear

*Explore string example data
list
su
describe
browse

*Condition on string information
list if id == "111"

*Insert a non-numeric character
replace income = "abc" in 7

*Destring income with replace option
destring *, replace
su 

*Destring income and use the force option
destring income, replace force
su

*Return income and price back to string variables 
tostring *, replace

*Open other string data
webuse hbp2, clear

*Explore data
describe 
tab sex, nolabel

*Destring sex with encode
encode sex, generate(gender)
tab gender, nolabel

*Return gender back into a string variable with decode
decode gender, gen(test)
tab test
***************merge**********************************
*Appending data - load both data sources and examine them
clear
use append1
list
use append2
list

*Append both datasets
append using append1
list

*Help merge
help merge

*Merging data - load both datasets and examine them
use autosize, clear
list
use autoexpense, clear
list

*Merge both datasets
merge 1:1 make using autosize
list

*Inspect the _merge variable
tab _merge
***************macro***********************************
*Load auto data
sysuse auto, clear

*Help macro
help macro

*Creating a local macro that contains a variable list as string
local varlist "price mpg rep78"
su `varlist'
reg length `varlist'

*Creating a local macro that contains a variable list as string 
global varlist "price mpg rep78"
su $varlist
reg length $varlist

*Help foreach
help foreach

*A simple loop
foreach i in price mpg rep78 {
gen log`i' = log(`i')
su log`i'
}

*A loop with forvalues
forvalues i = 1/20 {
	gen x`i' = rnormal()
	}
su x*	
****************accessing*****************************
*Open Auto Data
clear
sysuse auto

*Summarize price and return stored results
su price
return list 

*Perform computation with previously stored mean
di r(mean) * 2

*Regress price against mpg and length and return stored general & estimation results
regress price mpg length
ereturn list

*Explore stored matrices
matrix list e(b)
matrix list e(V)

*Perform computations with stored system variables
di _b[mpg] * 2
di _se[mpg] * 2
*******************doubl_loop***********************
clear
sysuse auto

foreach x of varlist * {
	forvalues i = 10(10)100 {
		gen `x'`i' = `x' * `i'
		}
	}
	*************date_variable*******************
	*Clear data
clear

*Load Auto training data
use date

*Examine data
describe
list

*Convert string date to numeric date
gen date2 = date(datestring1, "DM20Y")
list

*Format date2 to day format
format date2 %td
list

*Split year, month and day information into three separate variables
gen year = year(date2)
gen month = month(date2)
gen day = day(date2)
list

*Generate date variable date3 from numeric year, month and day information
gen date3 =mdy(month, day, year)
list

*Summary statistics for variable for first 7 days
su variable if date2 <= 21191
su variable if day <= 7 & month == 1 & year == 2018
su variable if date2 <= mdy(01,07,2018)
**********************subscri************************
*Load the auto data
sysuse auto, clear

*List data
list make price rep78 in 1/20

*Underscore variables
gen id = _n
gen total = _N

*List data
list make price rep78 id total in 1/20

*Subscripting
gen newprice1 = price[1]
gen newprice2 = price[_n-1]

*List data
list make price newprice* rep78 id total in 1/20

*By groups
bys rep78: gen newid = _n
bys rep78: gen newtotal = _N

*List data
list make price rep78 newid newtotal in 1/20

*Maximum price in each repair group
bys rep78 (price): gen maxprice = price[_N]
bys rep78 (price): gen minprice = price[1]

*List data
list make price maxprice minprice rep78 newid newtotal in 1/20

*Same with egen
egen maxprice2 = max(price), by(rep78) 
egen minprice2 = min(price), by(rep78) 

*List data
list make price maxprice maxprice2 rep78 newid newtotal in 1/20