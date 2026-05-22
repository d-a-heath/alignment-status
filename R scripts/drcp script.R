#DCRP on align processed lemmas, POS, and turns


library(readr)
library(writexl)
library(readxl)
library(tidyverse)
library(dplyr)
library(crqa)

# prep the workspace
rm(list=ls())

#real
setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/lemma POS")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/lemma POS")

#output_folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/lemma POS/lemma DCRP/")

#test
#setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/test/")

#folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/test/")

#list the transcripts

transcripts <- list.files(path = folder,
                          pattern = "lemma_POS.csv")

#create dataframes for output

output.lemma <- data.frame()
#output.pos <- data.frame()
#output.turn <- data.frame()


#run DcRP for LEMMA

for(file in transcripts){
  data <- read.csv(file,)
    speakers <- unique(data$speaker)
  S1 <- speakers[1]
  S2 <- speakers[2]
  convo_id <- gsub("_lemma_POS.csv","",file)
  data_hold <- add_row(data, speaker = data$speaker[1], S1_lemma = "strt", S2_lemma = "strt", .before = 1)
  data_use <- add_row(data_hold, speaker = data$speaker[length(data)], S1_lemma ="stp", S2_lemma ="stp")

  text1 <- data_use$S1_lemma
  text2 <- data_use$S2_lemma
  
  #begin dcrp
  dcrp_results <- drpfromts(ts1 = text1,
                           ts2 = text2,
                           windowsize = 200,
                           radius = .0001,
                           delay = 1,
                           embed = 1,
                           rescale = 0,
                           normalize = 0,
                           mindiagline = 2,
                           minvertline = 2,
                           tw = 0,
                           whiteline = FALSE,
                           recpt = FALSE,
                           side = "both",
                           method = "crqa",
                           metric = "euclidean",
                           datatype = "categorical")
  
  lagmax <- data.frame(dcrp_results$maxlag)
  
  output.lemma <- rbind(output.lemma,
                        cbind("convo_id" = convo_id,
                              "S1" = S1,
                              "S2" = S2,
                              "maxrec" = dcrp_results$maxrec,
                              "maxlag" = rownames(lagmax)[1]))
  
  profile <- data.frame(dcrp_results$profile)
  profile.name <- paste(convo_id, "profile", sep = "_")
  profile.name2 <- paste(profile.name, "csv", sep = ".")
  write.csv(profile,  profile.name2)

  
    
}


write.csv(output.lemma, paste(folder, "dcrp_results_lemma.csv", sep = "/"), row.names = FALSE)