% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FFTreesdata_doc.R
\docType{data}
\name{contraceptive}
\alias{contraceptive}
\title{Contraceptive use data}
\format{
A data frame containing 1473 cases (rows) and 10 variables (columns).

\describe{
  \item{wife.age}{Wife's age, Numeric}
  \item{wife.edu}{Wife's education, Nummeric, (1=low, 2, 3, 4=high)}
  \item{hus.ed}{Husband's education, Nummeric, (1=low, 2, 3, 4=high)}
  \item{children}{Number of children ever born, Numeric}
  \item{wife.rel}{Wife's religion, Numeric, (0=Non-Islam, 1=Islam)}
  \item{wife.work}{Wife's now working?, Nummeric, (0=Yes, 1=No)}
  \item{hus.occ}{Husband's occupation, Nummeric, (1, 2, 3, 4)}
  \item{sol}{Standard-of-living index, Nummeric, (1=low, 2, 3, 4=high)}
  \item{media}{Media exposure, Numeric, (0=Good, 1=Not good)}
  \item{cont.crit}{\emph{Criterion}: Use of a contraceptive (as logical).

  Values: \code{FALSE} vs. \code{TRUE} (42.7\% vs. 57.3\%).}
}
}
\source{
\url{https://archive.ics.uci.edu/ml/datasets/Contraceptive+Method+Choice}

Original creator and donor:

Tjen-Sien Lim
}
\usage{
contraceptive
}
\description{
A subset of the 1987 National Indonesia Contraceptive Prevalence Survey.
}
\details{
The samples describe married women who were either not pregnant
or do not know if they were pregnant at the time of the interview.

The problem consists in predicting a woman's current contraceptive method choice
(here: binarized \code{cont.crit})
based on her demographic and socio-economic characteristics.


We made the following enhancements to the original data for improved usability:

\itemize{
 \item{The criterion was binarized from a class attribute variable with three levels (\code{1=No-use}, \code{2=Long-term}, \code{3=Short-term}) , into a logical variable with two levels (\code{TRUE} vs. \code{FALSE}).}
 }

 Other than that, the data remains consistent with the original dataset.
}
\seealso{
Other datasets: 
\code{\link{blood}},
\code{\link{breastcancer}},
\code{\link{car}},
\code{\link{creditapproval}},
\code{\link{fertility}},
\code{\link{forestfires}},
\code{\link{heart.cost}},
\code{\link{heart.test}},
\code{\link{heart.train}},
\code{\link{heartdisease}},
\code{\link{iris.v}},
\code{\link{mushrooms}},
\code{\link{sonar}},
\code{\link{titanic}},
\code{\link{voting}},
\code{\link{wine}}
}
\concept{datasets}
\keyword{datasets}
