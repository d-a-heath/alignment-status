#Split transcripts by speaker, step 2

library(readr)
library(writexl)
library(readxl)
library(tidyverse)
library(dplyr)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/strsplit")
#setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set/separated")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/strsplit")
#folder<- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set/separated")

output.folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit")
#output.folder <-  ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set/separated2")

#create a list of transcripts

transcripts <- list.files(path = folder,
                          pattern = "split.csv",
                          full.names = FALSE,
                          recursive = FALSE)

for(file in transcripts){
  data <- read.csv(file)
  parts <- unique(data$speaker)
  part1 <- parts[1]
  part2 <- parts[2]
  data$part1 <- ifelse(data$speaker == part1,data$utterance, "")
  data$part2 <- ifelse(data$speaker == part2,data$utterance, "")
  file.hold <- gsub("_strsplit.csv", "", file)
  new.file <- paste(file.hold, "part_split", sep = "_")
  new.file2 <- paste(new.file, "csv", sep = ".")
  output <- paste(output.folder, new.file2, sep = "/" )
  write_csv(data,output)
}