## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width = 7.5, fig.height = 7.5, dpi = 100, out.width = "600px", fig.align='center', message = FALSE)

## ----load-pkg, echo = FALSE, message = FALSE, results = 'hide'----------------
library(FFTrees)

## ----fft-example, out.width="80%", fig.align = "center", echo = FALSE, fig.cap = "**Figure 1**: Example FFT for the `heartdisease` data."----
# Create an FFTrees object predicting heart disease
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heartdisease)

plot(heart.fft)

## ----confusion-table, fig.align = "center", out.width="50%", echo = FALSE, fig.cap = "**Figure 2**: A 2x2 matrix illustrating the frequency counts of 4 possible outcomes."----
knitr::include_graphics("../inst/confusiontable.jpg")

## ----fft-heart----------------------------------------------------------------
heart.fft

## ----fft-levelout-------------------------------------------------------------
# A vector of levels/nodes at which each case was classified:
heart.fft$trees$decisions$train$tree_1$levelout

## ----fft-mcu------------------------------------------------------------------
# Calculate the mean number or cues used (mcu): 
mean(heart.fft$trees$decisions$train$tree_1$levelout)

## ----fft-pci------------------------------------------------------------------
# Calculate pci (percentage of cues ignored) as 
# (n.cues - mcu) / n.cues):
n.cues <- ncol(heartdisease) 
(n.cues - heart.fft$trees$stats$train$mcu[1]) / n.cues

