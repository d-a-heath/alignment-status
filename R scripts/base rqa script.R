#this is a test crqa script to
#run an autoreccurance on a CANDOR 
#transcript, using the cliffhanger
#version
#code mostly from Alex Paxtons crqa tutorial

# prep the workspace
rm(list=ls())

library(crqa)

setwd("C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR test crqa")

#data = read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR test crqa/transcript_cliffhanger_indexed.csv")

data(crqa)

# set the Theiler window parameter for RQA (should be 1 to ignore LOI in RQA)
rec_tw_quantification = 1

# set radius to be very small for categorical matches
rec_categorical_radius = .0001

######## 3b. Run recurrence quantification analysis ########

# run rqa over informative text
recurrence_analysis_transcript = crqa(ts1=text,
                                       ts2=text,
                                       delay=1,
                                       embed=1,
                                       rescale=0,
                                       radius=rec_categorical_radius,
                                       normalize=0,
                                       mindiagline=2,
                                       minvertline=2,
                                       tw=rec_tw_quantification)

######## 3c. Create the recurrence plot ########

# Note: In order to get the line of identity to appear in these plots,
#       you must run another `crqa()` function call with a Theiler window
#       (`tw`) of 0 in order to preserve the line of identity in the plot.

# set the Theiler window parameter for RP (should be 0 to keep LOI in RP)
rec_tw_plot = 0

# run rqa over informative with a Theiler window of 0 for plotting
recurrence_analysis_plot_transcript = crqa(ts1=text,
                                            ts2=text,
                                            delay=1,
                                            embed=1,
                                            rescale=0,
                                            radius=rec_categorical_radius,
                                            normalize=0,
                                            mindiagline=2,
                                            minvertline=2,
                                            tw=0)


# use crqa package's native plotting function
par = list(unit = 2, 
           labelx = "Letter", 
           labely = "Letter", 
           cols = "purple", 
           pcex = 1)
plot_rp(recurrence_analysis_plot_transcript$RP, par)

# take a look at the quantification metrics for informative text
recurrence_analysis_transcript$RR # rate of recurrence
recurrence_analysis_transcript$DET # % determinism
recurrence_analysis_transcript$NRLINE # total number of lines on the plot
recurrence_analysis_transcript$maxL # maximum line length on plot
recurrence_analysis_transcript$L # average line length on plot
recurrence_analysis_transcript$ENTR # entropy
recurrence_analysis_transcript$rENTR # normalized entropy
recurrence_analysis_transcript$LAM # laminarity
recurrence_analysis_transcript$TT # trapping time

rqa_metrics <- data.frame()

rqa_metrics <- cbind(
  "RR" = recurrence_analysis_transcript$RR, # rate of recurrence
  "DET" = recurrence_analysis_transcript$DET, # % determinism
  "NRLINE" = recurrence_analysis_transcript$NRLINE, # total number of lines on the plot
  "maxL" = recurrence_analysis_transcript$maxL, # maximum line length on plot
  "L" = recurrence_analysis_transcript$L, # average line length on plot
  "ENTR" = recurrence_analysis_transcript$ENTR, # entropy
  "rENTR" = recurrence_analysis_transcript$rENTR, # normalized entropy
  "LAM" = recurrence_analysis_transcript$LAM, # laminarity
  "TT" = recurrence_analysis_transcript$TT) # trapping time



