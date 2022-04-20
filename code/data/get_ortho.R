##___________________________________________________
##
## Script name: get_ortho.R
##
## Purpose of script:
## download orthophoto for area of dtm
##
## Author: Jens Wiesehahn
## Copyright (c) Jens Wiesehahn, 2022
## Email: wiesehahn.jens@gmail.com
##
## Date Created: 2022-04-20
##
## Notes:
##
##
##___________________________________________________

## use renv for reproducability

## run `renv::init()` at project start inside the project directory to initialze 
## run `renv::snapshot()` to save the project-local library's state (in renv.lock)
## run `renv::history()` to view the git history of the lockfile
## run `renv::revert(commit = "abc123")` to revert the lockfile
## run `renv::restore()` to restore the project-local library's state (download and re-install packages) 

## In short: use renv::init() to initialize your project library, and use
## renv::snapshot() / renv::restore() to save and load the state of your library.

##___________________________________________________

## install and load required packages

## to install packages use: (better than install.packages())
# renv::install("packagename") 

renv::restore()
library(here)
library(dplyr)
library(terra)
library(sf)

##___________________________________________________

## load functions into memory
# source("code/functions/some_script.R")

##___________________________________________________


gjn <- sf::st_read("https://single-datasets.s3.eu-de.cloud-object-storage.appdomain.cloud/pro-download-indices/dop/lgln-opengeodata-dop20.geojson")

# gjn$year <- format(as.Date(as.character(gjn$Aktualitaet), format = "%Y-%m-%d"), format= "%Y")
# mapview::mapview(gjn, zcol="year")

fileadress <- gjn$rgb[11928]
cog.url <- paste0("/vsicurl/", fileadress)
ras <- terra::rast(cog.url)

# crop to dtm
v <- rast(here("data/external", "dtm_1.tif"))
x <- crop(ras, v)

terra::writeRaster(x, here("data/external", "ortho.tif"))
