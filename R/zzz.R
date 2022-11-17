.onLoad <- function(libname, pkgname){
  updateCheck(gitPkg = 'PopulationEcologyDivision/RVSurveyData')
  packageStartupMessage("This package is in draft form and may not reflect the actual data available")
}