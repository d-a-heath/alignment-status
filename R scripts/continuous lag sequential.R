## test script, categorical lag sequential analysis

#load packages


#clear workspace
rm(list=ls())

#test file

data <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/data/current data/turns/00deb2e5-cf7f-4a5c-a8db-7fc335634ad6_turns.csv")

#convert nas to zeros

data[is.na(data)] <- 2

#speaker_2 <- as.matrix(as.numeric(data[,3]))
#speaker_1 <- as.matrix(as.numeric(data[,4]))

#colnames(speaker_1) <- NULL
#colnames(speaker_2) <- NULL

speaker_2 <- as.numeric(data[,3])
speaker_1 <- as.numeric(data[,4])

#DistMat <- as.matrix(dist(rbind(speaker_1,speaker_2)))[1:nrow(speaker_1), (nrow(speaker_1)+1):(nrow(speaker_1)*2)]
DistMat <- abs(outer(speaker_1,speaker_2,"-"))

Normed_DistMat <- DistMat/mean(DistMat)

#LagMat <- outer(1:nrow(Normed_DistMat), 1:ncol(Normed_DistMat), "-")
LagMat <- outer(1:length(speaker_1),1:length(speaker_1),"-")

lags <- -300:300

binned_lags <- sapply(lags, function(L) mean(Normed_DistMat[lags == L]))

plot(lags, binned_lags, type="b",
     xlab="Temporal lag)",
     ylab="Mean normalized distance",
     main="Continuous Lag Sequential")
abline(v=0, lty=2, col="red")