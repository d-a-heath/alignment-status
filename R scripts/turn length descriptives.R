# checking some descriptives of turn length to figure out window sizes

library(tidyverse)

data <- read.delim("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts/txt for align/analysis_ready/AlignmentT2T.txt")

turns <- data.frame(data$utterance_length1)

turns_unique <- unique(turns)

new.df <- data.frame(table(data$utterance_length1))

turn_mean <- mean(data$utterance_length1)

turn_sd <- sd(data$utterance_length1)