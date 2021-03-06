# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' R2 Sequence
#' 
#' Search for the most similar time windows in a time series.
#' 
#' @param wind A matrix to feed the regression.
#' @param window The size of the window
#' 
#' @return a \code{list} containing:
#' \itemize{
#'   \item sequence: a \code{data.frame} indicating the starting and stoping 
#'   indexes and R2 for the calculated model.
#'   \item y: the target window. 
#' }
#' 
#' @author Leandro Mineti
rcpp_seqr2 <- function(wind, window) {
    .Call('_DTScanF_rcpp_seqr2', PACKAGE = 'DTScanF', wind, window)
}

