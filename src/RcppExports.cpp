// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// rcpp_seqr2
Rcpp::List rcpp_seqr2(const arma::mat& wind, const int& window);
RcppExport SEXP _DTScanF_rcpp_seqr2(SEXP windSEXP, SEXP windowSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::mat& >::type wind(windSEXP);
    Rcpp::traits::input_parameter< const int& >::type window(windowSEXP);
    rcpp_result_gen = Rcpp::wrap(rcpp_seqr2(wind, window));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_DTScanF_rcpp_seqr2", (DL_FUNC) &_DTScanF_rcpp_seqr2, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_DTScanF(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
