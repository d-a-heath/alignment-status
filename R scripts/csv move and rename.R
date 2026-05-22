#transcript extractor v2

# prep the workspace
rm(list=ls())

#set lookup location
#csv.directory <- "C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR CSV EXTRACT/OLD"
#save.directory <- "C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR CSV EXTRACT/NEW"

csv.directory <- "D:/CANDOR/01 processed media ALL"
save.directory <- "D:/CANDOR/02 Extracted CSVs"


# List all CSV files in the directory
csv.files <- list.files(path = csv.directory,
                        pattern = "transcript_cliffhanger.csv",
                        full.names = TRUE,
                        recursive = TRUE,
                        include.dirs = TRUE)
                        
                        
# TEST Loop through each CSV file and read it into a data frame
#for (file in csv.files){
 #   conv.ID.hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR CSV EXTRACT/OLD/","",file)
  #  conv.ID <- gsub("/transcription/transcript_cliffhanger.csv","", conv.ID.hold)
   # new.name <- paste(conv.ID, "transcript_cliffhanger.csv", sep = "_")
    #new.file <- paste(save.directory, new.name, sep = "/")
    #file.copy(file, new.file)
#}

# Loop through each CSV file and read it into a data frame
for (file in csv.files){
  conv.ID.hold <- gsub("D:/CANDOR/01 processed media ALL/","",file)
  conv.ID <- gsub("/transcription/transcript_cliffhanger.csv","", conv.ID.hold)
  new.name <- paste(conv.ID, "transcript_cliffhanger.csv", sep = "_")
  new.file <- paste(save.directory, new.name, sep = "/")
  file.copy(file, new.file)
}
