% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trawl_query.R
\name{trawl_query}
\alias{trawl_query}
\title{Execute query of multiple Oracle trawl tables for use by EchoNet2Fish functions}
\usage{
trawl_query(
  year = c(2019),
  lake = c(2, 3),
  lakec = c("MI", "HU"),
  target = c(209, 210, 252),
  species = c(106, 109, 202, 203, 204, 504),
  user = username,
  password = password,
  dbname = dbname,
  schma = "RVCAT",
  descr = "LW acoustic survey",
  outdir = NULL
)
}
\arguments{
\item{year}{Numeric vector indicating the desired collection year(s).}

\item{lake}{Numeric vector indicating the desired collection lake(s).}

\item{lakec}{Character vector representing an abbreviation for the lake name.
This value is used to direct output files to the correct subfolder of the
folder in which the EchoNet2Fish reference file is located. For example, if
the path to this folder is C:/Documents/Acoustics/EchoNet2Fish and data are
from the year 2018 and lake with abbreviation (lakec) "MI", the output will
be written to the folder C:/Documents/Acoustics/EchoNet2Fish/MI2018.}

\item{target}{Numeric vector indicating the desired collection target(s).}

\item{species}{Numeric vector of RVCAT species codes for which you wish to
query.}

\item{user}{Character vector providing the username used to connect to
the database.}

\item{password}{Character vector providing the password used to connect to
the database.}

\item{schma}{Character vector providing the schema used to connect to
the database. Default is "RVCAT".}

\item{descr}{Character vector to include in the output file names to help identify
the data for later use. Default is "Acoustic".
in only a subset of fields being returned. The subset includes}

\item{outdir}{Character vector representing the parent directory in which the
output directory where data should be saved is located. The values for lakec and
year are pasted together with this directory name to provide the output location
for files generated by the function. This folder must exist already.}
}
\value{
Six different data frames are saved as objects in an Rdata file and are written to csv
  files in \code{outdir}:
  \itemize{
    \item \code{op} = Data from the RVCAT.OP table for the desired selection.
    \item \code{tr_op} = Data from the RVCAT.TR_OP table matching the operations
    in the op data.
    \item \code{tr_catch} = Data from the RVCAT.TR_CATCH table matching the
    operations in the op data
    \item \code{tr_lf} = Data from the RVCAT.TR_LF table matching the operations
    in the op data.
    \item \code{tr_l} = Data from the RVCAT.TR_L table matching the operations
    in the op data.
    \item \code{tr_fish} = Data from the RVCAT.TR_FISH table matching the operations
    in the op data.
    }
}
\description{
Execute query of multiple Oracle trawl tables for use by EchoNet2Fish functions
}
\details{
This function queries the RVCAT database to obtain trawl data desired by the user.
It currently allows the user to determine if certain field names should be renamed
to match the requirements of Echonet2Fish functions.
}
