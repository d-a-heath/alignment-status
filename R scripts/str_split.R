#Split transcripts by speaker

library(readr)
library(writexl)
library(readxl)
library(tidyverse)
library(dplyr)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts")
#setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts")
#folder<- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set")

output.folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/strsplit")
#output.folder <-  ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set/separated")

#create a list of transcripts

transcripts <- list.files(path = folder,
                          pattern = "transcript_cliffhanger.csv",
                          full.names = FALSE,
                          recursive = FALSE)

#loop through list
#create new df for each conversation with split strings and conversation id retained
#maybe turn id too?

for (file in transcripts){
  data <- read.csv(file)
  utter_rep <- str_replace_all(data$utterance,"'"," ")
  data2 <- data.frame(cbind(turn_id = data$turn_id,
                            speaker = data$speaker, 
                            utterance = utter_rep))
  new.df <- data.frame()
  new.df <- separate_longer_delim(data2, c(speaker, utterance), delim = " ")
  file.hold <- gsub("_transcript_cliffhanger.csv", "", file)
  new.file <- paste(file.hold, "strsplit", sep = "_")
  new.file2 <- paste(new.file, "csv", sep = ".")
  output <- paste(output.folder, new.file2, sep = "/" )
  write_csv(new.df,output)
}