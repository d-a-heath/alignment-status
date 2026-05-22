#CANDOR Status Score

library(readr)
library(writexl)
library(readxl)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/surveys")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/surveys")

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
  perceived_status_1 <- data$i_think_your_status[1]
  perceived_status_2 <- data$i_think_your_status[2]
  sex_1 <- data$sex[1]
  sex_2 <- data$sex[2]
  race_1 <- data$race[1]
  race_2 <- data$race[2]
  politics_1 <- data$politics[1]
  politics_2 <- data$politics[2]
  edu_1 <- data$edu[1]
  edu_2 <- data$edu[2]
  age_1 <- data$age[1]
  age_2 <- data$age[2]
  how_enjoyable_1 <- data$how_enjoyable[1]
  how_enjoyable_2 <- data$how_enjoyable[2]
  in_common_1 <- data$in_common[1]
  in_common_2 <- data$in_common[2]
  topic_diversity_1 <- data$topic_diversity[1]
  topic_diversity_2 <- data$topic_diversity[2]
  our_thoughts_synced_up_1 <- data$our_thoughts_synced_up_sr1[1]
  our_thoughts_synced_up_2 <- data$our_thoughts_synced_up_sr1[2]
  developed_joint_perspective_sr2_1 <- data$developed_joint_perspective_sr2[1] 
  developed_joint_perspective_sr2_2 <- data$developed_joint_perspective_sr2[2]
  shared_thoughts_feels_sr3_1 <- data$shared_thoughts_feels_sr3[1]
  shared_thoughts_feels_sr3_2 <- data$shared_thoughts_feels_sr3[2]
  discussed_real_things_sr4_1 <- data$discussed_real_things_sr4[1]
  discussed_real_things_sr4_2 <- data$discussed_real_things_sr4[2]
  thoughts_became_more_alike_sr5_1 <- data$thoughts_became_more_alike_sr5[1]
  thoughts_became_more_alike_sr5_2 <- data$thoughts_became_more_alike_sr5[2]
  saw_world_in_same_way_sr8_1 <- data$saw_world_in_same_way_sr8[1]
  saw_world_in_same_way_sr8_2 <- data$saw_world_in_same_way_sr8[2]
  output_df<- rbind(output_df, 
                    cbind (data$convo_id[1],
                           data$user_id[1],
                           data$user_id[2],
                           reported_status_1,
                           reported_status_2,
                           perceived_status_1,
                           perceived_status_2,
                           #sex_1,
                           #sex_2,
                           #race_1,
                           #race_2,
                           politics_1,
                           politics_2,
                           #edu_1,
                           #edu_2,
                           age_1,
                           age_2,
                           how_enjoyable_1,
                           how_enjoyable_2,
                           in_common_1,
                           in_common_2,
                           topic_diversity_1,
                           topic_diversity_2,
                           our_thoughts_synced_up_1,
                           our_thoughts_synced_up_2,
                           developed_joint_perspective_sr2_1, 
                           developed_joint_perspective_sr2_2,
                           shared_thoughts_feels_sr3_1,
                           shared_thoughts_feels_sr3_2,
                           discussed_real_things_sr4_1,
                           discussed_real_things_sr4_2,
                           thoughts_became_more_alike_sr5_1, 
                           thoughts_became_more_alike_sr5_2,
                           saw_world_in_same_way_sr8_1,
                           saw_world_in_same_way_sr8_2))
  
}

#create a name for our output file

output_file <- "status_scores_for_corr_2.csv"

#write difference scores into csv file

write_csv(output_df, file = output_file)
