# ----------------------------------------
# Data Curation
# ----------------------------------------
# This script processes raw data:
# 1. Creates player stats table
# 2. Creates player stats csv file
# 3. Creates player stats per mode table
# 4. Creates player stats per mode csv file
# ----------------------------------------

# Load necessary libraries
library(dplyr)

# ----------------------------------------
# Step 1: Player stats
# ----------------------------------------

# Custom function to calculate the mode
get_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))] # Get the most frequent value
}

# Group data
season_data_player <- season_data %>% 
  group_by(player) %>% 
  summarise(
    series_played = n_distinct(series_id),  # Count unique matches
    win_rate = mean(result == "W"),           # Calculate win rate (percentage of "win" results)
    kd = sum(kills) / sum(deaths),           # Kill/Death ratio
    favourite_weapon = get_mode(favourite_weapon), # Get the mode (most frequent weapon)
    .groups = "drop"
  ) %>% 
  filter(
    series_played > 5  # Keep only players with more than 5 matches
  ) %>% 
  arrange(desc(win_rate)) %>% 
  mutate(
    role = case_when(
      favourite_weapon == "PPSh-41" ~ "SMG",       # If weapon is PPSH, mark as SMG
      favourite_weapon == "STG-44" ~ "AR",          # If weapon is AK-47, mark as Assault Rifle
      favourite_weapon == "BAR" ~ "AR",
      favourite_weapon == "FG 42" ~ "AR", # If weapon is M4A1, mark as Assault Rifle
      TRUE ~ "Z"                              # Else, mark as Z
    )
  ) %>% 
  select(-favourite_weapon) # Remove the favourite_weapon column after calculating role

# Reorder columns
season_data_player <- season_data_player %>%
  select(player, role, everything())

# Convert win_rate to percentage and round to 1 decimal places
season_data_player <- season_data_player %>%
  mutate(
    win_rate = round(win_rate * 100, 1)  # Convert to percentage
  )


# ----------------------------------------
# Step 2: Create curated data file
# ----------------------------------------

# Define the directory path
dir_path <- "data/curated"

# Check if the directory exists, if not, create it
if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
}

# Write the CSV file
write.csv(season_data_player, file.path(dir_path, "2018_season_data_player.csv"))

# Print confirmation message
message("Curated data saved successfully!")

# ----------------------------------------
# Step 3: Player stats per game mode
# ----------------------------------------

# Group data
season_data_player_modes <- season_data %>% 
  group_by(player, mode) %>% 
  summarise(
    series_played = n_distinct(series_id),  # Count unique matches
    win_rate = mean(result == "W"),           # Calculate win rate (percentage of "win" results)
    kd = sum(kills) / sum(deaths),           # Kill/Death ratio
    .groups = "drop"
  ) %>% 
  filter(
    series_played > 5  # Keep only players with more than 5 matches
  ) %>% 
  arrange(desc(win_rate))

# Join roles onto data
season_data_player_modes_with_roles <- season_data_player_modes %>%
  left_join(season_data_player %>% select(player, role), by = "player")

# Reorder columns
season_data_player_per_mode <- season_data_player_modes_with_roles %>%
  select(player, role, everything())

# Convert win_rate to percentage and round to 1 decimal places
season_data_player_per_mode <- season_data_player %>%
  mutate(
    win_rate = round(win_rate * 100, 1)  # Convert to percentage
  )

# ----------------------------------------
# Step 4: Create curated data file
# ----------------------------------------

# Define the directory path
dir_path <- "data/curated"

# Check if the directory exists, if not, create it
if (!dir.exists(dir_path)) {
  dir.create(dir_path, recursive = TRUE)
}

# Write the CSV file
write.csv(season_data_player_per_mode, file.path(dir_path, "2018_season_data_player_per_mode.csv"))

# Print confirmation message
message("Curated data saved successfully!")