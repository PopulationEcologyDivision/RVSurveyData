#' @title updateRVSurveySpatialData
#' @description This function generates the sf files included in RVSurveyData
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}

updateRVSurveySpatialData <- function(){
  library(ggplot2)
  library(mapdata)
  library(sf)
  #stuff below is for Kasia's new improved layer.
  # the layer read in below already has the US areas, and new fields.
  nafo_sf <- sf::st_read("c:/git/Maritimes/Mar.data/data-raw/NAFO/NAFO_BEST_KasiaUS2022.shp")
  nafo_sf$OBJECTID_1 <- nafo_sf$ORIG_FID <- nafo_sf$OBJECTID <- nafo_sf$Shape_Leng <- nafo_sf$Shape_Le_1 <- nafo_sf$Shape_Area <- NULL
  colnames(nafo_sf)[colnames(nafo_sf)=="AREA"] <- "AREA_ID"
  usethis::use_data(nafo_sf, overwrite = TRUE)
  
  strataMar_sf <- sf::st_read("inst/rawSpatial/MaritimesRegionEcosystemAssessmentStrata(2014-).shp")
  colnames(strataMar_sf)[colnames(strataMar_sf)=="StrataID"] <- "STRATA_ID"
  colnames(strataMar_sf)[colnames(strataMar_sf)=="Areakm"] <- "AREA_KM"
  strataMar_sf$TYPE <- NULL
  strataMar_sf <- st_transform(strataMar_sf, crs = 4326)
  usethis::use_data(strataMar_sf, overwrite = TRUE)
  
  
  strataMar4VSW_sf <- sf::st_read("inst/rawSpatial/4VsW_geom.shp")
  colnames(strataMar4VSW_sf)[colnames(strataMar4VSW_sf)=="StrataID"] <- "STRATA_ID"
  colnames(strataMar4VSW_sf)[colnames(strataMar4VSW_sf)=="Areakm"] <- "AREA_KM"
  strataMar4VSW_sf$fid <- NULL
  strataMar4VSW_sf <- st_transform(strataMar4VSW_sf, crs = 4326)
  usethis::use_data(strataMar4VSW_sf, overwrite = TRUE)
}

