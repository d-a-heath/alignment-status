#RQA 4 bins
#CANDOR dataset

library("tidyverse")
library("crqa")


#clear workspace
rm(list=ls())



spacy_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/CANDOR_transcripts_spacy_recoded_4bins"

save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/output 3.28"

setwd(spacy_dir)

spacy_transcripts <- list.files(path = spacy_dir,
                                pattern = "output.csv",
                                full.names = FALSE,
                                include.dirs = TRUE)



for(file in spacy_transcripts){
  transcript_data <- read.csv(file)
  cleaned.df <- data.frame()
  filter_var <- "PUNCT"
  cleaned.df <- filter(transcript_data, POS != filter_var)
  new_name <- gsub("output.csv", "output_cleaned.csv",file)
  
  
  setwd(spacy_dir)
  
  #get files
  spacy_transcripts_clean <- list.files(path = spacy_dir,
                                        pattern = "output_cleaned.csv",
                                        full.names = FALSE)
  
  #create a df for metrics
  rqa_metrics <- data.frame()
  
  
  #pull in each file and do a recurrence analysis
  #need to check delay and embedding values
  #F&T use three
  for(file in spacy_transcripts_clean){
    transcript_data <- read.csv(file)
    fileID <- substr(file, 1, 28)
    convoID <- substr(file, 3, 6)
    P1 <- substr(file, 11, 14)
    P2 <- substr(file, 19,22)
    Bin <- substr(file, 28, 28)
    text <- transcript_data$Lemma
    
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
                                          datatype = "categorical")
    #need to save each plot
    #png(file = gsub(".csv",".png",file), width = 256, height = 256)
    
    #two for the plot,tw = 0
    #  recurrence_analysis_plot_transcript = crqa(ts1=text,
    #                                           ts2=text,
    #                                          delay=1,
    #                                         embed=1,
    #                                        rescale=0,
    #                                       radius=.0001,
    #                                      normalize=0,
    #                                     mindiagline=2,
    #                                    minvertline=2,
    #                                   tw=0,
    #                                  method = "rqa",
    #                                 datatype = "categorical")
    
    
    # use crqa package's native plotting function
    #par = list(unit = 2, 
    #      labelx = "Letter", 
    #     labely = "Letter", 
    #    cols = "purple", 
    #   pcex = 1)
    #    plot_rp(recurrence_analysis_plot_transcript$RP, par)
    # rp_plot <- recurrence_analysis_plot_transcript$RP
    #plot_rp(rp_plot)
    #  dev.off
    
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
                                "catT"= recurrence_analysis_transcript$catH #categorical area entropy
                                "LAM" = recurrence_analysis_transcript$LAM, # laminarity
                                "TT" = recurrence_analysis_transcript$TT)) # trapping time 
    
    
    
    
  }
  
  write_csv(rqa_metrics, paste(save_dir, "rqa_metrics_test.csv", sep="/")
  