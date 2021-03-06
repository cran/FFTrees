% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fftrees_create.R
\name{fftrees_create}
\alias{fftrees_create}
\title{Create an FFTrees object}
\usage{
fftrees_create(
  data = NULL,
  formula = NULL,
  algorithm = NULL,
  goal = NULL,
  goal.chase = NULL,
  goal.threshold = NULL,
  numthresh.method = NULL,
  numthresh.n = NULL,
  sens.w = NULL,
  max.levels = NULL,
  cost.outcomes = NULL,
  cost.cues = NULL,
  stopping.rule = NULL,
  stopping.par = NULL,
  decision.labels = NULL,
  main = NULL,
  my.tree = NULL,
  data.test = NULL,
  repeat.cues = NULL,
  quiet = NULL,
  do.lr = TRUE,
  do.svm = TRUE,
  do.cart = TRUE,
  do.rf = TRUE,
  do.comp = TRUE
)
}
\arguments{
\item{data}{dataframe. Training data}

\item{formula}{formula. A formula}

\item{algorithm}{string.}

\item{goal}{string.}

\item{goal.chase}{string.}

\item{goal.threshold}{string.}

\item{numthresh.method}{string.}

\item{numthresh.n}{integer.}

\item{sens.w}{numeric.}

\item{max.levels}{integer.}

\item{cost.outcomes}{list.}

\item{cost.cues}{list.}

\item{stopping.rule}{string.}

\item{stopping.par}{numeric.}

\item{decision.labels}{string.}

\item{main}{string.}

\item{my.tree}{string.}

\item{data.test}{dataframe.}

\item{repeat.cues}{logical.}

\item{quiet}{logical}

\item{do.lr}{logical.}

\item{do.svm}{logical.}

\item{do.cart}{logical.}

\item{do.rf}{logical.}

\item{do.comp}{logical.}
}
\value{
An FFTrees object.
}
\description{
Create an FFTrees object
}
