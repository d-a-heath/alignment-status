# Save CANDOR conversations as tsv compatible with ALIGN

# prep the workspace
rm(list=ls())

library(readr)

setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts")
#setwd(("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts"))


transcripts_folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/not recoded/cliffhanger transcripts")
#transcripts_folder <- ("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts")

transcript_list <- list.files(transcripts_folder, 
                              pattern = "transcript_cliffhanger.csv",
                              recursive = FALSE)

for (file in transcript_list){
  data <- read_csv(file)
  output_df <- data.frame(rbind(cbind("participant" = data$speaker,
                     "content" = data$utterance)))
  file_name <- gsub(".csv", ".tsv", file)
  write_tsv(output_df, file_name)
}