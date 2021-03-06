
[![Travis-CI Build Status](https://travis-ci.org/fboehm/limmbo2.svg?branch=master)](https://travis-ci.org/fboehm/limmbo2)

<!-- README.md is generated from README.Rmd. Please edit that file -->
limmbo2
=======

The goal of `limmbo2` is to estimate Vg and Ve covariance matrices in the multivariate LMM. Note that it uses the python module `limmbo` to do this. The preprint article that describes the `limmbo` python module's methods is here: <https://www.biorxiv.org/content/early/2018/01/30/255497>

Installation
------------

First, be sure that you have python modules `limix` and `limmbo` installed:

``` bash
conda install -c conda-forge limix
pip install limmbo
```

Once those two modules are successfully installed, you can proceed to install the limmbo2 R package:

``` r
# install.packages("devtools")
devtools::install_github("fboehm/limmbo2")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(limmbo2)
pheno <- matrix(data = runif(300), nrow = 100, ncol = 3)
kinship <- diag(100)
t(chol(kinship)) -> chol_kin

prep_data(pheno, kinship) -> input_data

make_limmbo(input_data, TRUE, 10, 2) -> l_out
bs_covar_est(l_out, 1, 1) -> bs_out
bs_out2 <- lapply(FUN = convert_for_bscombine, X = bs_out)

combine_bs(bs_out2, l_out) -> fits
(fits$Cn_fit -> Ve)
#>           [,1]      [,2]      [,3]
#> [1,] 0.1696938 0.1342838 0.1126630
#> [2,] 0.1342838 0.1813464 0.1230871
#> [3,] 0.1126630 0.1230871 0.1421201
(fits$Cg_fit -> Vg)
#>           [,1]      [,2]      [,3]
#> [1,] 0.1696938 0.1342838 0.1126630
#> [2,] 0.1342838 0.1813464 0.1230871
#> [3,] 0.1126630 0.1230871 0.1421201
```
