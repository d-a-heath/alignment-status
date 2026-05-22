#correlations

library(tidyverse)
library(corrplot)
library(Hmisc)

# prep the workspace
rm(list=ls())


data <- read.csv("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/surveys/status_scores_for_corr_2.csv")

data2 <- data %>% na.omit()

data3 <- data2[,4:29]

data3$reported_diff <- abs(data3$reported_status_1 - data3$reported_status_2)
data3$perceived_diff <- abs(data3$perceived_status_1 - data3$perceived_status_2)
data3$composite_diff <- abs(data3$reported_status_1 - data3$perceived_status_1) + abs(data3$reported_status_2 - data3$perceived_status_2)

cor_data = cor(data3, method = "pearson")

print(cor_data
      )

corrplot(cor_data, method = "color")

output_file <- "survey_correlations_pearson.csv"

write.csv(cor_data, file = output_file)


#cor_test <- cor.test(data3$composite_diff, data3$saw_world_in_same_way_sr8_1, method = "pearson")


# Assuming your data is in a data frame called 'data'
correlation_matrix <- rcorr(as.matrix(data3))

# Extract the correlation coefficients
correlation_matrix$r

# Extract the p-values
correlation_matrix$P


output_file2 <- "survey_correlations_pearson_p.csv"

write.csv(correlation_matrix$P, file = output_file2)

