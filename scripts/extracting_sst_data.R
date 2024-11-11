
# Loading libraries -------------------------------------------------------
library(sf)
library(stringr)
library(dplyr)
library(ggplot2)
library(tidyterra)
library(readr)
source("C:/Users/lidef/Documents/scripts/rimrep-training/AIMS_workshop_Nov2024/R_notebooks/useful_functions.R")


# Getting areas of interest -----------------------------------------------
gbr <- gbr_features()

# Transforming to new CRS
gbr_trans <- gbr |> 
  st_transform(crs = "epsg:4326")

tpc_reefs_north <- gbr_trans |>
  filter(str_detect(str_to_lower(GBR_NAME),
                    "macgillivray|no name"))

tpc_reefs_central <- gbr_trans |>
  filter(str_detect(str_to_lower(GBR_NAME),
                    "davies|^kelso"))

tpc_reefs_south <- gbr_trans |>
  filter(str_detect(str_to_lower(GBR_NAME),
                    "^heron r"))

#Load reef locations
reef_locations <- read_csv("TPC_reef_latlongs.csv") |> 
  janitor::clean_names() |> 
  #Change to shapefile
  st_as_sf(coords = c("longitude", "latitude"), crs = "epsg:4326")

# Loading SST data --------------------------------------------------------
sst_url <- "https://pygeoapi.reefdata.io/collections/noaa-crw-chs-sst"
variable <- "analysed_sst"

sst_data_central <- connect_dms_dataset(sst_url, "analysed_sst",
                                        bounding_shape = tpc_reefs_central)

sst_data_south <- connect_dms_dataset(sst_url, "analysed_sst",
                                        bounding_shape = tpc_reefs_south)


# Extract SST data using locations ----------------------------------------
sst_reef_central <- extract(sst_data_central, reef_locations)

ggplot()+
  geom_spatraster(data = sst_data$analysed_sst_1)+
  geom_sf(data = tpc_reefs_north, color = "pink")+
  lims(x = c(145, 147), y = c(-15, -14))

tpc_reefs_north |> 
  ggplot()+
  geom_sf(aes(fill = GBR_NAME))


tpc_reefs |> 
  filter()