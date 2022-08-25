#' @title GSAUX Metadata
#' @name GSAUX
#' @description This is auxiliary gear code table.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{AUX}{A single digit numeric code to identify any auxiliary gear being used.}
#' \item{AUXDESC}{Description of auxiliary gear.}
#' }
"GSAUX"

#' @title GSCAT Metadata
#' @name GSCAT
#' @description This table describes the catches of species, grouped by set.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{MISSION}{A 10 character field to identify the survey.  The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
#' \item{SETNO}{Each tow is assigned a numeric set identifier starting with 1 for the first tow and then assigned consecutively.}
#' \item{SPEC}{Maritimes species code.}
#' \item{TOTWGT}{Total Weight (Kg). When a trawl is hauled, all of the individuals for a given species are weighed and counted.  These values become  TOTWGT and TOTNO in GSCAT.  For huge catches, the TOTNO is sometimes calculated from the weight.}
#' \item{TOTNO}{Total Number. When a trawl is hauled, all of the individuals for a given species are weighed and counted.  These values become  TOTWGT and TOTNO in GSCAT.  For huge catches, the TOTNO is sometimes calculated from the weight.}
#' }
"GSCAT"

# @title GSCRUISELIST Metadata
# @name GSCRUISELIST
# @description This table describes all of the different survey cruises (e.g. when and where they went, etc)
# @docType data
# @format data.frame
# \describe{
# \item{YEAR}{The year of the survey.}
# \item{NAFO}{The NADO divisions in which the survey occurred (e.g. 4VWX5; 5Z)}
# \item{VESL}{A 3 character identifying the vessel (eg. NED)}
# \item{CRUNO}{A 3 digit code identifying the survey number within the year. (eg. 001)}
# \item{SDATE}{The start date of the cruise}
# \item{EDATE}{The end date of the cruise}
# \item{SETS}{The number of sets conducted during the survey}
# \item{PURPOSE}{The purpose of the cruise}
# \item{LOCALE}{Description of the area in which the survey occurred}
# \item{DATASOURCE}{xxx}
# \item{DATASTATUS}{xxx}
# \item{DATALOCATION}{Physical location of hard copy data}
# \item{MISSION}{A 10 character field to identify the survey.  The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
# }
#"GSCRUISELIST"

#' @title GSCURNT Metadata
#' @name GSCURNT
#' @description This is a lookup table for describing the direction of the tide relative to the vessel.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{CURNT}{A single digit code to identify the direction of the tide in relation to the vessel}
#' \item{CURNTDESC}{The description of CURNT (e.g. "starboard")}
#' }
"GSCURNT"

#' @title dataDETS Metadata
#' @name dataDETS
#' @description This table describes the various measurements take for individual specimens (e.g. length, weight, etc). 
#' @docType data
#' @format data.frame
#' \describe{
#' \item{MISSION}{A 10 character field to identify the survey.  The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
#' \item{SETNO}{Each tow is assigned a numeric set identifier starting with 1 for the first tow and then assigned consecutively.}
#' \item{SPEC}{Maritimes species code.}
#' \item{FSHNO}{Unique number assigned within species and mission.}
#' \item{SPECIMEN_ID}{Specimen Identifier}
#' \item{FLEN}{"Fish Length" - typically cm}
#' \item{FSEX}{Sex of the specimen.}
#' \item{FMAT}{Code for the observed maturity stage.}
#' \item{FWT}{The round weight in grams of the specimen.}
#' \item{AGMAT}{Code for the age material collected.}
#' \item{AGE}{Age of specimen.}
#' }
"dataDETS"

#' @title dataLF Metadata
#' @name dataLF
#' @description This table describes the various measurements take for individual specimens (e.g. length, weight, etc). 
#' @docType data
#' @format data.frame
#' \describe{
#' \item{MISSION}{A 10 character field to identify the survey.  The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
#' \item{SETNO}{Each tow is assigned a numeric set identifier starting with 1 for the first tow and then assigned consecutively.}
#' \item{SPEC}{Maritimes species code.}
#' \item{FSEX}{Sex of the specimen.}
#' \item{FLEN}{"Fish Length" - typically cm}
#' \item{CLEN}{Count at Length.}
#' }
"dataLF"

#' @title GSFORCE Metadata
#' @name GSFORCE
#' @description This is a lookup table for describing the wind.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{FORCE}{A single digit code to identify wind force on the Beaufort scale}
#' \item{FORCEDESC}{The description of FORCE (e.g. "1 - 3 Knots")}
#' }
"GSFORCE"

