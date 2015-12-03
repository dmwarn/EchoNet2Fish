#' Read in Sv or TS Data from Echoview
#'
#' Read in Sv (volume backscattering strength) or TS (single target frequencies)
#' data from Echoview csv files and combine into a single data frame.
#' @param svtsdir
#'   A character scalar giving the directory in which the csv files are located.
#' @param oldname
#'   A character vector giving the original names of variables to be renamed,
#'   default NULL.
#' @param newname
#'   A character vector giving the new names of variables to be renamed,
#'   default NULL.
#' @param elimMiss
#'   A character vector giving the names of variables which must have
#'   nonmissing values.  All rows with a missing value for any of these
#'   variables will be eliminated, default NULL.
#' @param datevars
#'   A character vector giving the names of variables with date information
#'   stored as YYYYMMDD, default c("Date_S", "Date_E", "Date_M").
#'   These will be converted to R dates.
#' @param addyear
#'   A logical scalar indicating if a \code{year} variable should be added
#'   to the data frame, based on the first variable named in
#'   \code{datevars}, default TRUE.
#' @param tidy
#'   A logical scalar indicating if the data frame should be tidied using
#'   \code{\link{dfTidy}}, default TRUE.
#' @details
#'   In addition to changing names, eliminating missing values, generating
#'   dates and years, and tidying the data (as specified by the function
#'   arguments), any variable names starting with "X." and ending with a number
#'   are changed to ensure the number part of the name is rounded to the
#'   nearest whole number.
#' @return
#'   A data frame with the all rows of the csv files in \code{svtsdir} combined.
#' @import
#'   lubridate
#' @export
#'
readSVTS <- function(svtsdir, oldname=NULL, newname=NULL, elimMiss=NULL,
  datevars=c("Date_S", "Date_E", "Date_M"), addyear=TRUE, tidy=TRUE) {
  # read in csv files
  df <- combinecsv(svtsdir)
  # change names
  if(!is.null(oldname)) {
    if(oldname %in% names(df)) {
      for(i in seq_along(oldname)) {
        df[, newname[i]] <- df[, oldname[i]]
        df[, oldname[i]] <- NULL
      }
    }
  }
  # create date variables
  if(!is.null(datevars)) {
    for(i in seq_along(datevars)) {
      df[, datevars[i]] <- ymd(df[, datevars[i]], quiet=TRUE)
    }
    # create variable for year
    if(addyear) {
      df$year <- year(df[, datevars[1]])
    }
  }
  # assign NAs to missing value codes
  if(tidy) {
    df <- dfTidy(df)
  }
  # make sure numbered names are rounded to whole numbers
  namez <- names(df)
  sel <- substring(namez, 1, 2)=="X."
  names(df)[sel] <- paste0("X.", round(as.numeric(substring(namez[sel], 3, 5))))
  # eliminate records with missing values
  if(!is.null(elimMiss)) {
    missmat <- sapply(elimMiss, function(var) is.na(df[, var]))
    df <- df[!apply(missmat, 1, any), ]
  }
  df
}

