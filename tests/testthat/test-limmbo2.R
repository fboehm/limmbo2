library(limmbo2)

P <- 5
N <- 100
pheno <- matrix(rnorm(P * N), nrow = N)

# helper function to skip tests if we don't have the 'numpy' module
skip_if_no_numpy <- function() {
  have_numpy <- reticulate::py_module_available("numpy")
  if (!have_numpy)
    skip("numpy not available for testing")
}


context("Testing limmbo2() when kinship is identity matrix, so the two components should be equal.")

test_that("when kinship is identity matrix, the two variance components are equal", {
  skip_on_travis()
  limmbo2(pheno, kinship = diag(N), seed = 1) -> out
  expect_identical(out$Ve, out$Vg)
})