#' @title GSGEAR Metadata
#' @name GSGEAR
#' @description This is a lookup table for describing the gear
#' @docType data
#' @format data.frame
#' \describe{
#' \item{GEAR}{A single digit numeric code to identify the gear being used.}
#' \item{GEARDESC}{The description of GEAR (e.g. "Western IIA trawl")}
#' }
"GSGEAR"

#' @title GSHOWOBT Metadata
#' @name GSHOWOBT
#' @description This is a lookup table for describing how the vessel's positional information was obtained.
#' @docType data
#' @format data\.frame
#' \describe{
#' \item{HOWOBT}{A single digit numeric code describing how the ship's position was determined.}
#' \item{HOWOBTDESC}{The description of HOWOBT (e.g. "GPS")}
#' }
"GSHOWOBT"

#' @title GSINF Metadata
#' @name GSINF
#' @description This table describes information about the sets (e.g. when and where they occurred)
#' @docType data
#' @format data.frame
#' \describe{
#' \item{MISSION}{A 10 character field to identify the survey. The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
#' \item{SETNO}{Each tow is assigned a numeric set identifier starting with 1 for the first tow and then assigned consecutively.}
#' \item{SDATE}{The date at the beginning of the tow.}
#' \item{TIME}{The local time at the beginning of the tow.}
#' \item{STRAT}{A numeric code to identify stratum.}
#' \item{AREA}{A numeric code to identify the NAFO area.}
#' \item{DUR}{Duration.}
#' \item{DIST}{The actual tow distance in nautical miles.}
#' \item{SPEED}{The average speed of the vessel over bottom, based on GPS, to the nearest tenth of a nautical mile.}
#' \item{HOWD}{A single digit code to identify the source of information for the distance.}
#' \item{HOWS}{A single digit code to identify the source of information for the speed.}
#' \item{WIND}{Wind Direction. In true degrees, between 0 and 360.}
#' \item{FORCE}{A single digit code to identify wind force on the Beaufort scale}
#' \item{CURNT}{A single digit code to identify the direction of the tide in relation to the vessel}
#' \item{TYPE}{A numeric code to identify the experiment type.}
#' \item{GEAR}{A single digit numeric code to identify the gear being used.}
#' \item{AUX}{A single digit numeric code to identify any auxiliary gear being used.}
#' \item{REMARKS}{Any comments pertaining to set.}
#' \item{SURFACE_TEMPERATURE}{Surface Temperature in celsius}
#' \item{BOTTOM_TEMPERATURE}{Bottom temperature in celsius }
#' \item{BOTTOM_SALINITY}{Bottom salinity measured in pounds per square unit. }
#' \item{STATION}{xxx}
#' \item{SLAT_DD}{The latitude at the start of a tow (decimal degrees)}
#' \item{SLONG_DD}{The longitude at the start of a tow (decimal degrees)}
#' \item{ELAT_DD}{The latitude at the end of a tow (decimal degrees)}
#' \item{ELONG_DD}{The longitude at the end of a tow (decimal degrees)}
#' \item{DMIN_M}{The minimum(shallowest) bottom depth, in meters observed during a tow.}
#' \item{DMAX_M}{The maximum(deepest) bottom depth, in meters observed during a tow.}
#' \item{DEPTH_M}{The average of start and end depth}
#' \item{START_DEPTH_M}{The bottom depth at start of a set, in meters}
#' \item{END_DEPTH_M}{The bottom depth at end of a set, in meters}
#' }
"GSINF"

#' @title GSMISSIONS Metadata
#' @name GSMISSIONS
#' @description This table describes all of the different survey cruises (e.g. when and where they went, etc)
#' @docType data
#' @format data.frame
#' \describe{
#' \item{MISSION}{A 10 character field to identify the survey.  The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
#' \item{VESEL}{A 1 digit code used to identify the vessel used in the survey}
#' \item{CRUNO}{A 3 digit code identifying the survey number within the year. (eg. 001)}
#' \item{YEAR}{The year of the survey.}
#' \item{SEASON}{The season of the survey.}
#' }
"GSMISSIONS"

