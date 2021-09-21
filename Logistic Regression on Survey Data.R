#Read file and amend
library(haven)
library(psych)
library(corrplot)
library(tidyverse)

# Set working directory
setwd("/Users/abhishekpadalkar/Documents/IRELAND Admissions/NCI/Course Modules/Modules/Sem 1/Statistics/Project TABA/Logistic Reg/")

teens_tech_survey <- read_sav("March-7-April-10-2018-Teens-and-Tech-Survey/March 7-April 10, 2018 - Teens and Tech Survey - SPSS.sav")
str(teens_tech_survey)
teens_tech_survey <- teens_tech_survey[-is.na(teens_tech_survey),]
str(teens_tech_survey)
teens_tech_survey_csv <- read.csv("March-7-April-10-2018-Teens-and-Tech-Survey/March 7-April 10, 2018 - Teens and Tech Survey - SPSS.csv")
str(teens_tech_survey_csv)
teens_tech_survey_csv_1 <- as.data.frame(lapply(teens_tech_survey_csv, as.numeric))
head(teens_tech_survey_csv_1)
teens_tech_survey_csv_2 <- teens_tech_survey_csv_1[complete.cases(teens_tech_survey_csv_1[3:13]), 3:13]
str(teens_tech_survey_csv_2)
teens_tech_survey_csv_2.1 <- teens_tech_survey_csv_2[!(teens_tech_survey_csv_2$FITIN == 77 | teens_tech_survey_csv_2$FITIN == 98 | teens_tech_survey_csv_2$FITIN == 99),  ]
str(teens_tech_survey_csv_2.1)
sapply(teens_tech_survey_csv_2.1, function(x) sum(is.na(x))) # => No missing Values
write.csv(teens_tech_survey_csv_2.1, "fitin.csv")

wave_56 <- read_sav("W56/ATP W56.sav")
wave_56_1 <- read_csv("W56/ATP W56.csv")
wave_56_1.1 <- wave_56_1[, 7:27]
wave_56_1.2 <- as.data.frame(lapply(wave_56_1.1, as.numeric))
wave_56_2 <- wave_56_1.2[, 1:5]
wave_56_2.1 <- wave_56_1.2[complete.cases(wave_56_1.2), ]
wave_56_2.2 <- wave_56_2[complete.cases(wave_56_2), ]
wave_56_2.2 <- wave_56_2.2[!(wave_56_2.2$MARITAL_W56 == 77 | wave_56_2.2$MARITAL_W56 == 98 | wave_56_2.2$MARITAL_W56 == 99),  ]
sapply(wave_56_2.2, function(x) sum(is.na(x))) # => No missing Values
wave_56_2.2$MARITAL_W56[wave_56_2.2$MARITAL_W56 <= 2] <- 1
wave_56_2.2$MARITAL_W56[wave_56_2.2$MARITAL_W56 > 2] <- 2
write.csv(wave_56_2.2, "marriage.csv")
str(wave_56_2.2)

## NEW MARITAL ##
cols_marital <- c("MARITAL_W56", "ONLINEDATE_W56", "DATE10YR_W56", "FIRSTDATE.a_W56", "FIRSTDATE.b_W56", "FIRSTDATE.c_W56", "DATEACCEPT.a_W56", "DATEACCEPT.b_W56", "DATEACCEPT.c_W56", "DATEACCEPT.d_W56", "DATEACCEPT.e_W56", "TRACKPARTNER_W56", "DATEHARASSM_W56", "DATEHARASSW_W56", "ONIMPACT_W56", "ONSAFE_W56", "DATEVOCAB.a_W56", "DATEVOCAB.b_W56", "DATEVOCAB.c_W56", "DATEVOCAB.d_W56", "DATEVOCAB.e_W56", "DATEGHOST_W56", "ORIENTATIONMOD_W56")
wave_56 <- wave_56_1[, cols_marital]
str(wave_56_final)
wave_56_ <- wave_56[complete.cases(wave_56), ]
wave_56_final <- wave_56_[!(wave_56_$MARITAL_W56 == 77 | wave_56_$MARITAL_W56 == 98 | wave_56_$MARITAL_W56 == 99),  ]
wave_56_final$MARITAL_W56[wave_56_final$MARITAL_W56 <= 2] <- 1
wave_56_final$MARITAL_W56[wave_56_final$MARITAL_W56 > 2] <- 2
sapply(wave_56_, function(x) sum(is.na(x))) # => No missing Values
write.csv(wave_56_final, "marriage_new.csv")

