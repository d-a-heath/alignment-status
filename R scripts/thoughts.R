#CANDOR Status Score

library(readr)
library(writexl)
library(readxl)

# prep the workspace
rm(list=ls())


setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/surveys recoded")

folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/surveys recoded")

#create a list of surveys

surveys <- list.files(path = folder,
                      pattern = "survey.csv",
                      full.names = FALSE,
                      recursive = FALSE)

#create empty dataframe to write difference scores into

output_df <- data.frame()

#loop through each survey and calculate difference scores, write into dataframe created above
#political "sameness" allows for one-degree of difference, age "sameness" is within 5 years

for(file in surveys){
  data <- read.csv(file)
  convoID <- gsub("_survey.csv","",file)
  Part1 <- data$partner_id[1]
  Part2 <- data$partner_id[2]
  P1Thoughts <- data$our_thoughts_synced_up_sr1[1]
  P2Thoughts <- data$our_thoughts_synced_up_sr1[2]
  output_df <- rbind(output_df, cbind(convoID,
                                      Part1,
                                      P1Thoughts,
                                      Part2,
                                      P2Thoughts))
  
}

# Load required packages
library(ggplot2)
library(dplyr)

# Sample data with duplicates
set.seed(123)
df <- data.frame(
  x = output_df$P1Thoughts,
  y = output_df$P2Thoughts
)

# Count occurrences of each (x, y) pair
df_count <- df %>%
  count(x, y)  # creates a new column "n" with the count

# Plot
ggplot(df_count, aes(x = x, y = y, size = n)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  scale_size_continuous(name = "Count") +
  theme_minimal() +
  labs(title = "Scatterplot with Dot Size Representing Frequency",
       x = "X-axis",
       y = "Y-axis")
