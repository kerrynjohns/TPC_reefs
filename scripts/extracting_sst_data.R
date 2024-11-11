library(sf)
library(stringr)
library(dplyr)
source("AIMS_workshop_Nov2024/R_notebooks/useful_functions.R")

gbr <- gbr_features()
tpc_reefs <- gbr |>
  st_drop_geometry() |>
  filter(str_detect(str_to_lower(GBR_NAME),
                    "davies|macgillivray|^kelso|^heron r|no name"))


