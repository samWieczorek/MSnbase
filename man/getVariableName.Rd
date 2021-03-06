\name{getVariableName}
\alias{getVariableName}
\title{Return a variable name}
\usage{
  getVariableName(match_call, varname)
}
\arguments{
  \item{match_call}{An object of class \code{call}, as
  returned by \code{match.call}.}

  \item{varname}{An \code{character} of length 1 which is
  looked up in \code{match_call}.}
}
\value{
  A \code{character} with the name of the variable passed
  as parameter \code{varname} in parent close of
  \code{match_call}.
}
\description{
  Return the name of variable \code{varname} in call
  \code{match_call}.
}
\examples{
a <- 1
f <- function(x, y)
 MSnbase:::getVariableName(match.call(), "x")
f(x = a)
f(y = a)
}
\author{
  Laurent Gatto
}

