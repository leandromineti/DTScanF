#' DTSF
#' 
#' Implementation a time series forecasting algorithm
#'
#' @author leandromineti@gmail.com
#'
#' @param ts time series.
#' @param poli an integer defining the degree of the model used.
#' @param best an integer defining how many matches will be used in the forecasting.
#' @param window an integer indicating the size of the window to match.
#' @param forecast number of data points to be forecasted.
#'
#' @return \code{list} 
#'
#' @export
#' 
#' @examples
#'
#' @family gbdcd
dtsf <- function(ts, poli, best, window, forecast) {
  
  # Data wrangling
  train <- head(ts, -window)
  wind <- cbind(1, train)
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
    model <- lm(y ~ poly(x, poli, raw = T), data=data.frame(x = ts[pos_train]))
    pos_test <- (sequence$stop[position[best_index]]+1):(sequence$stop[position[best_index]]+forecast)
    wind_forecast <- rbind(wind_forecast, predict(model, newdata=data.frame(x = ts[pos_test])))
  }
  
  return(list("windows" = sequence, 
              "forecast" = wind_forecast))
}