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
  
  #' created generously large area (based on the strata) 
  #' for which to extract coastline and bathy
  strataRng1<- as.vector(st_bbox(RVSurveyData::strataMar_sf))
  strataRng2<- as.vector(st_bbox(RVSurveyData::strataMar4VSW_sf))
  strataRng <- c(pmin(strataRng1[1], strataRng2[1]),
                 pmin(strataRng1[2], strataRng2[2]),
                 pmax(strataRng1[3], strataRng2[3]),
                 pmax(strataRng1[4], strataRng2[4]))
  
  limits <-   c(roundDD2Min(strataRng[1],nearestMin=30, how = "floor"), 
                roundDD2Min(strataRng[3],nearestMin=30, how = "ceiling"), 
                roundDD2Min(strataRng[2],nearestMin=30, how = "floor"), 
                roundDD2Min(strataRng[4],nearestMin=30, how = "ceiling"))
  
  library(mapdata)
  
  maritimesLand <- ggplot2::map_data("world2Hires",region = c('Canada', 'USA', 'France'), wrap = c(-180,180))
  maritimesBathy <- marmap::fortify.bathy(marmap::getNOAA.bathy(lon1 = limits[1], 
                                                          lon2 = limits[2], 
                                                          lat1 = limits[3], 
                                                          lat2 = limits[4], 
                                                          resolution = 1))
  usethis::use_data(maritimesLand, overwrite = TRUE)
  usethis::use_data(maritimesBathy, overwrite = TRUE)
}

