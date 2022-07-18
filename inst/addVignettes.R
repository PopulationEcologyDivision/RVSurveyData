#' @title addVignettes
#' @description This function generates the vignettes included in RVSurveyData
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}

tools::buildVignettes(dir = ".", tangle=TRUE)
# dir.create("inst/doc")
file.copy(dir("vignettes", full.names=TRUE), "inst/doc", overwrite=TRUE)

#change 
#Rmd from output: rmarkdown::html_vignette
#         output: pdf_document 
#to create a pdf