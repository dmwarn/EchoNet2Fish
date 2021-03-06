% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estrhov.R
\name{estrhov}
\alias{estrhov}
\title{Estimate the Volumetric Fish Density}
\usage{
estrhov(Sv, sigmabs)
}
\arguments{
\item{Sv}{Numeric vector, volume backscattering strength in dB.}

\item{sigmabs}{Numeric vector, backscattering cross-section in m^2,
same length as \code{Sv}.}
}
\value{
A numeric vector the same length as \code{Sv} containing the estimated
  volumetric fish density in number per m^3.
}
\description{
Estimate the volumetric fish density in number per m^3.
}
\details{
The volumetric fish density (in #/m^3)
  is estimated as
  rhov = sv/\code{sigmabs},
  where the volume backscattering coefficient (in 1/m) is
  sv = 10^(\code{Sv}/10).
  (Note distinction between upper and lower case S in \code{Sv} and sv.)
}
\examples{
mySv <- c(-71, -65, -89)
mysigma <- c(6e-4, 3e-5, 2e-6)
estrhov(Sv=mySv, sigmabs=mysigma)

}
\seealso{
\code{\link{estNv}}
}