wave_59 <- read_sav("W59/ATP W59.sav")

#### MAIN FINAL LR PROJECT ####

# New Data Global Attitudes
ga <- read_csv("Pew-Research-Center-Global-Attitudes-Spring-2019-Survey-Data/Pew Research Center Global Attitudes Spring 2019 Dataset WEB.csv")
str(ga)
cols_ga <- c("ECON_SIT", "CHILDREN_BETTEROFF2", "SATISFIED_DEMOCRACY", "FUTURE_CULTURE", "FUTURE_GAP", "FUTURE_JOBS", "FUTURE_EDUCATION", "FUTURE_POLSYS", "BELIEVE_GOD", "MOST_ELECTED", "VOTING_SAY", "MARKET_ECON", "SUCCESS", "STATE_BENEFIT", "NEIGHBORING_COUNTRIES", "RESTRICT_ENTRY", "MILITARY_FORCE", "RELIGIOUS_FREEDOM", "PRESS_FREEDOM", "GENDER_EQUALITY", "FREE_SPEECH", "FREE_ELECTIONS", "INTERNET_FREEDOM", "SEX", "AGE", "COUNTRY_SATIS")
ga <- ga[, cols_ga]
ga <- ga[!(ga$COUNTRY_SATIS == 8 | ga$COUNTRY_SATIS == 9), ]
str(ga)
sapply(ga, function(x) sum(is.na(x))) # => No missing Values
write.csv(ga, "global_attitudes.csv")
ga <- read_csv("global_attitudes_cleaned.csv")
str(ga)

age_ga <- ga$AGE
print(unique(age_ga))

age_grp <- c('[25 - 40]', '[41 - 65]', '[66 - 75]', '[75+]')
age_grp_num <- c(1,2,3,4)
age_grp_num <- as.numeric(age_grp_num)

for (i in 1:length(age_ga)){
  # print(age[i])
  if (age_ga[i] <41){
    age_ga[i] <- age_grp_num[1]
  }
  if (age_ga[i] >40 & age_ga[i] < 66){
    age_ga[i] <- age_grp_num[2]
  }
  if (age_ga[i] > 65 & age_ga[i] < 76){
    age_ga[i] <- age_grp_num[3]
  }
  if (age_ga[i] > 75){
    age_ga[i] <- age_grp_num[4]
  }
}

# print(unique(age_ga))
# print(age_ga)
# ga <- subset(ga, select = -c(AGE_GROUP))
ga["AGE_GROUP"] <- as.numeric(age_ga)
str(ga)
write.csv(ga, "global_attitudes_cleaned_age_grouped.csv")

ga_1000_sampled_idx <- sample(rownames(ga), 1000)
ga_1000_sampled <- ga[ga_1000_sampled_idx, ]
str(ga_1000_sampled)
ga_500_idx <- sample(rownames(ga_1000_sampled), 500)
ga_500_sampled <- ga_1000_sampled[ga_500_idx, ]
str(ga_500_sampled)
ga_250_idx <- sample(rownames(ga_500_sampled), 250)
ga_250_sampled <- ga_500_sampled[ga_250_idx, ]
str(ga_250_sampled)
write.csv(ga_1000_sampled, "global_attitudes_cleaned_age_grouped_1000.csv")
write.csv(ga_500_sampled, "global_attitudes_cleaned_age_grouped_500.csv")
write.csv(ga_250_sampled, "global_attitudes_cleaned_age_grouped_250.csv")
# write.csv(ga_sampled_250_train, "global_attitudes_250_train.csv")


# install.packages("rms")
library(caret)
library(psych)
library(leaps)
library(car)
library(rcompanion)
library(ResourceSelection)
library(rms)
ga_selected_250 <- ga_250_sampled[, c("ECON_SIT","CHILDREN_BETTEROFF2","SATISFIED_DEMOCRACY","FUTURE_EDUCATION","MARKET_ECON","FREE_ELECTIONS","SEX","COUNTRY_SATIS")]
ga_sampled_250 <- ga_selected_250
for (i in 1:length(ga_selected_250$COUNTRY_SATIS)){
  # print(ga_selected_250$COUNTRY_SATIS[i])
  if (ga_selected_250$COUNTRY_SATIS[i] == 1){
    ga_selected_250$COUNTRY_SATIS[i] <- 0
  }
  if (ga_selected_250$COUNTRY_SATIS[i] == 2){
    ga_selected_250$COUNTRY_SATIS[i] <- 1
  }
}

