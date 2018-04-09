#' Estimate Vg and Ve with limmbo
#'
#' @param kinship a n by n kinship matrix
#' @param pheno a n by d phenotypes matrix
#' @param niter integer number of iterations for limix calculations
#' @param S number of phenotypes per bootstrap sample
#' @param seed positive integer random seed
#' @export
#'
limmbo2 <- function(kinship, pheno, niter = 10, S = 2, seed){
    prep_data(pheno, kinship) -> input_data
    make_limmbo(input_data, TRUE, niter, S) -> l_out
    bs_covar_est(l_out, 1, seed) -> bs_out
    bs_out2 <- lapply(FUN = convert_for_bscombine, X = bs_out)
    combine_bs(bs_out2, l_out) -> fits
    fits$Cn_fit -> Ve
    fits$Cg_fit -> Vg
    return(list(Vg = Vg, Ve = Ve))
}
