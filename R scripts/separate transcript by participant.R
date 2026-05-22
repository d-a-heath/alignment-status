#Split transcripts by speaker

library(readr)
library(writexl)
library(readxl)
library(tidyverse)
library(dplyr)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts")
#folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR")

output.folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/separated transcripts")

#create a list of transcripts

transcripts <- list.files(path = folder,
                      pattern = "transcript_cliffhanger.csv",
                      full.names = FALSE,
                      recursive = FALSE)


#loop through transcripts and separate each participant into their own df

for(file in transcripts){
  data <- read.csv(file)
  trans.df.1 <- data.frame()
  trans.df.2 <- data.frame()
  trans.name.1 <- data$speaker[1]
  trans.name.2 <- data$speaker[2]
  trans.df.1 <- filter(data, data$speaker == trans.name.1)
  trans.df.2 <- filter(data, data$speaker == trans.name.2)
  file.hold <- gsub("_transcript_cliffhanger.csv", "", file)
  new.file.name.1 <- paste(file.hold, trans.name.1,"transcript_cliffhanger.csv",sep = "_")
  new.file.name.2 <- paste(file.hold, trans.name.2,"transcript_cliffhanger.csv",sep = "_")
  new.file.loc.1 <- paste(output.folder, new.file.name.1, sep = "/")
  new.file.loc.2 <- paste(output.folder, new.file.name.2, sep = "/")
  write_csv(trans.df.1, new.file.loc.1)
  write_csv(trans.df.2, new.file.loc.2)
  }