# @title GSSPEC Metadata
# @name GSSPEC
# @description This table appears to describe quality control and data processing parameters by species
# @docType data
# @format data.frame
# \describe{
# \item{SPEC}{Maritimes species code.}
# \item{CNAME}{The common name of the species.}
# \item{DMIN}{Minimum depth for this species}
# \item{DMAX}{Maximum depth for this species}
# \item{VSEX1}{xxx}
# \item{VSEX2}{xxx}
# \item{VSEX3}{xxx}
# \item{LGRP}{length grouping}
# \item{LMIN}{Minimum length}
# \item{LMAX}{Maximum length}
# \item{MATREQ}{Aging materials required}
# \item{SAMPREQ}{Samples required}
# \item{MLEN}{xxx}
# \item{LENWGTA}{Length weight regression coefficient a}
# \item{LENWGTB}{Length weight regression coefficient b}
# \item{LFSEXED}{Length frequency counts by sex (Y/N)}
# \item{MAXWGT}{Maximum weight for species}
# }
# "GSSPEC"

#' @title GSSPECIES
#' @name GSSPECIES
#' @description This is an updated version of the Maritimes Species Code table.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{CODE}{The numeric code used to identify the species.}
#' \item{SPEC}{The scientific name of the species.}
#' \item{COMM}{The common name of the species.}
#' \item{COMMENTS}{Most frequently used record previously used scientific name}
#' \item{VALID_SPP}{Boolean field indicating if this is a valid, biological species or something else (e.g. life stage, etc)}
#' \item{TSN}{ITIS Taxonomic Serial Number}
#' \item{APHIAID}{WoRMS Aphia ID code}
#' \item{TAXON_STATUS}{An assessment of the validity of "SPEC" from WoRMS (NULLS are "accepted")}
#' \item{APHIAID_SUGG}{A suggested, more valid APHIAID from WoRMS}
#' \item{SPEC_SUGG}{The suggested, more valid scientific name, according to WoRMS}
#' \item{IDD_CONFID_SINCE}{A date indicating the point in time at which this species was confidently and consistently identified during the survey}
#' \item{PREV_IDD_APHIAID}{If this species may have been grouped with one or more other species prior to IDD_CONFID_SINCE, this is the aphiaid that would have been used previously}
#' \item{LGRP}{length grouping}
#' \item{LFSEXED}{Length frequency counts by sex (Y/N)}
#' \item{KINGDOM}{KINGDOM (for APHIAID from WoRMS)}
#' \item{PHYLUM}{PHYLUM (for APHIAID from WoRMS)}
#' \item{CLASS}{CLASS (for APHIAID from WoRMS)}
#' \item{ORDER}{ORDER (for APHIAID from WoRMS)}
#' \item{FAMILY}{FAMILY (for APHIAID from WoRMS)}
#' \item{GENUS}{GENUS (for APHIAID from WoRMS)}
#' \item{SPECIES}{SPECIES (for APHIAID from WoRMS)}
#' }
"GSSPECIES"

# @title GSSPECIES_TAX
# @name GSSPECIES_TAX
# @description This is a table of the taxonomic hierarchies associated with the APHIAIDs found in GSSPECIES_20220624 (from WoRMS)
# @docType data
# @format data.frame
# \describe{
# \item{APHIAID}{WoRMS Aphia ID code}
# \item{KINGDOM}{KINGDOM}
# \item{PHYLUM}{PHYLUM}
# \item{CLASS}{CLASS}
# \item{ORDER}{ORDER}
# \item{FAMILY}{FAMILY}
# \item{GENUS}{GENUS}
# \item{SPECIES}{SPECIES}
# }
#"GSSPECIES_TAX"

# @title GSSTRATA Metadata
# @name GSSTRATA
# @description This appears to be a table that could be used to plot the strata.  
# @docType data
# @format data.frame
# \describe{
# \item{STRATA}{survey stratum code}
# \item{MAJOR}{xxx}
# \item{MINOR}{xxx}
# \item{LATITUDE}{xxx}
# \item{LONGITUDE}{xxx}
# }
# "GSSTRATA"

#' @title GSSTRATUM Metadata
#' @name GSSTRATUM
#' @description This is the depth range and area by survey stratum 
#' @docType data
#' @format data.frame
#' \describe{
#' \item{STRAT}{survey stratum code}
#' \item{DMIN}{Stratum minimum Depth}
#' \item{DMAX}{Stratum maximum Depth}
#' \item{AREA}{Area of stratum (square nautical miles)}
#' \item{DEPTH}{Stratum nominal Depth}
#' \item{NAME}{stratum name}
#' }
"GSSTRATUM"

