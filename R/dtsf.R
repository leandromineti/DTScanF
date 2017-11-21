#' DTSF
#' 
#' Implementation a time series forecasting algorithm.
#'
#' @author leandromineti@gmail.com
#'
#' @param ts time series.
#' @param poli an integer defining the degree of the model used.
#' @param best an integer defining how many matches will be used in the forecasting.
#' @param window an integer indicating the size of the window to match.
#' @param forecast number of data points to be forecasted.
#' @param reg logical indicating if series regularization should be performed. 
#' Default = FALSE.
#'
#' @return a \code{list} with two objects:
#' \itemize{
#'   \item sequence: a \code{data.frame} indicating the starting and stoping 
#'   indexes and R2 for the calculated model.
#'   \item forecast: a \code{matrix} of "best" rows and "forecast" columns.
#' } 
#'
#' @export
#' 
#' @examples
#' library(DTScanF)
#' 
#' data("curvelo", package = "DTScanF")
#' 
#' res <- dtsf(ts = curvelo$vento, poli = 1, best = 5, window = 24, forecast = 10)
#'
#' @family gbdcd
dtsf <- function(ts, poli, best, window, forecast, reg = FALSE) {
  
  ts_reg <- ts  # If reg = FALSE, ts_reg remains equal to ts
  
  # Regularization
  if(reg) {
    for(i in 2:(length(ts)-1)) {
      ts_reg[i] <- 0.99*ts[i] + 0.005*ts[i-1] + 0.005*ts[i+1]
    }
  }
  
  # Handling polynomial order
  wind <- cbind(1, ts_reg)
  while(dim(wind)[2]-1!=poli) wind <- cbind(wind, train^dim(wind)[2])
  
  # Run window through data
  ans <- rcpp_seqr2(wind, window)
  colnames(ans$sequence) <- c("start", "stop", "R2")
  sequence <- as.data.frame(ans$sequence)
  y = ans$y
  
  position <- order(sequence$R2, decreasing=T)
  
  wind_forecast <- c()
  for(best_index in 1:best){ # Run it until the highest best match
    pos_train <- sequence$start[position[best_index]] : sequence$stop[position[best_index]]
    model <- lm(y ~ poly(x, poli, raw = T), data=data.frame(x = ts_reg[pos_train]))
    pos_test <- (sequence$stop[position[best_index]]+1):(sequence$stop[position[best_index]]+forecast)
    wind_forecast <- rbind(wind_forecast, predict(model, newdata=data.frame(x = ts[pos_test])))
  }
  
  return(list("windows" = sequence, 
              "forecast" = wind_forecast))
}