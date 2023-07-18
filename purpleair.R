##### PURPLEAIR TUTORIAL R SCRIPT #####
## Author: Stephen Colegate
## Last Updated: 7/17/2023

# This is the 'purpleair.R' script that is used with the vignette 'PurpleAir
# Data Exploration' for the RISE program at Cincinnati Children's Hospital
# Medical Center. All code from the vignette has been reproduced here.
# Please run each line of code carefully as you work through the tutorial
# and explore the data by trying out code of your own.

# Links to the GitHub site and the tutorial itself:
# GitHub page: https://github.com/geomarker-io/purple_air_data_in_R/tree/main#readme
# PurpleAir Data Exploration Tutorial: https://geomarker.io/purple_air_data_in_R/#sec-live

# Opening and Using R -----------------------------------------------------

# Assign values
x <- 2    # assign the letter 'x' the value 2
y <- 9    # assign the letter 'y' the value 9

# Perform simple operations
x + y     # equivalent to '2' + '9'
sqrt(y)   # sqrt = square-root


# Saving/Loading Data -----------------------------------------------------

# Install the 'here' package - only run this once
install.packages("here")

# Load the 'here' package
library(here)

# Save the file path location
mypath <- here()
mypath

# Save data frame as a file
head(mtcars, n=10)
saveRDS(mtcars, file = here(mypath, "cardata.rds"))

# Load data frame into the R session
mycars <- readRDS(file = here(mypath, "cardata.rds"))
head(mycars, n=10)


# Packages ----------------------------------------------------------------

# Only run once to install (select YES to load binary packages)
install.packages(c('dplyr', 'ggplot2', 'devtools',
                   'MazamaCoreUtils', 'MazamaSpatialUtils'))

# Install the 'AirSensor' package - only need to run once
devtools::install_github("MazamaScience/AirSensor")

# Load required R packages
library(dplyr)
library(ggplot2)
library(here)
library(MazamaCoreUtils)
library(MazamaSpatialUtils)
library(AirSensor)

# Display help documentation for 'mtcars'
help(mtcars)

# Display first n=10 rows of the example cars data 
head(mtcars, n=10)

# Reference the 'mpg' column within 'mtcars'
mileage <- mtcars$mpg
head(mileage, n=20)


# Fetch and Set API Key ---------------------------------------------------

# Replace the text API KEY below with your actual API Key from PurpleAir
PurpleAir_API = "API KEY"
# Open new R script, paste the above line in, and save as 'API_KEY.R'

# Read 'API_KEY.R' file containing the API Key
source(here(mypath, "API_KEY.R"))

# Set the API Key
setAPIKey(provider = "PurpleAir-read", key = PurpleAir_API)

# Return all API Keys currently set
getAPIKey()
showAPIKeys()


# Read Live PAS from PurpleAir Dashboard ----------------------------------

# Load in the new_pas() function from file
source(here(mypath, "new_pas.R"))

# Create new PAS of Hamilton County, Ohio sensors from past 7 days
pas <- new_pas(pas_filename = "PAS_Hamilton.rds",
               folder_location = here(),
               API_filename = "API_KEY.R",
               folder_name = "pas_data",
               countryCodes = "US",
               stateCodes = "OH",
               counties = "Hamilton",
               lookbackDays = 7,
               location_type = NULL)


# Read Archived PAS Data --------------------------------------------------

# Set location of pre-generated data files
setArchiveBaseUrl("https://airfire-data-exports.s3-us-west-2.amazonaws.com/PurpleAir/v1")

# Load a PAS object from a specific date (takes a minute to load)
pas_apr10 <- pas_load(datestamp="20200410")   # '20200410' = '4-10-2020'



# Explore PAS -------------------------------------------------------------

# Example PAS from AirSensor package (can use above PAS file you created here)
pas <- AirSensor::example_pas

# Open help documentation for example PAS
help(example_pas)

# Examine the first 10 rows
print(pas, n=10, max_footer_lines=0)

# Get list of column names
names(pas)

# Take a look at only PM2.5 data
pm25 <- pas %>%
  select(locationID, starts_with("pm2.5_"))
print(pm25, n=10)

# Plot interactive leaflet map of 1-hour average PM2.5
pas %>%
  pas_leaflet(parameter = "pm2.5_60minute")

# Apply filtering of sensors
pas %>%
  pas_filter(stateCode == "CA", pm2.5_24hour > 12.0) %>%
  pas_leaflet(parameter = "pm2.5_24hour")

# Plot interactive map of temperature, removing missing data
pas %>%
  pas_filter(stateCode == "CA", !is.na(temperature)) %>%
  pas_leaflet(parameter = "temperature")

#####

# Example using the archived PAS (not shown in tutorial)
setArchiveBaseUrl("https://airfire-data-exports.s3-us-west-2.amazonaws.com/PurpleAir/v1")
pas_apr10 <- pas_load(datestamp="20200410")   # '20200410' = '4-10-2020'

# Examine the first 10 rows
print(pas_apr10, n=10, max_footer_lines=0)

# Get list of column names
names(pas_apr10)

# Take a look at only PM2.5 data
pm25 <- pas_apr10 %>%
  select(locationID, starts_with("pm25_"))
print(pm25, n=10)

# Plot interactive leaflet map of 1-hour average PM2.5
pas_apr10 %>%
  pas_leaflet(parameter = "pm25_1hr")

# Apply filtering of sensors
pas_apr10 %>%
  pas_filter(stateCode == "OH", pm25_1day > 12.0) %>%
  pas_leaflet(parameter = "pm25_1day")

# Plot interactive map of temperature, removing missing data
pas_apr10 %>%
  pas_filter(stateCode == "FL", !is.na(temperature)) %>%
  pas_leaflet(parameter = "temperature")

# Plot interactive map of temperature for tri-state, removing missing data
pas_apr10 %>%
  pas_filter(stateCode %in% c("IN","KY","OH"), !is.na(temperature)) %>%
  pas_leaflet(parameter = "temperature")


# Loading PAT Data --------------------------------------------------------

# Load in the new_pat() function from file
source(here(mypath, "new_pat.R"))

# Create new PAT of one sensor from July 1 through July 8
mypat <- new_pat(pat_filename = "July_CFD12.rds",
                 folder_location = here(),
                 pas_filename = "PAS_Hamilton.rds",
                 API_filename = "API_KEY.R",
                 sensor_index = 176557,
                 start_date = "2023-07-01",
                 end_date = "2023-07-08",
                 time_zone = "UTC")


# Explore PAT -------------------------------------------------------------

# Example PAT from AirSensor package
pat <- AirSensor::example_pat

# Open help documentation for example PAT
help(example_pat)

# Variables that do not change with time
names(pat$meta)

# Examine time series data
print(pat$data, n=10)

# Plot raw sensor data
pat %>%
  pat_multiplot(plottype="all")

# Filter dates from the PAT object
pat_fourth <- pat %>%
  pat_filterDate(startdate=20220702, enddate=20220705)

# Plot only PM2.5 data covering only the 4th of July weekend 2022
pat_fourth %>%
  pat_multiPlot(plottype = "pm25_over")

# Compare sensor data with hourly data from federal monitor
pat_fourth %>%
  pat_externalFit()

# Identify any outliers and replace them with window median values
pat_fourth_filter <- pat_fourth %>%
  pat_outliers(replace = TRUE, showPlot = TRUE)

# Compare Channel A and Channel B of the sensors
pat_fourth_filter %>%
  pat_internalFit()

# Correlations to check that sensors are properly functioning
pat_fourth_filter %>%
  pat_scatterPlotMatrix()
