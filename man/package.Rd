% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/public_api.r
\name{package}
\alias{package}
\title{Metadata about a CRAN package}
\usage{
package(name, version = NULL)
}
\arguments{
\item{name}{Name of the package.}

\item{version}{The package version to query. If \code{NULL}, the latest
version if returned. If it is \sQuote{\code{all}}, then all versions
are returned. Otherwise it should be a version number.}
}
\value{
The package metadata.
}
\description{
Metadata about a CRAN package
}

