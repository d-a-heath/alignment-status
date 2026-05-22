#pulling turn taking information


library(readxl)
library(tidyverse)
library(crqa)



# prep the workspace
rm(list=ls())


setwd <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts/turn test")

#folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts/turn test")

testfile <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts/turn test/0aff0afe-6552-4f0d-a868-265e51c25bf2_transcript_cliffhanger.csv")

#####

len_exact = tail(testfile$stop, n = 1)

len_seconds = round(len_exact, digits = 0)

testfile$start_round <- round(testfile$start, digits = 0)
testfile$stop_round <- round(testfile$stop, digits = 0)

###

binary_conv <- expand.grid(
  time = 1:len_seconds,
  speaker = unique(testfile$speaker)
) %>%
  rowwise() %>%
  mutate(talking = any(time >= testfile$start_round[testfile$speaker == speaker] &
                         time <= testfile$stop_round[testfile$speaker == speaker])) %>%
  ungroup() %>%
  #mutate(talking = as.integer(talking)) %>%  # this gives you behavior matching (talking/silence)
  mutate(talking = ifelse(talking, 1, NA)) %>% # this gives you only talking
  pivot_wider(
    names_from = speaker,
    values_from = talking,
  )


testcrqa <- crqa(ts1 = binary_conv$`5f00cc127086ce2029ae6541`, # y axis!
                    ts2 = binary_conv$`5dbc46b70338051eb7999760`, # x axis! 
                    delay = 1,
                    embed = 1,
                    rescale = 0,
                    radius = 0.0001,
                    normalize = 0,
                    mindiagline = 2,
                    minvertline = 2,
                    tw = 0,
                    whiteline = FALSE,
                    recpt = FALSE,
                    side = "both",
                    method = "crqa",
                    datatype = "categorical"
)

plot_rp(testcrqa$RP,
        pcolour = "darkolivegreen",
        xlabel = "Participant A Transcript",
        ylabel = "Participant B Transcript",
        geom = "tile",
        flip_y = FALSE
)