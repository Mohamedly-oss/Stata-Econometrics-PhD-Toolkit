*****************scatter******************************
*Load auto data
sysuse auto

*Help entry for graph command
help graph

*Generate exemplar twoway scatter plot
graph twoway (scatter price mpg) (scatter weight mpg)

*Save current graph with replace option
graph save test, replace

*Open saved graph
graph use test

*Look at different graph schemes
graph query, schemes

*Set graph scheme 
set scheme economist

*Re-create graph using different scheme
graph twoway (scatter price mpg) (scatter weight mpg)
*******************graph_barr*************************
graph bar (count), over(rep78)

*Load Auto data
sysuse auto, clear

*Explore help file of graph bar
help graph bar

*Bar chart of the count of repair record categories
graph bar (count), over(rep78)

*Bar chart of the count of repair record and foreign categories
graph bar (count), over(rep78) over(foreign)

*Bar graph of the percentage of observations in each category of repair record and foreign
graph bar, over(rep78) over(foreign)

*Bar graph of the mean of price and standard deviation of price in each category of repair record and foreign
graph bar (mean) price (sd) price, over(rep78) over(foreign)
***************histogramme**********************
*Load auto data
sysuse auto, clear

*Histogram help entry
help histogram
*Histogram of price
histogram price
*Histogram of price with 20 bins
histogram price, bin(20)
*Histogram of price with bins of width 500
histogram price, width(5000)

*Histogram help entry
help kdensity
*Kernel density plot of price
kdensity price
*Kernel density plot of price with smaller bandwidth
kdensity price, bw(100)

*Quantile plot of price 
quantile price

*Boxplot help entry
help graph box
*Boxplot of price and weight
graph box price weight
*Boxplot of price and weight over foreign
graph box price weight, over(foreign)

*Ladders of power
gladder price
***********pie_graph*******************************
*Load auto data
sysuse auto

*Tabulate repair record
tab rep78

*Pie chart help
help graph pie

*Pie chart of repair record
graph pie, over(rep78)

*Pie chart of repair record with missing as category, exploded and with percentage labels
graph pie, over(rep78) missing pie(_all, explode) plabel(_all percent)

*Pie chart of repair record with missing as category, exploded and with percentage labels by foreign status
graph pie foreign, over(rep78) missing pie(_all, explode) plabel(_all percent) by(foreign)
*Dot chart of the mean of price and standard deviation of price in each category of repair record 
graph dot (mean) price (sd) price, over(rep78)

***********scatter*******************************
*Load auto data
sysuse auto, clear

*Help entry for scatter
help scatter

*A scatterplot of price against mpg
scatter price mpg 

*Help entry for twoway
help twoway

*Two scatterplot overlaid using the twoway command
tw (scatter price mpg if foreign == 0) (scatter price mpg if foreign == 1)

*Examples of twoway scatter plots with various lines of best fit
tw (scatter price mpg) (lfit price mpg)
tw (scatter price mpg) (qfit price mpg)
tw (scatter price mpg) (lpoly price mpg)
tw (scatter price mpg) (lpoly price mpg, bw(0.5))
tw (scatter price mpg) (lpolyci price mpg)
***************fonction*********************************
*Stata functions
help functions

*Draw a custom function y = sin(x)
tw (function y = sin(x))
tw (function y = sin(x), range(0 10))

*Draw an equation
tw (function y = 1 + 2*x + 3*x^2, range(-5 5))

*Draw the logitistic cumulative density function
tw (function y = logistic(x), range(-5 5))

*Load auto data
sysuse auto, clear

*Run regressiom
reg price c.mpg##c.mpg

