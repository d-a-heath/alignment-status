#recode participants
#the participant IDs that CANDOR uses are too long
#4 digit unique ids should be sufficient for both conversations and participants


##DO NOT RUN AGAIN##


#clear workspace
rm(list=ls())


#set directories
setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR")

transcript_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts"

survey_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys"

t_save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts recoded"

s_save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/surveys recoded"

#empty dataframe

ID_lookup <- data.frame()
convo_ID <- data.frame()
part_ID <- data.frame()

#get all conversations

transcripts <- list.files(path = transcript_dir,
                          pattern = "transcript_cliffhanger.csv",
                          full.names = TRUE,
                          recursive = FALSE)

#create ID dfs
for(file in transcripts){
  data <- read.csv(file)
  conversation_ID_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts/","",file) 
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

#assign shorter unique ids to participants
unique_parts <- unique(part_ID)
unique_parts$part_short_ID <- cbind(sample(1000:9999, 1456, replace = FALSE))

#map to lookup
#for conversations
ID.list <- as.list(ID_lookup$conversation_ID)

for(x in ID.list){
  ID_lookup$short_convo_ID <- convo_ID$short_ID
}

#for participants
part1.list <- as.list(ID_lookup$P1)

Part1.indexes <- lapply(part1.list, function (x){
                                  match_index <- match(x, unique_parts$Part)})

##I am giving up. Going to excel. 

write.csv(ID_lookup, "ID_lookup.csv")
write.csv(unique_parts, "unique_parts.csv")








