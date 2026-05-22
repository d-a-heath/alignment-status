#this is an R script for extracting strings from 
#CANDOR transcripts and converting them into a *.txt file
#and maybe then doing numerical indexes?
#thanks to chatGPT and stackOverflow

#clear workspace

rm(list=ls())

# Load the required library
library(readxl)
library(writexl)

#setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts")

# Specify the directory containing the CSV files
#csv_directory <- "D:/CANDOR"
#csv_directory <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts"
csv_directory <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/cliffhanger transcripts recoded 4 bins"

#save_path <-"C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/cliffhanger transcripts/text files"

# List all CSV files in the directory
csv_files <- list.files(path = csv_directory,
                        pattern = "transcript_cliffhanger.csv",
                        full.names = TRUE,
                        recursive = FALSE)

# Initialize an empty list to store data frames
data_list <- list()

# Loop through each CSV file and read it into a data frame
for (file in csv_files) {
  data <- read.csv(file)
  data_list[[file]] <- data
  save_path <- gsub(".csv", ".txt",file)
  #output_file <- file.path(save_path,".txt")
  string_data <- data$utterance
  
  # Write the string data to a text file, one entry per line
  writeLines(as.character(string_data), con = save_path)
  }

#####
#####


# convert to numerical indexes


# List all CSV files in the directory
txt_files <- list.files(path = csv_directory,
                        pattern = "transcript_cliffhanger.txt",
                        full.names = TRUE,
                        recursive = TRUE,
                        include.dirs = TRUE)

# Initialize an empty list to store data frames
txt_list <- list()

# Loop through each CSV file and read it into a data frame
for (file in txt_files) {
  
  #read text file
  txt_data <- readLines(file) 
  txt_list[[file]] <- txt_data
  
  #combining into single string
  txt_combined <- paste(txt_data, collapse = " ") 
  
  #split text into words
  words<- unlist(strsplit(txt_combined, "//s+")) 
  
  #remove punct, convert to lowercase
  clean_words <- tolower(gsub("[[:punct:]]", "", words)) 
  
  # Create a named vector where each unique word gets a unique index
  unique_words <- unique(clean_words)
  word_indices <- setNames(seq_along(unique_words), unique_words)
  
  # Map the original words to their respective indices
  indexed_vector <- word_indices[clean_words]
  
  # get file path
  txt_save_path <- gsub("transcript_cliffhanger.txt", "",file)
  
  # save the unique word-to-index mapping to a file
  txt_output_file <- file.path(txt_save_path, "transcript_cliffhanger_indexed.csv")
  write.csv(data.frame(Word = words, Index = indexed_vector),
            file = txt_output_file, row.names = FALSE)
  #writeLines(as.character(indexed_vector), con = txt_output_file)
  
}



