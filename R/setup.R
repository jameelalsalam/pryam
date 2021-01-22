# global reference to pyam (will be initialized in .onLoad)

#' @export
pyam <- NULL

.onLoad <- function(libname, pkgname) {
  reticulate::configure_environment(pkgname)

  # use superassignment to update global reference to pyam
  pyam <<- reticulate::import("pyam", delay_load = TRUE, convert = TRUE)
}

have_pyam <- function() {
  reticulate::py_module_available("pyam")
}

install_pyam <- function(method = "auto", conda = "auto") {
  reticulate::py_install("pyam", method = method, conda = conda)
}
