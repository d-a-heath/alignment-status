

library(ggcorrplot)
library(ggtext)
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


data3$age_diff <- abs(data3$age_1 - data3$age_2)
data3$avg_enjoyment <- abs((data3$how_enjoyable_1 + data3$how_enjoyable_2)/2)
data3$avg_in_common <- abs((data3$in_common_1 + data3$in_common_2)/2)
data3$avg_topic_diversity <- abs((data3$topic_diversity_1 + data3$topic_diversity_2)/2)
data3$avg_thoughts_synced <- abs((data3$our_thoughts_synced_up_1 + data3$our_thoughts_synced_up_2)/2)
data3$avg_joint_perspective <- abs((data3$developed_joint_perspective_sr2_1 + data3$developed_joint_perspective_sr2_2)/2)
data3$avg_shared_thoughts_feelings <- abs((data3$shared_thoughts_feels_sr3_1 + data3$shared_thoughts_feels_sr3_2)/2)
data3$avg_dicussed_real <- abs((data3$discussed_real_things_sr4_1 + data3$discussed_real_things_sr4_2)/2)
data3$avg_thoughts_became_more_alike <- abs((data3$thoughts_became_more_alike_sr5_1 + data3$thoughts_became_more_alike_sr5_2)/2)
data3$avg_same_worldview <- abs((data3$saw_world_in_same_way_sr8_1 + data3$saw_world_in_same_way_sr8_2)/2)

# Compute correlation matrix
corr <- cor(data3[,27:39], method = "pearson")

# Compute matrix of p-values
p_mat <- cor_pmat(data3[,27:39])


# Visualize the correlation matrix with p-values
ggcorrplot(corr, p.mat = p_mat,
           hc.order = TRUE,
           ggtheme = "theme_black",
           outline.color = "grey",
           type = "upper",
           lab = FALSE,
           #lab_size = 4,
           show.diag = TRUE,
           colors = c("darkblue", "white", "brown2"),
           #title = "CANDOR survey and status metrics correlation matrix",
           sig.level = .05,
           insig = "blank",
           digits = 3,
           show.legend = TRUE,
           legend.title = "Pearson's r",)