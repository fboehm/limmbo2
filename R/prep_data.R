#' Prepare data for use with bootstrap covariance estimation function
#'
#' @param pheno phenotypes matrix
#' @param kinship kinship matrix
#' @export
#' @examples \dontrun{
#' prep_data(pheno = matrix(rnorm(300), nrow = 100), kinship = diag(100))
#' }
prep_data <- function(pheno, kinship){
  limmbo$io$input$InputData() -> input_data
  sample_id <- paste0("SID", 1:nrow(pheno))
  pheno_id <- paste0("PID", 1:ncol(pheno))
  limmbo$io$input$InputData$addPhenotypes(input_data, phenotypes = pheno,
                                          phenotype_ID = pheno_id,
                                          pheno_samples = sample_id)

  limmbo$io$input$InputData$addRelatedness(input_data, relatedness = kinship,
                                           relatedness_samples = sample_id)
  return(input_data)
}

#' Make a limmbo output object
#'
#' @param datainput outputted object from prep_data
#' @param timing logical
#' @param iterations positive integer
#' @param subset_size positive integer, number of phenotypes per bootstrap sample
#' @export
#' @examples \dontrun{
#' prep_data(pheno = matrix(rnorm(300), nrow = 100), kinship = diag(100)) -> dat
#' make_limmbo(dat, timing = TRUE, iterations = 10, subset_size = 2)
#' }
make_limmbo <- function(datainput, timing, iterations, subset_size){
  iterations_np <- reticulate::np_array(iterations, dtype = "int64")
  S_np <- np$int(subset_size)
  limmbo$core$vdbootstrap$LiMMBo(datainput, timing = timing,
                                 iterations = iterations_np,
                                 S = S_np) -> foo
  return(foo)
}

