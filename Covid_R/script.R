rm(list=ls())#removes all previously loaded data
library(Hmisc)#import



data <- read.csv("C:/Users/ayrik/Desktop/Covid_R/COVID19_line_list_data.csv")
describe(data)

data$death_dummy <- as.integer(data$death !=0)

#death rate
sum(data$death_dummy)/nrow(data)

#AGE
#Claim: people who die are older
dead=subset(data,death_dummy == 1)
alive=subset(data,death_dummy==0)
mean(dead$age, na.rm=TRUE)#Removing NA
mean(alive$age,na.rm=TRUE)

#is this statistically significant?
t.test(alive$age,dead$age,alternative="two.sided",conf.level = 0.95)
#normally,if p-value<0.05, we reject null hypothesis
#here p-value~0, so we reject null hypothesis and conclude our result is statistically significant



#GENDER
#Claim: gender has no effect
men=subset(data,gender == "male")
women=subset(data,gender=="female")
mean(men$death_dummy, na.rm=TRUE)#Removing NA
mean(women$death_dummy,na.rm=TRUE)

#is this statistically significant?
t.test(men$death_dummy,women$death_dummy,alternative="two.sided",conf.level = 0.95)
#99% confidence:men have 0.8% to 8.8% higher chance of dying
#p-value=0.002< 0.05 so this is statistically significant
