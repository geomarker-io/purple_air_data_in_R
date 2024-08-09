##### PURPLEAIR API DASHBOARD VIGNETTE #####
## Author: Stephen Colegate
## Last Updated: 8/9/2024

# GitHub link: https://github.com/geomarker-io/purple_air_data_in_R/tree/main#readme

# PurpleAir API Dashboard Vignette link: https://geomarker.io/purple_air_data_in_R/


# Loading R Scripts -------------------------------------------------------

# Download 'purpleair.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/purpleair.R", destfile = "purpleair.R")


# Packages ----------------------------------------------------------------

# Install the PurpleAir package - only need to run once
install.packages('PurpleAir')

# Load the PurpleAir package
library(PurpleAir)

# Install the tidyverse and sf packages - only need to run once
install.packages(c('tidyverse', 'sf', 'usethis'))

# Load required R packages
library(tidyverse)
library(sf)
library(usethis)


# Obtain and Set API Key ---------------------------------------------------

# Run this to open .Renviron file
usethis::edit_r_environ()

# Copy and paste the line below into the .Renviron file that just opened
# Replace "PASTE_API_KEY_HERE" with your personal API Key in quotes
PURPLE_AIR_API_KEY = "PASTE_API_KEY_HERE"

# Check that your API Key has been set correctly
check_api_key(Sys.getenv("PURPLE_AIR_API_KEY"))


# Access PurpleAir API ----------------------------------------------------

# Link to a list of fields: https://api.purpleair.com/#api-sensors-get-sensor-data

# Get latest data from a single sensor
sensor_data <- get_sensor_data(sensor_index = 176557,
                               fields = c("name", "last_seen",
                                          "pm2.5_cf_1", "pm2.5_atm"))
sensor_data

# Get latest data from multiple sensors
multiple_data <- get_sensors_data(x = c(176557, 184705, 177011),
                                  fields = c("name", "last_seen",
                                             "pm2.5_cf_1", "pm2.5_atm"))
multiple_data

# Get sensor information from a boundary box
boundary_data <- sf::st_bbox(c("xmin" = -84.5320, "ymin" = 39.0978,
                               "xmax" = -84.5003, "ymax" = 39.1181),
                             crs = 4326) |>
  get_sensors_data(fields = c("name", "last_seen",
                              "pm2.5_cf_1", "pm2.5_atm"))
boundary_data

# Link to OpenStreetMap to get coordinates: https://www.openstreetmap.org/

# Get historical data from a sensor from July 3-6, 2024
sensor_history <- get_sensor_history(sensor_index = 176557,
                                     fields = c("pm1.0_cf_1", "pm1.0_atm",
                                                "pm2.5_cf_1", "pm2.5_atm"),
                                     start_timestamp = as.POSIXct("2024-07-03"),
                                     end_timestamp = as.POSIXct("2024-07-06") )
sensor_history

#####

# Get a time-series plot of sensor readings
sensor_history |>
  tidyr::pivot_longer(cols = tidyr::starts_with("pm"),
                      names_to = "pollutant", values_to = "concentration") |>
  ggplot2::ggplot(ggplot2::aes(time_stamp, concentration, color = pollutant)) +
  ggplot2::geom_line()


# Saving and Loading Data -------------------------------------------------

# Save each data object for analysis later
saveRDS(sensor_data, file="sensor_data.RDS")
saveRDS(multiple_data, file="multiple_data.RDS")
saveRDS(boundary_data, file="boundary_data.RDS")
saveRDS(sensor_history, file="sensor_history.RDS")

# Load each data object after a new R session
sensor_data <- readRDS(file="sensor_data.RDS")
sensor_data

multiple_data <- readRDS(file="multiple_data.RDS")
multiple_data

boundary_data <- readRDS(file="boundary_data.RDS")
boundary_data

sensor_history <- readRDS(file="sensor_history.RDS")
sensor_history

