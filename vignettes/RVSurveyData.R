## ----load-packages, include=FALSE----------------------------------------------------------------------------
  if (!require(dplyr)) install.packages('dplyr')  
  if (!require(ggplot2)) install.packages('ggplot2')  
  if (!require(mapdata)) install.packages('mapdata')  
  if (!require(sf)) install.packages('sf')  
library(RVSurveyData)
library(dplyr)
library(ggplot2)
library(mapdata)
library(sf)


## ----echo=FALSE----------------------------------------------------------------------------------------------
data(GSMISSIONS, package = "RVSurveyData")
recentData <- unique(GSMISSIONS[,c("YEAR","SEASON")]) %>% dplyr::group_by(SEASON) %>% dplyr::top_n(1, YEAR)
recentData <- recentData[order( -rank(recentData$SEASON),-recentData$YEAR),] %>% as.data.frame()
print(recentData)

## ----echo=FALSE----------------------------------------------------------------------------------------------
cat(paste(utils::data(package = "RVSurveyData")$results[,"Item"]),sep = "\n" )

## ------------------------------------------------------------------------------------------------------------
library(RVSurveyData)
head(GSCAT)

## ----echo=FALSE----------------------------------------------------------------------------------------------
reg = ggplot2::map_data("world2Hires")
reg = subset(reg, region %in% c('Canada', 'USA', 'France'))
#presence of France seems to force coordinates to do 0 to 360 instead of -180 to 180
reg[reg$long > 180, "long"] <- -360+reg[reg$long > 180, "long"]

extStrata <- st_bbox(strataMar_sf)
extNafo <- st_bbox(nafo_sf)
extstrataMar4VSW_sf <- st_bbox(strataMar4VSW_sf)

## ----echo=FALSE----------------------------------------------------------------------------------------------
ggplot() + 
  ggtitle("nafo_sf") +
  geom_sf(data = nafo_sf, fill="steelblue1") +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "lightgrey", color = "grey25") +
  coord_sf(xlim = c(extNafo[["xmin"]], extNafo[["xmax"]]), 
           ylim = c(extNafo[["ymin"]], extNafo[["ymax"]]), expand = TRUE) 

## ----echo=FALSE----------------------------------------------------------------------------------------------
ggplot() + 
  ggtitle("strataMar_sf") +
  geom_sf(data = strataMar_sf, fill="steelblue1") +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "lightgrey", color = "grey25") +
  coord_sf(xlim = c(extStrata[["xmin"]], extStrata[["xmax"]]), 
           ylim = c(extStrata[["ymin"]], extStrata[["ymax"]]), expand = TRUE) 

## ----echo=FALSE----------------------------------------------------------------------------------------------
ggplot()+
ggtitle("strataMar4VSW_sf") +
geom_sf(data = strataMar4VSW_sf, fill="steelblue1") +
geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "lightgrey", color = "darkgrey") +
coord_sf(xlim = c(extstrataMar4VSW_sf[["xmin"]], extstrataMar4VSW_sf[["xmax"]]),
ylim = c(extstrataMar4VSW_sf[["ymin"]], extstrataMar4VSW_sf[["ymax"]]), expand = TRUE)

