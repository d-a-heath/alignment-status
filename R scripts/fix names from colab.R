#rename our transcripts
#the output from spaCy gave everything a number at the end (e.g. (1)).
#this is because of a google drive tick
#were just going to clean these filenames so they're consistent

library(tidyverse)
library(dplyr)

#clear workspace
rm(list=ls())

#set dir
setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/python outputs/CANDOR_transcripts_spacy_full")
#setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/spacy test")

filedir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/python outputs/CANDOR_transcripts_spacy_full"
#filedir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/spacy test"

#text first
#get files
file_list <- list.files(path = filedir,
                        pattern = ".txt",
                        full.names = FALSE)

#rename
for(file in file_list){
  new_name <- substr(file, 1,59)
  new_name2 <- paste(new_name,"_output.txt", sep = "")
  file.rename(from = file, to = new_name2)
}

#now csvs
#get files
file_list2 <- list.files(path = filedir,
                        pattern = ".csv",
                        full.names = FALSE)

#rename
for(file in file_list2){
  new_name.1 <- substr(file, 1,59)
  new_name2.1 <- paste(new_name.1,"_output.csv", sep = "")
  file.rename(from = file, to = new_name2.1)
}