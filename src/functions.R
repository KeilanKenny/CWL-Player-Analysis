# functions.R

#---------------------------------------------------------------
# Function to save a CSV only if the current Git branch is 'master'
#---------------------------------------------------------------
save_csv_if_master <- function(data, folder, file_name) {
  # Get the current Git branch
  branch <- system("git rev-parse --abbrev-ref HEAD", intern = TRUE)
  
  # Construct the full output path
  output_path <- file.path(folder, file_name)
  
  # Check if the branch is 'master' and create CSV
  if (branch == "master") {
    write.csv(data, output_path, row.names = FALSE)
    message(paste("✅ CSV created at:", output_path))
  } else {
    message("⚠️ Skipping CSV creation (not on 'master' branch)")
  }
}

#---------------------------------------------------------------
# Space for IMDb Scraping Functions
# You can add your IMDb scraping functions below.
#---------------------------------------------------------------

# Example of an IMDb scraping function (commented out for now)
# scrape_imdb_movie <- function(movie_title) {
#   # Function content goes here (as per previous example)
#   return(list(title = "Inception", year = "2010", rating = "8.8", genre = "Sci-Fi"))
# }