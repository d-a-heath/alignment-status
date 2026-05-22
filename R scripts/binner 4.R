#chunk each conversation into four bins
#each bin will be saved in separate file
#easily modifiable for a different number of bins

#clear workspace

rm(list=ls())

#set dirs

setwd("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR")

file_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/cliffhanger transcripts recoded"
#file_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/recode"
  
save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/cliffhanger transcripts recoded 4 bins"
#save_dir <- "C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/recode/save"

#get files

transcripts <- list.files(path = file_dir,
                          pattern = "transcript_cliffhanger.csv",
                          full.names = TRUE,
                          recursive = FALSE)

#create bins
for(file in transcripts){
  data <- read.csv(file)
  name_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/recoded/cliffhanger transcripts recoded/","",file)
  #name_hold <- gsub("C:/Users/daheath/OneDrive - The University of Memphis/Alignment Status/CANDOR/test set/test transcripts/recode/","",file)
  name <- gsub("_transcript_cliffhanger.csv","",name_hold)
  name_loc <- paste(save_dir, name, sep = "/")
  data_rows <- nrow(data)
  bins <- cut(1:data_rows,4)
  bins_levels <- levels(bins)
  for(i in 1:length(bins_levels)){
    assign(paste0("bin_", i),
           data[bins == levels(bins)[i],])
  }
  write.csv(bin_1, paste(name_loc,"bin_1","transcript_cliffhanger.csv",sep = "_"), row.names = FALSE)
  write.csv(bin_2, paste(name_loc,"bin_2","transcript_cliffhanger.csv",sep = "_"), row.names = FALSE)
  write.csv(bin_3, paste(name_loc,"bin_3","transcript_cliffhanger.csv",sep = "_"), row.names = FALSE)
  write.csv(bin_4, paste(name_loc,"bin_4","transcript_cliffhanger.csv",sep = "_"), row.names = FALSE)
  }