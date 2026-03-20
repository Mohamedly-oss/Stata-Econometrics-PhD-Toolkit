********************associate*****************
*Load auto data
sysuse auto, clear

*Tabulate repair record against foreign status
tab rep78 foreign

*Help tabulate
help tab

*Tabulate repair record against foreign status with Pearson Chi2 test
tab rep78 foreign, chi2

*Tabulate repair record against foreign status with Pearson Chi2 test and the expected cell counts if there was no association
tab rep78 foreign, chi2 expected

*Tabulate repair record against foreign status with Pearson Chi2 test and the expected cell counts if there was no association and Fishers exact test
tab rep78 foreign, chi2 expected exact

*Tabulate repair record against foreign status with all measures of association and Fishers exact test
tab rep78 foreign, all expected 
*****************testmean*****************
*Load the auto data
sysuse auto

*Summarize price
su price 

*Test whether the mean of price is different from 2000
ttest price = 2000

*Test whether the standard deviation of price is different from 3000
sdtest price = 3000

*Test whether the proportion of foreign is different from 0.5
prtest foreign = 0.5

*Test whether the mean of price differs by foreign status
ttest price, by(foreign)

*Test whether the set of means of price, mpg and weight differs by foreign
hotelling price mpg weight, by(foreign)

* Graph means by categorical variables
grmeanby rep78 foreign, su(price)
****************correlation***********************
*Load auto data
sysuse auto

*Correlate price, mpg and weight against each other and report pearson's correlation coefficient
correlate price mpg weight

*Correlate price, mpg and weight against each other and report variance/covariances
correlate price mpg weight, cov

*Correlate price, mpg and weight using pairwise deletion
pwcorr price mpg weight

*Correlate price, mpg and weight using pairwise deletion and report statistical significance
pwcorr price mpg weight, sig

*Generate dummy variables from rep78
tab rep78, gen(dummy)

*Compute tetrachoric correlation for six dummy variables
tetrachoric foreign dummy1 dummy2 dummy3 dummy4 dummy5  
***********ANOVA*****************************
*Load auto data
sysuse auto

*One way analysis of variance using oneway
oneway price rep78, tabulate

*One way analysis of variance using ANOVA
anova price rep78

*Regression table from a one-way ANOVA
regress, baselevels

*Two-way ANOVA
anova price rep78 foreign

*Two-way full factorial ANOVA
anova price rep78##foreign
