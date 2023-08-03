##### PURPLEAIR TUTORIAL R SCRIPT #####
## Author: Stephen Colegate
## Last Updated: 7/26/2023

# Links to the GitHub site and the tutorial itself:
# GitHub page: https://github.com/geomarker-io/purple_air_data_in_R/tree/main#readme
# PurpleAir Data Exploration Tutorial: https://geomarker.io/purple_air_data_in_R/#sec-live

# Loading R Scripts -------------------------------------------------------

# Download 'purpleair.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/purpleair.R", destfile = "purpleair.R")

# Download 'new_pas.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/new_pas.R", destfile = "new_pas.R")

# Download 'new_pat.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/new_pat.R", destfile = "new_pat.R")


# Packages ----------------------------------------------------------------

##### Install Packages #####
# Install the following packages - only need to run once
install.packages(c('dplyr', 'ggplot2', 'devtools'))

# Install the 'MazamaCoreUtils' package - only need to run once
install.packages('MazamaCoreUtils')

# Install the 'AirSensor2' package - only need to run once
devtools::install_github('mazamascience/AirSensor2')

#####

# Load required R packages
library(dplyr)
library(ggplot2)
library(AirSensor2)


# Fetch and Set API Key ---------------------------------------------------

# Copy and paste this line into a new R script with your API Key
PurpleAir_API = "YOUR_API_KEY"

# Read 'API_KEY.R' file containing the API Key
source("API_KEY.R")


# Read PAS from PurpleAir Dashboard ---------------------------------------

# Load in the new_pas() function from file
source("new_pas.R")

# Create new PAS of Hamilton County, Ohio sensors from past 7 days
pas <- new_pas(pas_filename = "PAS_Hamilton.rds", API_filename = "API_KEY.R",
               countryCodes = "US", stateCodes = "OH", counties = "Hamilton",
               lookbackDays = 7, location_type = NULL)

# Example PAS from AirSensor package (only run if you could not download PAS)
pas <- AirSensor2::example_pas


# Explore PAS File --------------------------------------------------------

# Take a look at only PM2.5 data
pm25 <- pas %>%
  select(locationID, starts_with("pm2.5_"))
print(pm25, n=10)

# Plot interactive leaflet map of 1-hour average PM2.5
pas %>%
  pas_leaflet(parameter = "pm2.5_60minute")

# Filter sensors with moderate air quality
pas %>%
  pas_filter(pm2.5_24hour > 12.0) %>%
  pas_leaflet(parameter = "pm2.5_24hour")

# Plot interactive map of temperature, removing missing data
pas %>%
  pas_filter(!is.na(temperature)) %>%
  pas_leaflet(parameter = "temperature")


# Loading PAT Data --------------------------------------------------------

# Load in the new_pat() function from file
source("new_pat.R")

# Create new PAT of one sensor from July 1 through July 8
pat <- new_pat(pat_filename = "July_CFD12.rds", pas_filename = "PAS_Hamilton.rds",
               API_filename = "API_KEY.R", sensor_index = 176557,
               start_date = "2023-07-01", end_date = "2023-07-08")

# Example PAT from AirSensor package (only run if you could not download PAT)
pat <- AirSensor2::example_pat


# Explore PAT File --------------------------------------------------------

# Pull time series data from PAT
pat_data <- pat$data
names(pat_data)

# Plot time series of temperature
pat_data %>%
  ggplot()+
  geom_line(aes(x=datetime, y=temperature), color="orange", lwd=1.0)+
  theme_bw()+
  xlab("Time")+ylab("Temperature")+
  ggtitle("PurpleAir Time Series Plot of Temperature")

# Plot time series of PM2.5 from Channel A & B (note column name!)
pat_data %>%
  ggplot()+
  geom_line(aes(x=datetime, y=pm25_A), color="red", lwd=0.6, alpha=0.8)+
  geom_line(aes(x=datetime, y=pm25_B), color="blue", lwd=0.6, alpha=0.5)+
  theme_bw()+
  xlab("Time")+ylab("pm2.5")+
  ggtitle("PurpleAir PM2.5 Time Series Plot")

