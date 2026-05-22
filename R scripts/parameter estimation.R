#load packages

library("tidyverse")
library("readxl")
library("crqa")
library("dplyr")



#clear workspace
rm(list=ls())

#specify our dirs

csv_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts"

survey_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test surveys"

spacy_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/spacy test"

save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test set"

setwd(spacy_dir)

#get files
spacy_transcripts <- list.files(path = spacy_dir,
                                pattern = "output_cleaned_indexed.csv",
                                full.names = FALSE)

param_est <- data.frame()

par = list(method = "crqa", metric = "euclidean", maxlag = 20,
           radiusspan = 100, radiussample = 40, normalize = 0,
           rescale = 4, mindiagline = 10, minvertline = 10, tw = 0,
           whiteline = FALSE, recpt = FALSE, side = "both",
           datatype = "categorical", fnnpercent = NA,
           typeami = "maxdip", nbins = 50, criterion = "firstBelow",
           threshold = 1, maxEmb = 20, numSamples = 500,
           Rtol = 10, Atol = 2)


for(file in spacy_transcripts){
  results <- data.frame()
  transcript_data <- data.frame()
  text <- data.frame()
  transcript_data <- read.csv(file)
  transcript_data_short <- transcript_data[1:1000,]
  text <- transcript_data_short$LemmaIndex
  results <- optimizeParam(text,text,par = par)
  
  param_est <- rbind(param_est, cbind(unlist(results)))
  
}

#write_csv(param_est, "param_est.csv")