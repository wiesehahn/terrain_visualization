##___________________________________________________
##
## Script name: hillshade.R
##
## Purpose of script create hillshades
##
##
## Author: Jens Wiesehahn
## Copyright (c) Jens Wiesehahn, 2022
## Email: wiesehahn.jens@gmail.com
##
## Date Created: 2022-04-10
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
library(whitebox)
library(terra)

##___________________________________________________

## load functions into memory
# source("code/functions/some_script.R")

##___________________________________________________



# the whitebox package uses its functions from WhiteboxTools software, to install run:
# whitebox::install_whitebox()

wbt_init()

# multidirection hillshade WBT
wbt_multidirectional_hillshade(dem = here("data/external/dtm.tif"),
                               output = here("data/processed", "wbt_multidirectional_hillshade.tif"), 
                               compress_rasters= TRUE)



