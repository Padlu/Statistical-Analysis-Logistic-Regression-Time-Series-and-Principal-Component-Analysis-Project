# install.packages("haven")
library(psych)

#Read file and amend
library(haven)
olympic <- read_sav("~/Documents/70b_OLYMPIC.SAV")
olymp<-(olympic[,-c(1,12)])
head(olymp)

#check for number of components
fa.parallel(olymp,fa="pc",n.iter = 100)

#Extract components
pc.olymp<-principal(olymp,nfactors = 3,rotate = "none")
pc.olymp

#Rotate components
rc.olymp<-principal(olymp,nfactors = 3,rotate="varimax")
rc.olymp

#Interpret rotated components
fa.diagram(rc.olymp)

#Factor Scores
rc.olymp$score

#### ----- PCA Project ----- ####

# Set working directory
setwd("/Users/abhishekpadalkar/Documents/IRELAND Admissions/NCI/Course Modules/Modules/Sem 1/DMML/Final Project/")

# Get the data
superconductor_data <- read.csv("Super Conductor Temperature/Super_conductor.csv", header = T)
str(superconductor_data)
library(tidyverse)
superconductor_data_new <- superconductor_data %>% select(-contains("wtd"))
str(superconductor_data_new)

superconductor_data <- superconductor_data[, -c(82)]
superconductor_data_new <- superconductor_data_new[, -c(42)]
str(superconductor_data_new)
str(superconductor_data_new)  # 21263 obs and 81 variables => Suitable for PCA
library(corrplot)
corrplot(cor(superconductor_data), type = "upper") # We can see that there are high positive and negative corr
corrplot(cor(superconductor_data_new), type = "upper") # We can see that there are high positive and negative corr
corrplot(rc.superconductor_data$loadings)
corrplot(pc.superconductor_data$loadings)
rc.superconductor_data$loadings

KMO(superconductor_data)
bartlett.test(superconductor_data)
KMO(superconductor_data_new)
bartlett.test(superconductor_data_new)

#check for number of components
fa.parallel(superconductor_data_new, fa="pc",n.iter = 100, main = "Scree Plot for PCA and Eigen Value Threshold")

#Extract components
pc.superconductor_data<-principal(superconductor_data_new,nfactors = 8,rotate = "none")
pc.superconductor_data
typeof(pc.superconductor_data$communality)
plot(pc.superconductor_data$communality)
com_df <- as.data.frame(pc.superconductor_data$communality)
com_df <- sort(com_df[,])
barplot(sort(pc.superconductor_data$communality), descending = TRUE)
# print(rownames(com_df))
ggplot(data=com_df, aes(x=reorder(rownames(com_df), -`pc.superconductor_data$communality`),y=`pc.superconductor_data$communality`)) +
  geom_bar(stat="identity", width=0.3) + scale_y_continuous(name="Communality of variable", limits=c(0, 1), breaks=c(0,0.6,0.7,0.8,0.9,1)) +
  theme(axis.text.x = element_blank(), axis.title.x = element_blank())
pc.superconductor_data1<-principal(superconductor_data_new,nfactors = 41,rotate = "none")
pc.superconductor_data1

#Rotate components
rc.superconductor_data<-principal(superconductor_data_new,nfactors = 41,rotate="varimax")
rc.superconductor_data

#Interpret rotated components
fa.diagram(rc.superconductor_data)
fa.diagram(pc.superconductor_data)

#Factor Scores
rc.superconductor_data$score
rc.superconductor_data$communality
rc.superconductor_data$loadings
