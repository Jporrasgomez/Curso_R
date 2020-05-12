# merging data files
meta <- read.csv('dataCursoR/2020-04-28_meta_data.csv')
plant <- read.csv('dataCursoR/2020-04-28_plant_data.csv')

str(plant)
str(meta)

# old school merging files
plantMerged <- merge(meta, plant, by = c('author', 'year', 'journal', 'species'), all.x = TRUE,
                     all.y = TRUE)
# faster: merging with dyplyr
plantMerged <- dplyr::left_join(plant, meta, by = c('author', 'year', 'journal', 'species'))

# ----------------------------------------------------

# BEFORE YOU UPDATE R
# save current packages and their versions onto an object
ip <- installed.packages()

# save the object as an .rsd file somewhere
saveRDS(ip, 'currentPackages.rsd')

# update R

# how to update R (runs in Rstudio with Windows)
install.packages('installr')
installr::updateR()

# reinstall R packages
ip <- readRDS('currentPackages.rsd')
install.packages(ip[, 1])

# --------------------------------------------------------------

# retriving and uploading files from google drive

# install pacakges
install.packages('googledrive', 'googlesheets4')
# load packages
library(googledrive)
library(googlesheets4)
library(lubridate)

# create object from google spreasheet
meta_data <- read_sheet
("https://docs.google.com/spreadsheets/d/1Z7HathxScqACg5vBxWm5dBTbiYMsRKGFDWu2okI2JLE/edit#gid=0")
# character vector with today's date and name of file
metaToday <- paste0(today(), '_meta_data.csv')
# save a copy of the google spreadsheet in .csv format in local directory
write.csv(meta_data, file = paste0('meta_data/', metaToday), row.names = F)
# upload daily backup on google drive
drive_upload(paste0('meta_data/', metaToday),
             path = paste0('backup_meta_analysis/meta_backup/', metaToday))

plant_data <- read_sheet("https://docs.google.com/spreadsheets/d/1v2zOeuB-b_BdiEQUMSHTz9nmm9pgRseUygD7SDmDgpo/edit#gid=0")
plantToday <- paste0(today(), '_plant_data.csv')
write.csv(plant_data, file = paste0('plant_water/', plantToday), row.names = F)
drive_upload(paste0('plant_water/', plantToday),
             path = paste0('backup_meta_analysis/plant_backup/', plantToday))

other_vars_data <- read_sheet("https://docs.google.com/spreadsheets/d/1-2QE95kF_G4uugl2BQylzqFfPVpOmTO0_m57Ke6Engw/edit#gid=0")
otherVarsToday <- paste0(today(), '_other_vars_data.csv')
write.csv(other_vars_data, file = paste0('other_vars/', otherVarsToday), row.names = F)
drive_upload(paste0('other_vars/', otherVarsToday),
             path = paste0('backup_meta_analysis/other_vars_backup/', otherVarsToday))

# now the part for plant water sources is missing 

data_water_sources <- read_sheet("https://docs.google.com/spreadsheets/d/1udiv5w7YXCZXP2Pjnpshkzxsx5dxV1slG0OX7eztVq4/edit#gid=0")
watersourcesToday <- paste0(today(), '_data_water_sources.csv')
write.csv(data_water_sources, file = paste0('data_water_sources/', watersourcesToday), row.names = F)
drive_upload(paste0('data_water_sources/', watersourcesToday),
             path = paste0('backup_meta_analysis/source_meta/', watersourcesToday))
