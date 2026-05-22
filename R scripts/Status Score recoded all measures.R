#CANDOR Status Score

library(readr)
library(writexl)
library(readxl)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/surveys recoded")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/surveys recoded")

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
  convoID <- gsub("_survey.csv","",file)
  pre_affect_avg <- (data$pre_affect[1] + data$pre_affect[2])/2
  pre_affect_diff <- abs(data$pre_affect[1]-data$pre_affect[2])
  pre_arousal_avg <- data$pre_arousal[] data$pre_arousal[]
  pre_arousal_diff <- data$pre_arousal[] data$pre_arousal[]
  affect_avg <- data$affect[] data$affect[]
  affect_diff <- data$affect[] data$affect[]
  arousal_avg <- data$arousal[] data$arousal[]
  arousal_diff <- data$arousal[] data$arousal[]
  overall_affect_avg <- data$overall_affect
  overall_affect_diff
  overall_arousal_avg
  overall_arousal_diff
  overall_memory_rating_avg
  overall_memory_rating_diff
  begin_affect_avg
  begin_affect_diff
  begin_arousal_avg
  begin_arousal
  begin_memory_rating_avg
  begin_memory_rating_diff
  middle_affect_avg
  middle_affect_diff
  middle_arousal_avg
  middle_arousal_diff
  middle_memory_rating_avg
  middle_memory_rating_diff
  end_affect_avg
  end_affect_diff
  end_arousal_avg
  end_arousal_diff
  end_memory_rating_avg
  end_memory_rating_diff
  worst_affect_avg
  worst_affect_diff
  worst_arousal_avg
  worst_arousal_diff
  best_affect_avg
  best_affect_diff
  best_arousal_avg
  best_arousal_diff
  how_enjoyable_avg
  how_enjoyable_diff
  i_like_you_avg
  i_like_you_diff
  you_like_me_avg
  you_like_me_diff
  in_common_avg
  in_common_diff
  conversationalist_avg
  conversationalist_diff
  next_seven_days_avg
  next_seven_days_diff
  my_friends_like_you_avg
  my_friends_like_you_diff
  good_for_advice_avg
  good_for_advice_diff
  i_felt_close_to_my_partner_avg
  i_felt_close_to_my_partner_diff
  i_would_like_to_become_friends_avg
  i_would_like_to_become_friends_diff
  i_paid_attention_to_my_partner_avg
  i_paid_attention_to_my_partner_diff
  my_partner_paid_attention_to_me_avg
  my_partner_paid_attention_to_me_diff
  my_partner_was_clear_and_coherent_avg
  my_partner_was_clear_and_coherent_diff
  interested_in_exchanging_contact_info_avg
  interested_in_exchanging_contact_info_diff
  you_are_intelligent_avg
  you_are_intelligent_diff
  you_are_quickwitted_avg
  you_are_quickwitted_diff
  you_are_competent_avg
  you_are_competent_diff
  you_are_kind_avg
  you_are_kind_diff
  you_are_friendly_avg
  you_are_friendly_diff
  you_are_warm_avg
  you_are_warm_diff
  you_think_i_am_intelligent_avg
  you_think_i_am_intelligent_diff
  you_think_i_am_quickwitted_avg
  you_think_i_am_quickwitted_diff
  you_think_i_am_competent_avg
  you_think_i_am_competent_diff
  you_think_i_am_kind_avg
  you_think_i_am_kind_diff
  you_think_i_am_friendly_avg
  you_think_i_am_friendly_diff
  you_think_i_am_warm_avg
  you_think_i_am_warm_diff
  you_are_humble_avg
  you_are_humble_diff
  you_are_giving_avg
  you_are_giving_diff
  you_are_fair_avg
  you_are_fair_diff
  you_are_trustworthy_avg
  you_are_trustworthy_diff
  you_are_agreeable_avg
  you_are_agreeable_diff
  you_are_playful_avg
  you_are_playful_diff
  i_am_intelligent_avg
  i_am_intelligent_diff
  i_am_quickwitted_avg
  i_am_quickwitted_diff
  i_am_competent_avg
  i_am_competent_diff
  i_am_kind_avg
  i_am_kind_diff
  i_am_friendly_avg
  i_am_friendly_diff
  i_am_warm_avg
  i_am_warm_diff
  i_am_humble_avg
  i_am_humble_diff
  i_am_giving_avg
  i_am_giving_diff
  i_am_fair_avg
  i_am_fair_diff
  i_am_trustworthy_avg
  i_am_trustworthy_diff
  i_am_agreeable_avg
  i_am_agreeable_diff
  i_am_playful_avg
  i_am_playful_diff
  topic_diversity_avg
  topic_diversity_diff
  turn_overlap_gap_avg
  turn_overlap_gap_diff
  i_disclosed_avg
  i_disclosed_diff
  you_disclosed_avg
  you_disclosed_diff
  i_am_good_listener_avg
  i_am_good_listener_diff
  you_are_good_listener_avg
  you_are_good_listener_diff
  conv_leader_avg
  conv_leader_diff
  conv_pace_avg
  conv_pace_diff
  my_mind_wander_avg
  my_mind_wander_diff
  your_mind_wander_avg
  your_mind_wander_diff
  i_am_funny_avg
  i_am_funny_diff
  you_are_funny_avg
  you_are_funny_diff
  i_am_polite_avg
  i_am_polite_diff
  you_are_polite_avg
  you_are_polite_diff
  i_tried_to_impress_avg
  i_tried_to_impress_diff
  you_tried_to_impress_avg
  you_tried_to_impress_diff
  responsive_1_avg
  responsive_1_diff
  responsive_2_avg
  responsive_2_diff
  responsive_3_avg
  responsive_3_diff
  our_thoughts_synced_up_sr1_avg
  our_thoughts_synced_up_sr1_diff
  developed_joint_perspective_sr2_avg
  developed_joint_perspective_sr2_diff
  shared_thoughts_feels_sr3_avg
  shared_thoughts_feels_sr3_diff
  discussed_real_things_sr4_avg
  discussed_real_things_sr4_diff
  thoughts_became_more_alike_sr5_avg
  thoughts_became_more_alike_sr5_diff
  anticipated_each_other_sr6_avg
  anticipated_each_other_sr6_diff
  became_certain_of_perception_sr7_avg
  became_certain_of_perception_sr7_diff
  saw_world_in_same_way_sr8_avg
  saw_world_in_same_way_sr8_diff
  i_think_my_status_avg
  i_think_my_status_diff
  i_think_your_status_avg
  i_think_your_status_diff
  you_think_my_status_avg
  you_think_my_status_diff
  you_lack_companionship_avg
  you_lack_companionship_diff
  you_feel_left_out_avg
  you_feel_left_out_diff
  you_feel_isolated_avg
  you_feel_isolated_diff
  sex
  sex
  politics
  politics
  race
  race
  edu
  edu
  employ
  employ
  employ_7_TEXT
  employ_7_TEXT
  know_partner_1
  know_partner_1
  know_partner_1
  know_partner_1
  how_know_partner
  how_know_partner
  realtime
  realtime
  did
  did
  guided
  guided
  age_avg
  age
  i_lack_companionship_avg
  i_lack_companionship_diff
  i_feel_left_out_avg
  i_feel_left_out_diff
  i_feel_isolated_avg
  i_feel_isolated_diff
  shared_reality_avg
  shared_reality_diff
  responsive_avg
  responsive_diff
  my_loneliness_avg
  my_loneliness_diff
  your_loneliness_avg
  your_loneliness_diff
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
  enjoy_comb <- data$how_enjoyable[1]+data$how_enjoyable[2]
  enjoy_diff <- abs(data$how_enjoyable[1]-data$how_enjoyable[2])
  output_df<- rbind(output_df, 
                    cbind (convoID,
                           reported_status_diff,
                           perceived_status_diff, 
                           sex_diff, 
                           race_diff,
                           politics_diff,
                           edu_diff,
                           age_diff,
                           total_diff,
                           enjoy_comb,
                           enjoy_diff))
  
}

#create a name for our output file

output_file <- "status_scores_test_all.csv"

#write difference scores into csv file

write_csv(output_df, file = output_file)
