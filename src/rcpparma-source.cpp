// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-

// we only include RcppArmadillo.h which pulls Rcpp.h in for us
#include "RcppArmadillo.h"

//' R2 Sequence
//' 
//' Search for the most similar time windows in a time series.
//' 
//' @param wind A matrix to feed the regression.
//' @param window The size of the window
//' 
//' @return a \code{list} containing:
//' \itemize{
//'   \item sequence: a \code{data.frame} indicating the starting and stoping 
//'   indexes and R2 for the calculated model.
//'   \item y: the target window. 
//' }
//' 
//' @author Leandro Mineti
// [[Rcpp::export]]
Rcpp::List rcpp_seqr2(const arma::mat & wind, const int & window) {

  int j = window;
  int i = 0, n = wind.n_rows, c = wind.n_cols;
  double erro, sqt;
  
  arma::mat X(j,c);
  arma::colvec y = (wind.col(1)).tail(j);
  arma::colvec coef(c);
  arma::colvec residual(j); 
  
  arma::mat sequence(n - (2*j)+1, 3);
  
  for(i=0;i<=n-2*j;i++){
    sequence(i,0) = i+1;
    sequence(i,1) = i+j;
    X    = wind.rows(i, i+j-1);
    coef = arma::solve(X, y);
    erro = accu(pow(y - X*coef, 2));
    sqt  = accu(pow(y - mean(y), 2));
    sequence(i,2)   = 1 - (erro/sqt);
  }
  
  return Rcpp::List::create(Rcpp::Named("sequence") = sequence,
                            Rcpp::Named("y") = y);
}