# @title GSVESSEL Metadata
# @name GSVESSEL
# @description This is the...
# @docType data
# @format data.frame
# \describe{
# \item{VESEL}{A 1 digit code used to identify the vessel used in the survey}
# \item{VNAME}{Name of the vessel}
# \item{BDATE}{xxx}
# \item{EDATE}{xxx}
# \item{GEAR1}{xxx}
# \item{GEAR2}{xxx}
# \item{GEAR3}{xxx}
# \item{GEAR4}{xxx}
# \item{GEAR5}{xxx}
# }
#"GSVESSEL"

#' @title GSWARPOUT Metadata
#' @name GSWARPOUT
#' @description This is the table of the WARP associated with each fishing event.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{MISSION}{A 10 character field to identify the survey.  The first 3 character identifies the vessel (eg. NED), the next 4 characters identifies the year (eg. 2000) and the last 3 characters identifies the survey number within the year. (eg. 001). Example NED2000001.}
#' \item{SETNO}{Each tow is assigned a numeric set identifier starting with 1 for the first tow and then assigned consecutively.}
#' \item{WARPOUT}{Warp, in meters}
#' }
"GSWARPOUT"

#' @title GSXTYPE Metadata
#' @name GSXTYPE
#' @description This is the code table for the (GSINF) TYPE codes.
#' @docType data
#' @format data.frame
#' \describe{
#' \item{XTYPE}{Numeric code for the experiment type}
#' \item{XTYPEDESC}{Description of the experiment type code }
#' }
"GSXTYPE"

#' @title GSMATURITY Metadata
#' @name GSMATURITY
#' @description This is the code table for the maturity codes. 
#' @docType data
#' @format data.frame
#' \describe{
#' \item{CODE}{Maturity Code}
#' \item{DESCRIPTION}{Description of maturity stage}
#' }
"GSMATURITY"

#' @title GSSEX Metadata
#' @name GSSEX
#' @description This is the code table for the sex codes. 
#' @docType data
#' @format data.frame
#' \describe{
#' \item{CODE}{Sex Code}
#' \item{DESCRIPTION}{Description of sex code}
#' }
"GSSEX"

#' @title nafo_sf Metadata
#' @name nafo_sf
#' @description This is an sf object of the NAFO subunits used by DFO Maritimes.  It was initially 
#' created as a shapefile by Kasia Rozalska and Scott Coffen-Smout.  Mike McMahon added some US areas, 
#' split 4XP into sub-areas for use by an assessment group, added all fields other than "NAFO", and
#' converted it to an sf object.    
#' @docType data
#' @format sf multipolygon with a CRS of 4326 (i.e. WGS84)
#' \describe{
#' \item{NAFO}{This is the finest possible resolution identifier for any area}
#' \item{NAFO_1}{This is the NAFO unit identifier for the largest units (i.e. 2 characters (e.g. "4V", "3P", etc))}
#' \item{NAFO_2}{This is a finer resolution identifier for selected NAFO units (i.e. 3 characters (e.g. "4VS", "3PS", etc))}
#' \item{NAFO_3}{This is the finest possible identifier for selected NAFO units (i.e. 4 characters (e.g. "4VSE", "3PSG", etc))}
#' \item{COD}{Some groups break the NAFO Subunits up a little differently (i.e. 4VsW, 4X_SS amd 4XBoF), and this field facilitates working with those divisions.}
#' \item{COD_BEST}{This is the finest possible resolution identifier for any area (using the COD areas)}
#' \item{AREA_ID}{A numeric identifier for the various NAFO subunits}
#' \item{geometry}{}
#' }
"nafo_sf"

#' @title strataMar_sf Metadata
#' @name strataMar_sf
#' @description This is an sf object of the strata used by DFO Maritimes.
#' @docType data
#' @format an sf object with a CRS of 4326 (i.e. WGS84)
#' \describe{
#' \item{STRATA_ID}{This is the identifier used for each strata}
#' \item{AREA_KM}{This is the area for each strata in km^2}
#' }
"strataMar_sf"

#' @title strataMar4VSW_sf Metadata
#' @name strataMar4VSW_sf
#' @description This is an sf object of the strata used by DFO Maritimes.  This strata file is used
#' exclusively with the 4VSW survey data.
#' @docType data
#' @format an sf object with a CRS of 4326 (i.e. WGS84)
#' \describe{
#' \item{STRATA_ID}{This is the identifier used for each strata}
#' \item{AREA_KM}{This is the area for each strata in km^2}
#' }
"strataMar4VSW_sf"