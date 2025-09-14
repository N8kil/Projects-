getwd()

setwd("C:\\Users\\nikhi\\Desktop\\MSc DS\\3-MTHS4005_Applied stats and probability\\proj")

# Loading the given dataset into the variable name df

df=read.csv("Surgery_20590303.csv")
df

# Displaying the first 6 row of the data set. Our data has 2 columns of names : New.surgery and Current.surgery
head(df)

# To find the data type of the data set, we got two columns of num data type.
str(df)

# To view the summary of our data. we have 
summary(df)

# Calculating the mean and variance for Current_surgery of all 30 observations.
mean_current=mean(df[["Current.surgery"]]) 
var_current=var(df[["Current.surgery"]])

# Calculating the mean and variance for New_surgery of all 30 observations.
mean_new=mean(df[["New.surgery"]]) 
var_new=var(df[["Current.surgery"]])

# Calculating difference in the mean of New_surgery and Current_surgery all 30 observations.
# We got difference of -0.8133333 indicating there is a significant reduce in the mean length of hospital stays.
diff_mean=mean_new-mean_current

# Visualizing the box plot for both surgery, We can interpret that there is a difference in mean of both surgery.
boxplot(df[['Current.surgery']],df[['New.surgery']],
        col=rainbow(2), names= c("Current_Surgery", "New_Surgery"))
title('Box Plot of both groups.')

# Visualizing the scatter plot for both surgery,
plot(df[['Current.surgery']],df[['New.surgery']], xlab="Current_Surgery", ylab = "New_Surgery")
title('Scatter Plot of both groups.')

## Identifying whether or not the new surgery is beneficial in reducing the length of hospital stay by conducting a hypothesis test.

# Let µd denote the difference of mean of 'Current.surgery' and 'New.surgery'. (µd= diff_mean)
# Our Null Hypothesis (H0) is µd is equal to zero that is mean of 'Current.surgery' and 'New.surgery' is equal.
# Alternate Hypothesis (H1) is µd is greater than zero.
#H0 : µd = 0 vs. H1 : µd > 0.

# Calculating the hypothesis testing with confidence interval of 95 percentage.So,let α = 0.05. 

# Calculating Paired t-test : 
t.test(df[['Current.surgery']],df[['New.surgery']],mu=0,paired=T,conf.level=0.95)

#After calculating Paired t-test :
# 1) we got t-test value as t = 6.0402 and p value as 1.427e-06. We can clearly observe that p-value is less than the α value. 
#So,at the 5% significance level there is evidence to "Reject the null hypothesis".

# 2) Therefore it seems that there is an difference in the stay of the New Surgery and by looking at the mean difference, 
# we can interpret that the stay is reduced by 0.8133333 days because of New Surgery.


