#this is a test crqa script to
#run an autoreccurance on a CANDOR 
#transcript, using the cliffhanger
#version


library(readr)
library(writexl)
library(readxl)
library(tidyverse)
library(dplyr)
library(crqa)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit")
#setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set/separated2")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit")
#folder<- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/Presentations/LingCologne/test set/separated2")


#create a list of transcripts

transcripts <- list.files(path = folder,
                          pattern = "split.csv",
                          full.names = FALSE,
                          recursive = FALSE)

sorted_transcripts <- sort(transcripts, decreasing = TRUE)

# set the Theiler window parameter for RQA (should be 1 to ignore LOI in RQA)
rec_tw_quantification = 1

# set radius to be very small for categorical matches
rec_categorical_radius = .0001

rqa_metrics <- data.frame()

for(file in sorted_transcripts){
  data = read.csv(file, na.strings = c(""))
  data_hold <- add_row(data, turn_id = data$turn_id[1], speaker = data$speaker[1], utterance ="start", part1 = "start", part2 = "start", .before = 1)
  data_use <- add_row(data_hold, turn_id = data$turn_id[length(data)], speaker = data$speaker[length(data)], utterance ="stop", part1 ="stop", part2 ="stop")
  text1 <- data_use$part1
  text2 <- data_use$part2
  #convoID <- gsub("_split.csv_part_split.csv","", file)
  convoID <- gsub("_part_split.csv","", file)
  len = length(text1)
  lenhalf = len / 2
  lenquart = len /4

######## 3b. Run recurrence quantification analysis ########

# run rqa over informative text
recurrence_analysis_transcript = piecewiseRQA(ts1=text1,
                                       ts2=text2,
                                       blockSize = lenquart,
                                       delay=1,
                                       embed=1,
                                       rescale=0,
                                       radius=rec_categorical_radius,
                                       normalize=0,
                                       mindiagline=2,
                                       minvertline=2,
                                       tw=rec_tw_quantification,
                                       whiteline = "FALSE",
                                       recpt = "FALSE",
                                       datatype = "categorical",
                                       typeRQA = "full",
                                       method = "crqa")

######## 3c. Create the recurrence plot ########

# Note: In order to get the line of identity to appear in these plots,
#       you must run another `crqa()` function call with a Theiler window
#       (`tw`) of 0 in order to preserve the line of identity in the plot.

# set the Theiler window parameter for RP (should be 0 to keep LOI in RP)
rec_tw_plot = 0

# run rqa over informative with a Theiler window of 0 for plotting
#recurrence_analysis_plot_transcript = piecewiseRQA(ts1=text1,
 #                                           ts2=text2,
  #                                          blockSize = 100,
   #                                         delay=1,
    #                                        embed=1,
     #                                       rescale=0,
      #                                      radius=rec_categorical_radius,
       #                                     normalize=0,
        #                                    mindiagline=2,
         #                                   minvertline=2,
          #                                  tw=0,
           #                                 typeRQA = "full")


# use crqa package's native plotting function
#par = list(unit = 2, 
 #          labelx = "Letter", 
  #         labely = "Letter", 
   #        cols = "purple", 
    #       pcex = 1)
#plot_rp(recurrence_analysis_plot_transcript$RP, par)



rqa_metrics <- rbind(rqa_metrics,
  cbind(
  "convoID" = convoID,
  "RR" = recurrence_analysis_transcript$RR, # rate of recurrence
  "DET" = recurrence_analysis_transcript$DET, # % determinism
  "NRLINE" = recurrence_analysis_transcript$NRLINE, # total number of lines on the plot
  "maxL" = recurrence_analysis_transcript$maxL, # maximum line length on plot
  "L" = recurrence_analysis_transcript$L, # average line length on plot
  "ENTR" = recurrence_analysis_transcript$ENTR, # entropy
  "rENTR" = recurrence_analysis_transcript$rENTR, # normalized entropy
  "catH" = recurrence_analysis_transcript$catH,
  "LAM" = recurrence_analysis_transcript$LAM, # laminarity
  "TT" = recurrence_analysis_transcript$TT)) # trapping time

}

write_csv(rqa_metrics, paste(folder, "crqa_metrics_7.27_reverse_order.csv", sep="/"))