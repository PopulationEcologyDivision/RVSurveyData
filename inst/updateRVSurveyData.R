#' @title updateRVSurveyData
#' @description This function extracts the "main" data from 'groundfish' schema.  It i
#' @param fn.oracle.username default is \code{NULL} This is your username for accessing oracle 
#' objects. 
#' @param fn.oracle.password default is \code{NULL} This is your password for accessing oracle 
#' objects. 
#' @param fn.oracle.dsn default is \code{"PTRAN} This is your dsn/ODBC identifier for accessing 
#' oracle objects. 
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
updateRVSurveyData<-function(fn.oracle.username = NULL, 
                             fn.oracle.password = NULL, 
                             fn.oracle.dsn = "PTRAN"
){
  fathoms_to_meters <- function(field = NULL) {
    field <- round(field*1.8288,2)
    return(field)
  }
  
  DDMM_to_DDDD <- function(field = NULL){
    dfNm <-deparse(substitute(field))
    field <- (as.numeric(substr(field,1,2)) +(field - as.numeric(substr(field,1,2))*100)/60)
    if (grepl("LONG", dfNm)) field <- field*-1
    field <- round(field,6)
    return(field)
  }
  
  if (!require(purrr)) install.packages('purrr')  
  if (!require(dplyr)) install.packages('dplyr')
  if (!require(devtools)) install.packages('devtools')
  
  library(purrr)
  library(dplyr)
  library(devtools)
  
  # allTbls <- c("GSSPECIES_NEW","GSSPEC","GSSPECIES_APHIAS")
  
  allTbls = c("GSAUX", "GSCAT", "GSCURNT", "GSDET", 
              "GSFORCE", "GSGEAR", "GSHOWOBT", "GSINF", "GSMATURITY", 
              "GSMISSIONS", "GSSEX","GSSPEC", 
              "GSSTRATUM", "GSWARPOUT", "GSXTYPE",
             "GSSPECIES_NEW","GSSPECIES_APHIAS","GSSPEC")
  
  # make connection and extract all data to a list
  con <- ROracle::dbConnect(DBI::dbDriver("Oracle"), groundfish.username, groundfish.password, oracle.dsn)
  res <- lapply(allTbls,
                function(myTable){
                  sqlStatement <- paste0("select * from GROUNDFISH.",myTable)
                  ROracle::dbGetQuery(con, sqlStatement)
                })
  names(res)<- allTbls
  saveRDS(res, "C:/git/PopulationEcologyDivision/RVSurveyData/inst/GSExtract20221003.rds")
  ## Various source tables need some tweaking to improve usability
  #GSINF: add decimal degrees version of coords
  res$GSINF$SLAT_DD  <- DDMM_to_DDDD(res$GSINF$SLAT)
  res$GSINF$SLONG_DD <- DDMM_to_DDDD(res$GSINF$SLONG)
  res$GSINF$ELAT_DD  <- DDMM_to_DDDD(res$GSINF$ELAT)
  res$GSINF$ELONG_DD <- DDMM_to_DDDD(res$GSINF$ELONG)
  
  res$GSINF$SLAT <- res$GSINF$SLONG <- res$GSINF$ELAT <- res$GSINF$ELONG <- NULL
  
  #GSINF: populate DEPTH using DEPTH, START_DEPTH and END_DEPTH, as available
  #(DEPTH used preferentially, otherwise use average of START_DEPTH and END_DEPTH)
  res$GSINF$DEPTH_tmp <- NA
  res$GSINF$DEPTH_tmp <- rowMeans(res$GSINF[,c("START_DEPTH","END_DEPTH")], na.rm = F) #first do average
  res$GSINF[!is.na(res$GSINF$DEPTH),"DEPTH_tmp"]<- res$GSINF[!is.na(res$GSINF$DEPTH),"DEPTH"] #overwrite w depth, where avail
  res$GSINF$DEPTH <- res$GSINF$DEPTH_tmp
  res$GSINF$DEPTH_tmp <- NULL
  
  #GSINF: add meters version of depths
  res$GSINF$DMIN_M        <- fathoms_to_meters(res$GSINF$DMIN)
  res$GSINF$DMAX_M        <- fathoms_to_meters(res$GSINF$DMAX)
  res$GSINF$DEPTH_M       <- fathoms_to_meters(res$GSINF$DEPTH)
  res$GSINF$START_DEPTH_M <- fathoms_to_meters(res$GSINF$START_DEPTH)
  res$GSINF$END_DEPTH_M   <- fathoms_to_meters(res$GSINF$END_DEPTH)
  
  res$GSINF$DMIN <- res$GSINF$DMAX <- res$GSINF$DEPTH <- res$GSINF$START_DEPTH <- res$GSINF$END_DEPTH <- NULL
  
  #GSINF: remove the time component from SDATE - "TIME" field should be used instead.
  # remove ETIME - for end time, best to add tow duration to TIME field 
  res$GSINF$SDATE <- as.Date(res$GSINF$SDATE)
  res$GSINF$ETIME <- NULL
  
  #GSDET 
  #NED 2016016 - first instance of measuring herring in mm - convert all prior data from cm to mm
  res$GSDET[res$GSDET$SPEC == 60 &
            substr(res$GSDET$MISSION,4,7) <= 2016 & 
            !res$GSDET$MISSION %in% c("NED2016116","NED2016016") & 
            !is.na(res$GSDET$FLEN),"FLEN"] <- res$GSDET[res$GSDET$SPEC == 60 &
                                                        substr(res$GSDET$MISSION,4,7) <= 2016 & 
                                                        !res$GSDET$MISSION %in% c("NED2016116","NED2016016") & 
                                                        !is.na(res$GSDET$FLEN),"FLEN"]*10
  
  
  # 1 create table from GSDET with CLEN for each MISSION SETNO SPEC FLEN FSEX.
  #  - need to correct CLEN for size_class 1st
  #  - each set will be reduced to 1 record each combination of SPEC, FLEN and FSEX.
  
  dataLF <- res$GSDET
  #get the totwgt and sampwgt for every mission/set/spec/size_class combo, and use them to create
  #a ratio, and apply it to existing CLEN
  dataLF <- merge(dataLF, 
                  res$GSCAT[,c("MISSION", "SETNO", "SPEC", "SIZE_CLASS", "SAMPWGT","TOTWGT")],
                  all.x = T, by = c("MISSION", "SETNO", "SPEC", "SIZE_CLASS"))
  dataLF$CLEN_corr <- dataLF$CLEN
  #if non-na values exist for totwgt and sampwgt (and are >0), use them to bump up CLEN
  dataLF[!is.na(dataLF$TOTWGT) & !is.na(dataLF$SAMPWGT) & (dataLF$SAMPWGT> 0) & (dataLF$TOTWGT>0),"CLEN_corr"] <- round((dataLF[!is.na(dataLF$TOTWGT) & !is.na(dataLF$SAMPWGT) & (dataLF$SAMPWGT> 0) & (dataLF$TOTWGT>0),"TOTWGT"]/dataLF[!is.na(dataLF$TOTWGT) & !is.na(dataLF$SAMPWGT)  & (dataLF$SAMPWGT> 0) & (dataLF$TOTWGT>0),"SAMPWGT"])*dataLF[!is.na(dataLF$TOTWGT) & !is.na(dataLF$SAMPWGT) & (dataLF$SAMPWGT> 0) & (dataLF$TOTWGT>0),"CLEN"],3)
  
  #need to bump up CLEN by TOW dist!
  dataLF <- merge(dataLF, res$GSINF[,c("MISSION", "SETNO", "DIST")],all.x = T, by = c("MISSION", "SETNO"))
  #force NA dists to 1.75
  dataLF[is.na(dataLF$DIST),"DIST"] <- 1.75
  dataLF$CLEN_corr <- round(dataLF$CLEN_corr *(1.75/dataLF$DIST),6)
  dataLF$CLEN <- dataLF$DIST <- NULL
  colnames(dataLF)[colnames(dataLF)=="CLEN_corr"] <- "CLEN"
  dataLF <- dataLF[,c("MISSION", "SETNO", "SPEC", "FLEN", "FSEX", "CLEN")]
  
  dataLF <- dataLF %>%
    group_by(MISSION, SETNO, SPEC, FSEX, FLEN) %>%
    summarise(CLEN = sum(CLEN), .groups = "keep") %>%
    as.data.frame()
  
  res$dataLF <- dataLF
  rm(dataLF)
  # 2 capture the other material from GSDET that is focused on individual measurements - e.g. FSHNO, 
  #   SPECIMEN_ID, FMAT, FLEN, FSEX, FWT, AGE ...
  #  - multiple internal, age-related fields are being dropped
  
  dataDETS <- res$GSDET
  dataDETS <- dataDETS[,!names(dataDETS) %in% c("CLEN", "SIZE_CLASS")]
  # remove internal fields
  dataDETS <- dataDETS[,!names(dataDETS) %in% c("NANN", "EDGE", "CHKMRK", "AGER", "REMARKS" )]
  # keep only informative records
  dataDETS <- dataDETS[!is.na(dataDETS$FLEN) | !is.na(dataDETS$FSEX)| !is.na(dataDETS$FMAT)| !is.na(dataDETS$FWT)| !is.na(dataDETS$AGE),]
  #reorder columns
  dataDETS <- dataDETS[,c("MISSION", "SETNO", "SPEC", "FSHNO", "SPECIMEN_ID", "FLEN", "FSEX", "FMAT",  "FWT", "AGMAT", "AGE")]
  
  
  res$dataDETS <- dataDETS
  res$GSDET <-NULL
  rm(dataDETS)
  
  #GSCAT: following combines numbers and weights for different size classes within a set
  #this drops MARKET (never populated) & REMARKS. 
  res$GSCAT <- res$GSCAT %>%
    group_by(MISSION, SETNO, SPEC) %>%
    summarise(TOTNO = sum(TOTNO),
              TOTWGT = sum(TOTWGT), .groups = "keep") %>%
    as.data.frame()
  
  #GSSPECIES_20220624: remove temp, internal field and poorly used ENTR field
  # res<-list()
  # res$GSSPECIES_20220624<-GSExtract20220811$GSSPECIES_20220624
  # res$GSSPEC <- GSExtract20220811$GSSPEC
  # res$GSSPECIES_TAX <- GSExtract20220811$GSSPECIES_TAX
  
  # res$GSSPECIES_20220624$N_OCCURENCES_GSCAT <- NULL
  res$GSSPECIES_NEW$ENTR <- NULL
  
  #rename the new species table to GSSPECIES
  names(res)[names(res) == "GSSPECIES_NEW"] <- "GSSPECIES"
  
  # colnames(res$GSSPECIES)[colnames(res$GSSPECIES)=="CODE_MAR"] <- "CODE"
  res$GSSPECIES <-  merge(res$GSSPECIES, res$GSSPEC[, c("SPEC","LGRP","LFSEXED")], by.x= "CODE", by.y = "SPEC", all.x=T)
  res$GSSPECIES <-  merge(res$GSSPECIES, res$GSSPECIES_APHIAS[,!names(res$GSSPECIES_APHIAS)%in% c("SCIENTIFICNAME","RANK")], by = "APHIAID", all.x=T)
  
  #add GSCAT COUNT?
  if (F){
    library(RVSurveyData)
    sppCounter_CAT <- aggregate(
      x = list(N_OCCURENCES_GSCAT = GSCAT$SPEC),
      by = list(CODE = GSCAT$SPEC),
      length
    )
    res$GSSPECIES <- merge(res$GSSPECIES, sppCounter_CAT, all.x=T)
  }
  res$GSSPEC <- res$GSSPECIES_APHIAS <- NULL
  # add all of the list objects to the package
  purrr::walk2(res, names(res), function(obj, name) {
    assign(name, obj)
    do.call("use_data", list(as.name(name), overwrite = TRUE))
  })
  
}