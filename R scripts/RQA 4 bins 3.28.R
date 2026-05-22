#RQA 4 bins
#CANDOR dataset

library("tidyverse")
library("crqa")


#clear workspace
rm(list=ls())

setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR")

spacy_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/CANDOR_transcripts_spacy_recoded_4bins"
#spacy_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/spacy test"

save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/output 3.28"



spacy_transcripts <- list.files(path = spacy_dir,
                                pattern = "_spacy.csv",
                                full.names = TRUE,
                                recursive = FALSE)

  
#create a df for metrics
rqa_metrics <- data.frame()
  
  
#pull in each file and do a recurrence analysis
#need to check delay and embedding values
#F&T use three
for(file in spacy_transcripts){
    transcript_data <- read.csv(file)
    transcript_data_nopunct <- filter(transcript_data, POS != "PUNCT")
    file_name <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/CANDOR_transcripts_spacy_recoded_4bins/","",file)
    fileID <- substr(file_name, 1, 28)
    convoID <- substr(file_name, 3, 6)
    P1 <- substr(file_name, 11, 14)
    P2 <- substr(file_name, 19,22)
    Bin <- substr(file_name, 28, 28)
    text <- transcript_data_nopunct$Tag
    
    #one for the metrics, tw=1
    recurrence_analysis_transcript = crqa(ts1=text,
                                          ts2=text,
                                          delay=1,
                                          embed=1,
                                          rescale=0,
                                          radius=.0001,
                                          normalize=0,
                                          mindiagline=2,
                                          minvertline=2,
                                          tw=1,
                                          method = "rqa",
                                          datatype = "categorical",
                                          whiteline = FALSE)

    
    #need to write metrics into df
    #need to add conversation IDS
    #This will take a long ass time to run
    rqa_metrics <- rbind(rqa_metrics,
                         cbind( "fileID" = fileID,
                                "convoID" = convoID,
                                "P1" = P1,
                                "P2" = P2,
                                "Bin" = Bin,
                                "RR" = recurrence_analysis_transcript$RR, # rate of recurrence
                                "DET" = recurrence_analysis_transcript$DET, # % determinism
                                "NRLINE" = recurrence_analysis_transcript$NRLINE, # total number of lines on the plot
                                "maxL" = recurrence_analysis_transcript$maxL, # maximum line length on plot
                                "L" = recurrence_analysis_transcript$L, # average line length on plot
                                "ENTR" = recurrence_analysis_transcript$ENTR, # entropy
                                "rENTR" = recurrence_analysis_transcript$rENTR, # normalized entropy
                                "catH"= recurrence_analysis_transcript$catH, #categorical area entropy
                                "LAM" = recurrence_analysis_transcript$LAM, # laminarity
                                "TT" = recurrence_analysis_transcript$TT)) # trapping time 
    
    
}  
  
write.csv(rqa_metrics, paste(save_dir, "rqa_metrics_4bins_POStags_3_28.csv", sep="/"),row.names = FALSE)
  