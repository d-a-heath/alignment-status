# Load required libraries
library(readr)
library(writexl)

setwd("D:/CANDOR")

# Specify the directory containing the CSV files
csv_directory <- "D:/CANDOR/01 processed media ALL"

# List all CSV files in the directory
csv_files <- list.files(path = csv_directory,
                        pattern = "survey.csv",
                        full.names = TRUE,
                        recursive = TRUE)

# Initialize an empty list to store data frames
data_list <- list()

# Loop through each CSV file and read it into a data frame
for (file in csv_files) {
  data <- read_csv(file)
  data_list[[file]] <- data
}

# Combine all data frames into one
combined_data <- do.call(rbind, data_list)

# Specify the output Excel file name
output_file <- "all_surveys.csv"

# Write the combined data to an Excel file
write_csv(combined_data, path = output_file)

# Print a message indicating completion
cat("All CSV files have been combined and saved to", output_file)