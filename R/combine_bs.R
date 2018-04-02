#' Combine bootstrap covariance estimate results into estimates of the full covariance matrices
#'
#' @param bs_result output of function bs_covar_est(); contains the bootstrap covariance estimates
#' @param limmbo_out object produced by call to limmbo$core$vdbootstrap$LiMMBo
#' @return a list
#'
#' @export
#' @examples
#' prep_data(pheno = matrix(rnorm(300), nrow = 100), kinship = diag(100)) -> dat
#' make_limmbo(dat, timing = TRUE, iterations = 10, subset_size = 2) -> limmbo_out
#' bs_covar_est(limmbo_out, cpus = 1, seed = 100) -> bs_out
#' bs_out2 <- lapply(X = bs_out, FUN = convert_for_bscombine)
#' combine_bs(bs_out2, limmbo_out)
combine_bs <- function(bs_result, limmbo_out){
  out <- limmbo$core$vdbootstrap$LiMMBo$combineBootstrap(limmbo_out, bs_result)
  return(out)
}


#' Helper function to convert for use with combine_bs()
#'
#' @param x outputted object from bs_covar_est
#'
#' @export
#' @examples
#' prep_data(pheno = matrix(rnorm(300), nrow = 100), kinship = diag(100)) -> dat
#' make_limmbo(dat, timing = TRUE, iterations = 10, subset_size = 2) -> limmbo_out
#' bs_covar_est(limmbo_out, cpus = 1, seed = 100) -> bs_out
#' lapply(X = bs_out, FUN = convert_for_bscombine)
convert_for_bscombine <- function(x){
  x[[1]] <- reticulate::np_array(x[[1]], dtype = "int64")
  x[[3]] <- reticulate::np_array(x[[3]], dtype = "int64")
  return(x)
}
