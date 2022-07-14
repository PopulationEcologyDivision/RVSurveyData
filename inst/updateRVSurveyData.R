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
  

  allTbls = c("GSAUX", "GSCAT", "GSCURNT", "GSDET", 
              "GSFORCE", "GSGEAR", "GSHOWOBT", "GSINF", "GSMATURITY", 
              "GSMISSIONS", "GSSEX","GSSPEC", "GSSPECIES", 
              "GSSTRATUM", "GSWARPOUT", "GSXTYPE",
              "GSSPECIES_20220624", "GSSPECIES_TAX")
  
  # make connection and extract all data to a list
  con <- ROracle::dbConnect(DBI::dbDriver("Oracle"), fn.oracle.username, fn.oracle.password, fn.oracle.dsn)
  res <- lapply(allTbls,
                function(myTable){
                  sqlStatement <- paste0("select * from GROUNDFISH.",myTable)
                  ROracle::dbGetQuery(con, sqlStatement)
                })
  names(res)<- allTbls
  # beepr::beep()
  
  ## Various source tables need some tweaking to improve usability
  #GSINF: add decimal degrees version of coords
  res$GSINF$SLAT_DD  <- DDMM_to_DDDD(res$GSINF$SLAT)
  res$GSINF$SLONG_DD <- DDMM_to_DDDD(res$GSINF$SLONG)
  res$GSINF$ELAT_DD  <- DDMM_to_DDDD(res$GSINF$ELAT)
  res$GSINF$ELONG_DD <- DDMM_to_DDDD(res$GSINF$ELONG)
  
  #GSINF: populate DEPTH using DEPTH, DMIN and DMAX, as available
  #(DEPTH used preferentially, otherwise use average of DMIN and DMAX)
  res$GSINF$DEPTH_tmp <- NA
  res$GSINF$DEPTH_tmp <- rowMeans(res$GSINF[,c("DMIN","DMAX")], na.rm = F) #first do average
  res$GSINF[!is.na(res$GSINF$DEPTH),"DEPTH_tmp"]<- res$GSINF[!is.na(res$GSINF$DEPTH),"DEPTH"] #overwrite w depth, where avail
  res$GSINF$DEPTH <- res$GSINF$DEPTH_tmp
  res$GSINF$DEPTH_tmp <- NULL
  #GSINF: add meters version of depths
  res$GSINF$DMIN_M        <- fathoms_to_meters(res$GSINF$DMIN)
  res$GSINF$DMAX_M        <- fathoms_to_meters(res$GSINF$DMAX)
  res$GSINF$DEPTH_M       <- fathoms_to_meters(res$GSINF$DEPTH)
  res$GSINF$START_DEPTH_M <- fathoms_to_meters(res$GSINF$START_DEPTH)
  res$GSINF$END_DEPTH_M   <- fathoms_to_meters(res$GSINF$END_DEPTH)
  
  #GSINF: remove the time component from SDATE - "TIME" field should be used instead.
  # remove ETIME - for end time, best to add tow duration to TIME field 
  res$GSINF$SDATE <- as.Date(res$GSINF$SDATE)
  
  res$GSINF$ETIME <- NULL
  #GSCAT: following combines numbers and weights for different size classes within a set
  #this drops MARKET (never populated) & REMARKS. 
  res$GSCAT <- res$GSCAT %>%
    group_by(MISSION, SETNO, SPEC, LENGTH_TYPE, LENGTH_UNITS, WEIGHT_TYPE, WEIGHT_UNITS) %>%
    summarise(TOTNO = sum(TOTNO),
              TOTWGT = sum(TOTWGT),
              SAMPWGT = sum(SAMPWGT), .groups = "keep") %>%
    as.data.frame()
  
  #GSSPECIES_20220624: remove temp, internal field and poorly used ENTR field
  res$GSSPECIES_20220624$N_OCCURENCES_GSCAT <- NULL
  res$GSSPECIES_20220624$ENTR <- NULL

  # add all of the list objects to the package
  purrr::walk2(res, names(res), function(obj, name) {
    assign(name, obj)
    do.call("use_data", list(as.name(name), overwrite = TRUE))
  })
  
}