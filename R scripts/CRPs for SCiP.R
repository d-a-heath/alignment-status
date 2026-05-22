#rqa plots for lingcologne


library(readxl)
library(dplyr)
library(crqa)
library(ggplot2)

# prep the workspace
rm(list=ls())


conversation_lemma_pos <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/data/current data/lemma POS/002d68da-7738-4177-89d9-d72ae803e0e4_lemma_POS.csv")
conversation_turn <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/data/current data/turns/002d68da-7738-4177-89d9-d72ae803e0e4_turns.csv")
  
## These must be run 1 at a time
## Let each one fully finish and load the plot before continuing
## Don't rush!

#CRQA

#Time series - lemma and pos
#lemma 

#data_hold <- add_row(conversation_lemma_pos, speaker = conversation_lemma_pos$speaker[1], S1_lemma = "strt", S2_lemma = "strt", .before = 1)
#data_use <- add_row(data_hold, speaker = conversation_lemma_pos$speaker[length(data)], S1_lemma ="stp", S2_lemma ="stp")

#text1 <- data_use$S1_lemma
#text2 <- data_use$S2_lemma

#pos
#data_hold <- add_row(conversation_lemma_pos, speaker = conversation_lemma_pos$speaker[1], S1_POS = "strt", S2_POS = "strt", .before = 1)
#data_use <- add_row(data_hold, speaker = conversation_lemma_pos$speaker[length(conversation_lemma_pos)], S1_POS ="stp", S2_POS ="stp")

#text1 <- data_use$S1_POS
#text2 <- data_use$S2_POS


#Time series - turns

conversation_turn[is.na(conversation_turn)] <- 0

## change column names so we can add start/stop rows

colnames(conversation_turn) <- c("dummy", "time", "speaker1", "speaker2")

## add start/stop rows - here numerical bc cols are int

data_hold <- add_row(conversation_turn, dummy = 9999, 
                  time = 9999, 
                 speaker1 = 9999,
                speaker2 = 9999,
               .before = 1)

data_use <- add_row(data_hold, dummy = 8888,
                 time = 8888,
                speaker1 = 8888,
               speaker2 = 8888,
              .after = nrow(data_hold))

text1 <- data_use$speaker1
text2 <- data_use$speaker2


CRQA <- crqa(ts1 = text1,
                   ts2 = text2,
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

plot_rp(CRQA$RP,
        pcolour = "black",
        xlabel = "Speaker 1",
        ylabel = "Speaker 2",
        geom = "point",
        flip_y = FALSE
        )



