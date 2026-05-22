#transcript extractor v2

# prep the workspace
rm(list=ls()) 

#set lookup location
#csv.directory <- "C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR CSV EXTRACT/OLD"
#save.directory <- "C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR CSV EXTRACT/NEW"

audio.directory <- "D:/CANDOR/01 processed media ALL"
save.directory <- "D:/CANDOR/04 Extracted Audio"


# List all CSV files in the directory
audio.files <- list.files(path = audio.directory,
                        pattern = ".mp3",
                        full.names = TRUE,
                        recursive = TRUE,
                        include.dirs = )
                        
                        
# TEST Loop through each CSV file and read it into a data frame
#for (file in csv.files){
 #   conv.ID.hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Heath/CANDOR CSV EXTRACT/OLD/","",file)
  #  conv.ID <- gsub("/transcription/transcript_cliffhanger.csv","", conv.ID.hold)
   # new.name <- paste(conv.ID, "transcript_cliffhanger.csv", sep = "_")
    #new.file <- paste(save.directory, new.name, sep = "/")
    #file.copy(file, new.file)
#}

# Loop through each CSV file and read it into a data frame
for (file in audio.files){
  conv.ID.hold <- gsub("D:/CANDOR/01 processed media ALL/","",file)
  conv.ID <- gsub("/processed.*","", conv.ID.hold)
  new.name <- paste(conv.ID, "mp3", sep = ".")
  new.file <- paste(save.directory, new.name, sep = "/")
  file.copy(file, new.file)
}
