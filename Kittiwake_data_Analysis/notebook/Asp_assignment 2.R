install.packages('ggplot')
library(ggplot2)
library(Hmisc)

#data
getwd()
setwd("C:\\Users\\nikhi\\Desktop\\MSc DS\\3-MTHS4005_Applied stats and probability\\proj\\Assignment 2")
observation <- read.csv("Kittiwake_Observation_20590303.csv",header = TRUE)  

head(observation)

# To find the data type of the data set.
str(observation)

# Dimension of data set.
dim(observation)

# Summary of data set. 
summary(observation)

# 1(a)

# 1 boxplot
par(mfrow = c(1,1))
boxplot(observation[['dawn']],observation[['noon']],observation[['mid.afternoon']],observation[['dusk']],
        ylim=c(20,80),las=1, names= c("dawn", "noon",'mid.afternoon','dusk'))

# 2 Histogram
par(mfrow = c(1,4))
hist(observation)

# 3 Barplot

tot_kittiwakes <- colSums(observation[,c('dawn', 'noon', 'mid.afternoon', 'dusk')])
par(mfrow = c(1, 1))
barp <-barplot(tot_kittiwakes,ylim=c(0,2000),las=1,
        names.arg = c('Dawn', 'Noon', 'Mid Afternoon', 'Dusk'))
grid(nx = NA, ny = NULL, lwd = 1, lty = 1, col = "gray")
text(barp, 0, round(tot_kittiwakes, 1),cex=1,pos=3) 


#1(b)

#Calculating the mean number of Kittiwakes at mid-afternoon with confidence interval of 80 percentage.
t.test(observation[['mid.afternoon']],conf.level=0.80)$conf.int

#average number of Kittiwakes at during mid afternoon lies between 44.02 and 47.04.



# 2(a)

Historical  <- read.csv("Kittiwake_Historical_20590303.csv",header = TRUE)  

head(Historical)
dim(Historical)

# Our Null Hypothesis (H0) is the decline in kittiwake number is independent of site
# Alternate Hypothesis (H1) is dependent of site.

#observed value
obs_hist <- Historical
obs_hist <- obs_hist[, -1] 
print(obs_hist)

#expected value.
sum_year<-rowSums(obs_hist)  
sum_site<-colSums(obs_hist) 
n<-sum(obs_hist)

exp_hist<-sum_year%*%t(sum_site)/n
print(exp_hist)

chisq.test(obs_hist, exp_hist)

# we got t-test value as t = 11.171 and p value as 0.9417. We can clearly observe that p-value ia greater than aplha. 
#So,at the 5% significance level we fail to reject the null hypothesis". therefore the decline in kittiwake number is independent of site.


# 2(b)
#predicting the number of breeding pairs at Site D in 2014

colnames(Historical)[colnames(Historical) == "X"] <- "Year" 

model_hist <- lm(Site.D ~ Year, data = Historical) 

summary(model_hist)

# Predicting the number of breeding pairs at site Site D in 2014.
test_hist <- data.frame(Year = 2014) 
pred_hist <- predict(model_hist, newdata=test_hist,interval='prediction')

#predicted value
print(pred_hist)



# 3

measurement <- read.csv("Kittiwake_Measurement_20590303.csv",header = TRUE)  

# 3(a)
head(measurement)
str(measurement)
summary(measurement)

colnames(measurement)
red_leg   <- measurement[measurement[['Sub.species']] == "Red-legged"  , c("Weight","Wingspan", "Culmen")]
summary(red_leg)
black_leg <- measurement[measurement[['Sub.species']] == "Black-legged", c("Weight","Wingspan", "Culmen")]
summary(black_leg)

#boxplot
par(mfrow = c(1,3))
boxplot(Weight ~ Sub.species, data = measurement,ylim=c(350,410),las=1)
boxplot(Wingspan ~ Sub.species, data = measurement,ylim=c(85,112),las=1)
boxplot(Culmen ~ Sub.species, data = measurement,ylim=c(30,44),las=1)

#Histogram.
par(mfrow = c(1,3))
hist(red_leg)
par(mfrow = c(1,3))
hist(black_leg)

mean_red <- colMeans(red_leg[,c("Weight","Wingspan", "Culmen")])
summary(red_leg)
mean_black <- colMeans(black_leg[,c("Weight","Wingspan", "Culmen")])
summary(black_leg)

#barplot.
par(mfrow = c(1, 1))
barp <-barplot(mean_red,ylim=c(0,400),las=1,names.arg = c("Weight","Wingspan", "Culmen"),
               main = "Red-legged kittiwake",xlab = "Measurements of Red-legged kittiwake")
