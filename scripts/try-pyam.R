# Use {pyam} via {reticulate}

library(reticulate)
library(tidyverse)

# locating conda and/or python version is user-specific
# include code in your .Rprofile file to help find conda and/or python as appropriate.
# https://rstudio.github.io/reticulate/reference/conda-tools.html
# https://rstudio.github.io/reticulate/articles/versions.html


# Q: does this work if conda env 'pryam' not already created? could it use the common 'r-reticulate' env?
# Q: how to make this part cross-platform?
use_condaenv(condaenv = "pryam")

# install pyam and dependencies in conda env
reticulate::conda_install(
  envname = "pryam",
  package = c("pyam")
)

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
