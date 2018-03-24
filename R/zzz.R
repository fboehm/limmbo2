# global refs to limmbo and np (ie, numpy)
np <- NULL
limmbo <- NULL

.onLoad <- function(libname, pkgname){
  limmbo <<- reticulate::import("limmbo", convert = TRUE, delay_load = TRUE)
  np <<- reticulate::import("numpy", convert = FALSE, delay_load = TRUE)
}
