## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(collapse = FALSE, 
                      comment = "#>", 
                      prompt = FALSE,
                      tidy = FALSE,
                      echo = TRUE, 
                      message = FALSE,
                      warning = FALSE,
                      # Default figure options:
                      dpi = 100, 
                      fig.align = 'center',
                      fig.height = 6.0,
                      fig.width  = 6.5, 
                      out.width = "600px")

## ----pkgs, echo = FALSE, message = FALSE, results = 'hide'--------------------
library(FFTrees)

## ----titanic-image, fig.align = "center", out.width="50%", echo = FALSE-------
knitr::include_graphics("../inst/titanic.jpg")

## ----titanic-data-head--------------------------------------------------------
set.seed(12)  # reproducible randomness
rcases <- sort(sample(1:nrow(titanic), 10))

# Sample of data:
knitr::kable(titanic[rcases, ], caption = "A sample of 10 observations from the `titanic` data.")

## ----titanic-fft, message = FALSE, results = 'hide'---------------------------
# Create FFTs for the titanic data:
titanic.fft <- FFTrees(formula = survived ~.,
                       data = titanic, 
                       main = "Surviving the Titanic",
                       decision.labels = c("Died", "Survived"))       

## ----titanic-cues, fig.width = 6, fig.height = 6, out.width = "500px", fig.cap = "**Figure 1**: Cue accuracies of FFTs predicting survival in the `titanic` dataset."----
plot(titanic.fft, what = "cues", main = "Cues predicting Titanic survival")

## ----titanic-plot, fig.width = 7, fig.height = 7, fig.align = 'center', out.width = "75%", fig.cap="**Figure 2**: Plotting the best FFT of an `FFTrees` object."----
plot(titanic.fft, tree = 1)

## ----titanic-what-tree, fig.align = 'center', fig.height = 6, fig.width = 9, out.width = "550px", fig.cap = "**Figure 3**: An FFT diagram with icon arrays on exit nodes."----
# Plot tree diagram with icon arrays:
plot(titanic.fft, what = "icontree", 
     n.per.icon = 50, show.iconguide = TRUE)

## ----titanic-what-roc, fig.align = 'center', fig.height = 6, fig.width = 7, out.width = "550px", fig.cap = "**Figure 4**: Performance comparison of FFTs in ROC space."----
# Plot only the performance comparison in ROC space:
plot(titanic.fft, what = "roc")

## ----titanic-args, fig.align = 'center', fig.height = 7, fig.width = 9, out.width = "550px", fig.cap = "**Figure 5**: Plotting selected elements."----
# Hide some elements of the FFT plot: 
plot(titanic.fft, 
     show.icons = FALSE,     # hide icons
     show.iconguide = FALSE, # hide icon guide
     show.header = FALSE     # hide header
     )

## ----titanic-data-tree-best-train, eval = FALSE-------------------------------
#  plot(titanic.fft, tree = "best.train")

## ----titanic-data-tree-best-test, eval = FALSE--------------------------------
#  plot(titanic.fft, tree = "best.test")

## ----titanic-pred, message = FALSE, results = 'hide'--------------------------
set.seed(100)  # for replicability of the training/test split
titanic.pred.fft <- FFTrees(formula = survived ~.,
                            data = titanic,
                            train.p = .50,  # use 50% to train, 50% to test
                            main = "Titanic", 
                            decision.labels = c("Died", "Survived")
                            )

## ----titanic-train, fig.cap = "**Figure 6**: Plotting the best FFT on _training_ data."----
# print(titanic.pred.fft, tree = 1)
plot(titanic.pred.fft, tree = 1)

## ----titanic-test, fig.cap = "**Figure 7**: Plotting the best FFT on _test_ data."----
# print(titanic.pred.fft, data = "test", tree = 1)
plot(titanic.pred.fft, data = "test", tree = 1)

## ----titanic-viz-2, fig.cap = "**Figure 8**: Plotting Tree\ #2."--------------
plot(titanic.pred.fft, data = "test", tree = 2)

