# ----------------------------------------
# Data Processing
# ----------------------------------------
# This script processes raw data:
# 1. Loads data from csvs
# 2. Cleans the data (removes NAs, duplicates, etc.)
# 3. Transforms the data (format changes, feature engineering, etc.)
# 4. Save transformed data
# ----------------------------------------

# Load necessary libraries
# library()

# ----------------------------------------
# Step 1: Load Data
# ----------------------------------------

dir_path <- "data/raw"

# Example of loading data (adjust to your data source)
dallas_data <- read.csv(file.path(dir_path, "data-2017-12-10-dallas.csv"))
neworleans_data <- read.csv(file.path(dir_path, "data-2018-01-14-neworleans.csv"))
atlanta_data <- read.csv(file.path(dir_path, "data-2018-03-11-atlanta.csv"))
birmingham_data <- read.csv(file.path(dir_path, "data-2018-04-01-birmingham.csv"))
proleague1_data <- read.csv(file.path(dir_path, "data-2018-04-08-proleague1.csv"))
relegation_data <- read.csv(file.path(dir_path, "data-2018-04-19-relegation.csv"))
seattle_data <- read.csv(file.path(dir_path, "data-2018-04-22-seattle.csv"))
anaheim_data <- read.csv(file.path(dir_path, "data-2018-06-17-anaheim.csv"))
proleague2_data <- read.csv(file.path(dir_path,"data-2018-07-29-proleague2.csv"))
champs_data <- read.csv(file.path(dir_path, "data-2018-08-19-champs.csv"))

# Print a message to confirm data is loaded
message("Data loaded successfully!")

# ----------------------------------------
# Step 2: Clean Data
# ----------------------------------------

# Append data together
season_data <- rbind(dallas_data, 
                     neworleans_data, 
                     atlanta_data, 
                     birmingham_data, 
                     proleague1_data,
                     relegation_data, 
                     seattle_data,
                     anaheim_data, 
                     proleague2_data,
                     champs_data 
)

# Remove rows with NA values in essential columns
#clean_data <- data %>%
#  filter(!is.na(column_name))

# Remove duplicate rows
#clean_data <- clean_data %>%
#  distinct()

# Print message after cleaning
#message("Data cleaned successfully!")

# ----------------------------------------
# Step 3: Transform Data
# ----------------------------------------

# Example: Create a new feature based on existing columns
#clean_data <- clean_data %>%
#  mutate(new_feature = column1 + column2)

# Example: Format a date column
#clean_data$date_column <- as.Date(clean_data$date_column, format = "%Y-%m-%d")

# Print message after transformation
#message("Data transformed successfully!")

# ----------------------------------------
# Step 4: Save Processed Data
# ----------------------------------------

# Define the directory path
dir_path <- "data/processed"

# Check if the directory exists, if not, create it
if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
}

# Write the CSV file
write.csv(season_data, file.path(dir_path, "2018_season_data.csv"))

# Print confirmation message
message("Processed data saved successfully!")