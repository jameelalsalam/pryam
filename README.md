
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pryam

<!-- badges: start -->
<!-- badges: end -->

The goal of pryam is to provide an interface via reticulate to the
excellent Python package [pyam](https://pyam-iamc.readthedocs.io/),
which is used for analyzing and working with data in the data format
used by IAMC and EMF model intercomparison studies.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jameelalsalam/pryam")
```

If you have never used or installed Python, reticulate can take care of
the details of Python installation and environment setup. The first time
you load and use pryam, it should prompt you to install miniconda, and
will prepare a suitable Python environment called ‘r-reticulate’
including the pyam package. This approach should allow multiple
reticulate-based R packages to use a common Python environment.

If you already have Python installed (perhaps multiple versions), it may
be best to ensure that reticulate is using the appropriate version of
Python.

``` r
library(reticulate)
library(pryam)

# To examine Python configuration and manually install pyam:
# reticulate::py_discover_config()
# reticulate::py_install("pyam")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(pryam)

df <- pyam_data_frame(system.file("extdata", "pyam", "tutorial_data.csv", package = "pryam"))
```

At this time, IamDataFrames returned by pyam remain as references to
Python objects (because they have no unambiguous representation in
standard R data types), while simpler data structures (such as listings
of models or variables included) are converted to their R counterparts,
such as character vectors.

``` r
df
#> <class 'pyam.core.IamDataFrame'>
#> Index dimensions:
#>  * model    : AIM/CGE 2.1, GENeSYS-MOD 1.0, ... WITCH-GLOBIOM 4.4 (8)
#>  * scenario : 1.0, CD-LINKS_INDCi, CD-LINKS_NPi, ... Faster Transition Scenario (8)
#> Timeseries data coordinates:
#>    region   : R5ASIA, R5LAM, R5MAF, R5OECD90+EU, R5REF, R5ROWO, World (7)
#>    variable : ... (6)
#>    unit     : EJ/yr, Mt CO2/yr, °C (3)
#>    year     : 2010, 2020, 2030, 2040, 2050, 2060, 2070, 2080, ... 2100 (10)
#> Meta indicators:
#>    exclude (bool) False (1)
```

``` r
df$model
#> [1] "AIM/CGE 2.1"                 "GENeSYS-MOD 1.0"            
#> [3] "IEA World Energy Model 2017" "IMAGE 3.0.1"                
#> [5] "MESSAGEix-GLOBIOM 1.0"       "POLES CD-LINKS"             
#> [7] "REMIND-MAgPIE 1.7-3.0"       "WITCH-GLOBIOM 4.4"
```

Call pyam methods on Python/pyam objects using `$` instead of `.` as in
Python code. Properties are retrieved without parenthesis, while methods
are called as functions.

``` r
df$variables(include_units = TRUE)
#>                                                      variable      unit
#> 1 AR5 climate diagnostics|Temperature|Global Mean|MAGICC6|MED        °C
#> 2                                               Emissions|CO2 Mt CO2/yr
#> 3                                              Primary Energy     EJ/yr
#> 4                                      Primary Energy|Biomass     EJ/yr
#> 5                                       Primary Energy|Fossil     EJ/yr
#> 6                       Primary Energy|Non-Biomass Renewables     EJ/yr
```
