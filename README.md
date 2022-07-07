# RVSurveyData
A package facilitating sharing of the DFO Maritimes Groundfish Survey Data with external partners

Please see the ["NEWS"](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/NEWS.md) file form information about the status of the data. (e.g. most recent survey)

The idea for this repo came out of discussions within the [WGNAEO](https://www.ices.dk/community/groups/Pages/WGNAEO.aspx "Working Group on Northwest Atlantic Ecosystem Observations").  By providing an authoritative dataset in a single format, it is hoped that we can facilitate collaboration on analyses of this data.  While no functions/scripts are expected to be added to this package, they might be contributed via a sister package such as [RVTransmogrifier](https://github.com/PopulationEcologyDivision/RVTransmogrifier/). RVTransmogrifier is envisioned as a repo solely dedicated to the transformation of RV survey data into formats required by various partners.

## Installation
To install this package, run `devtools::install_github('PopulationEcologyDivision/RVSurveyData')`

## Usage
To view a particular data table, just load the package, and then issue a command:
```
> library(RVSurveyData)
> head(GSCAT)
     MISSION SETNO SPEC LENGTH_TYPE LENGTH_UNITS  WEIGHT_TYPE WEIGHT_UNITS TOTNO TOTWGT SAMPWGT
1 ATC1970175     1   10 Fork Length         <NA> Total Weight        Grams    12     59      59
2 ATC1970175     1   11 Fork Length         <NA> Total Weight        Grams     4     10      10
3 ATC1970175     1   12 Fork Length         <NA> Total Weight        Grams    19     19      19
4 ATC1970175     1   14 Fork Length         <NA> Total Weight        Grams     4      0       0
5 ATC1970175     1   40 Fork Length         <NA> Total Weight        Grams    17      6       6
6 ATC1970175     1   60 Fork Length  Centimeters Total Weight        Grams    18      7       7
```


## Contents
### Scripts
Scripts in this package are minimal - it is primarily a data package.
[R/updateCheck.R](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/R/updateCheck.R) runs when the package is loaded, and informs the user if updated data is available.

[R/listTbls.R](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/R/listTbls.R) simply returns a vector of the names of all of the included data tables.

[inst/updateRVSurveyData.R](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/inst/updateRVSurveyData.R) is not a user- usable function, and only serves to extract the data and add it to the package.  It does perform several small "convenience" tweaks to make the data a little easier to work with.  Please check that file to see exactly how these tweaks are performed, but they are described below:

#### GSINF Tweaks

* COORDINATES: The source database stores coordinates in DDMM.MM.   These are retained, but have also been duplicated as *_DD, where the values have been converted to decimal degrees.
* DEPTH (values): where DEPTH existed in the database, it is retained.  If missing, but values were present for DMIN and DMAX, DEPTH is populated with the average of these 2 values
* DEPTH (units): The source database stores depth values in fathoms.  All depth fields have been duplicated as *_M, where the values have been converted to meters.

#### GSCAT Tweaks

* Internally, this table includes a "SIZE_CLASS" field, which breaks down field-observations of a given species into manageable chunks based on different observed sizes of animals within a set.  This field has been removed, and all observations of a single species within a single set have had the weights and numbers of all size classes summed together. 

### Data
Following is a list of all of the data objects included in this package.  Each is documented within the package, accessible via a command like `?GSCAT`. Links below go to the respective Rd files.  These files are are better formatted when viewed from within the package. 

||||
| ------------- | ------------- | ----------- | 
|[GSAUX](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSAUX.Rd)       | [GSINF](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSINF.Rd)           | [GSSPEC](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSSPEC.Rd)                      |
|[GSCAT](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSCAT.Rd)       | [GSMATURITY](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSMATURITY.Rd) | [GSSPECIES](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSSPECIES.Rd)                          |
|[GSCURNT](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSCURNT.Rd)   | [GSMISSIONS](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSMISSIONS.Rd) | [GSSPECIES_20220624*](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSSPECIES_20220624.Rd)                    |
|[GSDET](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSDET.Rd)       | [GSSEX](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSSEX.Rd)           | [GSSPECIES_TAX*](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSSPECIES_TAX.Rd) |
|[GSFORCE](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSFORCE.Rd)   | [GSSTRATUM](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSSTRATUM.Rd)   |            |
|[GSGEAR](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSGEAR.Rd)     | [GSWARPOUT](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSWARPOUT.Rd)    | |
|[GSHOWOBT](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSHOWOBT.Rd) | [GSXTYPE](https://github.com/PopulationEcologyDivision/RVSurveyData/blob/main/man/GSXTYPE.Rd)     | |

\* These species-related tables are new (and draft), and include APHIAID information for each species.
