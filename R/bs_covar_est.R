#' Perform covariance estimates for each of multiple bootstrap samples of traits
#'
#' @param limmbo_out object produced by call to limmbo$core$vdbootstrap$LiMMBo
#' @param cpus number of cpus to use (as an R object)
#' @param seed integer for pseudo random number seed (as an R object)
#'
#' @export
bs_covar_est <- function(limmbo_out, cpus, seed){
  # change inputs to np objects
  cpus_np <- np$int(cpus)
  seed_np <- reticulate::np_array(seed, dtype = "int64")
  # call python function
  out <- limmbo$core$vdbootstrap$LiMMBo$runBootstrapCovarianceEstimation(limmbo_out,
                                                                  cpus = cpus_np,
                                                                  seed = seed_np
                                                                    )
  return(out)
}
