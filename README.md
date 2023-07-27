## About

This is an vignette for users of PurpleAir sensors to obtain real-time air pollution and meteorological data and to explore various ways of basic data analysis from PurpleAir data. The GitHub site here contains all the files needed for the user to get started quering and exploring PurpleAir data. This project is a part of **R**esearch **I**nnovations using **S**ensor Technology in **E**nvironmental Justice Communities (**RISE Communities**) to provide technical training in the application of low-cost sensors for indoor, outdoor, and personal air monitoring in Environmental Justice communities. The GitHub page is part of the RISE program hosted at Cincinnati Children's Hospital Medical Center August 1-3, 2023.

## Goals

-   Explain how to install and load R packages necessary for this vignette.
-   Become familiar with the [PurpleAir API dashboard](https://develop.purpleair.com/keys).
-   Create and set API Keys associated with the PurpleAir API dashboard.
-   Create or load PurpleAir Synoptic (PAS) data objects into R from the PurpleAir API dashboard.
-   Load archive PAS data files from a URL that hosts archived PurpleAir files.
-   Perform basic exploratory analysis of PAS files in R by creating interactive maps.
-   Create or load PurpleAir Time Series (PAT) data objects into R from the PurpleAir API dashboard.
-   Perform basic exploratory analysis of PAT files in R by examining time series plots.

## Prerequisites

-   A computer running either Windows, Mac, or Linux operating systems.
-   Have both R and RStudio installed in your computer. You can install R on your computer by going to <https://cran.r-project.org/> and selecting the R version that is appropriate for your operating system. After installing R, you will then need to install [RStudio Desktop](https://posit.co/download/rstudio-desktop/).
-   Be familiar with basic operations in the R programming language. If you are not familiar with R, [this vignette](https://colegasn.github.io/Rintro/) explains how to install R and RStudio on your computer as well as the basics of R programming, including setting a working directory, becoming familiar with the RStudio environment, opening and using R scripts, writing code and interpreting output, saving and loading data, sourcing a R script, and installing and loading packages. This tutorial is publicly available on [GitHub](https://github.com/colegasn/Rintro). It is highly recommended that you understand the basics of R before exploring this vignette.
-   A stable internet connection.
-   A [Google account](https://support.google.com/accounts/answer/27441?hl=en) or [GMail account](https://support.google.com/mail/answer/56256?hl=en) to log into the [PurpleAir API dashboard](https://develop.purpleair.com/keys).

It is assumed the user has a basic understanding of the R programming language but no extensive experience is required. Only essential code is provided in the vignette. Detailed descriptions are included for all the code blocks to explain each process. Additional code and examples are provided in the `purpleair.R` file for you to try as exercises. 

## Getting Started

Click [here](https://geomarker.io/purple_air_data_in_R/) to access the vignette, or click the URL link under the **About** section on the GitHub page. This should open an HTML document of the vignette.

For your convenience, we have taken all the R code specified in the HTML page and saved it into an R script named `purpleair.R`. It is highly recommended that you follow along with the HTML vignette by downloading `purpleair.R` that walks through the setup process. The code in the `purpleair.R` file should be executed by the user as they work through the vignette to get the most out of this tutorial.

First create a new R project inside RStudio (see [tutorial](https://colegasn.github.io/Rintro/) for details). The `purpleair.R` file and related files `new_pas.R` and `new_pat.R` can then be loaded into the R project folder by running these lines in the R console. Click on the clipboard icon on the top right of the code block below to copy these lines exactly as they appear below.

```{r}
# Download 'purpleair.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/purpleair.R", destfile = "purpleair.R")

# Download 'new_pas.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/new_pas.R", destfile = "new_pas.R")

# Download 'new_pat.R' file from GitHub
download.file("https://raw.githubusercontent.com/geomarker-io/purple_air_data_in_R/main/new_pat.R", destfile = "new_pat.R")
```

With the R project open in RStudio, paste these lines of code in the command prompt and execute them. Once the files have been downloaded to the R project folder, you can then begin the tutorial by clicking on the `purpleair.R` file in the **Files** tab of the Output Pane. All other files that are needed will be indicated in the vignette when prompted. 

## Additional Links

Learn more about PurpleAir and the PurpleAir Dashboard through the following links:

-   [PurpleAir main home page](https://www2.purpleair.com/).

-   [PurpleAir Dashboard announcement](https://www2.purpleair.com/blogs/blog-home/purpleair-s-new-api-dashboard-data-download-tool-release).

-   [PurpleAir Dashboard Getting Started guide](https://community.purpleair.com/t/new-api-dashboard/3981).

-   [Creating API Keys guide](https://community.purpleair.com/t/creating-api-keys/3951).

-   [PurpleAir Data Structure guide](https://api.purpleair.com/#api-sensors-get-sensor-data).
  
-   [AirSensor2 package](https://github.com/MazamaScience/AirSensor2).