grid(nx = NA, ny = NULL, lwd = 1, lty = 1, col = "gray")
text(barp, 0, round(mean_red, 1),cex=1,pos=3) 

par(mfrow = c(1, 1))
barp <-barplot(mean_black,ylim=c(0,400),las=1,names.arg = c("Weight","Wingspan", "Culmen"),
               main = "Black-legged kittiwake",xlab = "Measurements of Black-legged kittiwake")
grid(nx = NA, ny = NULL, lwd = 1, lty = 1, col = "gray")
text(barp, 0, round(mean_black, 1),cex=1,pos=3)

#Scatter plot.
pairs(red_leg[,   c("Weight", "Wingspan", "Culmen")], )
pairs(black_leg[, c("Weight", "Wingspan", "Culmen")], )


# 3(b)

# For each sub-species, is wing span and culmen length independent?
cor.test(red_leg[['Wingspan']],red_leg[['Culmen']])
cor.test(black_leg[['Wingspan']],black_leg[['Culmen']])

# We can observe that correlation value for black legged kittiwake's wingspan and culmen length is 0.3698665. 
# Based on this value, we can conclude it has very weak dependency. Similarly, the correlation value for red legged kittiwake's wingspan and culmen length is 0.5267068  
# Based on this value, we can conclude it has moderate relationship  between their measurements. 


# 3(c)
# to check Is there evidence that the weights of birds of the two sub-species are different?

# Our Null Hypothesis (H0) is  weights are same.
# Alternate Hypothesis (H1) is  weights are different.

# Calculating two sample t-test : 
t.test(red_leg[['Weight']],black_leg[['Weight']],mu=0, var.equal = TRUE,conf.level=0.95)

#After calculating t-test :
# 1) we got t-test value as t = 0.3271 and p value as 0.7459. We can clearly observe that p-value is greater than the α value. 
#     So,at the 5% significance level there is not enough evidence to "Reject the null hypothesis".
#     Therefore it seems that there is no difference of mean between redlegged kittiwakes weight and black legged kittiwakes weight.


# 3(d)
# Our Null Hypothesis (H0) is no difference in attributes.
# Alternate Hypothesis (H1) is there is difference in attributes.

#Lets calculate hypothesis testing for all the measurements of kittiwakeswith confidence interval of 95 percentage.
# So,let α = 0.05.

# 1) Weight : 
meas_wt <- t.test(red_leg[['Weight']],black_leg[['Weight']],mu=0, var.equal = TRUE,conf.level=0.95)
print(meas_wt)
# we got t-test value as t = 0.3271 and p value as 0.7459. Since p value is greater than alpha, 
#     we fail to reject H0 i.e there is no difference in weight measurement of kittiwake.

# 2) Wingspan :
meas_wing <- t.test(red_leg[['Wingspan']],black_leg[['Wingspan']],mu=0, var.equal = TRUE,conf.level=0.95)
print(meas_wing)
# we got t-test value as t = 1.5058 and p value as 0.1429 Since p value is greater than alpha, 
#     we fail to reject H0 i.e there is no difference in Wingspan measurement of kittiwake.

# 3) Culmen :
meas_cul <- t.test(red_leg[['Culmen']],black_leg[['Culmen']],mu=0, var.equal = TRUE,conf.level=0.95)
print(meas_cul)
# we got t-test value as t = -7.8896 and p value as 1.06e-08. Since p value is less than alpha, 
#     we reject H0 i.e there is significant difference in Culmen measurement of kittiwake.



# 4

location<- read.csv("Kittiwake_Location_20590303.csv",header = TRUE)  
head(location)

# 4(a)
model_loc <- lm(location[["Breeding.pairs"]] ~ Coast.direction + sandeel + Summer.temp + cliff.height, data = location)
summary(model_loc)
print(AIC(model_loc))

# 4(b)
model_log_loc <- lm(log(location[["Breeding.pairs"]]) ~ Coast.direction + sandeel + Summer.temp + cliff.height, data = location)
summary(model_log_loc)
print(AIC(model_log_loc))

# 4(c)
best_model_loc<-step(model_loc)
summary(best_model_loc)

# 4(d)
summary(best_model_loc)

hist(best_model_loc$residuals,xlab="Residuals",freq=FALSE)

plot(best_model_loc$fitted.values,best_model_loc$residuals,xlab="predicted values",ylab="Residuals",ylim=c(-200,300),las=1)
abline(h=0,lty=2) 


# 4(e)
test_loc<- data.frame(Coast.direction = 'South', sandeel= 2.56,Summer.temp= 20.8, cliff.height = 1.89)
pred<-predict(best_model_loc,newdata=test_loc,interval="confidence",level=0.98)
pred

