#this script is for indexing lemmas in 
#CANDOR transcripts that have been separated 
#by participant and lemmatized using spacy
#in a colab notebook

#shit, I just realized I will have to lemmatize and index them before I split them, otherwise the indexes wont match FUCK

#load req'd packages
library(readr)

# prep the workspace
rm(list=ls())

#specify our dir

setwd("C:/Users/
            daheath/
            OneDrive - The University of Memphis/Heath/
            Alignment Status/
            CANDOR")

csv_dir <- "C:/Users/
            daheath/
            OneDrive - The University of Memphis/Heath/
            Alignment Status/
            CANDOR/
            python outputs/
            /CANDOR_transcripts_spacy"

output_dir <- "C:/Users/
            daheath/
            OneDrive - The University of Memphis/Heath/
            Alignment Status/
            CANDOR/
            indexed lemmas"


#make a list of our files

# List all CSV files in the directory
csv_files <- list.files(path = csv_directory,
                        pattern = "transcript_cliffhanger.csv",
                        full.names = TRUE,
                        recursive = TRUE,
                        include.dirs = TRUE)

# Initialize an empty list to store data frames
data_list <- list()

# Loop through each CSV file and read it into a data frame
for (file in csv_files) {
  data <- read.csv(file)
  data_list[[file]] <- data

