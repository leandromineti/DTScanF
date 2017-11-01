
DTScanF
=======

Overview
--------

An R package implementing innovative forecasting algorithm for wind time series.

Installation
------------

``` r
library(devtools)

devtools::install_github("leandromineti/DTScanF")
```

``` r
library(DTScanF)

data("curvelo", package = "DTScanF")

res <- dtsf(ts = curvelo$vento, poli = 1, best = 5, window = 24, forecast = 10)

ts_f <- cbind(matrix(NA, ncol = 24, nrow = 5), res$forecast)
wind <- c(tail(curvelo$vento, 24), rep(NA, 10))

plot(wind, col = "blue", type = "l", ylim = c(0, 3), ylab = "Wind", xlab = "Hour")
par(new=T)
matplot(t(ts_f), type = "l", ylim = c(0, 3), ylab = "", xlab = "")
```

![](man/figures/README-unnamed-chunk-2-1.png)
