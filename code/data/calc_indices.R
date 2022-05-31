##___________________________________________________
##
## Script name: calc_indices.R
##
## Purpose of script:
## calculate several Indices based on Digital Terrain Model
##
## Author: Jens Wiesehahn
## Copyright (c) Jens Wiesehahn, 2022
## Email: wiesehahn.jens@gmail.com
##
## Date Created: 2022-04-14
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

#load terrain
dtm_path <- here("data/external/dtm_025.tif")
dtm <- rast(dtm_path)

dsm_path <- here("data/external/dsm_1.tif")
dsm <- rast(dtm_path)

# calc center
library(sf)
bbox<-st_as_sfc(st_bbox(dtm), crs = st_crs(dtm)) 
center<-st_centroid(bbox) %>% st_transform(crs= 4326)
longitude <- round(center[[1]][1], 1)
latitude <- round(center[[1]][2], 1)



# Terra indices

dtm_prod <- terra::terrain(dtm, v = c("TPI", "TRI", "roughness", "flowdir"))
writeRaster(dtm_prod$TPI, here("data/processed", "terra_tpi.tif"))
writeRaster(dtm_prod$TRI, here("data/processed", "terra_tri.tif"))
writeRaster(dtm_prod$roughness, here("data/processed", "terra_roughness.tif"))
writeRaster(dtm_prod$flowdir, here("data/processed", "terra_flowdir.tif"))



# WBT Indices

wbt_init()#

# Geomorphometric Analysis 

wbt_dev_from_mean_elev(dem = dtm_path, output = here("data/processed", "wbt_dev_from_mean_elev.tif"))

wbt_diff_from_mean_elev(dem = dtm_path, output = here("data/processed", "wbt_diff_from_mean_elev.tif"))

wbt_directional_relief(dem = dtm_path, output = here("data/processed", "wbt_directional_relief.tif"), azimuth = 270)

wbt_edge_density(dem = dtm_path, output = here("data/processed", "wbt_edge_density.tif"), filter=5, norm_diff=5)

wbt_elev_above_pit(dem = dtm_path, output = here("data/processed", "wbt_elev_above_pit.tif"))

wbt_elev_percentile(dem = dtm_path, output = here("data/processed", "wbt_elev_percentile_11x11.tif"), filterx = 11, filtery = 11)
wbt_elev_percentile(dem = dtm_path, output = here("data/processed", "wbt_elev_percentile_5x5.tif"), filterx = 5, filtery = 5)

wbt_feature_preserving_smoothing(dem = dtm_path, output = here("data/processed", "wbt_feature_preserving_smoothing_f11-nd15-ni3-mf05.tif"), filter = 11, norm_diff = 15, num_iter = 3, max_diff = 0.5)
wbt_feature_preserving_smoothing(dem = dtm_path, output = here("data/processed", "wbt_feature_preserving_smoothing_f5-nd15-ni3-mf05.tif"), filter = 5, norm_diff = 15, num_iter = 3, max_diff = 0.5)
wbt_feature_preserving_smoothing(dem = dtm_path, output = here("data/processed", "wbt_feature_preserving_smoothing_f11-nd5-ni3-mf05.tif"), filter = 11, norm_diff = 5, num_iter = 3, max_diff = 0.5)
wbt_feature_preserving_smoothing(dem = dtm_path, output = here("data/processed", "wbt_feature_preserving_smoothing_f11-nd15-ni5-mf05.tif"), filter = 11, norm_diff = 15, num_iter = 5, max_diff = 0.5)
wbt_feature_preserving_smoothing(dem = dtm_path, output = here("data/processed", "wbt_feature_preserving_smoothing_f11-nd15-ni3-mf02.tif"), filter = 11, norm_diff = 15, num_iter = 3, max_diff = 0.2)
wbt_feature_preserving_smoothing(dem = dtm_path, output = here("data/processed", "wbt_feature_preserving_smoothing_f5-nd20-ni4-mf03.tif"), filter = 5, norm_diff = 20, num_iter = 4, max_diff = 0.3)

wbt_find_ridges(dem = dtm_path, output = here("data/processed", "wbt_find_ridges.tif"))

