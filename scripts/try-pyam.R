# Use {pyam} via {reticulate}

library(reticulate)
library(tidyverse)
devtools::load_all(".") # {pryam dev}

# locating conda and/or python version is user-specific
# include code in your .Rprofile file to help find conda and/or python as appropriate. .Rprofile is git-ignored so that user-specific configuration is not shared via git.
# https://rstudio.github.io/reticulate/reference/conda-tools.html
# https://rstudio.github.io/reticulate/articles/versions.html


# Q: does this work if conda env 'r-reticulate' not already created? I believe not, because there is no numpy in it.
# Q: how to make this part cross-platform?
use_condaenv(condaenv = "r-reticulate")

py_config()

# to run py_config(), reticulate needs an appropriate environment with at least numpy. Without even numpy, I get errors.

# now the general part...

if(!py_module_available("pyam")) {
  # in user-specified or reticulate identified environment
  py_install("pyam")
}

pyam <- import("pyam")

data <- data.frame(
  model    = c('model_a', 'model_a', 'model_a'),
  scenario = c('scen_a', 'scen_a', 'scen_b'),
  region   = c('World', 'World', 'World'),
  variable = c('Primary Energy', 'Primary Energy|Coal', 'Primary Energy'),
  unit     = c('EJ/yr', 'EJ/yr', 'EJ/yr'),
  `2005`   = c(1, 0.5, 2),
  `2010`   = c(6, 3, 7)
)

data

df <- pyam$IamDataFrame(data)

df$data

df$interpolate(2007L)  # interpolating and appending the values

df$data

# convert back to R data frame:
rdf <- as_tibble(df$data) %>%
  arrange(model, scenario, region, variable, year)

rdf