*Plot regression coefficients on custom function
*general form: tw (function y = a + b*x + c*x^2, range(0 50)
tw (function y = _b[_cons] + _b[mpg]*x + _b[c.mpg#c.mpg]*x^2, range(mpg))
**********************countour_plot***************
*Load Sandstone training data
sysuse sandstone

*Explore the raw data with browse
browse 

*Help contour plot
help twoway contour 

*Create a contour plot
twoway contour depth northing easting

*Create a contour plot with 20 levels
twoway contour depth northing easting, levels(20)

*Create a contour plot with 20 levels with 5 legend levels
twoway contour depth northing easting, levels(20) zlabel(#5)

*Use auto data
sysuse auto

*Run regression with continuous by continuous interaction
reg price c.mpg##c.length weight

*Predict price at across mpg and length and save to new dataset
quietly margins, at(mpg=(12(5)41) length=(142(5)233))  saving(predictions, replace)

*Use new dataset
use predictions, clear
describe

*User contour plor to visualuse interactin effect
twoway contour _margin _at1 _at2 , levels(20)
***************nuage depoint*************************
*Load auto data
sysuse auto, clear

*Plot two categorical variables on scatterplot
tw (sc foreign rep78) 

*Use jitter to reveal overlapping data points 
tw (sc foreign rep78, jitter(10)) 

*Use jitter to anonymise "confidential" data points but keep relationship similar
tw (sc price mpg, mc(%30) ) (lfit price mpg) (sc price mpg, jitter(10))

****************combine graph***************
*Load auto data
sysuse auto, clear

*Generate two exemplar scatter plots with linear fits and store in memory (replace if already stored)
tw (scatter price mpg) (qfit price mpg), name(graph1, replace) 
tw (scatter price weight) (qfit price weight), name(graph2, replace) 

*Examine graphs in memory
graph dir
graph describe graph1 

*Help graph combine
help graph combine

*Combine both memory graphs
graph combine graph1 graph2

*Combine both memory graphs forcing a common y- and x-axis
graph combine graph1 graph2, ycommon xcommon

*Combine both memory graphs forcing a common y- and x-axis and shrink text appropriately
graph combine graph1 graph2, ycommon altshrink

*Combine both memory graphs forcing a common y- and x-axis and shrink text manually
graph combine graph1 graph2, ycommon iscale(1.2)

*Combine both memory graphs forcing a common y- and x-axis, shrink text appropriately and use only 1 column
graph combine graph1 graph2, ycommon altshrink col(1)
******************parcelle tornesol***************
*clear any data
clear

*set observations
set obs 100000

*generate data
gen x = rnormal()
gen y = rnormal()

*normal scatter plot
scatter y x

*sunflower plot
sunflower y x

*sunflower plot without bins
sunflower y x, flower

*sunflower plot with different bin widths
sunflower y x, binw(0.5)
sunflower y x, binw(0.1)

*sunflower plot as a two-way plot with a linear fit superimposed
tw (sunflower y x) (lfit y x)
*Combine both memory graphs forcing a common y- and x-axis, shrink text appropriately and use leave a hole at position 2 and 3
graph combine graph1 graph2, ycommon altshrink hole(2 3)

***********modification de la tailee grap**********
*Load auto data
sysuse auto, clear

*Generate base graph
tw (scatter price mpg) (qfit price mpg)

*Base graph with aspectratio option
tw (scatter price mpg) (qfit price mpg), aspectratio(1)
tw (scatter price mpg) (qfit price mpg), aspectratio(0.25)

*Base graph with ysize and xsize options
tw (scatter price mpg) (qfit price mpg), ysize(1) xsize(3)

*Base graph with ysize and xsize options and scale option
tw (scatter price mpg) (qfit price mpg), ysize(1) xsize(3) scale(2)
tw (scatter price mpg) (qfit price mpg), ysize(1) xsize(3) scale(0.5)

**************représentation par groupe***********
*Load auto data
sysuse auto, clear

*Generate base graph
tw (scatter price mpg) (qfit price mpg)

*Base graph by each category of rep78
tw (scatter price mpg) (qfit price mpg, by(rep78))

*Base graph by each category of rep78 scaled to 50%
tw (scatter price mpg) (qfit price mpg, by(rep78, iscale(0.5)))

*Base graph by each category of rep78 scaled to 50% with a total graph added
tw (scatter price mpg) (qfit price mpg, by(rep78, iscale(0.5) total))

*Base graph by each category of rep78 scaled to 50% with a total and missing graph added
tw (scatter price mpg) (qfit price mpg, by(rep78, iscale(0.5) total missing))

*Base graph by each category of rep78 scaled to 50% with a total and missing graph added presented over 2 rows
tw (scatter price mpg) (qfit price mpg, by(rep78, iscale(0.5) total missing row(2)))

*Base graph by each category of rep78 scaled to 50% with a total and missing graph added presented over 2 rows using a compact style
tw (scatter price mpg) (qfit price mpg, by(rep78, iscale(0.5) total missing row(2) compact))

*Base graph by each category of rep78 and foreign scaled to 50% with a total and missing graph added presented over 2 rows using a compact style
tw (scatter price mpg) (qfit price mpg, by(rep78 foreign, iscale(0.5) total missing row(3) compact))

*****************couleurs test**********************
*Load auto data
sysuse auto, clear

*Help 
help graph_text

*Generate base graph
tw (scatter price mpg)

*Scatter plot of price against miles per gallon with labelled markers
tw (scatter price mpg, mlabel(make))

*Scatter plot of price against miles per gallon with titles
tw (scatter price mpg, title(Price vs MPG) subtitle(Cars) xtitle(MPG) ytitle(Price) note(Autodata))

*Scatter plot of price against miles per gallon with added textbox
tw (scatter price mpg, text(10000 30 "Something" "Important"))

*Scatter plot of price against miles per gallon with added textbox, bold and italic font 
tw (scatter price mpg, text(10000 30 "{bf:Something}" "{it:Important}"))

*Scatter plot of price against miles per gallon with added textbox, bold and italic font 
tw (scatter price mpg, text(10000 30 "{bf:Something}" "{it:Important}") text(12000 30 "{bf:{&alpha} }" "{it:{&beta} }"))

********************couleure**********
*Open NLSW88 training data
clear
sysuse nlsw88

*Help speparate
help separate 

*Separate hours by race categories
separate hours, by(race) 

*Scatter hours categ ories by wage
scatter hours? wage, mcolor(dknavy%50 maroon%50 yellow%50) mlcolor(black ..) msize(*1.25 ..) 

*Open Auto training data
clear 
sysuse auto

*Separate price by rep78 categories
separate price, by(rep78) shortlabel

*Scatter price categories by mpg
scatter price? mpg, mlcolor(black ..) msize(*1.25 ..) legend(row(1) size(*0.75))

*Open NLSW88 training data
clear
sysuse nlsw88

*Help collapse
help collapse

*collapse dataset to summary statistics
collapse (mean) wage hour, by(occupation race)

*Separate summary statistics
separate hours, by(race) veryshortlabel

*Scatter hours categories by wage and label occupations.
scatter hours? wage, mcolor(dknavy%50 maroon%50 yellow%50) mlabel(occupation occupation occupation) mlcolor(black ..)  mlabposition(6) msize(*1.25 ..) legend(row(1)) ytitle(Average Hours Worked) xtitle(Average Hourly Wage)

