#CANDOR Status Score

library(readr)
library(writexl)
library(readxl)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys")

#create a list of surveys

surveys <- list.files(path = folder,
                      pattern = "survey.csv",
                      full.names = FALSE,
                      recursive = FALSE)

#create empty dataframe to write difference scores into

output_df <- data.frame()

#loop through each survey and calculate difference scores, write into dataframe created above
#political "sameness" allows for one-degree of difference, age "sameness" is within 5 years

for(file in surveys){
  data <- read.csv(file)
  reported_status_1 <- data$i_think_my_status[1]
  reported_status_2 <- data$i_think_my_status[2]
  reported_status_diff <- abs(reported_status_1 - reported_status_2)
  perceived_status_1 <- data$i_think_your_status[1]
  perceived_status_2 <- data$i_think_your_status[2]
  perceived_status_diff <- abs(perceived_status_1 - perceived_status_2)
  sex_1 <- data$sex[1]
  sex_2 <- data$sex[2]
  sex_diff <- ifelse(sex_1 == sex_2,0,1)
  race_1 <- data$race[1]
  race_2 <- data$race[2]
  race_diff <- ifelse(race_1 == race_2,0,1)
  politics_1 <- data$politics[1]
  politics_2 <- data$politics[2]
  politics_diff <- ifelse(abs(politics_1 == politics_2)<=1, 0,1)
  edu_1 <- data$edu[1]
  edu_2 <- data$edu[2]
  edu_diff <- ifelse(edu_1 == edu_2, 0,1)
  age_1 <- data$age[1]
  age_2 <- data$age[2]
  age_diff <- ifelse(abs(age_1 - age_2) <= 5,0,1)
  total_diff <- sex_diff+race_diff+politics_diff+edu_diff+age_diff
  output_df<- rbind(output_df, 
                    cbind (data$convo_id[1],
                           reported_status_diff,
                           perceived_status_diff, 
                           sex_diff, 
                           race_diff,
                           politics_diff,
                           edu_diff,
                           age_diff,
                           total_diff))
  
}

#create a name for our output file

output_file <- "status_scores_test.csv"

#write difference scores into csv file

write_csv(output_df, file = output_file)
