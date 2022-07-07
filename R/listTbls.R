#' @title listTbls
#' @description This function returns the names of all of the tables available in the package
#' @author  Mike McMahon, \email{Mike.McMahon@@dfo-mpo.gc.ca}
#' @export
listTbls<-function(){
  c("GSAUX", "GSCAT", "GSCURNT", "GSDET", 
    "GSFORCE", "GSGEAR", "GSHOWOBT", "GSINF", "GSMATURITY", 
    "GSMISSIONS", "GSSEX","GSSPEC", "GSSPECIES", 
    "GSSTRATUM", "GSVESSEL", "GSWARPUT", "GSXTYPE",
    "GSSPECIES_20220624", "GSSPECIES_TAX")
}