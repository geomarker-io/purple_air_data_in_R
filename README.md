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
-   Be familiar with basic operations in the R programming language.
-   A stable internet connection.
-   A [Google account](https://support.google.com/accounts/answer/27441?hl=en) or [GMail account](https://support.google.com/mail/answer/56256?hl=en) to log into the [PurpleAir API dashboard](https://develop.purpleair.com/keys).

It is assumed the user has a basic understanding of the R programming language but no extensive experience is required. Only essential code is provided in the vignette. Detailed descriptions are included for all the code blocks to explain each process. Additional code and examples are provided in the `purpleair.R` file for you to try as exercises.

## Getting Started

Click [here](https://geomarker.io/purple_air_data_in_R/) to access the vignette, or click the URL link under the **About** section on the GitHub page. This should open an HTML document of the vignette.

It is highly recommended that you follow along with the HTML vignette by setting up and running the R code provided on your computer to get the most out of this tutorial. For your convenience, we have taken the R code listed in the HTML document and saved it in an R script `purpleair.R`. You can file this file listed at the top of the GitHub page.

Download the following files from our GitHub page:
-   `purpleair.R`
-   `new_pas.R`
-   `new_pat.R`

To download a file, click on the file name at the top of this page. This will then open the file within GitHub. In the top-right corner, click on the icon that says **Download raw file**. Make sure that you download the raw `.R` files and not the HTML versions. Use the left-side panel to then open the next file to download. Repeat this process until all the files are downloaded.


Save all the files into one (preferrably new) folder. Remember the location of this folder, since you will need to reference its file path later in the tutorial. After you install both R and RStudio, clicking on any of these `.R` files should open RStudio and set your current working directory to the folder where these files are located. Make sure that the current working directory points to the folder containing these `.R` files. You can use the R package `here` to set up the correct working directory so that files are loaded and saved in the correct location on your computer. See the vignette for additional details.

## Additional Links

Learn more about PurpleAir and the PurpleAir Dashboard through the following links:

-   [PurpleAir main home page](https://www2.purpleair.com/).

-   [PurpleAir Dashboard announcement](https://www2.purpleair.com/blogs/blog-home/purpleair-s-new-api-dashboard-data-download-tool-release).

-   [PurpleAir Dashboard Getting Started guide](https://community.purpleair.com/t/new-api-dashboard/3981).

-   [Creating API Keys guide](https://community.purpleair.com/t/creating-api-keys/3951).

-   [PurpleAir Data Structure guide](https://api.purpleair.com/#api-sensors-get-sensor-data).
