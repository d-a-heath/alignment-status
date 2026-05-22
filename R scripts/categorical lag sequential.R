## test script, categorical lag sequential analysis

#load packages


#clear workspace
rm(list=ls())

#test file

data <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/data/current data/turns/00deb2e5-cf7f-4a5c-a8db-7fc335634ad6_turns.csv")

#convert nas to zeros

data[is.na(data)] <- 0

speaker_2 <- c(data[,3])
speaker_1 <- c(data[,4])

convert_one_to_zero <- function(x) {
  if (x == 1) {
    return(0)
  } else {
    return(1)
  }
}

speaker_2_inverted <- sapply(speaker_2, convert_one_to_zero)
speaker_1_inverted <- sapply(speaker_1, convert_one_to_zero)



#len <- nrow(data)

#if(len %% 2 == 0){
 # maxlag <- len/2 - 1
#} else {
 # maxlag <- (len-1)/2
#}

#maxlag <- nrow(data)
#minlag <- -maxlag

lags = -300:300

output <- data.frame()

for(lag in lags){
  if(lag > 0){
    speaker_1_lagged <- speaker_1_inverted[1:(length(speaker_1) - lag)]
    speaker_2_lagged <- speaker_2_inverted[(1 + lag): length(speaker_2)]
  } else if (lag < 0){
    lag_abs <- abs(lag)
    speaker_1_lagged <- speaker_1_inverted[(1 + lag_abs):length(speaker_1)]
    speaker_2_lagged <- speaker_2_inverted[1:(length(speaker_2) - lag_abs)]
  } else {
    speaker_1_lagged <- speaker_1_inverted
    speaker_2_lagged <- speaker_2_inverted
  }
  
  
  #CT <- table(S1 = speaker_1_lagged, S2 = speaker_2_lagged)
  
  CT <- table(
    factor(speaker_1_lagged, levels = c(0, 1)),
    factor(speaker_2_lagged, levels = c(0, 1))
  )
  
  CT_a <- as.numeric(CT[1,1])
  CT_b <- as.numeric(CT[1,2])
  CT_c <- as.numeric(CT[2,1])
  CT_d <- as.numeric(CT[2,2])

  phi = ((CT_a*CT_d) - (CT_b*CT_c))/sqrt((CT_a+CT_c)*(CT_b+CT_d)*(CT_a+CT_b)*(CT_c+CT_d))
  
  output <- rbind(output, cbind(lag, phi))
}

write.csv(output, "test_output3.csv")
