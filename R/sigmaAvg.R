#' Estimate the Average Backscattering Cross Section
#'
#' Estimate the average backscattering cross section, <sigma_bs>, as the mean
#' of the backscattering cross section, sigma_bs,
#' weighted by the number of targets in each target strength bin.
#' @param TSdf
#'   A data frame with some of the columns containing information on the
#'   number of targets detected, named according to the target
#'   strength bin, in dB.
#' @param columnPattern
#'   A character scalar containing a regular expression to be matched to the
#'   names of \code{TSdf}, identifying those columns with information
#'   on the number of targets detected.  Case is ignored.
#'   The default, "X[[:punct:]]", identifies columns that start with an upper
#'   or lower case X followed by any punctuation mark, e.g., "x.", "X_".
#'   See \code{\link{regex}}
#' @param prefixLen
#'   An integer scalar giving the number of characters in the prefix of the
#'   column names identified by \code{columnPattern} to be removed, such that
#'   the only part of the name remaining is numeric, default 2.
#' @param TSrange
#'   A numeric vector of length 2, the range in dB by which to
#'   constrain the target strengths used in the estimation of the average
#'   backscattering cross section.
#' @details
#'   The numeric portion of the column names of \code{TSdf} identified by
#'   \code{columnPattern}, represent a bin of target strengths (TS) in dB.
#'   These TS values are converted to backscattering cross section, sigma_bs
#'   in m^2, using \code{\link{TS2sigma}}.  The average backscattering cross
#'   section, <sigma_bs> in m^2, is then calculated as the mean of all the
#'   sigma_bs within the range of \code{TSrange}, weighted by the number of
#'   targets in each bin.
#'
#'   The numeric part of the column names are assumed to represent
#'   negative values in the dB scale, e.g., x.90 represents -90 dB.
#' @return
#'   A numeric vector of the average backscattering cross section, <sigma_bs>,
#'   one for each row in \code{TSdf}.
#' @seealso
#'   \code{\link{TS2sigma}}, \code{\link{regex}}
#' @export
#' @examples
#' mydf <- data.frame(a=letters[1:4], x.80=0:3, x.90=1:4, x.100=c(0, 1, 0, 1))
#' sigmaAvg(TSdf=mydf, TSrange=c(-105, -85))
#'
  sigmaAvg <- function(TSdf, TSrange, columnPattern="X[[:punct:]]",
    prefixLen=2) {
    namesdf <- names(TSdf)
    tsbin.colz <- grep(columnPattern, namesdf, ignore.case=TRUE)
    maxlen <- max(nchar(namesdf[tsbin.colz]))
    db <- -as.numeric(substring(namesdf[tsbin.colz], prefixLen+1, maxlen))
    sigmabs <- TS2sigma(db)
    in.range <- db >= TSrange[1] & db <= TSrange[2]
    sigma <- apply(TSdf[, tsbin.colz[in.range]], 1, function(w)
      weighted.mean(sigmabs[in.range], w))
    return(sigma)
  }
