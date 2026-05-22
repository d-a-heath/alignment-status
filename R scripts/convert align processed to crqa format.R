# Pull in processed transcripts from ALIGN
# Get lemmas and POS into single columns
# turn_id, speaker, lemma, POS

library(readr)
library(writexl)
library(readxl)
library(tidyverse)
library(dplyr)

# prep the workspace
rm(list=ls())

setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed")

#folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/test")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed")

output.folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/lemma POS")

transcripts <- list.files(path = folder,
                          pattern = "cliffhanger.txt",
                          full.names = FALSE,
                          recursive = FALSE)

for (file in transcripts){
  data <- read.delim(file)
  #grab speaker and tagged lemmas
  data.2 <- data.frame(cbind(speaker = data$participant,
                             tagged_lemma = data$tagged_lemma))
  #remove extra characters, except (
  clean.1 <- str_replace_all(data.2$tagged_lemma, "[\\[\\]\\,'\\)]","")
  clean.2 <- as.data.frame(clean.1)
  #get the band back together
  data.3 <- data.frame(cbind(speaker = data.2$speaker,
                             tagged_lemma = clean.2$clean.1))
  #split tagged lemmas into rows using (
  data.4 <- data.frame(separate_longer_delim(data.3, c(tagged_lemma), delim = "("))
  #split lemma and POS into separate columns using " "
  split.1 <- strsplit(data.4$tagged_lemma, " ")
  #this adds NAs to empty cells which are created by the splitting into rows
  #if you don't do this it gets confused
  max_len <- max(sapply(split.1, length))
  split_matrix <- t(sapply(split.1, function(x) {
    length(x) <- max_len
    return(x)
  }))
  split.2 <- as.data.frame(split_matrix)
  #get the band back together again
  data.5 <- data.frame(cbind(speaker = data.4$speaker,
                             lemma = split.2$V1,
                             POS = split.2$V2))
  #get rid of those NA rows
  data.6 <- na.omit(data.5)
  #get lemmas and POS into unique columns for each speakker so we can do crqa
  speakers <- unique(data.6$speaker)
  S1 <- speakers[1]
  S2 <- speakers[2]
  data.6$S1_lemma <- ifelse(data.6$speaker == S1, data.6$lemma, NA)
  data.6$S2_lemma <- ifelse(data.6$speaker == S2, data.6$lemma, NA)
  data.6$S1_POS <- ifelse(data.6$speaker == S1, data.6$POS, NA)
  data.6$S2_POS <- ifelse(data.6$speaker == S2, data.6$POS, NA)
  #save to file
  filename.1 <- gsub("_transcript_cliffhanger.txt", "", file)
  filename.2 <- paste(filename.1, "lemma", "POS", sep = "_")
  filename.3 <- paste(filename.2, "csv", sep = ".")
  output <- paste(output.folder, filename.3, sep = "/" )
  write_csv(data.6,output)
}


## TEST

#testfile <- read.delim("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/test/0af09289-1953-4e71-bee5-b34a5828fe52_transcript_cliffhanger.txt")

#test.2 <- data.frame(cbind(speaker = testfile$participant,
                          # tagged_lemma = testfile$tagged_lemma))

#clean.1 <- str_replace_all(test.2$tagged_lemma, "[\\[\\]\\,'\\)]","")

#clean.2 <- as.data.frame(clean.1)

#test.3 <- data.frame(cbind(speaker = test.2$speaker,
                         #   tagged_lemma = clean.2$clean.1))

#test.4 <- data.frame(separate_longer_delim(test.3, c(tagged_lemma), delim = "("))

#split.1 <- strsplit(test.4$tagged_lemma, " ")

#max_len <- max(sapply(split.1, length))

#word_matrix <- t(sapply(split.1, function(x) {
 # length(x) <- max_len
  #return(x)
#}))

#split.2 <- as.data.frame(word_matrix)

#test.5 <- data.frame(cbind(speaker = test.4$speaker,
                     # lemma = split.2$V1,
                      #POS = split.2$V2))

#test.6 <- na.omit(test.5)


#testcsv <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/test/0af09289-1953-4e71-bee5-b34a5828fe52_lemma_POS.csv")