ga_model <- glm(COUNTRY_SATIS~., data = ga_selected_250, family = "binomial")
summary(ga_model)
vif(ga_model)
ga_model
x <- as.factor(ga_selected_250$COUNTRY_SATIS)
describe(ga_selected_250)
y <- as.factor(ga_model$y)
plot(cooks.distance(ga_model))
confusionMatrix(as.factor(ga_selected_250$COUNTRY_SATIS), as.factor(ga_model$y), positive = "1")
pairs.panels(ga_selected_250[, 1:6],
             panel = panel.smooth,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE  # show density plots
)

ga_model_1 <- glm(COUNTRY_SATIS~.-FREE_ELECTIONS, data = ga_selected_250, family = "binomial")
summary(ga_model_1)
vif(ga_model_1)
plot(cooks.distance(ga_model_1))
nagelkerke(ga_model_1)


### Descriptive Stats ###

describe(ga_sampled_250)
pairs.panels(ga_sampled_250[, 1:8],
             panel = panel.smooth,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE  # show density plots
)

### Split into Train and Test Set ###

set.seed(2)
ga_sampled_250_train_idx <- sample(nrow(ga_sampled_250), round(nrow(ga_sampled_250)*0.80))
ga_sampled_250_train <- ga_sampled_250[ga_sampled_250_train_idx, ]
ga_sampled_250_test <- ga_sampled_250[-ga_sampled_250_train_idx, ]
str(ga_sampled_250_train)
str(ga_sampled_250_test)

### Model based on all variables using All variables at once method ###

satisfaction_model <- glm(COUNTRY_SATIS~., data = ga_sampled_250_train, family = "binomial")
summary(satisfaction_model)   # AIC => 175.46 | NULL DEV. = 273.33, Residual Dev. = 159.46

### REMOVE INSIGNIFICANT FREE ELECTIONS ###
satisfaction_model_1 <- glm(COUNTRY_SATIS~.-FREE_ELECTIONS, data = ga_sampled_250_train, family = "binomial")
summary(satisfaction_model_1)   # AIC => 176.04 | NULL DEV. = 273.33, Residual Dev. = 162.04

### REMOVE INSIGNIFICANT MARKET ECONOMY ###
satisfaction_model_2 <- update(satisfaction_model_1, COUNTRY_SATIS~.-MARKET_ECON)
summary(satisfaction_model_2)   # ALL THE VARIABLES ARE NOW SIGNIFICANT   # AIC => 177.01 | NULL DEV. = 273.33, Residual Dev. = 165.01

# Anova Omnibus test for all the variables
# Anova(satisfaction_model_2, test.statistic = "F")
ga_sampled_250_train[, -c(5,6,8)]


### PERFORM REQUIRED ASSUMPTION TESTS
vif(satisfaction_model_2)
plot(cooks.distance(satisfaction_model_2))
# Data is fine. 


### MODEL EVALUATION ###
nagelkerke(satisfaction_model_2)
hoslem.test(ga_sampled_250_train$COUNTRY_SATIS, satisfaction_model_2$fitted.values, g=20)


### NULL ACCURACY ###
null_list <- list(rep(0,50),rep(1,50))
crosstab <- table(prediction = null_list[[1]], actual = ga_sampled_250_test$COUNTRY_SATIS)
crosstab   # Null Accuracy = 27/50 = 0.54%

satisfaction_p <- predict(satisfaction_model_2, newdata = ga_sampled_250_test[,-c(5,6,8)], type="response")
satisfaction_p <- ifelse(satisfaction_p > 0.5, 1, 0)

confusionMatrix(as.factor(satisfaction_p), as.factor(ga_sampled_250_test$COUNTRY_SATIS), positive = "1")

# Odds Ratios
exp(coef(satisfaction_model_2))

#### END MAIN FINAL LR PROJECT ####