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

# Source function script
source("functions.R")

# ----------------------------------------
# Step 1: Load Data
# ----------------------------------------

# File path to raw data
dir_path <- "../data/raw"

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

# Rename columns
colnames(season_data) <- c("match_id", 
                           "series_id",
                           "end_time",
                           "map_duration",
                           "mode",
                           "map",
                           "team",
                           "player",
                           "result",
                           "score",
                           "kills",
                           "deaths",
                           "+/-",
                           "k/d",
                           "kills_per_10min",
                           "deaths_per_10min",
                           "assists",
                           "headshots",
                           "suicides",
                           "team_kills",
                           "team_deaths",
                           "kills_untraded",
                           "shots_hit",
                           "shots",
                           "accuracy_%",
                           "num_lives",
                           "time_alive_s",
                           "avg_time_per_life_s",
                           "favourite_weapon",
                           "favourite_division",
                           "favourite_basic_training",
                           "favourite_scorestreaks",
                           "hp_hill_time_s",
                           "hp_hill_captures",
                           "hp_hill_defends",
                           "snd_rounds",
                           "snd_first_bloods",
                           "snd_first_deaths",
                           "snd_rounds_survived",
                           "snd_bomb_pickups",
                           "snd_bomb_plants",
                           "snd_bomb_defuses",
                           "snd_bomb_sneak_defuses",
                           "snd_1_kill_round",
                           "snd_2_kill_round",
                           "snd_3_kill_round",
                           "snd_4_kill_round",
                           "ctf_captures",
                           "ctf_returns",
                           "ctf_pickups",
                           "ctf_defends",
                           "ctf_kill_carriers",
                           "ctf_flag_carry_time_s",
                           "2_piece",
                           "3_piece",
                           "4_piece",
                           "4_streak",
                           "5_streak",
                           "6_streak",
                           "7_streak",
                           "8+_streak",
                           "scorestreaks_earned",
                           "scorestreaks_used",
                           "scorestreaks_deployed",
                           "scorestreaks_kills",
                           "scorestreaks_assists"
                           )

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
dir_path <- "../data/processed"
file_name <- "2018_season_data.csv"

# Check if the directory exists, if not, create it
if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
}

# Write the CSV file
save_csv_if_master(season_data, folder = dir_path, file_name = file_name)