wbt_gaussian_curvature(dem = dtm_path, output = here("data/processed", "wbt_gaussian_curvature_log.tif"), log = T)

wbt_max_downslope_elev_change(dem = dtm_path, output = here("data/processed", "wbt_max_downslope_elev_change.tif"))
wbt_min_downslope_elev_change(dem = dtm_path, output = here("data/processed", "wbt_min_downslope_elev_change.tif"))

wbt_max_upslope_elev_change(dem = dtm_path, output = here("data/processed", "wbt_max_upslope_elev_change.tif"))

wbt_maximal_curvature(dem = dtm_path, output = here("data/processed", "wbt_maximal_curvature.tif"))
wbt_mean_curvature(dem = dtm_path, output = here("data/processed", "wbt_mean_curvature.tif"))
wbt_minimal_curvature(dem = dtm_path, output = here("data/processed", "wbt_minimal_curvature.tif"))

wbt_multidirectional_hillshade(dem = dtm_path, output = here("data/processed", "wbt_multidirectional_hillshade_full-mode-35.tif"), altitude = 35, full_mode = TRUE)

wbt_num_downslope_neighbours(dem = dtm_path, output = here("data/processed", "wbt_num_downslope_neighbours.tif"))
wbt_num_upslope_neighbours(dem = dtm_path, output = here("data/processed", "wbt_num_upslope_neighbours.tif"))

wbt_percent_elev_range(dem = dtm_path, output = here("data/processed", "wbt_percent_elev_range.tif"))

wbt_plan_curvature(dem = dtm_path, output = here("data/processed", "wbt_plan_curvature.tif"))

wbt_profile_curvature(dem = dtm_path, output = here("data/processed", "wbt_profile_curvature.tif"))

wbt_relative_topographic_position(dem = dtm_path, output = here("data/processed", "wbt_relative_topographic_position.tif"))
wbt_relative_topographic_position(dem = dtm_path, output = here("data/processed", "wbt_relative_topographic_position_15x15.tif"), filterx = 15, filtery = 15)

wbt_ruggedness_index(dem = dtm_path, output = here("data/processed", "wbt_ruggedness_index.tif"))

wbt_slope(dem = dtm_path, output = here("data/processed", "wbt_slope.tif"))

wbt_surface_area_ratio(dem = dtm_path, output = here("data/processed", "wbt_surface_area_ratio.tif"))

wbt_tangential_curvature(dem = dtm_path, output = here("data/processed", "wbt_tangential_curvature.tif"))

wbt_total_curvature(dem = dtm_path, output = here("data/processed", "wbt_total_curvature.tif"))

wbt_wetness_index(dem = dtm_path, output = here("data/processed", "wbt_wetness_index.tif"))


wbt_time_in_daylight(dem = dsm_path, output = here("data/processed", "wbt_time_in_daylight.tif"), lat = latitude, long = longitude, start_time = "sunrise", end_time = "sunset", max_dist=100)


# Hydrological Analysis

depression_path <- here("data/processed", "wbt_breach_depressions_least_cost.tif")
wbt_breach_depressions_least_cost(here("data/external/dtm_1.tif"), depression_path, 5)

wbt_average_flowpath_slope(dem = depression_path, output = here("data/processed", "wbt_average_flowpath_slope.tif"))
wbt_average_upslope_flowpath_length(dem = depression_path, output = here("data/processed", "wbt_average_upslope_flowpath_length.tif"))

wbt_d8_flow_accumulation(input = depression_path, output = here("data/processed", "wbt_d8_flow_accumulation.tif"))

wbt_d_inf_flow_accumulation(input = depression_path, output = here("data/processed", "wbt_d_inf_flow_accumulation.tif"))
wbt_d_inf_pointer(dem = depression_path, output = here("data/processed", "wbt_d_inf_pointer.tif"))

wbt_fd8_flow_accumulation(dem = depression_path, output = here("data/processed", "wbt_fd8_flow_accumulation.tif"))

wbt_md_inf_flow_accumulation(dem = depression_path, output = here("data/processed", "wbt_md_inf_flow_accumulation.tif"))
