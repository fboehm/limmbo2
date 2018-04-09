library(limmbo2)

P <- 5
N <- 100
pheno <- matrix(rnorm(P * N), nrow = 100)
limmbo2(pheno, kinship = diag(N), seed = 1) -> out

context("Testing limmbo2() when kinship is identity matrix, so the two components should be equal.")

test_that("when kinship is identity matrix, the two variance components are equal", {
  expect_identical(out$Ve, out$Vg)
})
