% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util_gfft.R
\name{drop_nodes}
\alias{drop_nodes}
\title{Drop a node from an FFT definition}
\usage{
drop_nodes(fft, nodes = NA, quiet = FALSE)
}
\arguments{
\item{fft}{One FFT definition
(as a data frame in tidy format, with one row per node).}

\item{nodes}{The FFT nodes to drop (as an integer vector).
Default: \code{nodes = NA}.}

\item{quiet}{Hide feedback messages (as logical)?
Default: \code{quiet = FALSE}.}
}
\value{
One FFT definition
(as a data frame in tidy format, with one row per node).
}
\description{
\code{drop_nodes} deletes
one or more \code{nodes} from an existing FFT definition
(by removing the corresponding rows from the FFT definition
in the tidy data frame format).

When dropping the final node,
the last remaining node becomes the new final node
(i.e., gains a second exit).

Duplicates in \code{nodes} are dropped only once
(rather than incrementally) and \code{nodes} not in
the range \code{1:nrow(fft)} are ignored.
Dropping all nodes yields an error.

\code{drop_nodes} is the inverse function of \code{\link{select_nodes}}.
Inserting new nodes is possible by \code{\link{add_nodes}}.
}
\seealso{
\code{\link{add_nodes}} for adding nodes to an FFT definition;
\code{\link{edit_nodes}} for editing nodes in an FFT definition;
\code{\link{select_nodes}} for selecting nodes in an FFT definition;
\code{\link{get_fft_df}} for getting the FFT definitions of an \code{FFTrees} object;
\code{\link{read_fft_df}} for reading one FFT definition from tree definitions;
\code{\link{add_fft_df}} for adding FFTs to tree definitions;
\code{\link{FFTrees}} for creating FFTs from and applying them to data.

Other tree definition and manipulation functions: 
\code{\link{add_fft_df}()},
\code{\link{add_nodes}()},
\code{\link{edit_nodes}()},
\code{\link{flip_exits}()},
\code{\link{get_fft_df}()},
\code{\link{read_fft_df}()},
\code{\link{reorder_nodes}()},
\code{\link{select_nodes}()},
\code{\link{write_fft_df}()}
}
\concept{tree definition and manipulation functions}
