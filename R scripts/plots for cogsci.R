#rqa plots for lingcologne


library(readxl)
library(dplyr)
library(crqa)
library(ggplot2)

# prep the workspace
rm(list=ls())

#low diff conversation ID:7595d874-c1cb-4aef-918f-3c81f3a84324
#high diff conversation ID: af66868c-3afa-49db-b53c-9706f6fd28e2



#LowSynData <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/python outputs/CANDOR_transcripts_spacy_full/7595d874-c1cb-4aef-918f-3c81f3a84324_transcript_cliffhanger_output_cleaned.csv", na.strings = c("") )


#HighSynData <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/python outputs/CANDOR_transcripts_spacy_full/af66868c-3afa-49db-b53c-9706f6fd28e2_transcript_cliffhanger_output_cleaned.csv", na.strings = c(""))

#LowAlignData <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit/7595d874-c1cb-4aef-918f-3c81f3a84324_part_split.csv", na.strings = c(""))

#HighAlignData <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit/af66868c-3afa-49db-b53c-9706f6fd28e2_part_split.csv", na.strings = c(""))


LowDiffData <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit/7595d874-c1cb-4aef-918f-3c81f3a84324_part_split.csv", na.strings = c(""))

HighDiffData <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/partsplit/af66868c-3afa-49db-b53c-9706f6fd28e2_part_split.csv", na.strings = c(""))

## These must be run 1 at a time
## Let each one fully finish and load the plot before continuing
## Don't rush!

LowDiffDataHold <- add_row(LowDiffData, turn_id= LowDiffData$turn_id[1], speaker=LowDiffData$speaker[1], utterance="start", part1="start", part2="start", .before = 1)
LowDiffDataTest <- add_row(LowDiffDataHold, turn_id= LowDiffData$turn_id[length(LowDiffData)], speaker= LowDiffData$speaker[length(LowDiffData)], utterance="stop", part1="stop", part2="stop")

HighDiffDataHold <- add_row(HighDiffData, turn_id= HighDiffData$turn_id[1], speaker=HighDiffData$speaker[1], utterance="start", part1="start", part2="start", .before = 1)
HighDiffDataTest <- add_row(HighDiffDataHold, turn_id= HighDiffData$turn_id[length(HighDiffData)], speaker= HighDiffData$speaker[length(HighDiffData)], utterance="stop", part1="stop", part2="stop")



## Synergy Plots ##

#Low diff synergy (RQA)

lowsyn_ts <- LowDiffDataTest$utterance

lowdiffRQA <- crqa(ts1 = lowsyn_ts,
                   ts2 = lowsyn_ts,
                   delay = 0,
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
                   method = "rqa",
                   datatype = "categorical"
)

plot_rp(lowdiffRQA$RP,
        pcolour = "darkolivegreen",
        xlabel = "Full Transcript",
        ylabel = "Full Transcript",
        geom = "point",
        flip_y = FALSE
        )



#High diff synergy (RQA)

highsyn_ts <- HighDiffDataTest$utterance

highdiffRQA <-  crqa(ts1 = highsyn_ts,
                   ts2 = highsyn_ts,
                   delay = 0,
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
                   method = "rqa",
                   datatype = "categorical"
)

plot_rp(highdiffRQA$RP,
        pcolour = "darkgoldenrod",
        xlabel = "Full Transcript",
        ylabel = "Full Transcript",
        geom = "point",
        flip_y = FALSE
)



## Alignment Plots

#Low diff alignment (CRQA)
#LowDiffDataHold <- add_row(LowDiffData, turn_id= LowDiffData$turn_id[1], speaker=LowDiffData$speaker[1], utterance="start", part1="start", part2="start", .before = 1)
#LowDiffDataTest <- add_row(LowDiffDataHold, turn_id= LowDiffData$turn_id[length(LowDiffData)], speaker= LowDiffData$speaker[length(LowDiffData)], utterance="stop", part1="stop", part2="stop")

lowalign_ts1 <- LowDiffDataTest$part1
lowalign_ts2 <- LowDiffDataTest$part2

#test 0011

#lowalign_ts1 <- c(0,0,1,0,1,1,0,1,0,1)
#lowalign_ts2 <- c(1,0,1,1,0,0,1,0,0,1)


lowdiffCRQA <- crqa(ts1 = lowalign_ts2,
                   ts2 = lowalign_ts1,
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

plot_rp(lowdiffCRQA$RP,
        pcolour = "darkolivegreen",
        xlabel = "Participant A Transcript",
        ylabel = "Participant B Transcript",
        geom = "tile",
        flip_y = FALSE
)  +  scale_x_continuous(breaks = seq(1,10,by = 1)) #+  scale_y_continuous(breaks = seq(1,10,by = 1))
  
#High diff alignment (CRQA)

#HighDiffDataHold <- add_row(HighDiffData, turn_id= HighDiffData$turn_id[1], speaker=HighDiffData$speaker[1], utterance="start", part1="start", part2="start", .before = 1)
#HighDiffDataTest <- add_row(HighDiffDataHold, turn_id= HighDiffData$turn_id[length(HighDiffData)], speaker= HighDiffData$speaker[length(HighDiffData)], utterance="stop", part1="stop", part2="stop")


highalign_ts1 <- HighDiffDataTest$part1
highalign_ts2 <- HighDiffDataTest$part2

highdiffCRQA <- crqa(ts1 = highalign_ts1,
                    ts2 = highalign_ts2,
                    delay = 0,
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

plot_rp(highdiffCRQA$RP,
        pcolour = "darkgoldenrod",
        xlabel = "Participant A Transcript",
        ylabel = "Participant B Transcript",
        geom = "point",
        flip_y = FALSE
)
