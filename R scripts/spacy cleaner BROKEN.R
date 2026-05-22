

setwd(spacy_dir)

spacy_transcripts <- list.files(path = spacy_dir,
                                pattern = "output.csv",
                                full.names = FALSE,
                                include.dirs = TRUE)



for(file in spacy_transcripts){
  transcript_data <- read.csv(file)
  cleaned.df <- data.frame()
  filter_var <- "PUNCT"
  cleaned.df <- filter(transcript_data, POS != filter_var)
  new_name <- gsub("output.csv", "output_cleaned.csv",file)
  write_csv(cleaned.df, new_name)
}