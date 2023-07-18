new_pat <- function(pat_filename, folder_location,
                    pas_filename, API_filename,
                    sensor_index=NULL, start_date=NULL,
                    end_date=NULL, time_zone="UTC",
                    average=0){
  
  # Load necessary packages
  library(here)
  library(AirSensor)
  library(MazamaSpatialUtils)
  
  # Check if the PAT object exists already
  if(file.exists(here(folder_location, pat_filename))){
    
    # Read in PAT if it exists
    message(paste("PAT with filename '", pat_filename, "' found! Loading PAT...", sep=""))
    pat <- readRDS(file = here(folder_location, pat_filename))
    message(paste("PAT with filename '", pat_filename, "' successfully loaded!", sep=""))
    return(pat)
    
  } else{
    # Prompt user if they would like to create new PAT
    message(paste("PAT with filename '", pat_filename, "' not found.", sep=""))
    pas.option <- readline(prompt="Create new PAT from PAS with API Key? [Y/N]")
    
    # Check the user's input
    if(pas.option!="Y" & pas.option!="N"){
      message("Your input was invalid. Please try again.")
    } 
    
    # If 'Y' use points to create and save a new PAT from PurpleAir
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
      
      # Check if a required PAS object does not exist
      if(!file.exists(here(folder_location, pas_filename))){
        
        # Inform the user that no PAS was found in their filepath
        message(paste("Error: PAS with filename '", pas_filename, "' was not found.", sep=""))
        message("Make sure a proper PAS exists with the filepath specified correctly.")
        
      } else{
        
        # Read in the PAS file
        message(paste("PAS with filename '", pas_filename, "' found! Loading PAS...", sep=""))
        pas <- readRDS(file = here(folder_location, pas_filename))
        message(paste("PAS with filename '", pas_filename, "' successfully loaded!", sep=""))
        
        
        # Get new PAT data using PAS and API KEY from PurpleAir dashboard
        message("Getting new PAT data from PurpleAir dashboard.")
        pat <- pat_createNew(pas=pas,
                             sensor_index=sensor_index,
                             startdate=start_date,
                             enddate=end_date,
                             timezone=time_zone,
                             average=average)
        message("New PAT data downloaded successfully from PurpleAir. Saving file...")
        saveRDS(pat, file = here(folder_location, pat_filename))
        message(paste("PAT file", pat_filename, "successfully saved!"))
        return(pat)
      }
    } else {
      message("No new PAT file was created.")
    }
  }
}