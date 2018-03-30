#' Combine bootstrap covariance estimate results into estimates of the full covariance matrices
#'
#' @param bs_result output of function bs_covar_est(); contains the bootstrap covariance estimates
#' @param limmbo_out object produced by call to limmbo$core$vdbootstrap$LiMMBo
#' @return a list
#'
#' @export
combine_bs <- function(bs_result, limmbo_out){
  out <- limmbo$core$vdbootstrap$LiMMBo$combineBootstrap(limmbo_out, bs_result)
  return(out)
}


#' Helper function to convert for use with combine_bs()
#'
#' @param x outputted object from bs_covar_est
#'
#' @export
convert_for_bscombine <- function(x){
  x[[1]] <- reticulate::np_array(x[[1]], dtype = "int64")
  x[[3]] <- reticulate::np_array(x[[3]], dtype = "int64")
  return(x)
}
