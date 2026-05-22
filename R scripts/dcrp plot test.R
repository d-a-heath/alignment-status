#some test plotting with align outputs


library(readxl)
library(dplyr)
library(crqa)
library(ggplot2)

# prep the workspace
rm(list=ls())


data <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/align processed/lemma POS/ffd372b5-0a7e-420f-bcd5-459119723e89_lemma_POS.csv")



data_hold <- add_row(data, speaker = data$speaker[1], S1_POS = "strt", S2_POS = "strt", .before = 1)
data_use <- add_row(data_hold, speaker = data$speaker[length(data)], S1_POS ="stp", S2_POS ="stp")

text1 <- data_use$S1_POS
text2 <- data_use$S2_POS


crp <- crqa(ts1 = text1,
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

plot_rp( crp$RP,
        pcolour = "darkolivegreen",
        xlabel = "Speaker 1",
        ylabel = "Speaker 2",
        geom = "point",
        flip_y = FALSE,
       
) +  scale_x_continuous(breaks = seq(0, length(text1), by = 200))
