#recode participants
#the participant IDs that CANDOR uses are too long
#4 digit unique ids should be sufficient for both conversations and participants

##file internal ids NOT recoded yet. Environment saved (but may not be needed for that part, can use filenames)
## will probably want to use mutate

library("dplyr")


#clear workspace
rm(list=ls())


#set directories
setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR")

transcript_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts"
#transcript_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts"

survey_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys"

t_save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts recoded"
#t_save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts"

s_save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys recoded"

#empty dataframes

ID_lookup <- data.frame()
convo_ID <- data.frame()
part_ID <- data.frame()

#I think I can just use filter - may not need these
#ID_rand_num <- cbind(sample(1000:9999, 1656, replace = FALSE))
#PartID_rand_num <- cbind(sample(1000:9999, 1456, replace = FALSE))

#get all conversations

transcripts <- list.files(path = transcript_dir,
                          pattern = "transcript_cliffhanger.csv",
                          full.names = TRUE,
                          recursive = FALSE)

#we want to loop through, for each file we want to save it with a unique ID and unique participants
#let's start with just getting our participant data and generating IDs

#create ID dfs
for(file in transcripts){
  data <- read.csv(file)
  conversation_ID_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts/","",file) 
  #conversation_ID_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/","",file)
  conversation_ID <- gsub("_transcript_cliffhanger.csv","", conversation_ID_hold)
  convo_ID <- rbind(convo_ID, cbind(conversation_ID))
  Part <- data$speaker[1]
  P1 <- data$speaker[1]
  part_ID <- rbind(part_ID,cbind(Part))
  Part <- data$speaker[2]
  P2 <- data$speaker[2]
  part_ID <- rbind(part_ID,cbind(Part))
  ID_lookup <- rbind(ID_lookup, cbind(conversation_ID,P1,P2))
}


#assign shorter unique ids to conversations
convo_ID$short_ID <- cbind(sample(1000:9999, 1656, replace = FALSE))
#convo_ID$short_ID <- cbind(sample(1000:9999, 5, replace = FALSE))

#assign shorter unique ids to participants
unique_parts <- unique(part_ID)
unique_parts$part_short_ID <- cbind(sample(1000:9999, 1456, replace = FALSE))
#unique_parts$part_short_ID <- cbind(sample(1000:9999, 10, replace = FALSE))

#Now we want to use filter to bring them together and make a copy with a new name.

for(file in transcripts){
  data <- read.csv(file)
  P1.2 <- data$speaker[1]
  P2.2 <- data$speaker[2]
  conversation_ID_hold2 <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts/","",file) 
  #conversation_ID_hold2 <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/","",file) 
  conversation_ID2 <- gsub("_transcript_cliffhanger.csv","", conversation_ID_hold2)
  conversation_ID_row <- convo_ID %>% filter(conversation_ID == conversation_ID2)
  conversation_ID_new <- conversation_ID_row[1,2]
  P1_row <- filter(unique_parts, Part == P1.2) 
  P2_row <- filter(unique_parts, Part == P2.2)
  P1_new <- P1_row[1,2]
  P2_new <- P2_row[1,2]
  new_name <- paste("C", conversation_ID_new, "P1", P1_new, "P2", P2_new, "transcript_cliffhanger.csv", sep = "_")
  new_name_loc <- paste(t_save_dir, new_name, sep = "/")
  file.copy(from = file, to = new_name_loc)
}


#actually, surveys next

surveys <- list.files(path = survey_dir,
                          pattern = "survey.csv",
                          full.names = TRUE,
                          recursive = FALSE)

for(file in surveys){
  sur_data <- read.csv(file)
  P1.3 <- sur_data$user_id[1]
  P2.3 <- sur_data$user_id[2]
  survey_ID_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys/","",file) 
  survey_ID <-  gsub("_survey.csv","", survey_ID_hold)
  survey_ID_row <- convo_ID %>% filter(conversation_ID == survey_ID)
  survey_ID_new <- survey_ID_row[1,2]
  P1.3_row <- unique_parts %>% filter(Part == P1.3)
  P2.3_row <- unique_parts %>% filter(Part == P2.3)
  P1.3_new <- P1.3_row[1,2]
  P2.3_new <- P2.3_row[1,2]
  new_name2 <- paste("C", survey_ID_new, "P1", P1.3_new, "P2", P2.3_new, "survey.csv", sep = "_")
  new_name_loc2 <- paste(s_save_dir, new_name2, sep = "/")
  file.copy(from = file, to = new_name_loc2)
}

## Ok, very good. File name recode success
## P1 & P2 orders are sometimes flipped because survey entry order does not match speaking order
## This is BetterUp's fault. I did what I could. 

#Now we need to recode the IDs inside the files... oofda

transcripts2 <- list.files(path = t_save_dir,
                          pattern = "transcript_cliffhanger.csv",
                          full.names = TRUE,
                          recursive = FALSE)
  
surveys2 <- list.files(path = s_save_dir,
                       pattern = "survey.csv",
                       full.names = TRUE,
                       recursive = FALSE)

for(file in transcripts2){
  data2 <- read.csv(file)
  speaker_col <- data.frame()
  speaker_col$speaker <- data2$speaker
  P1.4_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts recoded/","",file)
  P1.4_hold2 <- gsub("_transcript_cliffhanger.csv","",P1.4_hold)
  P1.4 <- substr(P1.4_hold2,11,14)
  P2.4_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts recoded/","",file)
  P2.4_hold2 <- gsub("_transcript_cliffhanger.csv","",P2.4_hold)
  P2.4 <- substr(P2.4_hold2,19,22)
  
  
  }

