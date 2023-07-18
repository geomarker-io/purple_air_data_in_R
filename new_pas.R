new_pas <- function(pas_filename, folder_location,
                    API_filename, folder_name="pas_data",
                    countryCodes="US", stateCodes="OH",
                    counties="Hamilton", lookbackDays=7,
                    location_type=NULL){
  
  # Load necessary packages
  library(here)
  library(AirSensor)
  library(MazamaSpatialUtils)
  
  # Check if the PAS object exists already
  if(file.exists(here(folder_location, pas_filename))){
    
    # Read in PAS if it exists
    message(paste("PAS with filename '", pas_filename, "' found! Loading PAS...", sep=""))
    pas <- readRDS(file = here(folder_location, pas_filename))
    message(paste("PAS with filename '", pas_filename, "' successfully loaded!", sep=""))
    return(pas)
  } else{
    
    # Prompt user if they would like to create new PAS
    message(paste("PAS with filename '", pas_filename, "' not found.", sep=""))
    pas.option <- readline(prompt="Create new PAS with API Key? [Y/N]")
    
    # Check the user's input
    if(pas.option!="Y" & pas.option!="N"){
      message("Your input was invalid. Please try again.")
    }
    
    # If 'Y' use points to create and save a new PAS from PurpleAir
    if(pas.option=="Y"){
        
      # Set the API Key from the API_KEY.R file
      message("Setting PurpleAir API Key.")
      source(API_filename)
      setAPIKey(provider="PurpleAir-read", key=PurpleAir_API)
      
      # Check if the API Key was successfully set
      if(!is.null(getAPIKey()$`PurpleAir-read`)){
        message("PurpleAir API Key was set successfully.")
      } else{
        message("Error: API Key was not set. Make sure API_KEY.R is properly set up.")
      }
    
    # Set the file directory to store the PAS data
    mypath <- here(folder_location, folder_name)
    setSpatialDataDir(mypath)
    
    # Check if these files have been downloaded and get them if not there
    if(!file.exists(here(mypath, "NaturalEarthAdm1.rda"))|
       !file.exists(here(mypath, "NaturalEarthAdm1_01.rda"))|
       !file.exists(here(mypath, "NaturalEarthAdm1_02.rda"))|
       !file.exists(here(mypath, "NaturalEarthAdm1_05.rda"))){
      message("Missing 'NaturalEarthAdm1' files. Downloading...")
      installSpatialData("NaturalEarthAdm1")
      message("'NaturalEarthAdm1.rda' files downloaded successfully.")
    } else{message("'NaturalEarthAdm1.rda' files found and read successfully.")}
    
    # Check if these files have been downloaded and get them if not there
    if(!file.exists(here(mypath, "USCensusCounties.rda"))|
       !file.exists(here(mypath, "USCensusCounties_01.rda"))|
       !file.exists(here(mypath, "USCensusCounties_02.rda"))|
       !file.exists(here(mypath, "USCensusCounties_05.rda"))){
      message("Missing 'USCensusCounties.rda' files. Downloading...")
      installSpatialData("USCensusCounties")
      message("'USCensusCounties.rda' files downloaded successfully.")
    } else{message("'USCensusCounties.rda' files found and read successfully.")}
    
    # Initialize spatial data processing 
    initializeMazamaSpatialUtils(spatialDataDir = here(mypath))
    message("Initialized spatial data processing")
    
    message("Getting new PAS data from PurpleAir dashboard.")
    pas <- pas_createNew(countryCodes=countryCodes,
                         stateCodes=stateCodes,
                         counties=counties,
                         lookbackDays=lookbackDays,
                         location_type=location_type)
    message("New PAS data downloaded successfully from PurpleAir. Saving file...")
    saveRDS(pas, file = here(folder_location, pas_filename))
    message(paste("PAS file", pas_filename, "successfully saved!"))
    return(pas)
  } else {message("No new PAS file was created.")} 
  }
}